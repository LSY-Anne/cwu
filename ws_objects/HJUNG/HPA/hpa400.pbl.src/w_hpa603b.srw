$PBExportHeader$w_hpa603b.srw
$PBExportComments$연말정산 생성(전체/학과별 생성)
forward
global type w_hpa603b from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type rb_1 from radiobutton within w_hpa603b
end type
type rb_2 from radiobutton within w_hpa603b
end type
type cb_1 from commandbutton within w_hpa603b
end type
type st_2 from statictext within w_hpa603b
end type
type cbx_1 from checkbox within w_hpa603b
end type
type st_1 from statictext within w_hpa603b
end type
type uo_member_no from cuo_member_fromto within w_hpa603b
end type
type st_7 from st_1 within w_hpa603b
end type
type rb_all from radiobutton within w_hpa603b
end type
type rb_y from radiobutton within w_hpa603b
end type
type rb_n from radiobutton within w_hpa603b
end type
type dw_list002 from uo_dwgrid within w_hpa603b
end type
type dw_update from uo_dwgrid within w_hpa603b
end type
type pb_1 from uo_imgbtn within w_hpa603b
end type
type gb_2 from groupbox within w_hpa603b
end type
end forward

global type w_hpa603b from w_tabsheet
string title = "월 세금계산 생성"
rb_1 rb_1
rb_2 rb_2
cb_1 cb_1
st_2 st_2
cbx_1 cbx_1
st_1 st_1
uo_member_no uo_member_no
st_7 st_7
rb_all rb_all
rb_y rb_y
rb_n rb_n
dw_list002 dw_list002
dw_update dw_update
pb_1 pb_1
gb_2 gb_2
end type
global w_hpa603b w_hpa603b

type variables
datawindowchild	idw_child
datawindow			idw_mast, idw_data


string	is_item1	=	'51'				// 소득세 코드
string	is_item2 =	'52'				// 주민세 코드
string	is_item3 =	'54'				// 의료보험료


string	is_pay_date
string	is_date_gbn						// 명절구분(1=평월, 2=명절)

string	is_member_no, is_code, is_name, is_today
integer	ii_excepte_gbn, ii_sort
dec{0}	idb_amt, idb_nontax_amt


string	is_yearmonth
string	is_str_member, is_end_member, is_jaejik_opt
integer	ii_jaejik_opt


end variables

forward prototypes
public subroutine wf_filter ()
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_filter ();// ==========================================================================================
// 기    능 : 	datawindow filter
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_filter()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

//if rb_all.checked then
//	idw_mast.setfilter("")
//	idw_mast.filter()
//	idw_data.setfilter("")
//	idw_data.filter()
//elseif rb_y.checked then
//	idw_mast.setfilter("hin001m_jaejik_opt in (1, 2, 4)")
//	idw_mast.filter()
//	idw_data.setfilter("hin001m_jaejik_opt in (1, 2, 4)")
//	idw_data.filter()
//else
//	idw_mast.setfilter("hin001m_jaejik_opt not in (1, 2, 4)")
//	idw_mast.filter()
//	idw_data.setfilter("hin001m_jaejik_opt not in (1, 2, 4)")
//	idw_data.filter()
//end if
end subroutine

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
STring ls_dept_code
dw_con.accepttext()
ls_dept_code = trim(dw_con.object.dept_code[1])
If ls_dept_code = '' Or isnull(ls_dept_code) Then ls_dept_code = '%'

uo_member_no.uf_getchild(0, 9, ls_dept_code, ii_jaejik_opt)

is_str_member	=	'0000000000'
is_end_member	=	'zzzzzzzzzz'

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
String ls_year, ls_dept_code, ls_jikjong
Integer	li_str_jikjong, li_end_jikjong
dw_con.accepttext()
ls_year = String(dw_con.object.year[1], 'yyyy')
ls_dept_code = trim(dw_con.object.dept_code[1])
If ls_dept_code = '' Or isnull(ls_dept_code) Then ls_dept_code = '%'
ls_jikjong = trim(dw_con.object.jikjong_code[1])

if isnull(ls_jikjong) or trim(ls_jikjong) = '0' or trim(ls_jikjong) = '' then	
	li_str_jikjong	=	0
	li_end_jikjong	=	9
else
	li_str_jikjong = integer(trim(ls_jikjong))
	li_end_jikjong = integer(trim(ls_jikjong))
end if



idw_mast.setfilter("")
idw_mast.filter()
idw_data.setfilter("")
idw_data.filter()

idw_mast.retrieve(ls_year, ls_dept_code, li_str_jikjong, li_end_jikjong, is_str_member, is_end_member, is_jaejik_opt)
idw_data.retrieve(ls_year, ls_dept_code, li_str_jikjong, li_end_jikjong, is_str_member, is_end_member, is_jaejik_opt)

//wf_filter()

return 0
end function

on w_hpa603b.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.cbx_1=create cbx_1
this.st_1=create st_1
this.uo_member_no=create uo_member_no
this.st_7=create st_7
this.rb_all=create rb_all
this.rb_y=create rb_y
this.rb_n=create rb_n
this.dw_list002=create dw_list002
this.dw_update=create dw_update
this.pb_1=create pb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cbx_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.uo_member_no
this.Control[iCurrent+8]=this.st_7
this.Control[iCurrent+9]=this.rb_all
this.Control[iCurrent+10]=this.rb_y
this.Control[iCurrent+11]=this.rb_n
this.Control[iCurrent+12]=this.dw_list002
this.Control[iCurrent+13]=this.dw_update
this.Control[iCurrent+14]=this.pb_1
this.Control[iCurrent+15]=this.gb_2
end on

on w_hpa603b.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.uo_member_no)
destroy(this.st_7)
destroy(this.rb_all)
destroy(this.rb_y)
destroy(this.rb_n)
destroy(this.dw_list002)
destroy(this.dw_update)
destroy(this.pb_1)
destroy(this.gb_2)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()

return 1
end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//DataWindowChild	ldwc_Temp
//long 		ll_insrow
//
//idw_mast	=	dw_list002
//idw_data	=	dw_update
//
//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		fALSE)
//
//is_str_member	=	'          '
//is_end_member	=	'zzzzzzzzzz'
//
//uo_year.st_title.text = '기준년도'
//is_year	=	uo_year.uf_getyy()
//
//uo_dept_code.uf_setdept('', '학과명')
//is_dept_code	=	uo_dept_code.uf_getcode()
//f_getdwcommon(dw_head, 'jikjong_code', 0, 750)
//
//wf_getchild()
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 재직구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_jaejik_opt.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
//	wf_setmsg('공통코드[재직]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code','0')
//	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//
//dw_jaejik_opt.InsertRow(0)
//dw_jaejik_opt.Object.code[1] = ''
//dw_jaejik_opt.Object.code.dddw.PercentWidth = 100
////triggerevent('ue_retrieve')
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
DataWindowChild	ldwc_Temp
long 		ll_insrow

idw_mast	=	dw_list002
idw_data	=	dw_update

//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		fALSE)

is_str_member	=	'          '
is_end_member	=	'zzzzzzzzzz'

//uo_year.st_title.text = '기준년도'
//is_year	=	uo_year.uf_getyy()

dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
//

dw_con.GetChild('dept_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa','9999')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF


//f_getdwcommon(dw_con, 'jikjong_code', 0, 750)

dw_con.GetChild('jikjong_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
	wf_setmsg('공통코드[직종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF


dw_con.Object.jikjong_code[1] = ''
dw_con.Object.jikjong_code.dddw.PercentWidth = 100

wf_getchild()

////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 재직구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('jaejik_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
	wf_setmsg('공통코드[재직]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','0')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF

dw_con.Object.jaejik_opt[1] = ''
dw_con.Object.jaejik_opt.dddw.PercentWidth = 100
//triggerevent('ue_retrieve')
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa603b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa603b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa603b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa603b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa603b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa603b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa603b
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa603b
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa603b
end type

type uc_save from w_tabsheet`uc_save within w_hpa603b
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa603b
end type

type uc_print from w_tabsheet`uc_print within w_hpa603b
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa603b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa603b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa603b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa603b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa603b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa603b
boolean visible = false
integer y = 1740
integer width = 4352
integer height = 780
integer taborder = 60
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
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

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4315
integer height = 660
long backcolor = 1073741824
string text = "급여계산기준코드관리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 1636
integer width = 3666
integer height = 544
borderstyle borderstyle = stylelowered!
end type

event dw_list001::clicked;call super::clicked;//String s_memberno
//IF row > 0 then
//	s_memberno = dw_list001.getItemString(row,'member_no')
//	dw_update101.retrieve(s_memberno)
//end IF
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer y = 504
integer width = 4334
integer height = 1328
end type

type uo_tab from w_tabsheet`uo_tab within w_hpa603b
integer x = 2002
integer y = 1768
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hpa603b
string dataobject = "d_hpa601a_con"
end type

event dw_con::itemchanged;call super::itemchanged;wf_getchild()
end event

type st_con from w_tabsheet`st_con within w_hpa603b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long backcolor = 1073741824
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4315
integer height = 660
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type rb_1 from radiobutton within w_hpa603b
boolean visible = false
integer x = 1353
integer y = 512
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long textcolor = 16711680
boolean enabled = false
string text = "평월"
boolean checked = true
end type

event clicked;rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)

rb_1.underline	=	true
rb_2.underline	=	false

is_date_gbn	= '1'

//dw_dept_code.enabled	=	false
//dw_dept_code.object.code.background.color = 78682240
//is_dept_code	=	''
//
//rb_1.textcolor = rgb(0, 0, 255)
//rb_2.textcolor = rgb(0, 0, 0)
//
//rb_1.underline	=	true
//rb_2.underline	=	false
//
//parent.triggerevent('ue_retrieve')
//
end event

type rb_2 from radiobutton within w_hpa603b
boolean visible = false
integer x = 1696
integer y = 512
integer width = 494
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long textcolor = 33554432
boolean enabled = false
string text = "명절(설날,추석)"
end type

event clicked;rb_2.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)

