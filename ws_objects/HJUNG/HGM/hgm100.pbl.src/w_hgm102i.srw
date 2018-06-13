$PBExportHeader$w_hgm102i.srw
$PBExportComments$품목분류 관리
forward
global type w_hgm102i from w_msheet
end type
type tab_1 from tab within w_hgm102i
end type
type tabpage_1 from userobject within tab_1
end type
type cb_3 from uo_imgbtn within tabpage_1
end type
type cb_4 from uo_imgbtn within tabpage_1
end type
type cb_2 from uo_imgbtn within tabpage_1
end type
type cb_1 from uo_imgbtn within tabpage_1
end type
type dw_update2 from uo_dwgrid within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type dw_update1 from uo_dwgrid within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_3 cb_3
cb_4 cb_4
cb_2 cb_2
cb_1 cb_1
dw_update2 dw_update2
gb_2 gb_2
dw_update1 dw_update1
gb_1 gb_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print1 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print1 dw_print1
end type
type tabpage_3 from userobject within tab_1
end type
type dw_print2 from datawindow within tabpage_3
end type
type sle_name from singlelineedit within tabpage_3
end type
type st_2 from statictext within tabpage_3
end type
type sle_code from singlelineedit within tabpage_3
end type
type st_1 from statictext within tabpage_3
end type
type gb_5 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_print2 dw_print2
sle_name sle_name
st_2 st_2
sle_code sle_code
st_1 st_1
gb_5 gb_5
end type
type tab_1 from tab within w_hgm102i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type uo_tab from u_tab within w_hgm102i
end type
end forward

global type w_hgm102i from w_msheet
integer height = 2616
tab_1 tab_1
uo_tab uo_tab
end type
global w_hgm102i w_hgm102i

type variables
int ii_tab
end variables

on w_hgm102i.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_tab=create uo_tab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_tab
end on

on w_hgm102i.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_tab)
end on

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////
//// 	작성목적 : 대분류,중분류 코드 관리
////    적 성 인 : 윤하영
////		작성일자 : 2002.03.01
////    변 경 인 :
////    변경일자 :
////    변경사유 :
////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)
//wf_setMenu('U',TRUE)
///////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
///////////////////////////////////////////////////////////////////////////////////////////
//////	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////////////
//
end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
tab_1.tabpage_1.dw_update1.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_update1.retrieve()
tab_1.tabpage_1.dw_update1.SetReDraw(TRUE)

tab_1.tabpage_2.dw_print1.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_2.dw_print1.Retrieve()
tab_1.tabpage_2.dw_print1.SetReDraw(TRUE)

String ls_lg_code, ls_lg_name,ls_large_code, ls_large_name
ls_large_code = tab_1.tabpage_1.dw_update1.object.large_code[tab_1.tabpage_1.dw_update1.getrow()]
ls_large_name = tab_1.tabpage_1.dw_update1.object.large_name[tab_1.tabpage_1.dw_update1.getrow()]
ls_lg_code = tab_1.tabpage_3.sle_code.text
ls_lg_name = tab_1.tabpage_3.sle_name.text

IF  isnull(ls_lg_code) OR ls_lg_code= '' THEN
	 ls_lg_code = '%'
ELSE 
	ls_lg_code = tab_1.tabpage_3.sle_code.text+'%'
	ls_lg_name = tab_1.tabpage_3.sle_name.text+'%'
END IF

IF  isnull(ls_lg_name) OR ls_lg_name= '' THEN
	 ls_lg_name = '%'
ELSE 
	ls_lg_code = tab_1.tabpage_3.sle_code.text+'%'
	ls_lg_name = tab_1.tabpage_3.sle_name.text+'%'
END IF

tab_1.tabpage_3.dw_print2.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_3.dw_print2.retrieve( ls_lg_code,ls_lg_name) 
tab_1.tabpage_3.dw_print2.SetReDraw(TRUE)
///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_1.tabpage_2.dw_print1.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_1.tabpage_2.dw_print1.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//
//tab_1.tabpage_3.dw_print2.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_1.tabpage_3.dw_print2.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('I',FALSE)
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('I',FALSE)
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////

return 1
end event

