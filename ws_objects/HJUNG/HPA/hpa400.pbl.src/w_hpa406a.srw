$PBExportHeader$w_hpa406a.srw
$PBExportComments$부양가족 공제자 관리//관리자
forward
global type w_hpa406a from w_tabsheet
end type
type dw_list from cuo_dwwindow within tabpage_sheet01
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print from cuo_dwwindow within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type sle_code1 from singlelineedit within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print dw_print
st_4 st_4
sle_code1 sle_code1
end type
type uo_year from cuo_year within w_hpa406a
end type
type uo_member from cuo_insa_member within w_hpa406a
end type
type gb_1 from groupbox within w_hpa406a
end type
end forward

global type w_hpa406a from w_tabsheet
string title = "건물관리"
uo_year uo_year
uo_member uo_member
gb_1 gb_1
end type
global w_hpa406a w_hpa406a

type variables

integer ii_tab
integer ii_str_jikjong = 0, ii_end_jikjong = 9
long il_getrow = 1

datawindowchild idw_child, idw_kname_child
datawindow idw_sname
string	is_year, is_member_no, is_name

DataWindowchild	idwc_Gwa
end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_insert ()
end prototypes

public subroutine wf_retrieve ();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: 
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
is_member_no = TRIM(uo_member.sle_member_no.Text)

if is_member_no = '' or  isNull(is_member_no) then
	is_member_no = '%'
end if

SetPointer(HourGlass!)

ii_tab = tab_sheet.selectedtab
CHOOSE CASE ii_tab	
	CASE 1
		///////////////////////////////////////////////////////////////////////////////////////
		// 2. 자료조회
		///////////////////////////////////////////////////////////////////////////////////////
		wf_SetMsg('조회 처리 중입니다...')
		Long	ll_RowCnt, ll_RowCnt_list, ll_RowCnt_print
		
		tab_sheet.tabpage_sheet01.dw_list.SetReDraw(FALSE)
		ll_RowCnt = tab_sheet.tabpage_sheet01.dw_update.Retrieve(is_year,is_member_no)
		ll_RowCnt_list = tab_sheet.tabpage_sheet01.dw_list.Retrieve(is_year,is_member_no)
		tab_sheet.tabpage_sheet01.dw_list.SetReDraw(TRUE)
		
	CASE 2
		ll_RowCnt_print = tab_sheet.tabpage_1.dw_print.Retrieve(is_year,is_member_no)
END CHOOSE
///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_sheet.tabpage_1.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_sheet.tabpage_1.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt_list = 0 THEN
//	wf_SetMenuBtn('ISDRP')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
	uo_year.SetFocus()
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end subroutine

public subroutine wf_insert ();STRING	ls_member_no,ls_name,ls_newrow
integer	li_newrow

ii_tab  = tab_sheet.selectedtab
idw_name = tab_sheet.tabpage_sheet01.dw_update
idw_sname = tab_sheet.tabpage_sheet01.dw_list

CHOOSE CASE ii_tab
	CASE 1
//      idw_name.Selectrow(0, false)	
		
		li_newrow	=	idw_name.getrow() + 1
		idw_name.insertrow(li_newrow)
		
		idw_name.setrow(li_newrow)
		idw_name.scrolltorow(li_newrow)
		
		ls_member_no	=	idw_sname.object.member_no[idw_sname.getrow()]
//		ls_name	=	idw_sname.object.name[idw_sname.getrow()]
//				
		idw_name.setitem(li_newrow, 'member_no', 	ls_member_no)
//		idw_name.setitem(li_newrow, 'name', 		ls_name)
		
		
		idw_name.object.worker[1] = gs_empcode      // 작업자 
		idw_name.object.work_date[1] = f_sysdate()           // 오늘 일자 
		idw_name.object.ipaddr[1] = gs_ip  //IP
		
		idw_sname.accepttext()
		
		idw_name.object.ipaddr[1] = gs_ip  	
		idw_name.setfocus()

END CHOOSE

end subroutine

on w_hpa406a.create
int iCurrent
call super::create
this.uo_year=create uo_year
this.uo_member=create uo_member
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_year
this.Control[iCurrent+2]=this.uo_member
this.Control[iCurrent+3]=this.gb_1
end on

on w_hpa406a.destroy
call super::destroy
destroy(this.uo_year)
destroy(this.uo_member)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;
wf_retrieve()
return 1



