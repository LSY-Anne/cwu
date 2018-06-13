$PBExportHeader$w_hpa306a.srw
$PBExportComments$항목별 금액 관리/출력
forward
global type w_hpa306a from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type uo_3 from cuo_search_insa within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type gb_2 from groupbox within tabpage_sheet02
end type
type rb_4 from radiobutton within tabpage_sheet02
end type
type rb_5 from radiobutton within tabpage_sheet02
end type
type rb_3 from radiobutton within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
gb_2 gb_2
rb_4 rb_4
rb_5 rb_5
rb_3 rb_3
end type
type uo_yearmonth from cuo_yearmonth within w_hpa306a
end type
type rb_1 from radiobutton within w_hpa306a
end type
type rb_2 from radiobutton within w_hpa306a
end type
type dw_head2 from datawindow within w_hpa306a
end type
type dw_head1 from datawindow within w_hpa306a
end type
type st_41 from statictext within w_hpa306a
end type
type dw_list002 from datawindow within w_hpa306a
end type
type st_1 from statictext within w_hpa306a
end type
type st_2 from statictext within w_hpa306a
end type
type dw_update2 from datawindow within w_hpa306a
end type
end forward

global type w_hpa306a from w_tabsheet
integer height = 2440
string title = "입력항목 금액 관리"
uo_yearmonth uo_yearmonth
rb_1 rb_1
rb_2 rb_2
dw_head2 dw_head2
dw_head1 dw_head1
st_41 st_41
dw_list002 dw_list002
st_1 st_1
st_2 st_2
dw_update2 dw_update2
end type
global w_hpa306a w_hpa306a

type variables
datawindowchild	idw_child, idw_kname_child
datawindow			idw_data,  idw_item, idw_delete

statictext			ist_back

string	is_str_opt	=	'1'
string	is_end_opt	=	'3'
string	is_pay_opt = '1', is_yearmonth
string	is_code, is_name, is_pay_date
integer	ii_str_jikjong	=	0, ii_end_jikjong = 9

long		il_confirm_gbn
end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_getchild2 ()
public subroutine wf_head_retrieve ()
public function integer wf_retrieve ()
public subroutine wf_confirm_gbn ()
end prototypes

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 항목구분
idw_data.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

wf_getchild2()

end subroutine

public subroutine wf_getchild2 ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild2()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

idw_data.getchild('member_no', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_data.getchild('hpa001m_name', idw_kname_child)
idw_kname_child.settransobject(sqlca)
if idw_kname_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
	idw_kname_child.reset()
	idw_kname_child.insertrow(0)
end if

end subroutine

public subroutine wf_head_retrieve ();// ==========================================================================================
// 기    능 : 	급여항목을 지급구분(수당/공제)에 따라서 Retrieve 한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_head_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

dw_head2.reset()
dw_head2.insertrow(0)

dw_head2.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(is_pay_opt, is_str_opt, is_end_opt) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

wf_getchild()


end subroutine

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

idw_delete.reset()

if idw_data.retrieve(is_yearmonth, is_code, ii_str_jikjong, ii_end_jikjong) > 0 then
	idw_print.retrieve(is_yearmonth, is_code, ii_str_jikjong, ii_end_jikjong)
	
else
	idw_print.reset()
end if


return 0
end function

public subroutine wf_confirm_gbn ();// 급여의 확정상태를 확인한다.
// 확정된 상태이면 자료를 입력, 수정, 삭제할 수 없다.
il_confirm_gbn	=	f_getconfirm('%',is_yearmonth, 'N')

//if il_confirm_gbn	=	0	then
//	wf_setMenu('INSERT',		TRUE)
//	wf_setMenu('DELETE',		TRUE)
//	wf_setMenu('UPDATE',		TRUE)
//else
//	wf_setMenu('INSERT',		FALSE)
//	wf_setMenu('DELETE',		FALSE)
//	wf_setMenu('UPDATE',		FALSE)
//end if			
end subroutine

on w_hpa306a.create
int iCurrent
call super::create
this.uo_yearmonth=create uo_yearmonth
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_head2=create dw_head2
this.dw_head1=create dw_head1
this.st_41=create st_41
this.dw_list002=create dw_list002
this.st_1=create st_1
this.st_2=create st_2
this.dw_update2=create dw_update2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_yearmonth
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.dw_head2
this.Control[iCurrent+5]=this.dw_head1
this.Control[iCurrent+6]=this.st_41
this.Control[iCurrent+7]=this.dw_list002
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_update2
end on

on w_hpa306a.destroy
call super::destroy
destroy(this.uo_yearmonth)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_head2)
destroy(this.dw_head1)
destroy(this.st_41)
destroy(this.dw_list002)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_update2)
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

