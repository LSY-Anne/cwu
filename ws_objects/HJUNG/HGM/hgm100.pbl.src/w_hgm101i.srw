$PBExportHeader$w_hgm101i.srw
$PBExportComments$거래처 관리
forward
global type w_hgm101i from w_tabsheet
end type
type dw_list from cuo_dwwindow within tabpage_sheet01
end type
type dw_update from uo_dwfree within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print dw_print
end type
end forward

global type w_hgm101i from w_tabsheet
string title = "거래처관리"
end type
global w_hgm101i w_hgm101i

type variables

int ii_tab
datawindowchild idw_child
datawindow idw_name1
end variables

forward prototypes
public subroutine wf_insert ()
public function boolean wf_chk_cust_no (string cust_no)
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_insert ();
int li_row

ii_tab  = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
		
		idw_name1 = tab_sheet.tabpage_sheet01.dw_update
		
		idw_name1.reset()		
		idw_name1.insertrow(0)
		
		idw_name1.object.worker[1] = gs_empcode // gstru_uid_uname.uid      // 작업자 
		idw_name1.object.work_date[1] = f_sysdate()           // 오늘 일자 
		idw_name1.object.ipaddr[1] = gs_ip   //gstru_uid_uname.address  //IP
		idw_name1.object.corp_no_t.text = '법인 번호'
		
		idw_name1.setfocus()

END CHOOSE

end subroutine

public function boolean wf_chk_cust_no (string cust_no);
//boolean 함수명(string cust_no)

int i, sum = 0, li_y, epno_chk, li_epno[10], li_chkvalue[9] = {1,3,7,1,3,7,1,3,5}

For i = 1 to 10
  li_epno[i] = integer(mid(cust_no, i, 1))
Next

For i = 1 to 9
  sum += li_epno[i] * li_chkvalue[i]
Next

sum = sum + ((li_epno[9] * 5) / 10)

li_y = mod(sum, 10)

If li_y = 0 Then 
  epno_chk = 0 
Else
  epno_chk = 10 - li_y
End IF

If epno_chk = li_epno[10] Then
  // 사업자등록번호가 맞음.
  return true
Else
  // 잘못된 사업자 등록번호임.
  return false
End If

end function

public subroutine wf_retrieve ();
string ls_cust_code, ls_cust_name, ls_main_items, ls_business_no


dw_con.accepttext()

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
    
 		ls_cust_code =   trim(dw_con.object.cust_no[1]) + '%' // trim(tab_sheet.tabpage_sheet01.sle_code.text) + '%'
		ls_cust_name =   trim(dw_con.object.cust_name[1]) + '%'  // trim(tab_sheet.tabpage_sheet01.sle_name.text) + '%'
		ls_business_no =  trim(dw_con.object.business_no[1]) + '%'  //trim(tab_sheet.tabpage_sheet01.sle_business_no.text) + '%'
		ls_main_items = '%' +   trim(dw_con.object.main_items[1]) + '%'  //trim(tab_sheet.tabpage_sheet01.sle_main_items.text) + '%'	
		
		If isnull(ls_cust_code) Then ls_cust_code = '%'
		If isnull(ls_cust_name) Then ls_cust_name = '%'
		If isnull(ls_business_no) Then ls_business_no = '%'
		If isnull(ls_main_items) Then ls_main_items = '%%'
		
		
		
		IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( ls_cust_code, ls_cust_name, ls_business_no, ls_main_items) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			wf_insert()
		ELSE	
			tab_sheet.tabpage_1.dw_print.retrieve( ls_cust_code, ls_cust_name ,ls_business_no, ls_main_items)
//			tab_sheet.tabpage_sheet01.dw_update_tab.sharedata(tab_sheet.tabpage_1.dw_print)
			tab_sheet.tabpage_sheet01.dw_update_tab.setfocus()
         tab_sheet.tabpage_sheet01.dw_update_tab.trigger event rowfocuschanged(1)
		END IF	 
     ///////////////////////////////////////////////////////////////////////////////////////
     // 데이타원도우에 출력조건 및 시스템일자 처리
     ///////////////////////////////////////////////////////////////////////////////////////
//     DateTime	ldt_SysDateTime
//     ldt_SysDateTime = f_sysdate()	//시스템일자
//     tab_sheet.tabpage_1.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//     tab_sheet.tabpage_1.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

END CHOOSE		



end subroutine

on w_hgm101i.create
int iCurrent
call super::create
end on

on w_hgm101i.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;
wf_retrieve()
return 1






end event

event ue_insert;call super::ue_insert;
wf_insert()