rb_2.underline	=	true
rb_1.underline	=	false

is_date_gbn	= '2'

//dw_dept_code.enabled	=	true
//dw_dept_code.object.code.background.color = rgb(255, 255, 255)
//is_dept_code	=	dw_dept_code.getitemstring(dw_dept_code.getrow(), 'code')
//
//dw_dept_code.setfocus()
//
//rb_1.textcolor = rgb(0, 0, 0)
//rb_2.textcolor = rgb(0, 0, 255)
//
//rb_1.underline	=	false
//rb_2.underline	=	true
//
//parent.triggerevent('ue_retrieve')
//
end event

type cb_1 from commandbutton within w_hpa603b
event keypress pbm_keydown
boolean visible = false
integer x = 1755
integer y = 428
integer width = 370
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
string text = "처리"
end type

event keypress;if key = keyenter! then
	this.post event clicked()
end if
end event

event clicked;//string ls_year
//long   ll_count
//
//em_year_month.getdata(ls_year)
//ls_year = trim(ls_year)
//select count(member_no)
//  into :ll_count
//  from jbtmonth_pay
// where year_month = :ls_year
//   and nvl(trim(ok_date), '') <> ''
//using sqlca;
//COMMIT USING SQLCA;
//
//// 확정일자 확인
//if ll_count > 0 then
//	gf_dis_msg(2,'해당년월은 급여지급이 완료된 상태입니다. 확인후 다시 처리해 주시기 바랍니다.','')
//	return
//end if
//
//// 생성조건 입력여부 체크
//string  ls_date, ls_member_from, ls_member_to
//string  ls_campus
//string ls_from, ls_to
//
//if not gf_chk_date(ls_year, 'YM') then
//	gf_dis_msg(2,'지급년월을 입력하시기 바랍니다.','')
//	em_year_month.setfocus()
//	return
//end if
//em_pay_date.getdata(ls_date)
//ls_date = trim(ls_date)
//if not gf_chk_date(ls_date, 'YMD') then
//	gf_dis_msg(2,'지급년월을 입력하시기 바랍니다.','')
//	em_pay_date.setfocus()
//	return
//end if
//
//ls_member_from = trim(em_member_from.text)
//ls_member_to   = trim(em_member_to.text)
////개인번호 처리
//if rb_4.checked then
//	if len(ls_member_from) < 6 then
//		gf_dis_msg(2,'개인번호를 입력하시기 바랍니다.','')
//		em_member_from.setfocus()
//	end if
//	if ls_member_to = '' then
//		em_member_to.text = ls_member_from
//		ls_member_to   = trim(em_member_to.text)
//	elseif len(ls_member_to) < 6 then
//		gf_dis_msg(2,'개인번호를 정확히 입력하시기 바랍니다.','')
//		em_member_to.setfocus()
//	end if
//else
//	//개인번호 전체 처리
//	ls_member_from = '000001'
//	ls_member_to   = '999999'
//end if
//
//// 캠퍼스별
//if rb_1.checked then
//	ls_campus = '1%'
//elseif rb_2.checked then
//	ls_campus = '2%'
//else
//	ls_campus = '%'
//end if
//
//EXECUTE IMMEDIATE "set lock mode to wait 60";
//
//st_status.text = '급여계산 준비중입니다. 잠시만 기다려주시기 바랍니다...'
//
//long ll_member
//SELECT  count(A.member_no)
//into    :ll_member
//FROM    JBTmonth_pay  A,
//        jBTpay_master B,
//		  CATjojik      C
//WHERE   A.member_no    = B.member_no
//AND     A.year_month   = B.year_month
//AND     nvl(B.campus_code,' ') || nvl(B.jojik_code, ' ') || nvl(B.organ_code, ' ') 
//         || nvl(B.class_code, ' ') || nvl(B.major_code, ' ') = C.code
//AND     A.year_month   = :ls_year
//AND     decode(C.campus_code, '0', '1', C.campus_code) like :ls_campus
//AND	  A.member_no between :ls_member_from and :ls_member_to 
//using sqlca;
//
//COMMIT USING SQLCA;
//if ll_member > 0 then
//	if gf_dis_msg(2,'이미 생성된 자료가 있습니다.~r~n' + &
//	               '다시 생성하시려면 [예]를 누르십시오.', 'QY2') = 2 then 
//		RETURN
//	else
//		DELETE FROM person.JBTmonth_pay
//		WHERE   year_month   = :ls_year
//		AND	  member_no in (SELECT  A.member_no
//									  from   jatinsa_master A,
//									 	      CATjojik   B
//									 WHERE   nvl(A.campus_code,' ') || nvl(A.jojik_code, ' ') || nvl(A.organ_code, ' ') 
//												|| nvl(A.class_code, ' ') || nvl(A.major_code, ' ') = B.code
//  										AND   decode(B.campus_code, '0', '1', B.campus_code) like :ls_campus	
//										AND	A.member_no between :ls_member_from and :ls_member_to );
//	   IF SQLCA.SQLCODE <> 0 then
//			ROLLBACK USING SQLCA;
//			gf_dis_msg(2,'전산장애가 발생되었습니다.~r~n' + &
//							'하단의 장애번호와 장애내역을~r~n' + &
//							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
//							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
//							'장애내역 : ' + SQLCA.SqlErrText,'S' )
//			RETURN
//		END IF
//	end if
//end if	
//
//integer li_check
//SELECT  count(A.member_no)
//into    :li_check
//FROM    jBTpay_master A,
//        CATjojik      B
//WHERE   A.year_month = :ls_year
//AND     decode(B.campus_code, '0', '1', B.campus_code) like :ls_campus
//AND	  A.member_no between :ls_member_from and :ls_member_to 
//AND     nvl(A.campus_code,' ') || nvl(A.jojik_code, ' ') || nvl(A.organ_code, ' ') 
//        || nvl(A.class_code, ' ') || nvl(A.major_code, ' ') = B.code
//using sqlca;
//COMMIT USING SQLCA;
//
//IF li_check  < 1  THEN
//	st_status.text = '급여마스터 자료가 존재하지 않습니다. 확인후 다시 생성하여 주시기 바랍니다!'
//	gf_dis_msg(1,'급여마스터 자료가 존재하지 않습니다. 확인후 다시 생성하여 주시기 바랍니다!',"")
//	RETURN
//END IF
//hpb_1.SetRange(1, li_check)
//hpb_1.SetStep = 1
//hpb_1.Position	= 0
//
//setpointer(HourGlass!)
//gf_dis_msg(1,'생성중입니다..','')
//
//// 연구보조비 비과세
//dw_1.retrieve(left(ls_year, 4), mid(ls_year, 5, 2))
//// 수당
//dw_2.retrieve()
////급여계산기준
//dw_3.retrieve(ls_year)
////인사 변동사항
//if right(ls_year, 2) = '04' or right(ls_year, 2) = '10' then
//	ls_from = ls_year
//	if right(ls_year, 2) = '04' then
//		ls_to = string(long(left(ls_year, 4)) - 1) + '11'
//	else
//		ls_to = left(ls_year, 4) + '05'
//	end if
//	dw_4.retrieve(ls_to, ls_from)
//elseif right(ls_year, 2) = '05' or right(ls_year, 2) = '11' then
//	ls_from = ls_year
//	if right(ls_year, 2) = '05' then
//		ls_to = left(ls_year, 4) + '03'
//	else
//		ls_to = left(ls_year, 4) + '09'
//	end if		
//	dw_4.retrieve(ls_to, ls_from)
//elseif right(ls_year, 2) = '03' or right(ls_year, 2) = '09' then
//	ls_from = ls_year
//	if right(ls_year, 2) = '03' then
//		ls_to = string(long(left(ls_year, 4)) - 1) + '10'
//	else
//		ls_to = left(ls_year, 4) + '04'
//	end if
//	dw_4.retrieve(ls_to, ls_from)
//else
//	dw_4.retrieve(ls_year, ls_year)
//end if
//// 강사료
//IF right(ls_year, 2) = '04' or left(ls_year,2) = '10' then	
//	ls_from = right(ls_year, 2)
//	ls_to   = string(long(ls_from) - 1, '00')
//	
//	dw_7.retrieve(ls_year, ls_to, ls_from, ls_campus, ls_member_from, ls_member_to )
//ELSEIF right(ls_year, 2) = '03' or right(ls_year, 2) = '09' then
//	dw_7.reset()	
//ELSE 
//	ls_from = right(ls_year, 2)
//	dw_7.retrieve( ls_year, ls_from, ls_from, ls_campus, ls_member_from, ls_member_to )
//END IF
//
//// 정근수당
//if right(ls_year, 2) = '03' or right(ls_year, 2) = '09' then
//	ls_from = left(ls_year, 4) + string(long(right(ls_year, 2)) - 1, '00')
//	ls_to = ls_from 
//
//	dw_5.retrieve(ls_to, ls_from)
//// 체력단련수당
//elseif right(ls_year, 2) = '04' or right(ls_year, 2) = '10' then
//	ls_from = left(ls_year, 4) + string(long(right(ls_year, 2)) - 1, '00')
//		
//	if right(ls_year, 2) = '04' then
//		ls_to = string(long(left(ls_year, 4)) - 1) + '11'
//	else
//		ls_to = left(ls_year, 4) + '05'
//	end if
//	
//	dw_5.retrieve(ls_to, ls_from)
//// 상여수당
//elseif right(ls_year, 2) = '05' or right(ls_year, 2) = '11' then
//	ls_from = left(ls_year, 4) + string(long(right(ls_year, 2)) - 1, '00')
//		
//	if right(ls_year, 2) = '05' then
//		ls_to = left(ls_year, 4) + '03'
//	else
//		ls_to = left(ls_year, 4) + '09'
//	end if		
//	dw_5.retrieve( ls_to, ls_from )
//else
//	dw_5.reset()	
//end if
//
//string ls_day
//
//if right(ls_year, 2) = '01' then
//	ls_day = string( long( left( ls_year, 4 )) - 1 ) + '12'
//else
//	ls_day = left( ls_year, 4 ) + string( long( right( ls_year, 2 )) - 1, '00' )
//end if
//
////급여마스터 
//string  ls_member_no, ls_year_month, ls_campus_code, ls_jikjong_code, ls_sosok
//string  ls_jikgeub_code, ls_hobong_code, ls_wife_yn, ls_jaejik_opt
//string  ls_support_20, ls_support_60, ls_handycap, ls_older, ls_woman
//string  ls_study_supp_code, ls_spouse_code, ls_family_code, ls_long_code
//string  ls_jido_code, ls_bojik_code, ls_study_code, ls_account_code, ls_retire_date
//string  ls_duty_code, ls_gubyang_code, ls_hang_supp_code, ls_hakwonhire_date
//string  ls_upmu_supp_code, ls_overtime_code, ls_night_code, ls_union_opt, ls_rest_gubun
//long    ll_bojeon_amt, ll_imsi_amt, ll_tukgun_amt, ll_etc_sudang1, ll_etc_sudang2
//long    ll_exception_amt, ll_tot, ll_find, ll_date, ll_sudang
//long    ll_bonbong, ll_accept_month, ll_bojik_cnt
//long    ll_paywork, ll_bonwork, ll_healthwork
//long    ll_bonbong_date, ll_payday, ll_over_gangsa
//long    ll_study_supp_amt, ll_long_amt, ll_jido_amt, ll_bojik_amt
//long    ll_study_amt, ll_account_amt, ll_duty_amt, ll_gubyang_amt
//long    ll_hang_supp_amt, ll_upmu_supp_amt, ll_overtime_amt, ll_night_amt
//long    ll_family, ll_pay_sum, ll_jungkun_amt, ll_handycap
//dec{0}    ll_sang, ll_bonus, ll_health, ll_health_tot
//long		ll_bonday, ll_bonus_sum, ll_health_amt, ll_spouse
//long    ll_pension, ll_pension_lend_amt, ll_kyowon_deduc, ll_kyowon_lend_deduc
//long    ll_medical_insurance, ll_kyungjo_amt, ll_sangjo_amt, ll_etc_saving
//long    ll_union_cost, ll_pay_total, ll_num_of_abs, ll_bong
//long    ll_month, ll_mod, ll_over_bojik, ll_find2, ll_today
//long    ll_etc_gongje, ll_month_amt, ll_cnt = 0, ll_month_count = 0
//decimal ld_rate_bon, ld_deduct_tot, ld_chagam_amt, ll_study2
//long    ll_sub_limit_amt, ll_sub_limit_tot, ll_gub_amt, ll_limit
//String	ls_EntryNo			//처리자
//DateTime ldt_EntryDateTime //처리일자-시간
//
//ls_EntryNo = gs_entry_no
//ldt_EntryDateTime = Datetime(today(), now())
//
//DECLARE CUR_SOR CURSOR FOR
////급여 마스터 자료 가져오기
//SELECT   trim(A.member_no)               ,
//         trim(A.year_month)              ,
//         trim(A.campus_code)             ,
//         trim(A.jikjong_code)            ,
//         trim(A.jikgeub_code)            ,
//         trim(A.hobong_code)             ,
//			nvl(A.num_of_paywork, 0)        ,
//			nvl(A.num_of_bonwork, 0)        ,
//			nvl(A.num_of_healthwork, 0)     ,
//			nvl(A.num_of_abs, 0)            ,
//			nvl(B.bonbong, 0)               ,
//         nvl(trim(A.wife_yn), '')        ,
//         nvl(A.support_20, 0)            ,
//         nvl(A.support_60, 0)            ,
//         nvl(A.handycap, 0)              ,
//         nvl(A.older, 0)                 ,
//         nvl(trim(A.woman), '')          ,
//         nvl(trim(A.study_supp_code), ''),
//         nvl(trim(A.spouse_code), '')    ,
//         nvl(trim(A.family_code), '')    ,
//         nvl(trim(A.long_code), '')      ,
//         nvl(trim(A.jido_code), '')      ,
//         nvl(trim(A.bojik_code), '')     ,
//         nvl(A.bojik_cnt, 0)             ,
//         nvl(trim(A.study_code), '')     ,
//         nvl(trim(A.account_code), '')   ,
//         nvl(trim(A.duty_code), '')      ,
//         nvl(A.bojeon_amt, 0)            ,
//         nvl(trim(A.gubyang_code), '')   ,
//         nvl(trim(A.hang_supp_code), '') , 
//         nvl(trim(A.upmu_supp_code), '') ,
//         nvl(trim(A.overtime_code), '')  ,
//         nvl(trim(A.night_code), '')     ,
//         nvl(A.imsi_amt, 0)              ,
//         nvl(A.tukgun_amt, 0)            ,
//         nvl(A.etc_sudang1, 0)           ,
//         nvl(A.etc_sudang2, 0)           ,
//         sum(nvl(C.pay_amt, 0))          ,
//			nvl(D.accept_month, 0)          ,
//			nvl(A.pension, 0)               ,
//			nvl(A.pension_lend_amt, 0)      ,
//			nvl(A.kyowon_deduc, 0)          ,
//		   nvl(A.kyowon_lend_deduc, 0)     ,
//			nvl(A.medical_insurance, 0)     ,
//			nvl(A.kyungjo_amt, 0)           ,
//			nvl(A.sangjo_amt, 0)            ,
//			nvl(A.etc_saving, 0)            ,
//			nvl(A.etc_gongje, 0)            ,
//			nvl(A.union_opt, '')            ,
//			nvl(D.jaejik_opt, '')           ,
//			nvl(D.hakwonhire_date, '')      ,
//			NVL(D.retire_date, '')          ,
//			trim(nvl(D.campus_code,' ') || nvl(D.jojik_code, ' ') || nvl(D.organ_code, ' ') 
//        || nvl(D.class_code, ' ') || nvl(D.major_code, ' '))
//FROM     JBTpay_master                   A,
//         outer JAThobong                 B,
//			JATinsa_master                  D,
//			outer JBTexception_pay          C,
//			catjojik                        E
//WHERE    A.jikjong_code = B.jikjong_code
//AND      A.jikgeub_code = B.jikgeub_code
//AND      A.hobong_code  = B.hobong_code
//AND      A.member_no    = D.member_no
//AND      A.member_no    = C.member_no
//AND      A.year_month   = C.year_month
//AND     nvl(A.campus_code,' ') || nvl(A.jojik_code, ' ') || nvl(A.organ_code, ' ') 
//        || nvl(A.class_code, ' ') || nvl(A.major_code, ' ') = E.code
//AND      A.year_month   = :ls_year
//AND      decode(E.campus_code, '0', '1', E.campus_code) like :ls_campus
//AND		A.member_no between :ls_member_from and :ls_member_to 
//group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 
//         20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,
//			37, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53 ;
//
//OPEN CUR_SOR;
//FETCH CUR_SOR INTO :ls_member_no, :ls_year_month, :ls_campus_code, :ls_jikjong_code, 
//                   :ls_jikgeub_code, :ls_hobong_code, :ll_paywork, :ll_bonwork, :ll_healthwork, :ll_num_of_abs,
//						 :ll_bonbong, :ls_wife_yn, :ls_support_20, :ls_support_60, :ls_handycap,
//						 :ls_older, :ls_woman, :ls_study_supp_code, :ls_spouse_code, :ls_family_code,
//						 :ls_long_code, :ls_jido_code, :ls_bojik_code, :ll_bojik_cnt ,:ls_study_code, :ls_account_code, 
//                   :ls_duty_code, :ll_bojeon_amt, :ls_gubyang_code, :ls_hang_supp_code, 
//                   :ls_upmu_supp_code, :ls_overtime_code, :ls_night_code, :ll_imsi_amt, 
//                   :ll_tukgun_amt, :ll_etc_sudang1, :ll_etc_sudang2,
//						 :ll_exception_amt, :ll_accept_month,
//						 :ll_pension, :ll_pension_lend_amt, :ll_kyowon_deduc, :ll_kyowon_lend_deduc,
//						 :ll_medical_insurance, :ll_kyungjo_amt, :ll_sangjo_amt, :ll_etc_saving,
//						 :ll_etc_gongje, :ls_union_opt, :ls_jaejik_opt, :ls_hakwonhire_date, :ls_retire_date, :ls_sosok;
//
//DO WHILE SQLCA.SQLCODE = 0
//	//자료수 확인
//	ll_cnt++
//	st_status.text = string(ll_cnt) + ' / ' + string(li_check) + '  생성중입니다..'
//	gf_dis_msg(1,string(ll_cnt) + ' / ' + string(li_check) + ' 생성중입니다..','')
//	//예외지급수당
//	ll_tot = ll_exception_amt
//	ll_study2 = 0
//	//연구보조비
//	ll_study_supp_amt = dw_2.find("sudang_opt = '01' and sudang_code = '" + ls_study_supp_code + "'", 1, dw_2.rowcount())
//   if ll_study_supp_amt > 0 then
//   	ll_study_supp_amt = dw_2.object.sudang_amt[ll_study_supp_amt]
//		
//		if ls_jikjong_code = '21' and ls_sosok = '01' then
//			select sudang_amt
//			  into :ll_sudang
//			  from jbtsudang
//			 where trim(sudang_opt) = '01'
//				and trim(sudang_code) = '99'
//			using sqlca;
//	
//			ll_study_supp_amt = ll_study_supp_amt  + ll_sudang
//		end if
//
//		if right(ls_year, 2) = '03' or right(ls_year, 2) = '04' or right(ls_year, 2) = '09' or right(ls_year, 2) = '10' then
//			ll_study_supp_amt = ll_study_supp_amt * 1
//		else
//			ll_study_supp_amt = ll_study_supp_amt * 1.75
//		end if
//	else
//		ll_study_supp_amt = 0
//	end if
//   //가족수당
//	ll_spouse         = dw_2.find("sudang_opt = '02' and sudang_code = '" + ls_spouse_code + "'", 1, dw_2.rowcount())
//	ll_family         = dw_2.find("sudang_opt = '02' and sudang_code = '" + ls_family_code + "'", 1, dw_2.rowcount())
//	if ll_family > 0 then
//		ll_family      = dw_2.object.sudang_amt[ll_family]
//	else
//		ll_family = 0
//	end if
//	//장기근속수당
//   ll_long_amt       = dw_2.find("sudang_opt = '03' and sudang_code = '" + ls_long_code + "'", 1, dw_2.rowcount())
//   if ll_long_amt > 0 then
//		ll_long_amt    = dw_2.object.sudang_amt[ll_long_amt]
//	else
//		ll_long_amt = 0
//	end if
//	//학생지도수당
//   ll_jido_amt       = dw_2.find("sudang_opt = '04' and sudang_code = '" + ls_jido_code + "'", 1, dw_2.rowcount())
//   if ll_jido_amt > 0 then
//		ll_jido_amt    = dw_2.object.sudang_amt[ll_jido_amt]
//	else
//		ll_jido_amt    = 0
//	end if
//	//보직수당
//   ll_bojik_amt      = dw_2.find("sudang_opt = '05' and sudang_code = '" + ls_bojik_code + "'", 1, dw_2.rowcount())
//	ll_over_bojik     = dw_2.find("sudang_opt = '05' and sudang_code = '99'", 1, dw_2.rowcount())
//	if ll_over_bojik > 0 then
//		ll_over_bojik     = dw_2.object.sudang_amt[ll_over_bojik]
//		ll_bojik_cnt   = ll_bojik_cnt * ll_over_bojik		
//	else
//		ll_over_bojik = 0
//		ll_bojik_cnt = ll_bojik_cnt * ll_over_bojik		
//	end if
//
//   if ll_bojik_amt > 0 then
//		ll_bojik_amt   = dw_2.object.sudang_amt[ll_bojik_amt]
//		ll_bojik_amt   = ll_bojik_amt + ll_bojik_cnt
//	else
//		ll_bojik_amt = 0
//		ll_bojik_amt = ll_bojik_amt + ll_bojik_cnt
//	end if
//	//연구수당
//   ll_study_amt      = dw_2.find("sudang_opt = '06' and sudang_code = '" + ls_study_code + "'", 1, dw_2.rowcount())
//   if ll_study_amt > 0 then
//		ll_study_amt   = dw_2.object.sudang_amt[ll_study_amt]
//	else
//		ll_study_amt = 0
//	end if
//	//출납수당
//   ll_account_amt    = dw_2.find("sudang_opt = '07' and sudang_code = '" + ls_account_code + "'", 1, dw_2.rowcount())
//   if ll_account_amt > 0 then
//		ll_account_amt = dw_2.object.sudang_amt[ll_account_amt]
//	else
//		ll_account_amt = 0
//	end if
//	//책임수당
//   ll_duty_amt       = dw_2.find("sudang_opt = '08' and sudang_code = '" + ls_duty_code + "'", 1, dw_2.rowcount())
//   if ll_duty_amt > 0 then
//		ll_duty_amt    = dw_2.object.sudang_amt[ll_duty_amt]
//	else
//		ll_duty_amt    = 0 
//	end if
//	//급량비
//	ll_gubyang_amt    = dw_2.find("sudang_opt = '09' and sudang_code = '" + ls_gubyang_code + "'", 1, dw_2.rowcount())
//   if ll_gubyang_amt > 0 then
//		ll_gubyang_amt = dw_2.object.sudang_amt[ll_gubyang_amt]
//	else 
//		ll_gubyang_amt = 0
//	end if
//	//행정보조비
//	ll_hang_supp_amt  = dw_2.find("sudang_opt = '10' and sudang_code = '" + ls_hang_supp_code + "'", 1, dw_2.rowcount())
//   if ll_hang_supp_amt > 0 then
//		ll_hang_supp_amt = dw_2.object.sudang_amt[ll_hang_supp_amt]
//	else
//		ll_hang_supp_amt = 0
//	end if
//	//업무보조비
//	ll_upmu_supp_amt  = dw_2.find("sudang_opt = '11' and sudang_code = '" + ls_upmu_supp_code + "'", 1, dw_2.rowcount())
//   if ll_upmu_supp_amt > 0 then
//		ll_upmu_supp_amt = dw_2.object.sudang_amt[ll_upmu_supp_amt]
//	else
//		ll_upmu_supp_amt = 0
//	end if
//	//휴일및시간외수당
//	ll_overtime_amt   = dw_2.find("sudang_opt = '12' and sudang_code = '" + ls_overtime_code + "'", 1, dw_2.rowcount())
//   if ll_overtime_amt > 0 then
//		ll_overtime_amt = dw_2.object.sudang_amt[ll_overtime_amt]
//	else
//		ll_overtime_amt = 0
//	end if
//	//야근수당
//	ll_night_amt      = dw_2.find("sudang_opt = '13' and sudang_code = '" + ls_night_code + "'", 1, dw_2.rowcount())
//   if ll_night_amt > 0 then
//		ll_night_amt   = dw_2.object.sudang_amt[ll_night_amt]
//	else
//		ll_night_amt   = 0
//	end if
//	//장애수당
//	ll_handycap = 0
//	// 비서실일반조교는 봉급, 연구보조비를 일정금액만큼 넣는다.
//	if ls_jikjong_code = '21' and ls_sosok = '01' then
//		select bonbong
//		  into :ll_bong
//		  from jathobong
//		 where jikjong_code = '21'
//		   and jikgeub_code = '2199'
//			and trim(hobong_code) = '99'
//		using sqlca;
//		
//		ll_bonbong        = ll_bonbong + ll_bong
//	end if
//	// 급여계산일수에 따른 급여계산
//  	ll_bonbong_date = dw_3.find("year_month = '" + ls_year_month + "'", 1, dw_2.rowcount())
//	if ll_bonbong_date > 0 then
//		ll_payday = dw_3.object.num_of_payday[ll_bonbong_date]
//	else
//		ll_payday = 1
//	end if
//	ll_bonbong        = (ll_paywork / ll_payday) * ll_bonbong
//	ll_study_supp_amt = (ll_paywork / ll_payday) * ll_study_supp_amt
//	ll_family         = (ll_paywork / ll_payday) * ll_family
//	ll_long_amt       = (ll_paywork / ll_payday) * ll_long_amt
//	ll_jido_amt       = (ll_paywork / ll_payday) * ll_jido_amt
//	ll_bojik_amt      = (ll_paywork / ll_payday) * ll_bojik_amt
//	ll_study_amt      = (ll_paywork / ll_payday) * ll_study_amt
//	ll_account_amt    = (ll_paywork / ll_payday) * ll_account_amt
//	ll_duty_amt       = (ll_paywork / ll_payday) * ll_duty_amt
//	ll_bojeon_amt     = (ll_paywork / ll_payday) * ll_bojeon_amt
//	ll_gubyang_amt    = (ll_paywork / ll_payday) * ll_gubyang_amt
//	ll_hang_supp_amt  = (ll_paywork / ll_payday) * ll_hang_supp_amt
//	ll_upmu_supp_amt  = (ll_paywork / ll_payday) * ll_upmu_supp_amt
//	ll_overtime_amt   = (ll_paywork / ll_payday) * ll_overtime_amt
//	ll_night_amt      = (ll_paywork / ll_payday) * ll_night_amt
//	ll_imsi_amt       = (ll_paywork / ll_payday) * ll_imsi_amt
//	ll_tukgun_amt     = (ll_paywork / ll_payday) * ll_tukgun_amt
//	ll_handycap       = (ll_paywork / ll_payday) * ll_handycap
//	ll_etc_sudang1    = (ll_paywork / ll_payday) * ll_etc_sudang1
//	ll_etc_sudang2    = (ll_paywork / ll_payday) * ll_etc_sudang2
//	
//	// 감액대상 처리 < 정직, 감봉 > 
//	ll_find = dw_4.find("member_no = '" + ls_member_no + "' and gubun = '1'", 1, dw_4.rowcount())
//	if ll_find > 0 then
//		// 정직기간중 수당 감액지급<수당액의 2/3>
//		if trim(dw_4.object.change_opt[ll_find]) = '72' then
//			ll_bonbong        = ll_bonbong        - (ll_bonbong        * (2 / 3))
//			ll_study_supp_amt = ll_study_supp_amt - (ll_study_supp_amt * (2 / 3))
//      	ll_family         = ll_family         - (ll_family         * (2 / 3))
//			ll_long_amt       = ll_long_amt       - (ll_long_amt       * (2 / 3))
//			ll_jido_amt       = ll_jido_amt       - (ll_jido_amt       * (2 / 3))
//	   	ll_bojik_amt      = ll_bojik_amt      - (ll_bojik_amt      * (2 / 3))
//   		ll_study_amt      = ll_study_amt      - (ll_study_amt      * (2 / 3))
//			ll_account_amt    = ll_account_amt    - (ll_account_amt    * (2 / 3))
//			ll_duty_amt       = ll_duty_amt       - (ll_duty_amt       * (2 / 3))
//			ll_bojeon_amt     = ll_bojeon_amt     - (ll_bojeon_amt     * (2 / 3))
//			ll_gubyang_amt    = ll_gubyang_amt    - (ll_gubyang_amt    * (2 / 3))
//			ll_hang_supp_amt  = ll_hang_supp_amt  - (ll_hang_supp_amt  * (2 / 3))
//			ll_upmu_supp_amt  = ll_upmu_supp_amt  - (ll_upmu_supp_amt  * (2 / 3))
//			ll_overtime_amt   = ll_overtime_amt   - (ll_overtime_amt   * (2 / 3))
//			ll_night_amt      = ll_night_amt      - (ll_night_amt      * (2 / 3))
//			ll_imsi_amt       = ll_imsi_amt       - (ll_imsi_amt       * (2 / 3))
//			ll_tukgun_amt     = ll_tukgun_amt     - (ll_tukgun_amt     * (2 / 3))
//			ll_handycap       = ll_handycap       - (ll_handycap       * (2 / 3))
//			ll_etc_sudang1    = ll_etc_sudang1    - (ll_etc_sudang1    * (2 / 3))
//			ll_etc_sudang2    = ll_etc_sudang2    - (ll_etc_sudang2    * (2 / 3))
//		// 감봉기간중 수당감액지급<수당액의 1/3>
//		elseif trim(dw_4.object.change_opt[ll_find]) = '73' then
//			ll_bonbong        = ll_bonbong        - (ll_bonbong        * (1 / 3))
//			ll_study_supp_amt = ll_study_supp_amt - (ll_study_supp_amt * (1 / 3))
//      	ll_family         = ll_family         - (ll_family         * (1 / 3))
//			ll_long_amt       = ll_long_amt       - (ll_long_amt       * (1 / 3))
////			ll_jido_amt       = ll_jido_amt       - (ll_jido_amt       * (1 / 3))
////	   	ll_bojik_amt      = ll_bojik_amt      - (ll_bojik_amt      * (1 / 3))
//			ll_study_amt      = ll_study_amt      - (ll_study_amt      * (1 / 3))
//			ll_account_amt    = ll_account_amt    - (ll_account_amt    * (1 / 3))
//			ll_duty_amt       = ll_duty_amt       - (ll_duty_amt       * (1 / 3))
//			ll_bojeon_amt     = ll_bojeon_amt     - (ll_bojeon_amt     * (1 / 3))
//			ll_gubyang_amt    = ll_gubyang_amt    - (ll_gubyang_amt    * (1 / 3))
//			ll_hang_supp_amt  = ll_hang_supp_amt  - (ll_hang_supp_amt  * (1 / 3))
//			ll_upmu_supp_amt  = ll_upmu_supp_amt  - (ll_upmu_supp_amt  * (1 / 3))
//			ll_overtime_amt   = ll_overtime_amt   - (ll_overtime_amt   * (1 / 3))
//			ll_night_amt      = ll_night_amt      - (ll_night_amt      * (1 / 3))
//			ll_imsi_amt       = ll_imsi_amt       - (ll_imsi_amt       * (1 / 3))
//			ll_tukgun_amt     = ll_tukgun_amt     - (ll_tukgun_amt     * (1 / 3))
//			ll_handycap       = ll_handycap       - (ll_handycap       * (1 / 3))
//			ll_etc_sudang1    = ll_etc_sudang1    - (ll_etc_sudang1    * (1 / 3))
//			ll_etc_sudang2    = ll_etc_sudang2    - (ll_etc_sudang2    * (1 / 3))
//		// 직위해제기간중 수당감액지급<수당액의 2할>
//		elseif trim(dw_4.object.change_opt[ll_find]) = '74' then
//			ll_bonbong        = ll_bonbong        - (ll_bonbong        * 0.2)
//			ll_study_supp_amt = ll_study_supp_amt - (ll_study_supp_amt * 0.2)
//      	ll_family         = ll_family         - (ll_family         * 0.2)
//			ll_long_amt       = ll_long_amt       - (ll_long_amt       * 0.2)
//			ll_jido_amt       = ll_jido_amt       - (ll_jido_amt       * 0.2)
//	   	ll_bojik_amt      = ll_bojik_amt      - (ll_bojik_amt      * 0.2)
//			ll_study_amt      = ll_study_amt      - (ll_study_amt      * 0.2)
//			ll_account_amt    = ll_account_amt    - (ll_account_amt    * 0.2)
//			ll_duty_amt       = ll_duty_amt       - (ll_duty_amt       * 0.2)
//			ll_bojeon_amt     = ll_bojeon_amt     - (ll_bojeon_amt     * 0.2)
//			ll_gubyang_amt    = ll_gubyang_amt    - (ll_gubyang_amt    * 0.2)
//			ll_hang_supp_amt  = ll_hang_supp_amt  - (ll_hang_supp_amt  * 0.2)
//			ll_upmu_supp_amt  = ll_upmu_supp_amt  - (ll_upmu_supp_amt  * 0.2)
//			ll_overtime_amt   = ll_overtime_amt   - (ll_overtime_amt   * 0.2)
//			ll_night_amt      = ll_night_amt      - (ll_night_amt      * 0.2)
//			ll_imsi_amt       = ll_imsi_amt       - (ll_imsi_amt       * 0.2)
//			ll_tukgun_amt     = ll_tukgun_amt     - (ll_tukgun_amt     * 0.2)
//			ll_handycap       = ll_handycap       - (ll_handycap       * 0.2)
//			ll_etc_sudang1    = ll_etc_sudang1    - (ll_etc_sudang1    * 0.2)
//			ll_etc_sudang2    = ll_etc_sudang2    - (ll_etc_sudang2    * 0.2)
//		end if
//	end if
//	
//	// 휴직기간 중 봉급(기본급)의 5할, 7할, 8할, 전액
//	if ls_jaejik_opt = '3' then
//		ll_find = dw_4.find("member_no = '" + ls_member_no + "' and change_opt = '71'" + &
//		                      " and gubun = '1'" , 1, dw_4.rowcount())
//			if ll_find > 0 then
//				ls_rest_gubun = dw_4.object.rest_gubun[ll_find]
//				
//				choose case ls_rest_gubun
//					case '11'
//						ll_bonbong = ll_bonbong * 0.7
//					case '12'
//						ll_bonbong = ll_bonbong * 0.8
//					case '13'
//						ll_bonbong = ll_bonbong
//					case '17'
//						ll_bonbong = ll_bonbong * 0.5
//					case else
//						ll_bonbong = 0
//				end choose
//			end if
//			ll_study_supp_amt = 0  
//			ll_family         = 0
//			ll_long_amt       = 0
//			ll_jido_amt       = 0
//			ll_bojik_amt      = 0
//			ll_study_amt      = 0
//			ll_account_amt    = 0
//			ll_duty_amt       = 0
//			ll_bojeon_amt     = 0
//			ll_gubyang_amt    = 0
//			ll_hang_supp_amt  = 0
//			ll_upmu_supp_amt  = 0
//			ll_overtime_amt   = 0
//			ll_night_amt      = 0
//			ll_imsi_amt       = 0
//			ll_tukgun_amt     = 0
//			ll_handycap       = 0
//			ll_etc_sudang1    = 0
//			ll_etc_sudang2    = 0
//	// 해외연수, 연구년은 100% (단, 학생지도수당은 지급하지 않는다)
//	elseif ls_jaejik_opt = '4' or ls_jaejik_opt = '5' then
//		ll_jido_amt = 0
//	end if
//
//		ll_bonbong        = truncate(ll_bonbong        / 10, 0) * 10
//		ll_study_supp_amt = truncate(ll_study_supp_amt / 10, 0) * 10
//     	ll_family         = truncate(ll_family         / 10, 0) * 10
//		ll_long_amt       = truncate(ll_long_amt       / 10, 0) * 10
//		ll_jido_amt       = truncate(ll_jido_amt       / 10, 0) * 10 
//	  	ll_bojik_amt      = truncate(ll_bojik_amt      / 10, 0) * 10 
//   	ll_study_amt      = truncate(ll_study_amt      / 10, 0) * 10 
//		ll_account_amt    = truncate(ll_account_amt    / 10, 0) * 10 
//		ll_duty_amt       = truncate(ll_duty_amt       / 10, 0) * 10 
//		ll_bojeon_amt     = truncate(ll_bojeon_amt     / 10, 0) * 10 
//		ll_gubyang_amt    = truncate(ll_gubyang_amt    / 10, 0) * 10 
//		ll_hang_supp_amt  = truncate(ll_hang_supp_amt  / 10, 0) * 10 
//		ll_upmu_supp_amt  = truncate(ll_upmu_supp_amt  / 10, 0) * 10 
//		ll_overtime_amt   = truncate(ll_overtime_amt   / 10, 0) * 10 
//		ll_night_amt      = truncate(ll_night_amt      / 10, 0) * 10 
//		ll_imsi_amt       = truncate(ll_imsi_amt       / 10, 0) * 10
//		ll_tukgun_amt     = truncate(ll_tukgun_amt     / 10, 0) * 10 
//		ll_handycap       = truncate(ll_handycap       / 10, 0) * 10  
//		ll_etc_sudang1    = truncate(ll_etc_sudang1    / 10, 0) * 10 
//		ll_etc_sudang2    = truncate(ll_etc_sudang2    / 10, 0) * 10 
//				
//	//상여수당
//	ll_sang = ll_bonbong + ll_family + ll_long_amt + ll_study_amt + ll_bojeon_amt + ll_overtime_amt + ll_night_amt
//	
//	IF ls_jaejik_opt = '2' THEN
//		ll_find = dw_4.find("member_no = '" + ls_member_no + "' and (change_opt = '81' or change_opt = '82')", 1, dw_4.rowcount())
//		if ll_find > 0 then
//			ll_bonus = 0
//		else
//			ll_bonus = wf_retire_bunus(ls_member_no, ls_retire_date ,ll_sang)
//		end if
//	ELSE
//		if right(ls_year, 2) = '03' or right(ls_year, 2) = '04' or right(ls_year, 2) = '09' or right(ls_year, 2) = '10' then
//			ll_bonus = 0
//		else
//			ll_find = dw_4.find("member_no = '" + ls_member_no + "'", 1, dw_4.rowcount())
//			if ll_find > 0 then
//				ll_find2 = dw_5.find("member_no = '" + ls_member_no + "'", 1, dw_5.rowcount())
//				
//				if ll_find2 > 0 then
//					ll_sang = ll_sang + dw_5.object.bouns[ll_find2]
//	//				ll_month_count = (dw_5.object.month_count[ll_find2] + 1)
//				else
//					ll_sang = ll_sang
//				end if
//				
//				if right(ls_year, 2) = '05' or right(ls_year, 2) = '11' then
//					ll_month_count = 3
//				else
//					ll_month_count = 1
//				end if
//				
//				ll_bonday = dw_3.find("year_month = '" + ls_year_month + "'", 1, dw_2.rowcount())
//				if ll_bonday > 0 then
//					ld_rate_bon = dw_3.object.rate_of_bon[ll_bonday]
//					ll_bonday   = dw_3.object.num_of_bonday[ll_bonday]
//					ll_bonus = ( ll_sang / ll_month_count ) * ld_rate_bon
//				else
//					ll_bonus = 0
//				end if
//			else
//				ll_bonday = dw_3.find("year_month = '" + ls_year_month + "'", 1, dw_2.rowcount())
//				if ll_bonday > 0 then
//					ld_rate_bon = dw_3.object.rate_of_bon[ll_bonday]
//					ll_bonday   = dw_3.object.num_of_bonday[ll_bonday]
//					ll_bonus = ll_sang * ld_rate_bon
//				else
//					ll_bonus = 0
//				end if
//			end if
//		end if
//	end if
//	if right(ls_year, 2) = '05' or right(ls_year, 2) = '11' then
//		if left(ls_hakwonhire_date, 6) = ls_year then
//			if ll_paywork < 15 then
//				ll_bonus = 0
//			end if
//		end if
//	elseif right(ls_year, 2) = '06' or right(ls_year, 2) = '07' or right(ls_year, 2) = '08' &
//		    or right(ls_year, 2) = '12' or right(ls_year, 2) = '01' or right(ls_year, 2) = '02' then
//		if ll_paywork < 15 then
//			ll_bonus = 0
//		end if
//	end if
//
//	ll_sang = ll_bonbong + ll_family + ll_long_amt + ll_study_supp_amt + &
//	          ll_study_amt + ll_bojeon_amt + ll_overtime_amt + ll_night_amt
//   //정근수당
//	if right(ls_year, 1) = '3' or right(ls_year, 1) = '9' then
//		ll_find2 = dw_5.find("member_no = '" + ls_member_no + "'", 1, dw_5.rowcount())
//		if ll_find2 > 0 then
//			ls_to = left(ls_hakwonhire_date, 6)
//			ls_from = string((long(left(ls_year, 4)) - long(left(ls_to, 4))) * 12)
//			ls_from = string(long(ls_from) + (long(MID(ls_year, 5, 2)) - long(MID(ls_to, 5, 2))))
//
//			// 휴직기간 정근기간에서 제외...
//			ll_find = dw_8.find("member_no = '" + ls_member_no + "'", 1, dw_8.rowcount())
//			if ll_find > 0 then
//				ls_from = string(long(ls_from) - long(dw_8.object.month[ll_find]))
//			end if