end event

event ue_insert;call super::ue_insert;
wf_insert()


end event

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////
// 작성목적 : 부양가족 관리
// 적 성 인 : 이인갑
//	작성일자 : 2005.12.02
// 변 경 인 :
// 변경일자 :
// 변경사유 :
////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)

idw_sname = tab_sheet.tabpage_1.dw_print

//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
//////////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
//////////////////////////////////////////////////////////////////////////////////////////
// 1.1 부양가족 관계 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[부양가족 지급관계구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[부양가족 지급관계구분]를 초기화 중입니다...','')

tab_sheet.tabpage_sheet01.dw_update.GetChild('gwangae_code',idw_child)
idw_child.SetTransObject(SQLCA)
//IF idw_child.Retrieve('buyang_code',0) = 0 THEN
//	wf_setmsg('공통코드[부양가족 관계]를 입력하시기 바랍니다.')
//	idw_child.InsertRow(0)
//END IF
IF idw_child.Retrieve('buyang_code',0) < 0 THEN
	wf_setmsg('공통코드[부양가족 관계]를 입력하시기 바랍니다.')
	idw_child.InsertRow(0)
END IF

idw_sname.GetChild('gwangae_code',idw_child)
idw_child.SetTransObject(SQLCA)
IF idw_child.Retrieve('buyang_code',0) = 0 THEN
	wf_setmsg('공통코드[부양가족 관계]를 입력하시기 바랍니다.')
	idw_child.InsertRow(0)
END IF

idw_sname.Object.DataWindow.Print.Preview = 'YES'
idw_sname.Object.DataWindow.Zoom = 100




end event

event ue_save;call super::ue_save;		
//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////

idw_name = tab_sheet.tabpage_sheet01.dw_update
///////////////////////////////////////////////////////////////////////////////////////
// 2. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
IF idw_name.AcceptText() = -1 THEN
	idw_name.SetFocus()
	RETURN -1
END IF
IF idw_name.ModifiedCount() + &
	idw_name.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'member_no/개인번호'
ls_NotNullCol[1] = 'jumin_no/주민번호'
ls_NotNullCol[2] = 'year/년도'
//ls_NotNullCol[3] = 'gwangae_code/관계코드'