integer	li_newrow, li_sort, li_excepte_gbn

if isnull(is_pay_opt) or trim(is_pay_opt) = '' then
	f_messagebox('1', '급여항목 지급구분을 선택해 주세요.!')
	return 
end if
	
if isnull(is_code) or trim(is_code) = '' then
	f_messagebox('1', '급여항목을 선택해 주세요.!')
	dw_head2.setfocus()
	return 
end if



string ls_chasu
long ll_row
ll_row = idw_data.rowcount()
if ll_row <> 0 then
   ls_chasu = idw_data.getitemstring(1,'chasu')  
   ls_chasu = gf_nvl(ls_chasu,'0')
else
	ls_chasu = '0'
end if	

if ls_chasu = '0' then
	
	select chasu
	  into :ls_chasu
	  from padb.hpa005d
	 where year_month =:is_yearmonth
	   and code       =:is_code;
		
	if sqlca.sqlcode = -1 then
		messagebox('','월급여 테이블 오류입니다.! 전산실로 연락하여 주시기 바랍니다.')
		return //sqlca.sqlcode
	elseif sqlca.sqlcode = 100 then
		ls_chasu = ' '
	end if
end if	

idw_data.Selectrow(0, false)	

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)
idw_data.scrolltorow(li_newrow)

is_pay_date = is_yearmonth + '25'

idw_data.setitem(li_newrow, 'year_month', is_yearmonth)
idw_data.setitem(li_newrow, 'pay_date', 	is_pay_date)
idw_data.setitem(li_newrow, 'code', 		is_code)
idw_data.setitem(li_newrow, 'chasu', 		ls_chasu)


select	sort, excepte_gbn
into		:li_sort, :li_excepte_gbn
from		padb.hpa003m
where		code	=	:is_code	;

idw_data.setitem(li_newrow, 'item_name',				is_name)
idw_data.setitem(li_newrow, 'excepte_gbn',	li_excepte_gbn)
idw_data.setitem(li_newrow, 'sort', 			li_sort)

idw_data.setitem(li_newrow, 'worker',		gs_empcode)
idw_data.setitem(li_newrow, 'ipaddr',		gs_ip)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setcolumn('pay_date')
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
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update_tab
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//idw_delete	=	dw_update2
//
//idw_item		=	dw_list002
//
//f_getdwcommon(dw_head1, 'jikjong_code', 0, 750)
//ii_str_jikjong	=	0
//ii_end_jikjong	=	9
//
//uo_yearmonth.uf_settitle('지급년월')
//is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
//
//tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_data,		'member_no', 'hpa001m_name')
//
//// 급여확정여부를 체크한다.
//wf_confirm_gbn()
//
//wf_head_retrieve()
//
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow
long		ll_row, ll_rowcount
string	ls_member_no, ls_Chasu



dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우
dw_name.accepttext()
li_findrow = dw_name.getrow() 	  	//현재 저장하고자하는 행번호
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

end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

long		ll_deleterow


wf_setMsg('삭제중')

ll_deleterow	=	idw_data.getrow()

idw_data.rowscopy(ll_deleterow, ll_deleterow, primary!, idw_delete, 1, primary!) 
idw_delete.setitem(ll_deleterow, 'pay_amt', 			0)
idw_delete.setitem(ll_deleterow, 'nontax_amt', 	0)