event ue_save;call super::ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
int li_tab
long i, ll_mrow, ll_ModRow
datawindow dw_lname, dw_mname

li_tab = tab_1.selectedtab

CHOOSE CASE li_tab
		
	CASE 1

	  dw_lname = tab_1.tabpage_1.dw_update1
     dw_mname = tab_1.tabpage_1.dw_update2
	  
	  IF f_chk_modified(dw_lname) = FALSE AND f_chk_modified(dw_mname) = FALSE THEN RETURN -1
	  
     string ls_lcolarry[] = {'large_code/대분류 코드','large_name/대분류명' }
	  string ls_mcolarry[] = {'midd_code/대분류 코드','midd_name/중분류명' }
	
	  IF f_chk_null( dw_lname, ls_lcolarry ) = 1 AND f_chk_null( dw_mname, ls_mcolarry ) = 1 THEN 

        ll_mrow = dw_mname.rowcount()

        FOR i = 1 TO ll_mrow
			
			  dwItemStatus l_status 
			  l_status = dw_mname.getitemstatus(i, 0, Primary!)
	
			  IF l_status = New! OR l_status = NewModified! THEN 
	
	           dw_mname.object.item_middle[i] = trim(dw_mname.object.large_code[i]) + trim(dw_mname.object.midd_code[i])
	 
			  END IF
			  
		 NEXT
		 
		 ll_ModRow = dw_lname.GetNextModified(0, Primary!)
		 
		 Do While ll_ModRow > 0 
			dw_lname.object.job_uid[ll_ModRow] = gs_empcode		//수정자
		   dw_lname.object.job_date[ll_ModRow] = f_sysdate()           // 오늘 일자 
		   dw_lname.object.job_add[ll_ModRow] = gs_ip  //IP
			
			ll_ModRow = dw_lname.GetNextModified(ll_ModRow, Primary!)
		 Loop
		 
		 ll_ModRow = dw_mname.GetNextModified(0, Primary!)
		 
		 Do While ll_ModRow > 0 
			dw_mname.object.job_uid[ll_ModRow] = gs_empcode		//수정자
		   dw_mname.object.job_date[ll_ModRow] = f_sysdate()           // 오늘 일자 
		   dw_mname.object.job_add[ll_ModRow] = gs_ip  //IP
			
			ll_ModRow = dw_mname.GetNextModified(ll_ModRow, Primary!)
		 Loop
		 
		 dw_lname.AcceptText()
		 dw_mname.AcceptText()
		 
	    IF f_update2( dw_lname, dw_mname, 'U') = TRUE THEN wf_setmsg("저장되었습니다")
	  END IF	
	  
	  	String ls_large_code // 저장후 리스트에서 자료 찾기
		int  li_row
		
		ls_large_code = dw_mname.object.large_code[dw_mname.getrow()]

		tab_1.tabpage_1.dw_update1.retrieve()
      li_row   = tab_1.tabpage_1.dw_update1.Find("large_code = '" + ls_large_code + "'",1,tab_1.tabpage_1.dw_update1.rowcount())
		
//	   tab_1.tabpage_1.dw_update1.SELECTROW(0    ,FALSE)
		If li_row > 0 then   
//			tab_1.tabpage_1.dw_update1.SELECTROW(li_row,tRUE)	
			tab_1.tabpage_1.dw_update1.Setrow(li_row)
			tab_1.tabpage_1.dw_update1.ScrollToRow(li_row)
		end IF

END CHOOSE		
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1


end event

event ue_print;call super::ue_print;//
//ii_tab = tab_1.selectedtab
//
//CHOOSE CASE ii_tab
//		
//	CASE 2
//		f_print(tab_1.tabpage_2.dw_print1)
//	CASE 3
//		f_print(tab_1.tabpage_3.dw_print2)
//END CHOOSE
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
tab_1.tabpage_2.dw_print1.Reset()
tab_1.tabpage_3.dw_print2.Reset()
tab_1.tabpage_2.dw_print1.Object.DataWindow.Zoom = 100
tab_1.tabpage_2.dw_print1.Object.DataWindow.Print.Preview = 'YES'
tab_1.tabpage_3.dw_print2.Object.DataWindow.Zoom = 100
tab_1.tabpage_3.dw_print2.Object.DataWindow.Print.Preview = 'YES'