IF f_chk_null(idw_name,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 4. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IPAddr		//등록단말기
Boolean	lb_Start  = TRUE

String	ls_member_no		//개인번호

ll_Row = idw_name.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gs_empcode			//등록자
	ls_IPAddr    = gs_ip		//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = idw_name.GetItemStatus(ll_Row,0,Primary!)
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 저장처리전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		idw_name.Object.worker   [ll_Row] = ls_Worker		
		idw_name.Object.work_date[ll_Row] = ldt_WorkDate	
		idw_name.Object.ipaddr   [ll_Row] = ls_IPAddr		
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
		idw_name.Object.job_uid  [ll_Row] = ls_Worker		//등록자
		idw_name.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
		idw_name.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
		
		ll_Row = idw_name.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 5. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF f_update(idw_name,'U') = TRUE THEN 
			  wf_setmsg("저장되었습니다")
			  il_getrow = tab_sheet.tabpage_sheet01.dw_list.getrow()
			  wf_retrieve()
		  END IF

///////////////////////////////////////////////////////////////////////////////////////
// 6. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('IDSRP')
idw_name.SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;call super::ue_delete;//////////////////////////////////////////////////////////////////////////////////////////////
//////	이 벤 트 명: ue_delete
//////	기 능 설 명: 자료삭제 처리
//////	작성/수정자: 
//////	작성/수정일: 
//////	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////////
ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	   idw_name = tab_sheet.tabpage_sheet01.dw_update
      dwItemStatus l_status 
		l_status = idw_name.getitemstatus(1, 0, Primary!)
	
			IF f_messagebox( '2', 'DEL' ) = 1 THEN
	
				idw_name.deleterow(0)
				IF f_update2( tab_sheet.tabpage_sheet01.dw_update, idw_name,'D') = TRUE THEN 
					wf_setmsg("삭제되었습니다")
//					wf_retrieve()
//					idw_name.setfocus()
				END IF	
       
	       END IF
		
END CHOOSE
end event

event ue_print;call super::ue_print;if		tab_sheet.tabpage_1.dw_print.rowcount() >= 1		then
		f_print(tab_sheet.tabpage_1.dw_print)
end if
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa406a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa406a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa406a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa406a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa406a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa406a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa406a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa406a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa406a
end type

type uc_save from w_tabsheet`uc_save within w_hpa406a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa406a
end type

type uc_print from w_tabsheet`uc_print within w_hpa406a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa406a
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa406a
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa406a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa406a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa406a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa406a
integer x = 18
integer y = 204
integer width = 3854
integer height = 2300
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
integer width = 3817
integer height = 2184
string text = "부양가족 관리"
dw_list dw_list
dw_update dw_update
end type

on tabpage_sheet01.create
this.dw_list=create dw_list
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 2478
integer y = 32
integer width = 238
integer height = 168
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
end type

type uo_tab from w_tabsheet`uo_tab within w_hpa406a
end type

type dw_con from w_tabsheet`dw_con within w_hpa406a
end type

type st_con from w_tabsheet`st_con within w_hpa406a
end type

type dw_list from cuo_dwwindow within tabpage_sheet01
integer width = 663
integer height = 2184
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "조회내용"
string dataobject = "d_hpa406a_2"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;long	ll_row
 
if currentrow < 1 then return

//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

string ls_member_no,ls_year

idw_name = tab_sheet.tabpage_sheet01.dw_list

idw_name.accepttext()

IF currentrow <> 0 THEN

	ls_member_no = idw_name.object.member_no[currentrow]

   IF	tab_sheet.tabpage_sheet01.dw_update.retrieve( is_year, ls_member_no ) <> 0 THEN
//			wf_SetMenuBtn('IDSRP')
			wf_SetMsg('자료가 조회되었습니다.')
			dw_update.SetFocus()
	ELSE
//			wf_SetMenuBtn('IDSRP')
			wf_SetMsg('해당자료가 존재하지 않습니다.')
			uo_year.SetFocus()
	END IF
			dw_update.SetReDraw(TRUE)
   
END IF


end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(dw_update, this, 'member_no')
end event

event constructor;call super::constructor;this.uf_setClick(false)
end event

type dw_update from cuo_dwwindow within tabpage_sheet01
integer x = 663
integer width = 3154
integer height = 2184
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "부양가족 내역"
string dataobject = "d_hpa406a_11"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event itemerror;call super::itemerror;//return 1
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
SetItem(row, 'job_date', 	f_sysdate())	

end event

event constructor;call super::constructor;this.uf_setClick(False)

end event

event losefocus;call super::losefocus;accepttext()
end event

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 3817
integer height = 2184
long backcolor = 79741120
string text = "부양가족 출력"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
st_4 st_4
sle_code1 sle_code1
end type

on tabpage_1.create
this.dw_print=create dw_print
this.st_4=create st_4
this.sle_code1=create sle_code1
this.Control[]={this.dw_print,&
this.st_4,&
this.sle_code1}
end on

on tabpage_1.destroy
destroy(this.dw_print)
destroy(this.st_4)
destroy(this.sle_code1)
end on

type dw_print from cuo_dwwindow within tabpage_1
integer y = 12
integer width = 3799
integer height = 2172
integer taborder = 11
boolean titlebar = true
string dataobject = "d_hpa406a_3"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within tabpage_1
boolean visible = false
integer x = 59
integer y = 124
integer width = 297
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "건물 번호"
boolean focusrectangle = false
end type

type sle_code1 from singlelineedit within tabpage_1
boolean visible = false
integer x = 357
integer y = 112
integer width = 471
integer height = 80
integer taborder = 40
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

event modified;//wf_retrieve()
end event

type uo_year from cuo_year within w_hpa406a
event destroy ( )
integer x = 96
integer y = 80
integer taborder = 90
boolean bringtotop = true
boolean border = false
end type

on uo_year.destroy
call cuo_year::destroy
end on

event constructor;call super::constructor;em_year.text = left(f_today(), 4)

triggerevent('ue_itemchange')
end event

event ue_itemchange;call super::ue_itemchange;is_year = uf_getyy()


end event

type uo_member from cuo_insa_member within w_hpa406a
event destroy ( )
integer x = 1093
integer y = 84
integer taborder = 40
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type gb_1 from groupbox within w_hpa406a
integer x = 14
integer y = 4
integer width = 3840
integer height = 192
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회조건"
end type