//				
//			ll_today = Truncate(long(ls_from) / 12, 0)
//				CHOOSE CASE ll_today
//					CASE 0
//						ll_jungkun_amt = ll_sang * 0.5
//					CASE 1
//						ll_jungkun_amt = ll_sang * 0.55
//					CASE 2
//						ll_jungkun_amt = ll_sang * 0.6
//					CASE 3
//						ll_jungkun_amt = ll_sang * 0.65
//					CASE 4
//						ll_jungkun_amt = ll_sang * 0.7
//					CASE 5
//						ll_jungkun_amt = ll_sang * 0.75
//					CASE 6
//						ll_jungkun_amt = ll_sang * 0.8
//					CASE 7
//						ll_jungkun_amt = ll_sang * 0.85
//					CASE 8
//						ll_jungkun_amt = ll_sang * 0.9
//					CASE 9
//						ll_jungkun_amt = ll_sang * 0.95
//					CASE is > 9
//						ll_jungkun_amt = ll_sang * 1
//					CASE ELSE
//						ll_jungkun_amt = 0
//				END CHOOSE
//	
//				//정근수당지급율
//				ld_rate_bon = dw_3.find("year_month = '" + ls_year_month + "'", 1, dw_2.rowcount())
//				if ld_rate_bon > 0 then
//					ll_bonday = dw_3.object.num_of_abs[ld_rate_bon]
//					ld_rate_bon = dw_3.object.rate_of_abs[ld_rate_bon]
//				end if
//				//정근수당
//				ll_jungkun_amt = ll_jungkun_amt * ld_rate_bon
//	
//				//감액대상 체크
//				ld_rate_bon = dw_4.find("member_no = '" + ls_member_no + "' and gubun = '1'", 1, dw_4.rowcount())
//				if ld_rate_bon > 0 then
//					ls_from = dw_4.object.from_date[ld_rate_bon]
//					ls_to   = dw_4.object.to_date[ld_rate_bon]
//					if right(ls_year, 1) = '3' then
//						if left(ls_from, 6) < string(long(left(ls_year, 4)) - 1, '0000') + '10' then
//							ls_from = string(long(left(ls_year, 4)) - 1, '0000') + '10' + '01'
//						end if
//						if left(ls_to, 6) > left(ls_year, 4) + '03' then
//							ls_to = left(ls_year, 4) + '03' + '31'
//						end if
//					elseif right(ls_year, 1) = '9' then
//						if left(ls_from, 6) < left(ls_year, 4) + '04' then
//							ls_from = left(ls_year, 4) + '04' + '01'
//						end if
//						if left(ls_to, 6) > left(ls_year, 4) + '09' then
//							ls_to = left(ls_year, 4) + '09' + '30'
//						end if
//					end if
//
//					// 변동사항기간 - 월
//						ll_month = wf_monthbetween(ls_from, ls_to)
//			
//					// 정직기간중 수당감액지급
//					if trim(dw_4.object.change_opt[ld_rate_bon]) = '72' then
//						ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/9) * ll_month)
//					// 감봉기간중 수당감액지급
//					elseif trim(dw_4.object.change_opt[ld_rate_bon]) = '73' then
//						ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/18) * ll_month)
//					// 직위해제기간중 수당감액지급
//					elseif trim(dw_4.object.change_opt[ld_rate_bon]) = '74' then
//						ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/30) * ll_month)
//					// 휴직기간중 수당감액지급
//					elseif trim(dw_4.object.change_opt[ld_rate_bon]) = '71' then
//						 ls_rest_gubun  = dw_4.object.rest_gubun[ld_rate_bon]
//						choose case ls_rest_gubun
//							case '11'
//								ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/20) * ll_month)
//							case '12'
//								ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/30) * ll_month)
//							case '13'
//								ll_jungkun_amt = ll_jungkun_amt
//							case '17'
//								ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/12) * ll_month)
//							case else
//								ll_jungkun_amt = 0
//						end choose
//					end if
//				end if
//		else
//			ll_jungkun_amt = 0
//		end if
//	else
//		ll_jungkun_amt = 0
//	end if
//	
//	ll_find = dw_4.find("member_no = '" + ls_member_no + "' and (change_opt = '81' or change_opt = '82')", 1, dw_4.rowcount())
//	if ll_find > 0 then
//		ll_jungkun_amt = 0
//	end if
//
//   //체력단련비 - 연구보조비 175% 지급시 100%로 계산
//   	if right(ls_year, 2) = '03' or right(ls_year, 2) = '04' or right(ls_year, 2) = '09' or right(ls_year, 2) = '10' then
//			ll_study2 = ll_study_supp_amt
//		else
//			ll_study2 = truncate(ll_study_supp_amt / 1.75, 0)
//		end if
//   ll_health = ll_bonbong + ll_family + ll_long_amt + ll_study2 + &
//	            ll_study_amt + ll_bojeon_amt + ll_overtime_amt + ll_night_amt
//
//	IF ls_jaejik_opt = '2' THEN
////		ll_find = dw_4.find("member_no = '" + ls_member_no + "' and (change_opt = '81' or change_opt = '82')", 1, dw_4.rowcount())
////		if ll_find > 0 then
////			ll_health_tot = 0
////		else
//			ll_health_tot = wf_retire_health(ls_member_no, ls_retire_date ,ll_health)
////		end if
//	ELSE
//		if right(ls_year, 2) = '04' or right(ls_year, 2) = '10' then
//			ll_find = dw_4.find("member_no = '" + ls_member_no + "'", 1, dw_4.rowcount())
//			
//			if ll_find > 0 then
//				ll_find2 = dw_5.find("member_no = '" + ls_member_no + "'", 1, dw_5.rowcount())
//				if ll_find2 > 0 then
//					ll_health = ll_health + dw_5.object.health[ll_find2]
//	//				ll_month_count = (dw_5.object.month_count[ll_find2] + 1)
//				else
//					ll_health = ll_health
//				end if
//				
//				ll_month_count = 6
//	
//				ll_health_amt = dw_3.find("year_month = '" + ls_year + "'", 1, dw_2.rowcount())
//				if ll_health_amt > 0 then
//					ld_rate_bon = dw_3.object.rate_of_health[ll_health_amt]
//					ll_health_amt = dw_3.object.num_of_healthday[ll_health_amt]
//					ll_health_tot =  ( ll_health / ll_month_count ) * ld_rate_bon
//				else
//					ll_health_tot = 0
//				end if
//			else
//				ll_health_amt = dw_3.find("year_month = '" + ls_year + "'", 1, dw_2.rowcount())
//				if ll_health_amt > 0 then
//					ld_rate_bon = dw_3.object.rate_of_health[ll_health_amt]
//					ll_health_amt = dw_3.object.num_of_healthday[ll_health_amt]
//					ll_health_tot =   ll_health * ld_rate_bon
//				else
//					ll_health_tot = 0
//				end if
//			end if
//		else
//			ll_health_tot = 0
//		end if
//	END IF
//   // 무급 휴직은 상여도 지급되지 않는다.
//	if ls_jaejik_opt = '3' then
//		ll_find = dw_4.find("member_no = '" + ls_member_no + "' and change_opt = '71'" + &
//		                      " and gubun = '1'" , 1, dw_4.rowcount())
//			if ll_find > 0 then
//				ls_rest_gubun = dw_4.object.rest_gubun[ll_find]
//				
//				choose case ls_rest_gubun
//					case '11', '12', '13', '17'
//						ll_bonus = ll_bonus 						
//						ll_health_tot = ll_health_tot
//					case else
//						ll_bonus = 0
//						ll_health_tot = 0
//				end choose
//			end if
//	end if
//	// 사환, 촉탁, 고용직, 기타 기본금만 지급..
//	if ls_jikjong_code = '44' or ls_jikjong_code = '45' or ls_jikjong_code = '51' or ls_jikjong_code = '52' then
//		ll_study_supp_amt = 0
//		ll_family         = 0
//		ll_long_amt       = 0
//		ll_jido_amt       = 0
//		ll_bojik_amt      = 0
//		ll_study_amt      = 0
//		ll_account_amt    = 0
//		ll_duty_amt       = 0
//		ll_bojeon_amt     = 0
//		ll_gubyang_amt    = 0
//		ll_hang_supp_amt  = 0
//		ll_upmu_supp_amt  = 0
//		ll_overtime_amt   = 0
//		ll_night_amt      = 0
//		ll_imsi_amt       = 0
//		ll_tukgun_amt     = 0
//		ll_handycap       = 0
//		ll_etc_sudang1    = 0
//		ll_etc_sudang2    = 0
//		ll_bonus          = 0
//		ll_jungkun_amt    = 0
//		ll_health_tot     = 0
//	end if
//
//   //초과강의료
//	ll_over_gangsa = 0
//	ll_find = dw_7.find("member_no = '" + ls_member_no + "'", 1, dw_7.rowcount())
//	if ll_find > 0 then
//		ll_over_gangsa = dw_7.object.pay_tot[ll_find]
//	else
//		ll_over_gangsa = 0
//	end if
//	
//	ll_union_cost = 0
//	ll_month_amt = 0
//
//	//급여합계
//	ll_pay_sum = ll_bonbong + ll_study_supp_amt + ll_family + ll_long_amt + ll_jido_amt + &
//	             ll_bojik_amt + ll_study_amt + ll_account_amt + ll_duty_amt + ll_bojeon_amt + &
//					 ll_gubyang_amt + ll_hang_supp_amt + ll_upmu_supp_amt + ll_overtime_amt + ll_night_amt + & 
//					 ll_imsi_amt + ll_tukgun_amt + ll_handycap + ll_etc_sudang1 + ll_etc_sudang2
//	ll_bonus = Truncate(ll_bonus / 10, 0) * 10
//	ll_jungkun_amt = Truncate(ll_jungkun_amt / 10, 0) * 10
//	ll_health_tot = Truncate(ll_health_tot / 10, 0) * 10
//	//상여합계
//	ll_bonus_sum = ll_bonus + ll_jungkun_amt + ll_health_tot 
//	ll_pay_sum = Truncate(ll_pay_sum / 10, 0) * 10
//	//급여총계
//	ll_pay_total = ll_pay_sum + ll_bonus_sum  // + ll_tot
//	// 공제액계, 차인지급액
//		ld_deduct_tot = ll_pension + ll_pension_lend_amt + ll_kyowon_deduc + ll_kyowon_lend_deduc + &
//		                ll_medical_insurance + ll_union_cost + ll_kyungjo_amt + ll_sangjo_amt + &
//							 ll_month_amt + ll_etc_saving + ll_etc_gongje
//		ld_chagam_amt = ll_pay_total - ld_deduct_tot
//
//	// 연구보조비비과세금액, 연구보조비누계
//	if ll_gubyang_amt > 50000 then
//		ll_gub_amt = 50000
//	else
//		ll_gub_amt = ll_gubyang_amt
//	end if
//	
//	ll_limit = (ll_tot + ll_over_gangsa + ll_pay_total) - (ll_gub_amt)
//
//	ll_find = dw_1.find("member_no = '" + ls_member_no + "'", 1, dw_1.rowcount())
//	if ll_find > 0 then
//			ll_sub_limit_tot = dw_1.object.pay_sum[ll_find]
//			ll_sub_limit_tot = ll_sub_limit_tot + ll_limit
//			ll_sub_limit_tot = ll_sub_limit_tot * 0.2
//			ll_sub_limit_amt = dw_1.object.sub_limit_amt[ll_find]
//			ll_sub_limit_amt = ll_sub_limit_amt + ll_study_supp_amt
//			
//			if ll_sub_limit_tot >= ll_sub_limit_amt then
//				ll_sub_limit_amt = ll_study_supp_amt
//				ll_sub_limit_tot = long(dw_1.object.sub_limit_amt[ll_find]) + ll_sub_limit_amt
//			else
//				ll_sub_limit_amt = ll_sub_limit_tot - long(dw_1.object.sub_limit_amt[ll_find])
//				if ll_sub_limit_amt > ll_study_supp_amt then
//					ll_sub_limit_amt = ll_study_supp_amt
//					ll_sub_limit_tot = long(dw_1.object.sub_limit_amt[ll_find]) + ll_sub_limit_amt
//				else
//					ll_sub_limit_tot = long(dw_1.object.sub_limit_amt[ll_find]) + ll_sub_limit_amt
//				end if
//			end if		
//		else
//			ll_sub_limit_tot = ll_limit * 0.2
//			if ll_sub_limit_tot >= ll_study_supp_amt then
//				ll_sub_limit_amt = ll_study_supp_amt
//				ll_sub_limit_tot = ll_study_supp_amt
//			else
//				ll_sub_limit_amt = ll_sub_limit_tot
//				ll_sub_limit_tot = ll_sub_limit_amt
//			end if
//	end if
//	
//		INSERT INTO person.JBTmonth_pay
//		                   ( member_no, year_month, pay_date,	salary, study_supp_amt,
//								   family_amt,	long_amt, jido_amt, bojik_amt, study_amt,
//									account_amt, duty_amt, bojeon_amt, gubyang_amt,	hang_supp_amt,
//									upmu_supp_amt,	overtime_amt, night_amt, imsi_amt, tukgun_amt,
//									handicap_amt, etc_amt1,	etc_amt2, pay_sum, bonus_amt,	jungkun_amt,
//									health_amt,	bonus_sum, exception_pay_sum,	over_time_amt,
//									pay_total, sub_limit_amt, sub_limit_tot, standard_income,
//									product_tax, income_tax_deduct, income_tax, farm_tax,	resident_tax,
//									pension,	pension_lend_amt,	kyowon_deduct,	kyowon_lend_amt,
//									medical_insurance, union_cost, kyungjo_amt, sangjo_amt, meet_amt,
//									etc_saving,	etc_gongje, add_gongje1, add_gongje2, add_gongje3,
//									add_gongje4, add_gongje5, add_gongje6,	add_gongje7, add_gongje8,
//									add_gongje9, add_gongje10,	deduct_tot, chagam_amt,	pay_opt,	entry_no,
//									entry_date ) 
//					values   (  :ls_member_no,	:ls_year, :ls_date, :ll_bonbong,	:ll_study_supp_amt,
//									:ll_family,	:ll_long_amt, :ll_jido_amt, :ll_bojik_amt, :ll_study_amt,
//									:ll_account_amt, :ll_duty_amt, :ll_bojeon_amt, :ll_gubyang_amt,
//									:ll_hang_supp_amt, :ll_upmu_supp_amt, :ll_overtime_amt, :ll_night_amt,
//									:ll_imsi_amt, :ll_tukgun_amt, :ll_handycap, :ll_etc_sudang1,
//									:ll_etc_sudang2, :ll_pay_sum,	:ll_bonus, :ll_jungkun_amt, :ll_health_tot,
//									:ll_bonus_sum,	:ll_tot,	:ll_over_gangsa, :ll_pay_total, :ll_sub_limit_amt,
//									:ll_sub_limit_tot, 0, 0, 0, 0, 0, 0, :ll_pension, :ll_pension_lend_amt,
//									:ll_kyowon_deduc, :ll_kyowon_lend_deduc, :ll_medical_insurance, 
//									:ll_union_cost, :ll_kyungjo_amt,	:ll_sangjo_amt, :ll_month_amt,
//									:ll_etc_saving, :ll_etc_gongje, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
//									:ld_deduct_tot, :ld_chagam_amt, 'Y', :ls_EntryNo, :ldt_EntryDateTime );
//
//							IF SQLCA.SQLCODE <> 0 THEN
//								ROLLBACK USING SQLCA;
//								st_status.text = '개인번호 : ' + ls_member_no + ' 자료 생성실패입니다!'
//								gf_dis_msg(1,'자료 생성실패입니다.!',"")
//								RETURN
//							END IF
//FETCH CUR_SOR INTO :ls_member_no, :ls_year_month, :ls_campus_code, :ls_jikjong_code, 
//                   :ls_jikgeub_code, :ls_hobong_code, :ll_paywork, :ll_bonwork, :ll_healthwork, :ll_num_of_abs,
//						 :ll_bonbong, :ls_wife_yn, :ls_support_20, :ls_support_60, :ls_handycap,
//						 :ls_older, :ls_woman, :ls_study_supp_code, :ls_spouse_code, :ls_family_code,
//						 :ls_long_code, :ls_jido_code, :ls_bojik_code, :ll_bojik_cnt ,:ls_study_code, :ls_account_code, 
//                   :ls_duty_code, :ll_bojeon_amt, :ls_gubyang_code, :ls_hang_supp_code, 
//                   :ls_upmu_supp_code, :ls_overtime_code, :ls_night_code, :ll_imsi_amt, 
//                   :ll_tukgun_amt, :ll_etc_sudang1, :ll_etc_sudang2,
//						 :ll_exception_amt, :ll_accept_month,
//						 :ll_pension, :ll_pension_lend_amt, :ll_kyowon_deduc, :ll_kyowon_lend_deduc,
//						 :ll_medical_insurance, :ll_kyungjo_amt, :ll_sangjo_amt, :ll_etc_saving,
//						 :ll_etc_gongje, :ls_union_opt, :ls_jaejik_opt, :ls_hakwonhire_date, :ls_retire_date, :ls_sosok;
//	hpb_1.Position	= hpb_1.position + 1
//LOOP
//CLOSE CUR_SOR;
//
////자료 없음..
//if ll_cnt < 1 then
//	st_status.text = '생성될 자료가 없습니다..'
//	gf_dis_msg(1,'생성될 자료가 없습니다.','')
//	return
//end if
//
//COMMIT USING SQLCA;
//SetPointer(Arrow!)
//st_status.text = string(ll_cnt) + ' 건 자료가 생성되었습니다..'
//gf_dis_msg(1, string(ll_cnt) + '건 자료가 생성되었습니다.','')
end event

