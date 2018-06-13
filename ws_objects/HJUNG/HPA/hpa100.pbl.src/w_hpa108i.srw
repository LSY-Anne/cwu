$PBExportHeader$w_hpa108i.srw
$PBExportComments$세금공제기준 관리/생성//back up
forward
global type w_hpa108i from w_tabsheet
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_list002 from cuo_dwwindow within tabpage_sheet02
end type
type gb_5 from groupbox within tabpage_sheet02
end type
type gb_7 from groupbox within tabpage_sheet02
end type
type uo_1 from cuo_year within tabpage_sheet02
end type
type st_31 from statictext within tabpage_sheet02
end type
type uo_2 from cuo_year within tabpage_sheet02
end type
type st_4 from statictext within tabpage_sheet02
end type
type pb_create1 from picturebutton within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_list002 dw_list002
gb_5 gb_5
gb_7 gb_7
uo_1 uo_1
st_31 st_31
uo_2 uo_2
st_4 st_4
pb_create1 pb_create1
end type
end forward

global type w_hpa108i from w_tabsheet
string title = "세금공제기준 관리"
end type
global w_hpa108i w_hpa108i

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_data,  idw_preview

statictext			ist_back


end variables

forward prototypes
public function integer wf_retrieve ()
public subroutine wf_dwcopy ()
public function integer wf_create ()
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

idw_list.retrieve()
idw_preview.retrieve()

return 0
end function

public subroutine wf_dwcopy ();// ==========================================================================================
// 기    능 : 	데이타윈도우에 값을 넣는다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_dwcopy()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_val[]
long		ll_row

ll_row	=	idw_list.getrow()

idw_data.reset()

if ll_row < 1 then	return

ll_row = idw_list.rowscopy(ll_row, ll_row, primary!, idw_data, 1, primary!) 

end subroutine

public function integer wf_create ();// ==========================================================================================
// 기    능 : 	자료를 생성한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	reutrn	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 생성처리한다.
string	ls_year1, ls_year2
integer	li_cnt

ls_year1 = tab_sheet.tabpage_sheet02.uo_1.uf_getyy()
ls_year2 = tab_sheet.tabpage_sheet02.uo_2.uf_getyy()

select	count(*)
into		:li_cnt
from		padb.hpa014m
where		sub_year	=	:ls_year1	;

if li_cnt < 1 then
	f_messagebox('1', ls_year1 + '년도 자료가 존재하지 않습니다.!')
	return	100
end if

select	count(*)
into		:li_cnt
from		padb.hpa014m
where		sub_year	=	:ls_year2	;

if li_cnt > 0 then
	if f_messagebox('2', ls_year2 + '년도 자료가 이미 존재합니다. 삭제 후 생성하시겠습니까?') = 2 then	
		return	100
	else
		delete	from	padb.hpa014m
		where		sub_year	=	:ls_year2	;
		
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	end if
end if

insert	into	padb.hpa014m
select	:ls_year2, sub_income, sub_rate1, sub_income2, sub_rate2, sub_income3, sub_rate3, 
			sub_income4, sub_rate4, sub_income5, sub_rate5,
			sub_income_max, sub_basic, sub_addition1, sub_addition2, sub_add1, sub_add2, sub_standard,
			sub_labor1, sub_labor_rate1, sub_labor2, sub_labor_rate2, sub_labor_max,
			etc1, etc2, etc3, 
			medical_limit_amt, constribution_limit_amt, pension_indi_limit_amt, pension_limit_amt,
			:gs_empcode, :gs_ip, sysdate,
			:gs_empcode, :gs_ip, sysdate
from		padb.hpa014m
where		sub_year	=	:ls_year1	;

return	sqlca.sqlcode

end function

on w_hpa108i.create
int iCurrent
call super::create
end on

on w_hpa108i.destroy
call super::destroy
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

integer	li_newrow, li_newrow2



//idw_data.Selectrow(0, false)	

idw_data.reset()
li_newrow	=	1
idw_data.insertrow(li_newrow)

li_newrow2	=	idw_list.getrow() + 1
idw_list.insertrow(li_newrow2)
idw_list.setrow(li_newrow2)
idw_list.scrolltorow(li_newrow2)

idw_data.setrow(li_newrow)

idw_data.setcolumn('sub_year')
idw_data.setfocus()

idw_list.setitem(li_newrow2, 'worker',		gs_empcode)
idw_list.setitem(li_newrow2, 'ipaddr',		gs_ip)
idw_list.setitem(li_newrow2, 'work_date',	f_sysdate())



end event

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_list		=	tab_sheet.tabpage_sheet01.dw_list001
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_preview	=	tab_sheet.tabpage_sheet02.dw_list002

tab_sheet.tabpage_sheet02.uo_1.st_title.text = '기준년도'
tab_sheet.tabpage_sheet02.uo_2.st_title.text = '생성년도'

triggerevent('ue_retrieve')

end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow



dw_name   = idw_list  	                 		//저장하고자하는 데이타 원도우

//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
IF dw_name.Update(true) = 1 THEN
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
//s_uid     = gs_empcode         //사용자 명
//s_address = gs_ip     //사용자 IP
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

idw_list.deleterow(0)

wf_setMsg('.')

return 

end event

event ue_print;call super::ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 자료출력 처리
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