end event

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////
//// 	작성목적 : 거래처 관리
////    적 성 인 : 윤하영
////		작성일자 : 2002.03.01
////    변 경 인 :
////    변경일자 :
////    변경사유 :
////////////////////////////////////////////////////////////////////
//
//wf_setMenu('I',TRUE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',TRUE)
//wf_setMenu('U',TRUE)
//wf_setMenu('P',TRUE)
//
//idw_name = tab_sheet.tabpage_sheet01.dw_update
//
//f_childretrieve(idw_name,"payment_gbn","payment_class")           		// 지불구분 
//f_childretrieve(idw_name,"cust_tax_gbn","tax_class")                    // 세금구분 
//f_childretrieve(idw_name,"bank_code","bank_code")                    // 세금구분 
//
////DataWindowChild	ldwc_Temp
////idw_name.GetChild("bank_code",ldwc_Temp)
////ldwc_Temp.SetTransObject(SQLCA)
////IF ldwc_Temp.Retrieve('%') = 0 THEN
////	MessageBox('확인','은행지점코드를 입력하시기 바랍니다.')
////	ldwc_Temp.InsertRow(0)
////ENd IF
//
//
//wf_retrieve()
//
////this.postevent("ue_insert")
//
//
//
//
end event

event ue_save;call super::ue_save;
int 		li_count, li_count2
string 	ls_cust_no, ls_large_code, ls_DATE, ls_business_no
BOOLEAN	lb_cust_flag

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

     idw_name1 = tab_sheet.tabpage_sheet01.dw_update
	   
	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN -1
	  
	  	 dwItemStatus l_status 
	  	 l_status = idw_name1.getitemstatus(1, 0, Primary!)
	
	  IF l_status = New! OR l_status = NewModified! OR l_status = dataModified! THEN 
			string ls_colarry[]
		
			if idw_name1.object.business_opt[1] = '1' then	//법인
				ls_colarry[] = {'cust_name/거래처명','business_no/사업자번호','measure/단가','apply_price/예상단가'}
			elseif idw_name1.object.business_opt[1] = '2' then	//개인
				ls_colarry[] = {'cust_name/거래처명','measure/단가','apply_price/예상단가'}
			end if
		
		  IF f_chk_null( idw_name1, ls_colarry ) = 1 THEN  
			  idw_name1.object.job_uid[1] =  gs_empcode //gstru_uid_uname.uid		//수정자
			  idw_name1.object.job_date[1] = f_sysdate()           // 오늘 일자 
			  idw_name1.object.job_add[1] = gs_ip   //gstru_uid_uname.address  //IP
		  ELSE
			 RETURN -1
		  END IF	
	  
	  
			 IF l_status = New! OR l_status = NewModified! THEN
		        SELECT NVL(MAX(CUST_NO),'0')
				  INTO :ls_cust_no
				  FROM STDB.HST001M  
				  WHERE CUST_NO < '9999998';
				  
				  idw_name1.object.cust_no[1] = string(long(ls_cust_no) + 1,'0000000')

				  lb_cust_flag	=	wf_chk_cust_no(ls_cust_no)
			  
				  ls_cust_no = idw_name1.object.cust_no[1]
			     SELECT count(cust_no)                   // 거래처번호 중복 체크
				  INTO 	:li_count
				  FROM   STDB.HST001M
				  WHERE  CUST_NO = :ls_cust_no   ;
			  
				  IF li_count <> 0 THEN 
			        messagebox("확인","이미 등록되어 있는 거래처 코드입니다. 거래처 코드를 확인하세요")
					  idw_name1.setfocus()
					  idw_name1.setcolumn("business_no")
			        RETURN -1
				  END IF
			  
				  ls_business_no = idw_name1.object.business_no[1]  // 사업자 번호 중복체크
				   SELECT count(business_no)
			   	INTO 	 :li_count2
				   FROM   STDB.HST001M
				   WHERE  business_no = :ls_business_no   ;
			  
				  IF li_count2 <> 0 THEN 
		   	     messagebox("확인","이미 등록되어 있는 사업자 번호입니다. 사업자 번호를 확인하세요")
					  idw_name1.setfocus()
					  idw_name1.setcolumn("corp_no")
			        RETURN -1
				  END IF
			END IF

		    IF f_update( idw_name1,'U') = TRUE THEN 
				
				String ls_cust_code, ls_cust_name, ls_main_items   // 저장후 리스트에서 자료 찾기
				int  li_row
				ls_cust_code =  trim(dw_con.object.cust_no[1]) + '%'  //trim(tab_sheet.tabpage_sheet01.sle_code.text) + '%'
				      ls_cust_name =  trim(dw_con.object.cust_name[1]) + '%'  // trim(tab_sheet.tabpage_sheet01.sle_name.text) + '%'
				      ls_business_no =  trim(dw_con.object.business_no[1]) + '%'  // trim(tab_sheet.tabpage_sheet01.sle_business_no.text) + '%'
				      ls_main_items = '%' +  trim(dw_con.object.main_items[1]) + '%'  // trim(tab_sheet.tabpage_sheet01.sle_main_items.text) + '%'	
				      
				      If isnull(ls_cust_code) Then ls_cust_code = '%'
				If isnull(ls_cust_name) Then ls_cust_name = '%'
				If isnull(ls_business_no) Then ls_business_no = '%'
				If isnull(ls_main_items) Then ls_main_items = '%%'
				ls_cust_no   = tab_sheet.tabpage_sheet01.dw_update.object.cust_no[1]
				
				tab_sheet.tabpage_sheet01.dw_update_tab.retrieve(ls_cust_code, ls_cust_name, ls_business_no, ls_main_items)
            li_row     = tab_sheet.tabpage_sheet01.dw_update_tab.Find("cust_no = '" + ls_cust_no + "'",1,tab_sheet.tabpage_sheet01.dw_update_tab.rowcount())
			