type st_2 from statictext within w_hpa603b
boolean visible = false
integer x = 2313
integer y = 80
integer width = 453
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long textcolor = 8388608
string text = "※ 반드시 조회를"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_hpa603b
boolean visible = false
integer x = 2441
integer y = 384
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long textcolor = 16711680
boolean enabled = false
string text = "소급금계산"
end type

type st_1 from statictext within w_hpa603b
boolean visible = false
integer x = 2313
integer y = 148
integer width = 535
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long textcolor = 8388608
string text = "   하시기 바랍니다."
boolean focusrectangle = false
end type

type uo_member_no from cuo_member_fromto within w_hpa603b
integer x = 407
integer y = 368
integer taborder = 120
boolean bringtotop = true
end type

event ue_itemchanged();call super::ue_itemchanged;is_str_member	=	uf_str_member()
is_end_member	=	uf_end_member()

end event

on uo_member_no.destroy
call cuo_member_fromto::destroy
end on

type st_7 from st_1 within w_hpa603b
boolean visible = true
integer x = 105
integer y = 388
integer width = 288
boolean enabled = false
string text = "개 인 별"
end type

type rb_all from radiobutton within w_hpa603b
boolean visible = false
integer x = 2290
integer y = 72
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long textcolor = 16711680
string text = "전체"
boolean checked = true
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_y.textcolor = rgb(0, 0, 0)
rb_n.textcolor = rgb(0, 0, 0)

