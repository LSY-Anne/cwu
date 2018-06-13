$PBExportHeader$w_hsu002a_tmt.srw
$PBExportComments$상대평가 기준코드관리
forward
global type w_hsu002a_tmt from w_msheet
end type
type tab_1 from tab within w_hsu002a_tmt
end type
type tabpage_1 from userobject within tab_1
end type
type dw_list from uo_grid within tabpage_1
end type
type dw_type from uo_grid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_list dw_list
dw_type dw_type
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hsu002a_tmt
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from uo_imgbtn within w_hsu002a_tmt
end type
type uo_2 from u_tab within w_hsu002a_tmt
end type
end forward

global type w_hsu002a_tmt from w_msheet
string title = "권한그룹관리"
tab_1 tab_1
uo_1 uo_1
uo_2 uo_2
end type
global w_hsu002a_tmt w_hsu002a_tmt

type variables
DataWindowChild	idwc_SysGb
end variables

on w_hsu002a_tmt.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.uo_2
end on

on w_hsu002a_tmt.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_open
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

tab_1.tabpage_1.dw_type.retrieve()
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'

end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//int    li_Cnt
//string ls_TypeCode
//
//tab_1.SelectTab(2)
//ls_TypeCode = Trim(tab_1.tabpage_1.dw_type.GetiTemString(tab_1.tabpage_1.dw_type.getrow(),'large_div'))
//li_Cnt      = tab_1.tabpage_2.dw_print.Retrieve(ls_TypeCode)
//If tab_1.tabpage_2.dw_print.rowcount() > 0 THEN
//   f_print(tab_1.tabpage_2.dw_print)
//else
//   messagebox("인쇄", "인쇄할 자료가 없습니다...")		
//end IF
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;call super::ue_delete;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_delete
////	기 능 설 명: 자료삭제 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 삭제할 데이타원도우의 선택여부 체크.
/////////////////////////////////////////////////////////////////////////////////////////
string ls_code,  ls_type, ls_large
int    li_yesno, li_code, li_ROW

lI_ROW   = tab_1.tabpage_1.dw_list.Getrow()
iF li_Row > 0 then
   ls_code   = tab_1.tabpage_1.dw_list.GetitemString(li_row, 'small_div') 
	ls_large  = tab_1.tabpage_1.dw_list.GetItemString(li_row, "large_div")
	
   IF tab_1.tabpage_1.dw_list.Rowcount() = 1 AND ls_code = '00000000'  THEN
		tab_1.tabpage_1.dw_list.deleterow(0)    //현재행 
      IF tab_1.tabpage_1.dw_list.update() = 1 THEN
         Commit USING SQLCA;
  	      tab_1.tabpage_1.dw_type.retrieve()
			tab_1.tabpage_1.dw_list.retrieve(ls_large)
//			tab_1.tabpage_1.dw_type.SELECTROW(0    ,FALSE)
			li_row     = tab_1.tabpage_1.dw_type.Find("large_div = '" + ls_large + "'",1,tab_1.tabpage_1.dw_type.rowcount())
			If li_row > 0 then   
//				tab_1.tabpage_1.dw_type.SELECTROW(li_row,tRUE)	
				tab_1.tabpage_1.dw_type.Setrow(li_row)
				tab_1.tabpage_1.dw_type.ScrollToRow(li_row)
			end IF	
      ELSE
         MessageBox("삭제", "삭제 실패!")
  	      ROLLBACK USING SQLCA;
			return
      END IF //dw_list.update() = 1		
   elseIF tab_1.tabpage_1.dw_list.Rowcount() <>  1 AND ls_code = '00000000'  THEN
	   MessageBox("삭제 실패"," 마지막 코드일 경우에만 삭제할 수 있습니다.")
	else	
      // 삭제
		tab_1.tabpage_1.dw_list.deleterow(0)    //현재행 
      IF tab_1.tabpage_1.dw_list.update() = 1 THEN
         Commit USING SQLCA;
  	      tab_1.tabpage_1.dw_type.retrieve()
			tab_1.tabpage_1.dw_list.retrieve(ls_large)
//			tab_1.tabpage_1.dw_type.SELECTROW(0    ,FALSE)
			li_row     = tab_1.tabpage_1.dw_type.Find("large_div = '" + ls_large + "'",1,tab_1.tabpage_1.dw_type.rowcount())
			If li_row > 0 then   
//				tab_1.tabpage_1.dw_type.SELECTROW(li_row,tRUE)	
				tab_1.tabpage_1.dw_type.Setrow(li_row)
				tab_1.tabpage_1.dw_type.ScrollToRow(li_row)
			end IF	
      ELSE
         MessageBox("삭제", "삭제 실패!")
  	      ROLLBACK USING SQLCA;
			return
      END IF //dw_list.update() = 1
   END IF       //dw_list.Rowcount() = 1 AND i_code = -1 