ll_deleterow	=	idw_data.deleterow(0)

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
idw_delete	=	dw_update2

idw_item		=	dw_list002

f_getdwcommon(dw_head1, 'jikjong_code', 0, 750)
ii_str_jikjong	=	0
ii_end_jikjong	=	9

uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_data,		'member_no', 'hpa001m_name')

// 급여확정여부를 체크한다.
wf_confirm_gbn()

wf_head_retrieve()


end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "항목별 금액내역")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa306a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa306a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa306a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa306a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa306a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa306a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa306a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa306a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa306a
end type

type uc_save from w_tabsheet`uc_save within w_hpa306a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa306a
end type

type uc_print from w_tabsheet`uc_print within w_hpa306a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa306a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa306a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa306a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa306a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa306a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa306a
event create ( )
event destroy ( )
integer y = 324
integer width = 4384
integer height = 1940
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
end type

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

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case	1
//		if il_confirm_gbn = 0 then
//			wf_setMenu('INSERT',		TRUE)
//			wf_setMenu('DELETE',		TRUE)
//			wf_setMenu('UPDATE',		TRUE)
//		else
//			wf_setMenu('INSERT',		FALSE)
//			wf_setMenu('DELETE',		FALSE)
//			wf_setMenu('UPDATE',		FALSE)
//		end if		
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('PRINT',		FALSE)
//	
//	case	2
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
//
//	case	else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		FALSE)
//end choose
end event

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 1820
string text = "항목별금액관리"
gb_4 gb_4
uo_3 uo_3
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.uo_3=create uo_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.uo_3
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.uo_3)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 1276
integer width = 3995
integer height = 976
borderstyle borderstyle = stylelowered!
end type

event dw_list001::clicked;call super::clicked;//String s_memberno
//IF row > 0 then
//	s_memberno = dw_list001.getItemString(row,'member_no')
//	dw_update101.retrieve(s_memberno)
//end IF
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 168
integer width = 4343
integer height = 1660
string dataobject = "d_hpa306a_1"
boolean hsplitscroll = true
end type

event dw_update_tab::itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
long		ll_row

if dwo.name = 'member_no' then
	ll_row	=	idw_child.find("member_no = '" + data + "'	", 1, idw_child.rowcount())
	if ll_row > 0 then
		setitem(row, 'hpa001m_name', idw_child.getitemstring(idw_child.getrow(), 'name'))
	else
		setitem(row, 'hpa001m_name', '')
	end if
elseif dwo.name = 'hpa001m_name' then
	ll_row	=	idw_kname_child.find("name = '" + data + "'	", 1, idw_kname_child.rowcount())
	if ll_row > 0 then
		setitem(row, 'member_no',	idw_child.getitemstring(idw_kname_child.getrow(), 'member_no'))
	else
		setitem(row, 'member_no',	'')
	end if
end if

setitem(row, 'isrowmodified',	1)

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
SetItem(row, 'job_date', 	f_sysdate())	

end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then
	dw_head2.setfocus()
else
	setfocus()
end if
end event

type uo_tab from w_tabsheet`uo_tab within w_hpa306a
end type

type dw_con from w_tabsheet`dw_con within w_hpa306a
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hpa306a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type gb_4 from groupbox within tabpage_sheet01
integer y = -20
integer width = 4347
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type uo_3 from cuo_search_insa within tabpage_sheet01
integer x = 114
integer y = 40
integer width = 3566
integer taborder = 60
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search_insa::destroy
end on

type tabpage_sheet02 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1820
string text = "항목별금액내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
gb_2 gb_2
rb_4 rb_4
rb_5 rb_5
rb_3 rb_3
end type

on tabpage_sheet02.create
this.dw_print=create dw_print
this.gb_2=create gb_2
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_3=create rb_3
this.Control[]={this.dw_print,&
this.gb_2,&
this.rb_4,&
this.rb_5,&
this.rb_3}
end on

on tabpage_sheet02.destroy
destroy(this.dw_print)
destroy(this.gb_2)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_3)
end on

