$PBExportHeader$w_hpa107a.srw
$PBExportComments$세금계산과세기준세율표 관리/출력
forward
global type w_hpa107a from w_tabsheet
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type st_back from statictext within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
st_back st_back
end type
type uo_1 from cuo_year within w_hpa107a
end type
type st_mes1 from statictext within w_hpa107a
end type
type st_mes2 from statictext within w_hpa107a
end type
end forward

global type w_hpa107a from w_tabsheet
string title = "세금계산과세기준 세율표 관리/출력"
uo_1 uo_1
st_mes1 st_mes1
st_mes2 st_mes2
end type
global w_hpa107a w_hpa107a

type variables
datawindowchild	idw_child
datawindow			idw_data

statictext			ist_back

string	is_year

end variables

forward prototypes
public function integer wf_retrieve ()
end prototypes

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_name
integer	li_tab



li_tab  = tab_sheet.selectedtab

ist_back.bringtotop = true

if idw_data.retrieve(is_year) > 0 then
	idw_print.retrieve(is_year)
	ist_back.bringtotop = false
else
	idw_print.reset()
end if

return 0
end function

on w_hpa107a.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.st_mes1=create st_mes1
this.st_mes2=create st_mes2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.st_mes1
this.Control[iCurrent+3]=this.st_mes2
end on

on w_hpa107a.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.st_mes1)
destroy(this.st_mes2)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()

return 1
end event

event ue_insert;call super::ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////

integer	li_newrow, li_maxcode



//idw_data.Selectrow(0, false)	

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)
idw_data.scrolltorow(li_newrow)

li_maxcode	= integer(idw_data.describe("evaluate('max(seq_no)', 1)"))
li_maxcode 	++

idw_data.setitem(li_newrow, 'tax_year', 	is_year)
idw_data.setitem(li_newrow, 'seq_no', 		li_maxcode)
idw_data.setitem(li_newrow, 'worker',		gs_empcode)//gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gs_ip)   //gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setcolumn('tax_year')
idw_data.setfocus()



end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
//
//uo_1.st_title.text = '기준년도'
//is_year	=	uo_1.uf_getyy()
//
//triggerevent('ue_retrieve')
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow



//dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
IF idw_data.Update(true) = 1 THEN
	COMMIT;
	triggerevent('ue_retrieve')
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText + '~r~n' )
  ROLLBACK;
END IF


return 1







///////////////////////////////////////////////////////////////
//// 작성목적 : 데이타를 저장한다.		                       //
//// 작성일자 : 2001. 8                                      //
//// 작 성 인 : 						                             //
///////////////////////////////////////////////////////////////
//
//int    i_tab,i_findrow,i_code,i_row = 1,i_rowcount,i,i_process,i_oldprocess,i_gbn
//String s_type,s_fname,s_sname,s_ename,s_processID,s_uid,s_programuser,s_address,s_biscode
//String s_member_no, s_k_name
//cuo_dwwindow dw_name
//
//f_setpointer('START')
//i_tab     = tab_sheet.Selectedtab
//s_uid     = gstru_uid_uname.uid         //사용자 명
//s_address = gstru_uid_uname.address     //사용자 IP
//
//
//choose case i_tab
//	case 1
//
//		  dw_name   = tab_sheet.tabpage_sheet01.dw_update101                   //저장하고자하는 데이타 원도우
//		  i_findrow = tab_sheet.tabpage_sheet01.dw_list001.GetSelectedrow(0)   //현재 저장하고자하는 행번호
//		  IF dw_name.Update(true) = 1 THEN
//			  COMMIT;
//			  s_k_name     = dw_name.GetItemString(i_row,'kname')			  
//			  IF i_findrow < 1 then
//			  	  s_member_no  = dw_name.GetItemString(i_row,'member_no')
//				  i_findrow    = tab_sheet.tabpage_sheet01.dw_list001.Insertrow(0)
//				  tab_sheet.tabpage_sheet01.dw_list001.uf_selectrow(i_findrow)
//				  tab_sheet.tabpage_sheet01.dw_list001.SetItem(i_findrow,'member_no',s_member_no) //관리번호
//			  END IF
//           tab_sheet.tabpage_sheet01.dw_list001.SetItem(i_findrow,'kname',s_k_name) //성명
//		  ELSE
//			  ROLLBACK;
//		  END IF
//
//END CHOOSE		
//
//f_setpointer('END')
//return 1
end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		li_deleterow