End IF	       //I_rOW

tab_1.tabpage_1.dw_type.retrieve()
ls_large  = tab_1.tabpage_1.dw_type.GetItemString(1, 'large_div')
tab_1.tabpage_1.dw_list.retrieve(ls_large)
end event

event ue_insert;call super::ue_insert;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_insert
////	기 능 설 명: 자료추가 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 입력조건체크
/////////////////////////////////////////////////////////////////////////////////////////
int    li_code
long   ll_row,     li_row
String ls_large

ll_row    = tab_1.tabpage_1.dw_type.GetRow() //현재 행을 검색한다.

li_row    = tab_1.tabpage_1.dw_list.InsertRow(0)

tab_1.tabpage_1.dw_list.SetItem(li_row, "abo_flag",   'Y')
tab_1.tabpage_1.dw_list.SetItem(li_row, "upd_pgm_id", 'W_HSU002A_TMT')
tab_1.tabpage_1.dw_list.SetColumn("small_div")
tab_1.tabpage_1.dw_list.SetFocus()
tab_1.tabpage_1.dw_list.ScrollToRow(li_row)


end event

event open;call super::open; idw_print = tab_1.tabpage_2.dw_print
end event

event ue_save;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_db_save
////	기 능 설 명: 자료저장 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
int    li_temp,  li_code,     li_row,    ii
string ls_fname, ls_rowstatus,ls_large,  ls_small,   ls_small1,   ls_small2
string ls_large1,ls_contdesc

tab_1.tabpage_1.dw_list.AcceptText()
// 입력 자료 check 
IF tab_1.tabpage_1.dw_list.rowcount() < 1 THEN 
	messagebox("저장", "저장할 자료가 없습니다...")
else
   ls_large   = tab_1.tabpage_1.dw_list.GetItemString(1, "large_div")
   IF isnull(ls_large) OR ls_large = '' THEN
		messagebox("저장", '코드 종류는 필수 입력항목입니다.')
		rollback USING SQLCA;
		return -1
	END IF
	/* 중복 자료 입력 체크 */
	FOR li_row        = 1 TO tab_1.tabpage_1.dw_list.RowCount()
	 IF li_row        < tab_1.tabpage_1.dw_list.RowCount() THEN
		 ls_small1     = tab_1.tabpage_1.dw_list.GetItemString(li_row, 'small_div')
	    FOR ii        = li_row + 1 TO tab_1.tabpage_1.dw_list.RowCount()
			  ls_small2 = tab_1.tabpage_1.dw_list.GetItemString(ii, 'small_div')
			  IF ls_small1 = ls_small2 THEN
				  messagebox("저장", '소구분이 중복된 자료가 있으니 확인바랍니다')
				  return -1
			  END IF
		 NEXT
	 END IF
	NEXT
	FOR li_row     = 1 TO tab_1.tabpage_1.dw_list.RowCount()
	    ls_small   = tab_1.tabpage_1.dw_list.GetItemString(li_row, "small_div")
	    IF isnull(ls_small) OR ls_small = '' THEN
	    ELSE
			 ls_contdesc = tab_1.tabpage_1.dw_list.GetItemString(li_row, "cont_desc")
			 ls_large1   = tab_1.tabpage_1.dw_list.GetItemString(li_row, "large_div")
			 IF isnull(ls_contdesc) OR ls_contdesc = '' THEN
				 messagebox("저장", '설명을 입력 바랍니다')
				 return -1
			 END IF
			 IF isnull(ls_large1) OR ls_large1 = '' THEN
	          tab_1.tabpage_1.dw_list.SetItem(li_row, 'large_div',    ls_large)
			 END IF
			 tab_1.tabpage_1.dw_list.SetItem(li_row, 'upd_user_id',     gs_empcode)
			 tab_1.tabpage_1.dw_list.SetItem(li_row, 'upd_user_ip_addr',gs_ip)
		 END IF
	NEXT
	IF tab_1.tabpage_1.dw_list.update() = 1 THEN
      COMMIT USING SQLCA;
      tab_1.tabpage_1.dw_type.retrieve()
		tab_1.tabpage_1.dw_list.retrieve(ls_large)
      li_row     = tab_1.tabpage_1.dw_type.Find("large_div = '" + ls_large + "'",1,tab_1.tabpage_1.dw_type.rowcount())
//	   tab_1.tabpage_1.dw_type.SELECTROW(0    ,FALSE)
		If li_row > 0 then   