type dw_print from cuo_dwprint within tabpage_sheet02
integer y = 196
integer width = 4347
integer height = 1628
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa306a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type gb_2 from groupbox within tabpage_sheet02
integer x = 27
integer y = 16
integer width = 1413
integer height = 164
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "선택"
end type

type rb_4 from radiobutton within tabpage_sheet02
integer x = 91
integer y = 84
integer width = 338
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "직급별"
end type

event clicked;tab_sheet.tabpage_sheet02.dw_print.dataobject = 'd_hpa306a_4'                 // 직급별 
tab_sheet.tabpage_sheet02.dw_print.settransobject(sqlca)
tab_sheet.tabpage_sheet02.dw_print.Object.DataWindow.Print.Preview = 'YES'

end event

type rb_5 from radiobutton within tabpage_sheet02
integer x = 576
integer y = 84
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "직종별"
end type

event clicked;tab_sheet.tabpage_sheet02.dw_print.dataobject = 'd_hpa306a_3'                 // 직종별 
tab_sheet.tabpage_sheet02.dw_print.settransobject(sqlca)
tab_sheet.tabpage_sheet02.dw_print.Object.DataWindow.Print.Preview = 'YES'

end event

type rb_3 from radiobutton within tabpage_sheet02
integer x = 1070
integer y = 84
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "사번별"
end type

event clicked;tab_sheet.tabpage_sheet02.dw_print.dataobject = 'd_hpa306a_2'                 // 사번별 
tab_sheet.tabpage_sheet02.dw_print.settransobject(sqlca)
tab_sheet.tabpage_sheet02.dw_print.Object.DataWindow.Print.Preview = 'YES'

end event

type uo_yearmonth from cuo_yearmonth within w_hpa306a
event destroy ( )
integer x = 91
integer y = 176
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yearmonth	=	uf_getyearmonth()

wf_confirm_gbn()


end event

type rb_1 from radiobutton within w_hpa306a
integer x = 1984
integer y = 184
integer width = 238
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "수당"
boolean checked = true
end type

event clicked;is_pay_opt = '1'
wf_head_retrieve()


end event

type rb_2 from radiobutton within w_hpa306a
integer x = 2217
integer y = 184
integer width = 238
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "공제"
end type

event clicked;is_pay_opt = '2'
wf_head_retrieve()


end event

type dw_head2 from datawindow within w_hpa306a
integer x = 2450
integer y = 176
integer width = 1125
integer height = 88
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_item_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) then	
	is_code	= ''
	is_name	= ''
	return
end if
accepttext()

is_code	=	string(data)
is_name	=	getitemstring(row, 'code_name')
is_name	=	mid(is_name, 6, len(is_name))

//parent.triggerevent('ue_retrieve')

end event

event itemfocuschanged;triggerevent(itemchanged!)

end event

type dw_head1 from datawindow within w_hpa306a
integer x = 1134
integer y = 176
integer width = 695
integer height = 84
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) or trim(data) = '0' or trim(data) = '' then	
	ii_str_jikjong	=	0
	ii_end_jikjong	=	9
else
	ii_str_jikjong = integer(trim(data))
	ii_end_jikjong = integer(trim(data))
end if

wf_getchild2()




end event

event itemfocuschanged;triggerevent(itemchanged!)

end event

type st_41 from statictext within w_hpa306a
integer x = 901
integer y = 192
integer width = 215
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "직종명"
boolean focusrectangle = false
end type

type dw_list002 from datawindow within w_hpa306a
boolean visible = false
integer x = 3799
integer y = 720
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa302a_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type st_1 from statictext within w_hpa306a
integer x = 3611
integer y = 172
integer width = 261
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "조회를"
boolean focusrectangle = false
end type

type st_2 from statictext within w_hpa306a
integer x = 3611
integer y = 220
integer width = 261
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "해주세요."
boolean focusrectangle = false
end type

type dw_update2 from datawindow within w_hpa306a
boolean visible = false
integer x = 1019
integer y = 1144
integer width = 1563
integer height = 432
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_hpa306a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