wf_setMsg('삭제중')

li_deleterow	=	idw_data.deleterow(0)

wf_setMsg('.')

return 

end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//IF idw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, idw_print)
//
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_data		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_print	=	tab_sheet.tabpage_sheet02.dw_print
ist_back		=	tab_sheet.tabpage_sheet02.st_back

uo_1.st_title.text = '기준년도'
is_year	=	uo_1.uf_getyy()

triggerevent('ue_retrieve')

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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa107a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa107a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa107a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa107a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa107a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa107a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa107a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa107a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa107a
end type

type uc_save from w_tabsheet`uc_save within w_hpa107a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa107a
end type

type uc_print from w_tabsheet`uc_print within w_hpa107a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa107a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa107a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa107a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa107a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa107a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa107a
integer y = 324
integer width = 4384
integer height = 2296
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//	case else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
end event

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 2176
string text = "세금계산과세기준세율표관리"
dw_update dw_update
end type

on tabpage_sheet01.create
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

event dw_list001::clicked;call super::clicked;//String s_memberno
//IF row > 0 then
//	s_memberno = dw_list001.getItemString(row,'member_no')
//	dw_update101.retrieve(s_memberno)
//end IF
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
string dataobject = "d_hpa107a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode )//gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   //gstru_uid_uname.address)
setitem(row, 'job_date',	f_sysdate())
end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

type uo_tab from w_tabsheet`uo_tab within w_hpa107a
end type

type dw_con from w_tabsheet`dw_con within w_hpa107a
boolean visible = false
integer width = 0
integer height = 0
end type

type st_con from w_tabsheet`st_con within w_hpa107a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer x = 4183
integer y = 1812
integer width = 155
integer height = 368
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa107a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event losefocus;call super::losefocus;accepttext()
end event

event itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode) //gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip )  //gstru_uid_uname.address)
setitem(row, 'job_date',	f_sysdate())
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2176
long backcolor = 79741120
string text = "세금계산과세기준세율표내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
st_back st_back
end type

on tabpage_sheet02.create
this.dw_print=create dw_print
this.st_back=create st_back
this.Control[]={this.dw_print,&
this.st_back}
end on

on tabpage_sheet02.destroy
destroy(this.dw_print)
destroy(this.st_back)
end on

type dw_print from cuo_dwprint within tabpage_sheet02
integer width = 4352
integer height = 1828
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa107a_2"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_back from statictext within tabpage_sheet02
integer width = 4352
integer height = 1828
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean focusrectangle = false
end type

type uo_1 from cuo_year within w_hpa107a
integer x = 224
integer y = 180
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_1.destroy
call cuo_year::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_year	=	uf_getyy()

if is_year = '0000' then
	is_year = ''
end if

parent.triggerevent('ue_retrieve')

end event

event constructor;call super::constructor;setposition(totop!)
end event

type st_mes1 from statictext within w_hpa107a
integer x = 1047
integer y = 164
integer width = 2738
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 기준년도에 해당하는 자료가 조회됩니다."
boolean focusrectangle = false
end type

event constructor;setposition(totop!)
end event

type st_mes2 from statictext within w_hpa107a
integer x = 1047
integer y = 224
integer width = 2738
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "   기준년도를 삭제한 후 조회하면 전체 자료가 조회됩니다."
boolean focusrectangle = false
end type

event clicked;setposition(totop!)
end event