idw_print = tab_1.tabpage_2.dw_print1
this.postevent("ue_retrieve")
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////
// 	작성목적 : 대분류,중분류 코드 관리
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)
//wf_setMenu('U',TRUE)
/////////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
/////////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
/////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
/////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = tab_1.tabpage_1.gb_1.x + tab_1.tabpage_1.gb_1.width

If tab_1.tabpage_1.cb_2.Enabled Then
	tab_1.tabpage_1.cb_2.X		= ll_stnd_pos - tab_1.tabpage_1.cb_2.Width
	ll_stnd_pos		= ll_stnd_pos - tab_1.tabpage_1.cb_2.Width - 16
Else
	tab_1.tabpage_1.cb_2.Visible	= FALSE
End If

If tab_1.tabpage_1.cb_1.Enabled Then
	tab_1.tabpage_1.cb_1.X			= ll_stnd_pos - tab_1.tabpage_1.cb_1.Width
	ll_stnd_pos			= ll_stnd_pos - tab_1.tabpage_1.cb_1.Width - 16
Else
	tab_1.tabpage_1.cb_1.Visible	= FALSE
End If

ll_stnd_pos    = tab_1.tabpage_1.gb_2.x + tab_1.tabpage_1.gb_2.width

If tab_1.tabpage_1.cb_3.Enabled Then
	tab_1.tabpage_1.cb_3.X		= ll_stnd_pos - tab_1.tabpage_1.cb_3.Width
	ll_stnd_pos		= ll_stnd_pos - tab_1.tabpage_1.cb_3.Width - 16
Else
	tab_1.tabpage_1.cb_3.Visible	= FALSE
End If

If tab_1.tabpage_1.cb_4.Enabled Then
	tab_1.tabpage_1.cb_4.X			= ll_stnd_pos - tab_1.tabpage_1.cb_4.Width
	ll_stnd_pos			= ll_stnd_pos - tab_1.tabpage_1.cb_4.Width - 16
Else
	tab_1.tabpage_1.cb_4.Visible	= FALSE
End If


end event

type ln_templeft from w_msheet`ln_templeft within w_hgm102i
end type

type ln_tempright from w_msheet`ln_tempright within w_hgm102i
end type

type ln_temptop from w_msheet`ln_temptop within w_hgm102i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hgm102i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hgm102i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hgm102i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hgm102i
end type

type uc_insert from w_msheet`uc_insert within w_hgm102i
end type

type uc_delete from w_msheet`uc_delete within w_hgm102i
end type

type uc_save from w_msheet`uc_save within w_hgm102i
end type

type uc_excel from w_msheet`uc_excel within w_hgm102i
end type

type uc_print from w_msheet`uc_print within w_hgm102i
end type