IF idw_print.RowCount() < 1 THEN	return

OpenWithParm(w_printoption, idw_print)

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa108i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa108i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa108i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa108i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa108i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa108i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa108i
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa108i
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa108i
end type

type uc_save from w_tabsheet`uc_save within w_hpa108i
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa108i
end type

type uc_print from w_tabsheet`uc_print within w_hpa108i
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa108i
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa108i
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa108i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa108i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa108i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa108i
integer y = 4
integer width = 3881
integer height = 2516
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
integer width = 3845
integer height = 2400
string text = "세금공제기준관리"
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
integer width = 704
integer height = 2400
string dataobject = "d_hpa108i_1"
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

event dw_list001::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then	
	idw_data.reset()
	return
end if

//selectrow(0, false)
//selectrow(currentrow, true)

string	ls_year

ls_year	=	getitemstring(currentrow, 'sub_year')

//idw_data.retrieve(ls_year)
wf_dwcopy()

end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then
	idw_data.reset()
	return
end if

//selectrow(0, false)
//selectrow(1, true)

trigger event rowfocuschanged(getrow())

end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
end type

type uo_tab from w_tabsheet`uo_tab within w_hpa108i
end type

type dw_con from w_tabsheet`dw_con within w_hpa108i
end type

type st_con from w_tabsheet`st_con within w_hpa108i
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
integer x = 709
integer width = 3136
integer height = 2400
integer taborder = 20
string dataobject = "d_hpa108i_2"
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event losefocus;call super::losefocus;accepttext()

end event

event itemchanged;call super::itemchanged;string	ls_col, ls_type
long		ll_row

ll_row	=	idw_list.getrow()
ls_col 	=	dwo.name
ls_type 	=	describe(ls_col + ".coltype")

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(ll_row, ls_col, dec(data))
elseif ls_type = 'date' then
	idw_list.setitem(ll_row, ls_col, date(data))
else	
	idw_list.setitem(ll_row, ls_col, data)
end if

idw_list.setitem(ll_row, 'job_uid',		gs_empcode)
idw_list.setitem(ll_row, 'job_add',		gs_ip)
idw_list.setitem(ll_row, 'job_date',	f_sysdate())

end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 3845
integer height = 2400
long backcolor = 79741120
string text = "세금공제기준생성"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list002 dw_list002
gb_5 gb_5
gb_7 gb_7
uo_1 uo_1
st_31 st_31
uo_2 uo_2
st_4 st_4
pb_create1 pb_create1
end type

on tabpage_sheet02.create
this.dw_list002=create dw_list002
this.gb_5=create gb_5
this.gb_7=create gb_7
this.uo_1=create uo_1
this.st_31=create st_31
this.uo_2=create uo_2
this.st_4=create st_4
this.pb_create1=create pb_create1
this.Control[]={this.dw_list002,&
this.gb_5,&
this.gb_7,&
this.uo_1,&
this.st_31,&
this.uo_2,&
this.st_4,&
this.pb_create1}
end on

on tabpage_sheet02.destroy
destroy(this.dw_list002)
destroy(this.gb_5)
destroy(this.gb_7)
destroy(this.uo_1)
destroy(this.st_31)
destroy(this.uo_2)
destroy(this.st_4)
destroy(this.pb_create1)
end on

type dw_list002 from cuo_dwwindow within tabpage_sheet02
integer x = 5
integer y = 328
integer width = 3845
integer height = 2080
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hpa108i_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(true)
end event

event retrieveend;call super::retrieveend;//selectrow(0, false)
//selectrow(1, true)

end event

type gb_5 from groupbox within tabpage_sheet02
integer y = -20
integer width = 2853
integer height = 336
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_7 from groupbox within tabpage_sheet02
integer x = 2857
integer y = -20
integer width = 987
integer height = 336
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_1 from cuo_year within tabpage_sheet02
integer x = 270
integer y = 56
integer taborder = 90
boolean bringtotop = true
boolean border = false
end type

on uo_1.destroy
call cuo_year::destroy
end on

type st_31 from statictext within tabpage_sheet02
integer x = 1083
integer y = 76
integer width = 270
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "의 자료를"
boolean focusrectangle = false
end type

type uo_2 from cuo_year within tabpage_sheet02
integer x = 270
integer y = 180
integer taborder = 100
boolean bringtotop = true
boolean border = false
end type

on uo_2.destroy
call cuo_year::destroy
end on

type st_4 from statictext within tabpage_sheet02
integer x = 1083
integer y = 200
integer width = 590
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "의 자료로 생성합니다."
boolean focusrectangle = false
end type

type pb_create1 from picturebutton within tabpage_sheet02
integer x = 3131
integer y = 104
integer width = 480
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "   생성처리"
string picturename = "..\bmp\PROCES_E.BMP"
string disabledname = "..\bmp\PROCES_D.BMP"
vtextalign vtextalign = vcenter!
end type

event clicked;// 생성처리한다.
integer	li_rtn

setpointer(hourglass!)

li_rtn = wf_create()

setpointer(arrow!)

if	li_rtn = 0 then
	commit	;
	
	wf_retrieve()
	
	f_messagebox('1', '자료를 생성했습니다.!')
elseif li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
	wf_retrieve()
end if

end event