ii_jaejik_opt = 0

wf_getchild()

end event

type rb_y from radiobutton within w_hpa603b
boolean visible = false
integer x = 2542
integer y = 84
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
string text = "재직"
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_all.textcolor = rgb(0, 0, 0)
rb_n.textcolor = rgb(0, 0, 0)

ii_jaejik_opt = 1

wf_getchild()

end event

type rb_n from radiobutton within w_hpa603b
boolean visible = false
integer x = 2775
integer y = 84
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
string text = "퇴직"
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_all.textcolor = rgb(0, 0, 0)
rb_y.textcolor = rgb(0, 0, 0)

ii_jaejik_opt = 3

wf_getchild()

end event

type dw_list002 from uo_dwgrid within w_hpa603b
integer x = 50
integer y = 504
integer width = 4384
integer height = 952
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "연말정산 대상자 기초사항"
string dataobject = "d_hpa603b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_data, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_data, 'member_no')

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_update from uo_dwgrid within w_hpa603b
integer x = 50
integer y = 1460
integer width = 4384
integer height = 816
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "연말정산 내역"
string dataobject = "d_hpa603b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_mast, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_mast, 'member_no')

end event

type pb_1 from uo_imgbtn within w_hpa603b
integer x = 3456
integer y = 368
integer taborder = 60
boolean bringtotop = true
string btnname = "연말정산"
end type