//			   tab_sheet.tabpage_sheet01.dw_update_tab.SELECTROW(0    ,FALSE)
				If li_row > 0 then   
//					tab_sheet.tabpage_sheet01.dw_update_tab.SELECTROW(li_row,tRUE)	
					tab_sheet.tabpage_sheet01.dw_update_tab.Setrow(li_row)
					tab_sheet.tabpage_sheet01.dw_update_tab.ScrollToRow(li_row)
				end IF
				
			 	wf_setmsg("저장되었습니다")
		    END IF
	  END IF
END CHOOSE
end event

event ue_delete;call super::ue_delete;
int li_tab

li_tab = tab_sheet.selectedtab

CHOOSE CASE li_tab
		
	CASE 1

	   idw_name1 = tab_sheet.tabpage_sheet01.dw_update
      
		IF idw_name1.object.cust_no[1] = '9999998' OR idw_name1.object.cust_no[1] = '9999999'THEN
			messagebox('확인','이거래처는 삭제 할수 없습니다..!')
			RETURN
		END IF
	   dwItemStatus l_status 
		l_status = idw_name1.getitemstatus(1, 0, Primary!)
	
		IF l_status = New! OR l_status = NewModified! THEN 
				  
		ELSE
			
			IF f_messagebox( '2', 'DEL' ) = 1 THEN
	
				idw_name1.deleterow(0)
				
				IF f_update( idw_name1,'D') = TRUE THEN 
					wf_setmsg("삭제되었습니다")
					wf_retrieve()
					this.triggerevent("ue_insert")
				END IF	
       
	       END IF
		END IF
END CHOOSE		




end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////
// 	작성목적 : 거래처 관리
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

//wf_setMenu('I',TRUE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',TRUE)
//wf_setMenu('U',TRUE)
//wf_setMenu('P',TRUE)

idw_name1 = tab_sheet.tabpage_sheet01.dw_update
idw_print = tab_sheet.tabpage_1.dw_print

f_childretrieve(idw_name1,"payment_gbn","payment_class")           		// 지불구분 
f_childretrieve(idw_name1,"cust_tax_gbn","tax_class")                    // 세금구분 
f_childretrieve(idw_name1,"bank_code","bank_code")                    // 세금구분 

func.of_design_dw(idw_name1)
idw_name1.settransobject(sqlca)
idw_name1.insertrow(0)

//DataWindowChild	ldwc_Temp
//idw_name1.GetChild("bank_code",ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('%') = 0 THEN
//	MessageBox('확인','은행지점코드를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ENd IF


wf_retrieve()

//this.postevent("ue_insert")




end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "거래선 리스트")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hgm101i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hgm101i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hgm101i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hgm101i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hgm101i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hgm101i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hgm101i
end type

type uc_insert from w_tabsheet`uc_insert within w_hgm101i
end type

type uc_delete from w_tabsheet`uc_delete within w_hgm101i
end type

type uc_save from w_tabsheet`uc_save within w_hgm101i
end type

type uc_excel from w_tabsheet`uc_excel within w_hgm101i
end type