type st_line1 from w_msheet`st_line1 within w_hgm102i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hgm102i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hgm102i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hgm102i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hgm102i
end type

type tab_1 from tab within w_hgm102i
integer x = 50
integer y = 192
integer width = 4384
integer height = 2492
integer taborder = 10
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

event selectionchanged;
CHOOSE CASE newindex
		
	CASE 1,2
		idw_print  = tab_1.tabpage_2.dw_print1
	CASE 3
		idw_print = tab_1.tabpage_3.dw_print2
END CHOOSE
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2372
string text = "대분류, 중분류 코드관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_3 cb_3
cb_4 cb_4
cb_2 cb_2
cb_1 cb_1
dw_update2 dw_update2
gb_2 gb_2
dw_update1 dw_update1
gb_1 gb_1
end type

on tabpage_1.create
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_update2=create dw_update2
this.gb_2=create gb_2
this.dw_update1=create dw_update1
this.gb_1=create gb_1
this.Control[]={this.cb_3,&
this.cb_4,&
this.cb_2,&
this.cb_1,&
this.dw_update2,&
this.gb_2,&
this.dw_update1,&
this.gb_1}
end on

on tabpage_1.destroy
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_update2)
destroy(this.gb_2)
destroy(this.dw_update1)
destroy(this.gb_1)
end on

type cb_3 from uo_imgbtn within tabpage_1
integer x = 4018
integer y = 32
integer taborder = 140
string btnname = "삭제"
end type

event clicked;call super::clicked;
long ll_row
Datawindow  idw_name
idw_name = tab_1.tabpage_1.dw_update2

idw_name.accepttext()

ll_row = idw_name.getrow()

dwItemStatus l_status 
l_status = idw_name.getitemstatus(ll_row, 0, Primary!)
	
IF l_status = New! OR l_status = NewModified! THEN 

   idw_name.deleterow(ll_row)				  
				  
ELSE
	
	IF messagebox("확인","선택한 중분류 코드를 삭제하시겠습니까? 삭제후 저장됩니다.", Question!, YesNo! ,2 ) = 1 THEN
	
		idw_name.deleterow(ll_row)
	
		IF f_update(idw_name,'D') = TRUE THEN wf_setmsg("삭제되었습니다") 
	    
   END IF
	
END IF



end event

on cb_3.destroy
call uo_imgbtn::destroy
end on

type cb_4 from uo_imgbtn within tabpage_1
integer x = 3653
integer y = 32
integer taborder = 130
string btnname = "추가"
end type

event clicked;call super::clicked;
datawindow dw_lname, dw_mname
long ll_lrow, ll_mrow
string ls_large_code

dw_lname = tab_1.tabpage_1.dw_update1

IF dw_lname.rowcount() <> 0 THEN
	
	ll_lrow = dw_lname.getrow()
	
	IF ll_lrow = 0 THEN
		messagebox("확인","대분류 코드를 선택하세요")
		dw_lname.setfocus()
      RETURN
	END IF
	
END IF

dw_mname = tab_1.tabpage_1.dw_update2

ll_mrow = dw_mname.insertrow( dw_mname.getrow() + 1 )

dw_mname.object.large_code[ll_mrow] = dw_lname.object.large_code[ll_lrow]
dw_mname.object.worker[ll_mrow] = gs_empcode      // 작업자 
dw_mname.object.work_date[ll_mrow] = f_sysdate()           // 오늘 일자 
dw_mname.object.ipaddr[ll_mrow] = gs_ip  //IP

dw_mname.setfocus()
dw_mname.scrolltorow(ll_mrow)
dw_mname.setcolumn("midd_code")

//wf_SetMenu('S',TRUE)

end event

on cb_4.destroy
call uo_imgbtn::destroy
end on

type cb_2 from uo_imgbtn within tabpage_1
integer x = 1824
integer y = 32
integer taborder = 120
string btnname = "삭제"
end type

event clicked;call super::clicked;
// 추후에 스크립트 추가 - 다른 테이블과 연관 

long ll_row, i, ll_count
datawindow dw_lname, dw_mname
string ls_large_code, ls_large_code1

dw_lname = tab_1.tabpage_1.dw_update1
dw_mname = tab_1.tabpage_1.dw_update2

dwItemStatus l_status 
l_status = dw_lname.getitemstatus(dw_lname.getrow(), 0, Primary!)
	
IF l_status = New! OR l_status = NewModified! THEN 

   dw_lname.deleterow(0)
  
ELSE

	IF messagebox("확인","선택한 대분류 코드를 삭제하시겠습니까? ~n(대분류 코드와 연관된 중분류 코드도 모두 삭제후 저장됩니다.)", Question!, YesNo! ,2 ) = 1 THEN
      ls_large_code1 = dw_lname.object.large_code[dw_lname.getrow()]
		select count(midd_code)
	   into   :ll_count
		from   stdb.hst003m
		where  large_code = :ls_large_code1;
		IF ll_count = 0 THEN
			dw_lname.deleterow(0)
		   IF f_update( dw_lname, 'D') = TRUE THEN wf_setmsg("삭제되었습니다") 
	   ELSE
         ls_large_code  = dw_mname.object.large_code[dw_mname.getrow()]
	      DELETE FROM STDB.HST003M WHERE LARGE_CODE = :ls_large_code  ;
		   dw_lname.deleterow(0)
	    IF f_update( dw_lname, 'D') = TRUE THEN wf_setmsg("삭제되었습니다") 
	   END If
   END IF
END IF

end event

on cb_2.destroy
call uo_imgbtn::destroy
end on

type cb_1 from uo_imgbtn within tabpage_1
integer x = 1486
integer y = 32
integer taborder = 110
string btnname = "추가"
end type

event clicked;call super::clicked;
long ll_row

DataWindow  idw_name
idw_name = tab_1.tabpage_1.dw_update1 

tab_1.tabpage_1.dw_update2.reset()

ll_row = idw_name.insertrow( idw_name.getrow() + 1 )

idw_name.object.worker[ll_row] = gs_empcode      // 작업자 
idw_name.object.work_date[ll_row] = f_sysdate()           // 오늘 일자 
idw_name.object.ipaddr[ll_row] = gs_ip  //IP
		
idw_name.setfocus()
idw_name.scrolltorow(ll_row)
idw_name.setcolumn("large_code")

//wf_SetMenu('S',TRUE)



end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

type dw_update2 from uo_dwgrid within tabpage_1
integer x = 2194
integer y = 168
integer width = 2112
integer height = 1808
integer taborder = 21
string dataobject = "d_hgm102i_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_2 from groupbox within tabpage_1
integer x = 2149
integer y = 108
integer width = 2199
integer height = 1900
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "중분류 코드"
end type

type dw_update1 from uo_dwgrid within tabpage_1
integer x = 59
integer y = 168
integer width = 2016
integer height = 1808
integer taborder = 21
string dataobject = "d_hgm102i_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event dberror;call super::dberror;
IF sqldbcode = 1 THEN
	messagebox("확인",'중복된 값이 있습니다.')
	setcolumn(1)
	setfocus()
END IF

RETURN 1
end event

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
string ls_large_code, ls_large_name
ls_large_code = tab_1.tabpage_1.dw_update1.object.large_code[ll_GetRow]
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')

tab_1.tabpage_1.dw_update2.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_update2.retrieve( ls_large_code) 
tab_1.tabpage_1.dw_update2.SetReDraw(TRUE)

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



end event

type gb_1 from groupbox within tabpage_1
integer x = 14
integer y = 108
integer width = 2117
integer height = 1900
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "대분류 코드"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2372
string text = "품목 대분류 리스트"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
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
integer x = 14
integer y = 20
integer width = 4329
integer height = 1964
integer taborder = 110
string title = "none"
string dataobject = "d_hgm102i_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2372
string text = "품목 중분류 리스트"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print2 dw_print2
sle_name sle_name
st_2 st_2
sle_code sle_code
st_1 st_1
gb_5 gb_5
end type

on tabpage_3.create
this.dw_print2=create dw_print2
this.sle_name=create sle_name
this.st_2=create st_2
this.sle_code=create sle_code
this.st_1=create st_1
this.gb_5=create gb_5
this.Control[]={this.dw_print2,&
this.sle_name,&
this.st_2,&
this.sle_code,&
this.st_1,&
this.gb_5}
end on

on tabpage_3.destroy
destroy(this.dw_print2)
destroy(this.sle_name)
destroy(this.st_2)
destroy(this.sle_code)
destroy(this.st_1)
destroy(this.gb_5)
end on

type dw_print2 from datawindow within tabpage_3
integer x = 14
integer y = 256
integer width = 4334
integer height = 1716
integer taborder = 21
string title = "none"
string dataobject = "d_hgm102i_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type sle_name from singlelineedit within tabpage_3
integer x = 1330
integer y = 92
integer width = 457
integer height = 92
integer taborder = 100
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

type st_2 from statictext within tabpage_3
integer x = 1070
integer y = 116
integer width = 265
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "대분류명"
boolean focusrectangle = false
end type

type sle_code from singlelineedit within tabpage_3
integer x = 498
integer y = 92
integer width = 457
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within tabpage_3
integer x = 174
integer y = 116
integer width = 357
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "대분류코드"
boolean focusrectangle = false
end type

type gb_5 from groupbox within tabpage_3
integer x = 18
integer y = 12
integer width = 4329
integer height = 236
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type uo_tab from u_tab within w_hgm102i
event destroy ( )
integer x = 1728
integer y = 196
integer taborder = 160
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