//			tab_1.tabpage_1.dw_type.SELECTROW(li_row,tRUE)	
			tab_1.tabpage_1.dw_type.Setrow(li_row)
			tab_1.tabpage_1.dw_type.ScrollToRow(li_row)
		end IF	
		wf_SetMsg('자료가 저장되었습니다.')
	ELSE
      MessageBox("저장실패","저장실패")
      ROLLBACK USING SQLCA;
   END IF					
END IF

Return 1
end event

event ue_retrieve;call super::ue_retrieve;
tab_1.tabpage_1.dw_type.Retrieve()

Return 1
end event

type ln_templeft from w_msheet`ln_templeft within w_hsu002a_tmt
end type

type ln_tempright from w_msheet`ln_tempright within w_hsu002a_tmt
end type

type ln_temptop from w_msheet`ln_temptop within w_hsu002a_tmt
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hsu002a_tmt
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hsu002a_tmt
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hsu002a_tmt
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hsu002a_tmt
end type

type uc_insert from w_msheet`uc_insert within w_hsu002a_tmt
end type

type uc_delete from w_msheet`uc_delete within w_hsu002a_tmt
end type

type uc_save from w_msheet`uc_save within w_hsu002a_tmt
end type

type uc_excel from w_msheet`uc_excel within w_hsu002a_tmt
end type

type uc_print from w_msheet`uc_print within w_hsu002a_tmt
end type

type st_line1 from w_msheet`st_line1 within w_hsu002a_tmt
end type

type st_line2 from w_msheet`st_line2 within w_hsu002a_tmt
end type

type st_line3 from w_msheet`st_line3 within w_hsu002a_tmt
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hsu002a_tmt
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hsu002a_tmt
end type

type tab_1 from tab within w_hsu002a_tmt
integer x = 55
integer y = 248
integer width = 4379
integer height = 2016
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;String ls_TypeCode
If newindex = 2 Then
	IF tab_1.tabpage_1.dw_list.rowcount() > 0 THEN
		ls_TypeCode = Trim(tab_1.tabpage_1.dw_type.GetiTemString(tab_1.tabpage_1.dw_type.getrow(),'large_div'))
		tab_1.tabpage_2.dw_print.Retrieve(ls_TypeCode)
	END IF
End if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1896
long backcolor = 16777215
string text = "공통코드 관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list dw_list
dw_type dw_type
end type

on tabpage_1.create
this.dw_list=create dw_list
this.dw_type=create dw_type
this.Control[]={this.dw_list,&
this.dw_type}
end on

on tabpage_1.destroy
destroy(this.dw_list)
destroy(this.dw_type)
end on

type dw_list from uo_grid within tabpage_1
integer x = 1065
integer y = 20
integer width = 3255
integer height = 1860
integer taborder = 20
string dataobject = "d_hsu002a_2"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_type from uo_grid within tabpage_1
integer y = 20
integer width = 1033
integer height = 1860
integer taborder = 60
string dataobject = "d_hsu002a_1"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;Int      i_cnt    //행의수
String s_type  //현재행의 데이타 타입

IF row > 0 THEN
   s_type  = Trim(this.GetItemString(row, "large_div"))
   i_cnt   = dw_list.retrieve(s_type) //원하는 데이타 타입으로 검색한다.
End If

end event

event retrieveend;call super::retrieveend;long   l_row
String s_type //현재선택한 데이타 타입

IF rowcount < 1 THEN 
	dw_list.reset()
	parent.TriggerEvent('ue_insert')
ELSE                   //가장 첫행으로 이동한다
	l_row  = dw_list.getrow()
	If l_row < 1 then   //처음 검색
		l_row  = This.Getrow()
      s_type = Trim(this.GetItemString(L_ROW, "large_div"))		
	else
	   s_type = Trim(dw_list.GetitemString(l_row,'large_div'))
	end IF
     l_row = dw_list.retrieve(s_type)

END IF
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1896
long backcolor = 16777215
string text = "공통코드 리스트"
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

type dw_print from uo_dwfree within tabpage_2
integer y = 16
integer width = 4325
integer height = 1880
integer taborder = 20
string dataobject = "d_hsu002a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

type uo_1 from uo_imgbtn within w_hsu002a_tmt
integer x = 594
integer y = 40
integer width = 539
integer taborder = 40
boolean bringtotop = true
string btnname = "신규코드작성"
end type

event clicked;call super::clicked;tab_1.tabpage_1.dw_list.reset()
tab_1.tabpage_1.dw_list.InsertRow(0)
tab_1.tabpage_1.dw_list.SetItem(1, 'small_div', '00000000')
tab_1.tabpage_1.dw_list.SetColumn('large_div')
tab_1.tabpage_1.dw_list.SetFocus()
tab_1.tabpage_1.dw_list.ScrollToRow(1)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from u_tab within w_hsu002a_tmt
integer x = 462
integer y = 200
integer taborder = 50
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_2.destroy
call u_tab::destroy
end on