type uc_print from w_tabsheet`uc_print within w_hgm101i
end type

type st_line1 from w_tabsheet`st_line1 within w_hgm101i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hgm101i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hgm101i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hgm101i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hgm101i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hgm101i
event create ( )
event destroy ( )
integer y = 324
integer width = 4379
integer height = 1968
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_1 tabpage_1
end type

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

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		f_setpointer('START')
//      wf_retrieve()
//		f_setpointer('END')		
//end choose
end event

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4343
integer height = 1848
long backcolor = 1073741824
string text = "거래처 관리"
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
integer y = 356
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
integer x = 0
integer y = 16
integer width = 1737
integer height = 1836
boolean titlebar = true
string title = "조회내용"
string dataobject = "d_hgm101i_1"
end type

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

long ll_row
string ls_cust_no

//idw_name = tab_sheet.tabpage_sheet01.dw_update_tab

//idw_name.accepttext()
This.accepttext()
IF currentrow <> 0 THEN

	ls_cust_no = this.object.cust_no[currentrow]
	
	tab_sheet.tabpage_sheet01.dw_update.retrieve( ls_cust_no) 

END IF

end event

type uo_tab from w_tabsheet`uo_tab within w_hgm101i
integer x = 1097
integer y = 300
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hgm101i
string dataobject = "d_hgm101i_con"
end type

event dw_con::itemchanged;call super::itemchanged;This.accepttext()

wf_retrieve()

end event

event dw_con::getfocus;call super::getfocus;//f_pro_toggle('k',handle(parent))
end event

type st_con from w_tabsheet`st_con within w_hgm101i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type dw_list from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer x = 23
integer y = 32
integer width = 0
integer height = 0
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "조회내용"
string dataobject = "d_hgm101i_1"
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

long ll_row
string ls_cust_no

idw_name = tab_sheet.tabpage_sheet01.dw_list

idw_name.accepttext()

IF currentrow <> 0 THEN

	ls_cust_no = idw_name.object.cust_no[currentrow]
	
	tab_sheet.tabpage_sheet01.dw_update.retrieve( ls_cust_no) 

END IF

end event

type dw_update from uo_dwfree within tabpage_sheet01
integer x = 1751
integer y = 16
integer width = 2587
integer height = 1836
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hgm101i_2"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;////////////////////////////////////////////////////////////////////////////////////////// 
// 이 벤 트 명: buttonclikced::dw_update1
// 기 능 설 명: 우편번호 처리
// 작성/수정자: 
// 작성/수정일: 
// 주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
IF row = 0 THEN RETURN
IF UPPER(THIS.Object.DataWindow.ReadOnly) = 'YES' THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
//String ls_ColName 
//String ls_ColData
//ls_ColName = STRING(dwo.name)
//
//CHOOSE CASE ls_ColName
// CASE 'btn_post_no'
//  String ls_Addr
//
//  open(w_zipcode)
// 
//  ls_addr = message.stringparm
// 
//  if isnull(ls_addr) or trim(ls_addr) = '' then return
//  ls_addr = trim(ls_addr)
// 
//  IF ls_ColName = 'btn_post_no' THEN
//   THIS.Object.postno[row] = left(ls_addr,6)
//   THIS.Object.addr1 [row] = mid(ls_addr,7)
//   setcolumn('addr1')
//  END IF

// CASE ELSE
//END CHOOSE

Vector lvc_data

lvc_data = Create Vector

Choose Case dwo.name
 Case 'btn_post_no'
  lvc_data.SetProperty('parm_cnt', '0')
  lvc_data.SetProperty('parm_str01', This.Object.postno[row])
  
  If  OpenWithParm(w_post_pop, lvc_data) = 1 Then
   lvc_data = Message.PowerObjectParm
   If isvalid(lvc_data) Then
    This.Object.postno[row]  = lvc_data.GetProperty("parm_str01")
    This.Object.addr1[row]    = lvc_data.GetProperty("parm_str03")
   ENd If
  End IF
End Choose

////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE',true) //정장버튼 활성황

if row > 0 then
	if data = '1' then		//법인
		this.object.corp_no_t.text = '법인 번호'
	elseif data = '2' then		//개인
		this.object.corp_no_t.text = '주민등록번호'
	end if
end if
	
end event

event retrieveend;call super::retrieveend;if rowcount > 0 then
	if this.object.business_opt[rowcount] = '1' then		//법인
		this.object.corp_no_t.text = '법인 번호'
	elseif this.object.business_opt[rowcount] = '2' then		//개인
		this.object.corp_no_t.text = '주민등록번호'
	end if
end if

end event

type tabpage_1 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4343
integer height = 1848
string text = "거래처 출력"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_1.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_1.destroy
destroy(this.dw_print)
end on

type dw_print from datawindow within tabpage_1
integer y = 4
integer width = 4343
integer height = 1840
integer taborder = 30
string title = "none"
string dataobject = "d_hgm101i_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