event clicked;call super::clicked;// 생성처리한다.
String	s_buffer
integer	li_rtn, l_count

String ls_year, ls_dept_code, ls_jikjong
Integer	li_str_jikjong

dw_con.accepttext()
ls_year = String(dw_con.object.year[1], 'yyyy')
ls_dept_code = trim(dw_con.object.dept_code[1])
If ls_dept_code = '' or isnull(ls_dept_code) Then ls_dept_code = '%'


ls_jikjong = trim(dw_con.object.jikjong_code[1])

if isnull(ls_jikjong) or trim(ls_jikjong) = '0' or trim(ls_jikjong) = '' then	
	li_str_jikjong	=	0
	//li_end_jikjong	=	9
else
	li_str_jikjong = integer(trim(ls_jikjong))
	//li_end_jikjong = integer(trim(ls_jikjong))
end if

li_rtn = f_messageBox('2','작업을 하시면 기존내용은 무시됩니다. ~n그래도 계속하시겠습니까?')
IF		li_rtn	=	1	THEN	
	
	setpointer(hourglass!)
//messageBox('', ls_year+':'+ls_dept_code+':'+is_str_member+':'+is_end_member)
//messageBox('', li_str_jikjong)
   DECLARE create_proc PROCEDURE FOR PADB.USP_INCOME_TAX (:ls_year,:ls_dept_code,:li_str_jikjong,:is_str_member,:is_end_member );

	EXECUTE create_proc;
	if SQLCA.SqlCode 	=	0 then
		f_messageBox('1','작업중 오류발생'+sqlca.sqlerrtext)
		RETURN 
	end if

	commit;
	f_messageBox('1','작업이 완료되었습니다.')
	setpointer(arrow!)
END IF
end event

on pb_1.destroy
call uo_imgbtn::destroy
end on

type gb_2 from groupbox within w_hpa603b
integer x = 55
integer y = 300
integer width = 4379
integer height = 200
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long textcolor = 33554432
string text = "개인번호를 선택하지 않으면 전체"
end type

