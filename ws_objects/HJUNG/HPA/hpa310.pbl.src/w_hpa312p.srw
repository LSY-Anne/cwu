$PBExportHeader$w_hpa312p.srw
$PBExportComments$급여명세서 출력
forward
global type w_hpa312p from w_print_form2
end type
type dw_display_title from cuo_display_title within w_hpa312p
end type
type st_4 from st_2 within w_hpa312p
end type
type st_5 from st_3 within w_hpa312p
end type
type st_7 from st_1 within w_hpa312p
end type
type st_8 from st_2 within w_hpa312p
end type
type st_41 from st_2 within w_hpa312p
end type
type pb_1_old from picturebutton within w_hpa312p
end type
type dw_sudang from datawindow within w_hpa312p
end type
type dw_gongje from datawindow within w_hpa312p
end type
type pb_2 from picturebutton within w_hpa312p
end type
type uo_member_no from cuo_member_fromto within w_hpa312p
end type
type cbx_1 from checkbox within w_hpa312p
end type
type pb_3 from picturebutton within w_hpa312p
end type
type ddlb_1 from dropdownlistbox within w_hpa312p
end type
type st_9 from statictext within w_hpa312p
end type
type st_10 from statictext within w_hpa312p
end type
type dw_print2 from cuo_dwprint within w_hpa312p
end type
type dw_data from datawindow within w_hpa312p
end type
type gb_1 from groupbox within w_hpa312p
end type
end forward

global type w_hpa312p from w_print_form2
integer width = 4512
string title = "급여명세서 출력"
dw_display_title dw_display_title
st_4 st_4
st_5 st_5
st_7 st_7
st_8 st_8
st_41 st_41
pb_1_old pb_1_old
dw_sudang dw_sudang
dw_gongje dw_gongje
pb_2 pb_2
uo_member_no uo_member_no
cbx_1 cbx_1
pb_3 pb_3
ddlb_1 ddlb_1
st_9 st_9
st_10 st_10
dw_print2 dw_print2
dw_data dw_data
gb_1 gb_1
end type
global w_hpa312p w_hpa312p

type variables
mailSession 		m_mail_session 
mailReturnCode		m_rtn
mailMessage 		m_message

string	is_str_member= 'A0000', is_end_member = 'Z9999'
end variables

forward prototypes
public subroutine wf_getchild2 ()
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

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

uo_member_no.uf_getchild(ii_str_jikjong, ii_end_jikjong, is_dept_code, 1)

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

// 보직코드
dw_print.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

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


if ddlb_1.text = '2' then
	dw_print2.dataobject = 'd_hpa312p_16'
//end if
elseif ddlb_1.text = '3' then
	dw_print2.dataobject = 'd_hpa312p_5'

elseif ddlb_1.text = '5' then
	dw_print2.dataobject = 'd_hpa312p_7'
end if

dw_print2.settransobject(sqlca)
dw_print2.Modify("DataWindow.Print.Preview='yes'")

if dw_print2.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, is_str_member, is_end_member) > 0 then
	if dw_data.Retrieve(is_yearmonth, ddlb_1.Text) = 0 then
		dw_data.insertrow(0)
	end if
else
	messagebox('알림',is_yearmonth + '에 해당되는 데이타가 없습니다.~n 해당년월과 차수를 확인하여 주시기바랍니다,')
end if

return 0

end function

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()

return 1
end event

on w_hpa312p.create
int iCurrent
call super::create
this.dw_display_title=create dw_display_title
this.st_4=create st_4
this.st_5=create st_5
this.st_7=create st_7
this.st_8=create st_8
this.st_41=create st_41
this.pb_1_old=create pb_1_old
this.dw_sudang=create dw_sudang
this.dw_gongje=create dw_gongje
this.pb_2=create pb_2
this.uo_member_no=create uo_member_no
this.cbx_1=create cbx_1
this.pb_3=create pb_3
this.ddlb_1=create ddlb_1
this.st_9=create st_9
this.st_10=create st_10
this.dw_print2=create dw_print2
this.dw_data=create dw_data
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_display_title
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.st_8
this.Control[iCurrent+6]=this.st_41
this.Control[iCurrent+7]=this.pb_1_old
this.Control[iCurrent+8]=this.dw_sudang
this.Control[iCurrent+9]=this.dw_gongje
this.Control[iCurrent+10]=this.pb_2
this.Control[iCurrent+11]=this.uo_member_no
this.Control[iCurrent+12]=this.cbx_1
this.Control[iCurrent+13]=this.pb_3
this.Control[iCurrent+14]=this.ddlb_1
this.Control[iCurrent+15]=this.st_9
this.Control[iCurrent+16]=this.st_10
this.Control[iCurrent+17]=this.dw_print2
this.Control[iCurrent+18]=this.dw_data
this.Control[iCurrent+19]=this.gb_1
end on

on w_hpa312p.destroy
call super::destroy
destroy(this.dw_display_title)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_41)
destroy(this.pb_1_old)
destroy(this.dw_sudang)
destroy(this.dw_gongje)
destroy(this.pb_2)
destroy(this.uo_member_no)
destroy(this.cbx_1)
destroy(this.pb_3)
destroy(this.ddlb_1)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.dw_print2)
destroy(this.dw_data)
destroy(this.gb_1)
end on

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//IF dw_print2.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, dw_print2)
//
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
//wf_getchild()
//wf_getchild2()
//
//wf_SetMenu('FIRST', 	TRUE)
//wf_SetMenu('NEXT', 	TRUE)
//wf_SetMenu('PRE', 	TRUE)
//wf_SetMenu('LAST', 	TRUE)
//wf_SetMenu('SAVE', 	TRUE)
//
//ddlb_1.text = '2'
end event

event ue_first;call super::ue_first;dw_print2.scrolltorow(1)
end event

event ue_last;call super::ue_last;dw_print2.scrolltorow(dw_print2.rowcount())
end event

event ue_next;call super::ue_next;dw_print2.scrollpriorpage()
end event

event ue_prior;call super::ue_prior;dw_print2.scrollnextpage()
end event

event ue_save;call super::ue_save;///////////////////////////////////////////////////////
// 1. 공지사항을 저장하기 위핸 기술
///////////////////////////////////////////////////////
string ls_chasu

if ddlb_1.text = '2' then
   ls_chasu = '2'
elseif ddlb_1.text = '3' then
   ls_chasu = '3'
elseif ddlb_1.text = '5' then
   ls_chasu = '5'
end if
///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IPAddr		//등록단말기

ll_Row = dw_data.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gs_empcode // gstru_uid_uname.uid			//등록자
	ls_IPAddr    = gs_ip   //gstru_uid_uname.address		//등록단말기
END IF
DO WHILE ll_Row > 0
	
	ldis_Status = dw_data.GetItemStatus(ll_Row,0,Primary!)
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 저장처리전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		dw_data.Object.year_month[ll_row] = is_yearmonth
		dw_data.Object.chasu		 [ll_row] = ls_chasu
		
		dw_data.Object.worker    [ll_Row] = ls_Worker		//등록일자
		dw_data.Object.work_date [ll_Row] = ldt_WorkDate	//등록자
		dw_data.Object.ipaddr    [ll_Row] = ls_IPAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	dw_data.Object.job_uid  [ll_Row] = ls_Worker		//등록자
	dw_data.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	dw_data.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = dw_data.GetNextModified(ll_Row,primary!)
LOOP
///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF NOT dw_data.TRIGGER EVENT ue_db_save() THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('IDSRP')

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================


uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

uo_dept_code.uf_setdept('', '소속명')
is_dept_code	=	uo_dept_code.uf_getcode()

f_getdwcommon2(dw_head, 'jikjong_code', 0, 'code', 750, 100)



wf_button_control()

uo_yearmonth.em_yearmonth.setfocus()


wf_getchild()
wf_getchild2()

//wf_SetMenu('FIRST', 	TRUE)
//wf_SetMenu('NEXT', 	TRUE)
//wf_SetMenu('PRE', 	TRUE)
//wf_SetMenu('LAST', 	TRUE)
//wf_SetMenu('SAVE', 	TRUE)

idw_print = dw_print2
ddlb_1.text = '2'
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
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

type ln_templeft from w_print_form2`ln_templeft within w_hpa312p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa312p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa312p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa312p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa312p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa312p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa312p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa312p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa312p
end type

type uc_save from w_print_form2`uc_save within w_hpa312p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa312p
end type

type uc_print from w_print_form2`uc_print within w_hpa312p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa312p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa312p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa312p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa312p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa312p
end type

type st_back from w_print_form2`st_back within w_hpa312p
boolean visible = false
integer y = 584
integer height = 1940
end type

type dw_print from w_print_form2`dw_print within w_hpa312p
boolean visible = false
integer y = 592
integer height = 1940
boolean hscrollbar = false
end type

type st_1 from w_print_form2`st_1 within w_hpa312p
end type

type dw_head from w_print_form2`dw_head within w_hpa312p
integer y = 184
integer width = 686
integer height = 80
end type

event dw_head::itemchanged;call super::itemchanged;wf_getchild2()
end event

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa312p
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa312p
integer x = 974
integer y = 184
boolean border = false
end type

event uo_dept_code::ue_itemchange;call super::ue_itemchange;wf_getchild2()
end event

type st_2 from w_print_form2`st_2 within w_hpa312p
end type

type st_3 from w_print_form2`st_3 within w_hpa312p
end type

type st_con from w_print_form2`st_con within w_hpa312p
end type

type dw_con from w_print_form2`dw_con within w_hpa312p
boolean visible = false
end type

type dw_display_title from cuo_display_title within w_hpa312p
boolean visible = false
integer x = 3150
integer y = 1148
integer taborder = 50
boolean bringtotop = true
end type

event constructor;call super::constructor;settransobject(sqlca)

end event

type st_4 from st_2 within w_hpa312p
boolean visible = false
integer x = 754
integer y = 440
integer width = 3054
string text = "※ 아웃룩의 도구/옵션에서 보안 -> 다른 응용 프로그램에서 나를 발신으로 하는 메일 보낼 때 경고의 체크를 없앨것."
end type

type st_5 from st_3 within w_hpa312p
boolean visible = false
integer x = 754
integer y = 496
integer width = 3054
string text = "                          읽기 -> 글꼴을 굴림체(표준)으로 설정할것."
end type

type st_7 from st_1 within w_hpa312p
integer x = 160
integer y = 340
integer width = 288
long backcolor = 1073741824
string text = "개 인 별"
end type

type st_8 from st_2 within w_hpa312p
integer x = 2697
integer y = 316
integer width = 613
long backcolor = 1073741824
string text = "※ 개인번호를 지우면"
end type

type st_41 from st_2 within w_hpa312p
integer x = 2697
integer y = 368
integer width = 613
long backcolor = 1073741824
string text = "   전체가 조회됩니다."
end type

type pb_1_old from picturebutton within w_hpa312p
boolean visible = false
integer x = 1266
integer y = 368
integer width = 530
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "    E-Mail 전송"
string picturename = "..\bmp\EMAIL_E.BMP"
string disabledname = "..\bmp\EMAIL_D.BMP"
vtextalign vtextalign = vcenter!
end type

event clicked;integer	li_rtn, li_cnt, i, li_errcnt, li_totcnt, li_succnt
long		ll_rowcount
string	ls_notetext, ls_name, ls_amt, ls_member_no, ls_kname

if dw_print.rowcount() < 1 then
	if f_messagebox('2', '자료가 존재하지 않습니다.~n~n조회를 하시겠습니까?') = 2 then return

	parent.triggerevent('ue_retrieve')	
end if

if f_messagebox('2', 'E-Mail 전송을 하시겠습니까?') = 2 then	return

// Session Create
m_mail_session = CREATE mailSession 

m_rtn = m_mail_session.MailLogon() 

IF m_rtn <> mailReturnSuccess! THEN 
	destroy	m_mail_session
	f_messagebox('3', '로그온을 실패했습니다.~n~n전산실에 문의하세요.!')
	return
end if

li_errcnt = 0
li_totcnt = 0
li_succnt = 0

// mailMessage 스트럭쳐에 메시지 세팅하기. 
ll_rowcount = dw_print.rowcount()
for li_cnt = 1 to ll_rowcount
	if isnull(dw_print.getitemstring(li_cnt, 'hin011m_email_id')) or trim(dw_print.getitemstring(li_cnt, 'hin011m_email_id')) = '' then continue

	li_totcnt ++
//	m_message.recipient[li_totcnt].name	=	dw_print.getitemstring(li_cnt, 'hin011m_email_id')
	m_message.recipient[1].name	=	dw_print.getitemstring(li_cnt, 'hin011m_email_id')
	
	ls_notetext	=	'▶ ' + string(is_yearmonth, '@@@@년 @@월') + ' 급여 명세서 내역 ◀~n~n~n'	+	&
						'※ 귀하의 노고에 진심으로 감사드립니다.~n~n~n'
	
	ls_member_no = dw_print.getitemstring(li_cnt, 'member_no')
	ls_kname		 = dw_print.getitemstring(li_cnt, 'name')
	ls_notetext	+= '  개인번호   ' + ls_member_no + '~n'		+	&
						'  성    명   ' + ls_kname + '~n'				+	&
						'  호    봉   ' + dw_print.getitemstring(li_cnt, 'sal_code') + '~n~n'	+	&
						'┏━━━━━━━━━━━┯━━━━━━┳━━━━━━━━━━━┯━━━━━━┓~n'	+	&
						'┃    수  당  내  역    │   금  액   ┃    공  제  내  역    │   금  액   ┃~n'	+	&
						'┣━━━━━━━━━━━┿━━━━━━╋━━━━━━━━━━━┿━━━━━━┫~n'

	// 명칭과 금액
	for i = 1 to 15
		ls_name = dw_print.getitemstring(li_cnt, 'sudang_' + string(i) + '_t')
		ls_amt  = string(dw_print.getitemnumber(li_cnt, 'hpa015m_sudang_' + string(i)), '#,##0')
		ls_notetext += '┃'	+	&
							ls_name + fill(' ', 22 - len(trim(ls_name)))	+ '│ ' 	+ &
							fill(' ', 11 - len(trim(ls_amt))) + ls_amt
							
		ls_name = dw_print.getitemstring(li_cnt, 'gongje_' + string(i) + '_t')
		ls_amt  = string(dw_print.getitemnumber(li_cnt, 'hpa015m_gongje_' + string(i)), '#,##0')
		ls_notetext += '┃'	+	&
							ls_name + fill(' ', 22 - len(trim(ls_name)))	+ '│ ' 	+ &
							fill(' ', 11 - len(trim(ls_amt))) + ls_amt + '┃~n'
	next
	// 명칭과 금액
	for i = 16 to 18
		ls_name = dw_print.getitemstring(li_cnt, 'sudang_' + string(i) + '_t')
		ls_amt  = string(dw_print.getitemnumber(li_cnt, 'hpa015m_sudang_' + string(i)), '#,##0')
		ls_notetext += '┃'	+	&
							ls_name + fill(' ', 22 - len(trim(ls_name)))	+ '│ ' 	+ &
							fill(' ', 11 - len(trim(ls_amt))) + ls_amt	+	&
							'┃' + fill(' ', 22) + '│ ' + fill(' ', 11) + '┃~n'
	next
	ls_notetext += '┣━━━━━━━━━━━┿━━━━━━╋━━━━━━━━━━━┿━━━━━━┫~n'
	ls_amt = string(dw_print.getitemnumber(li_cnt, 'tot'), '#,##0')
	ls_notetext += '┃    합          계    │ ' + fill(' ', 11 - len(trim(ls_amt))) + ls_amt
	
	ls_amt = string(dw_print.getitemnumber(li_cnt, 'gongje_tot'), '#,##0')
	ls_notetext += '┃    합          계    │ ' + fill(' ', 11 - len(trim(ls_amt))) + ls_amt	+	'┃~n'
	ls_notetext += '┠───────────┼──────╂───────────┼──────┨~n'
	ls_amt = string(dw_print.getitemnumber(li_cnt, 'chain_amt'), '#,##0')
	ls_notetext += '┃                      │            ┃    차 인 지 급 액    │ ' +	&
						fill(' ', 11 - len(trim(ls_amt))) + ls_amt + '┃~n'
	ls_notetext += '┗━━━━━━━━━━━┷━━━━━━┻━━━━━━━━━━━┷━━━━━━┛~n'

	m_message.Subject			= string(is_yearmonth, '@@@@년 @@월') + ' 급여 명세서 내역'
	m_message.NoteText		= ls_notetext
	
	// 메일 메시지 전송 
	m_rtn = m_mail_session.mailSend(m_message)
	
	IF m_rtn <> mailReturnSuccess! THEN 
//		m_mail_session.MailLogoff() 
//		DESTROY	m_mail_session 
		f_messagebox('3', '개인번호 : ' + ls_member_no + '~n'	+	&
								'성명 : ' + ls_kname	  + '~n'	+	&
								'E-Mail : ' + m_message.recipient[1].name + '~n~n메일 보내기를 실패했습니다.!')
		li_errcnt ++
//		return
	else
		li_succnt ++
	END IF
next

m_mail_session.MailLogoff() 
DESTROY	m_mail_session 

if li_errcnt > 0 then
	f_messagebox('1', '총 ' + string(ll_rowcount, '#,##0') + '건의 자료중~n'			+	&
							string(li_succnt, '#,##0') + '건의 메일 전송을 완료했습니다.~n'	+	&
							string(li_errcnt, '#,##0') + '건의 메일 전송을 실패했습니다.~n~n확인 후 다시 실행해 주시기 바랍니다.!')
else
	f_messagebox('1', '총 ' + string(ll_rowcount, '#,##0') + '건의 자료중~n' + string(li_succnt, '#,##0') + '건의 메일 전송을 완료했습니다.!')
end if

return
end event

type dw_sudang from datawindow within w_hpa312p
boolean visible = false
integer x = 1906
integer y = 732
integer width = 329
integer height = 432
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa312p_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_gongje from datawindow within w_hpa312p
boolean visible = false
integer x = 2496
integer y = 648
integer width = 329
integer height = 432
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa312p_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type pb_2 from picturebutton within w_hpa312p
boolean visible = false
integer x = 859
integer y = 492
integer width = 530
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "    E-Mail 전송"
string picturename = "..\bmp\EMAIL_E.BMP"
string disabledname = "..\bmp\EMAIL_D.BMP"
vtextalign vtextalign = vcenter!
end type

event clicked;integer	li_cnt, li_totcnt, li_sudang_cnt, li_gongje_cnt, li_maxrow, i, li_succtn
long		ll_rowcount
string	ls_mail, ls_notetext, ls_member_no, ls_kname, ls_name, ls_amt

ll_rowcount = dw_print.rowcount()

for li_cnt = 1 to ll_rowcount
//	if isnull(dw_print.getitemstring(li_cnt, 'hin011m_email_id')) or trim(dw_print.getitemstring(li_cnt, 'hin011m_email_id')) = '' then continue

	li_totcnt ++
	ls_mail	=	dw_print.getitemstring(li_cnt, 'hin011m_email_id')

	ls_notetext	=	'▶ ' + string(is_yearmonth, '@@@@년 @@월') + ' 급여 명세서 내역 ◀~n~n~n'	+	&
						'※ 귀하의 노고에 진심으로 감사드립니다.~n~n~n'
	
	ls_member_no = dw_print.getitemstring(li_cnt, 'member_no')
	ls_kname		 = dw_print.getitemstring(li_cnt, 'hpa001m_name')
	ls_notetext	+= '  개인번호   ' + ls_member_no + '~n'		+	&
						'  성    명   ' + ls_kname + '~n'				+	&
						'  호    봉   ' + dw_print.getitemstring(li_cnt, 'hpa001m_sal_code') + '~n~n'	+	&
						'┏━━━━━━━━━━━┯━━━━━━┳━━━━━━━━━━━┯━━━━━━┓~n'	+	&
						'┃    수  당  내  역    │   금  액   ┃    공  제  내  역    │   금  액   ┃~n'	+	&
						'┣━━━━━━━━━━━┿━━━━━━╋━━━━━━━━━━━┿━━━━━━┫~n'

	li_sudang_cnt = dw_sudang.retrieve(is_yearmonth, ls_member_no, '1')
	li_gongje_cnt = dw_gongje.retrieve(is_yearmonth, ls_member_no, '2')

	li_maxrow	=	max(li_sudang_cnt, li_gongje_cnt)
	// 명칭과 금액
	for i = 1 to li_maxrow
		// 수당금액
		if i <= li_sudang_cnt then
			ls_name	=	dw_sudang.getitemstring(i, 'name')
			ls_amt	=	string(dw_sudang.getitemnumber(i, 'amt'), '#,##0')
		else
			ls_name	=	space(22)
			ls_amt	=	space(11)
		end if
		ls_notetext += '┃'	+	&
							ls_name + space(22 - len(trim(ls_name)))	+ '│ ' 	+ &
							space(11 - len(trim(ls_amt))) + ls_amt

		if i <= li_gongje_cnt then
			ls_name	=	dw_gongje.getitemstring(i, 'name')
			ls_amt	=	string(dw_gongje.getitemnumber(i, 'amt'), '#,##0')
		else
			ls_name	=	space(22)
			ls_amt	=	space(11)
		end if
		ls_notetext += '┃'	+	&
							ls_name + space(22 - len(trim(ls_name)))	+ '│ ' 	+ &
							space(11 - len(trim(ls_amt))) + ls_amt + '┃~n'
	next

//	// 명칭과 금액
//	for i = li_maxrow + 1 to 18
//		ls_name = dw_print.getitemstring(li_cnt, 'sudang_' + string(i) + '_t')
//		ls_amt  = string(dw_print.getitemnumber(li_cnt, 'hpa015m_sudang_' + string(i)), '#,##0')
//		ls_notetext += '┃'	+	&
//							ls_name + fill(' ', 22 - len(trim(ls_name)))	+ '│ ' 	+ &
//							fill(' ', 11 - len(trim(ls_amt))) + ls_amt	+	&
//							'┃' + fill(' ', 22) + '│ ' + fill(' ', 11) + '┃~n'
//	next
	ls_notetext += '┣━━━━━━━━━━━┿━━━━━━╋━━━━━━━━━━━┿━━━━━━┫~n'
	ls_amt = string(dw_print.getitemnumber(li_cnt, 'sudang_sum'), '#,##0')
	ls_notetext += '┃    합          계    │ ' + space(11 - len(trim(ls_amt))) + ls_amt
	
	ls_amt = string(dw_print.getitemnumber(li_cnt, 'gongje_sum'), '#,##0')
	ls_notetext += '┃    합          계    │ ' + space(11 - len(trim(ls_amt))) + ls_amt	+	'┃~n'
	ls_notetext += '┠───────────┼──────╂───────────┼──────┨~n'
	ls_amt = string(dw_print.getitemnumber(li_cnt, 'chain_amt'), '#,##0')
	ls_notetext += '┃                      │            ┃    차 인 지 급 액    │ ' +	&
						space(11 - len(trim(ls_amt))) + ls_amt + '┃~n'
	ls_notetext += '┗━━━━━━━━━━━┷━━━━━━┻━━━━━━━━━━━┷━━━━━━┛~n'

messagebox('', ls_notetext)
//	m_message.Subject			= string(is_yearmonth, '@@@@년 @@월') + ' 급여 명세서 내역'
//	m_message.NoteText		= ls_notetext
	
	// 메일 메시지 전송 
//	m_rtn = m_mail_session.mailSend(m_message)
	
//	IF m_rtn <> mailReturnSuccess! THEN 
////		m_mail_session.MailLogoff() 
////		DESTROY	m_mail_session 
//		f_messagebox('3', '개인번호 : ' + ls_member_no + '~n'	+	&
//								'성    명 : ' + ls_kname	  + '~n'	+	&
//								'E - Mail : ' + m_message.recipient[1].name + '~n~n메일 보내기를 실패했습니다.!')
//		li_errcnt ++
////		return
//	else
//		li_succnt ++
//	END IF
	li_succtn	++
next
end event

type uo_member_no from cuo_member_fromto within w_hpa312p
integer x = 457
integer y = 320
integer taborder = 60
boolean bringtotop = true
end type

on uo_member_no.destroy
call cuo_member_fromto::destroy
end on

event ue_itemchanged();call super::ue_itemchanged;is_str_member	=	uf_str_member()
is_end_member	=	uf_end_member()

end event

type cbx_1 from checkbox within w_hpa312p
boolean visible = false
integer x = 3383
integer y = 248
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "연말정산제외"
end type

type pb_3 from picturebutton within w_hpa312p
boolean visible = false
integer x = 2610
integer y = 532
integer width = 530
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "    E-Mail 전송"
string picturename = "..\bmp\EMAIL_E.BMP"
string disabledname = "..\bmp\EMAIL_D.BMP"
vtextalign vtextalign = vcenter!
end type

event clicked;integer	li_rtn, li_cnt, i, li_errcnt, li_totcnt, li_succnt
long		ll_rowcount
string	ls_notetext, ls_name, ls_amt, ls_member_no, ls_kname

integer	li_sudang_cnt, li_gongje_cnt, li_maxrow

if dw_print.rowcount() < 1 then
	if f_messagebox('2', '자료가 존재하지 않습니다.~n~n조회를 하시겠습니까?') = 2 then return

	parent.triggerevent('ue_retrieve')	
end if

if f_messagebox('2', 'E-Mail 전송을 하시겠습니까?') = 2 then	return

// Session Create
m_mail_session = CREATE mailSession 

m_rtn = m_mail_session.MailLogon() 

IF m_rtn <> mailReturnSuccess! THEN 
	destroy	m_mail_session
	f_messagebox('3', '로그온을 실패했습니다.~n~n전산실에 문의하세요.!')
	return
end if

li_errcnt = 0
li_totcnt = 0
li_succnt = 0

// mailMessage 스트럭쳐에 메시지 세팅하기. 
ll_rowcount = dw_print.rowcount()
for li_cnt = 1 to ll_rowcount
	ls_member_no = trim(dw_print.getitemstring(li_cnt, 'member_no'))
	ls_kname		 = trim(dw_print.getitemstring(li_cnt, 'hpa001m_name'))
	
	if isnull(dw_print.getitemstring(li_cnt, 'hin011m_email_id')) or trim(dw_print.getitemstring(li_cnt, 'hin011m_email_id')) = '' then	
		f_messagebox('2', '[' + ls_member_no + ']' + ls_kname + ' 님의 E-Mail이 없습니다.~n~n확인 후 재발송하시기 바랍니다.!')
		continue
	end if

	li_totcnt ++
//	m_message.recipient[li_totcnt].name	=	dw_print.getitemstring(li_cnt, 'hin011m_email_id')
	m_message.recipient[1].name	=	dw_print.getitemstring(li_cnt, 'hin011m_email_id')

	ls_notetext	=	'▶ ' + string(is_yearmonth, '@@@@년 @@월') + ' 급여 명세서 내역 ◀~n~n~n'	+	&
						'※ 귀하의 노고에 진심으로 감사드립니다.~n~n~n'
	
	ls_notetext	+= '  개인번호   ' + ls_member_no + '~n'		+	&
						'  성    명   ' + ls_kname + '~n'				+	&
						'  호    봉   ' + dw_print.getitemstring(li_cnt, 'hpa001m_sal_code') + '~n~n'	+	&
						'┏━━━━━━━━━━━┯━━━━━━┳━━━━━━━━━━━┯━━━━━━┓~n'	+	&
						'┃    수  당  내  역    │   금  액   ┃    공  제  내  역    │   금  액   ┃~n'	+	&
						'┣━━━━━━━━━━━┿━━━━━━╋━━━━━━━━━━━┿━━━━━━┫~n'

	li_sudang_cnt = dw_sudang.retrieve(is_yearmonth, ls_member_no, '1')
	li_gongje_cnt = dw_gongje.retrieve(is_yearmonth, ls_member_no, '2')

	li_maxrow	=	max(li_sudang_cnt, li_gongje_cnt)

	// 명칭과 금액
	for i = 1 to li_maxrow
		// 수당금액
		if i <= li_sudang_cnt then
			if isnull(dw_sudang.getitemstring(i, 'hpa003m_item_name')) then
				ls_name	=	''
			else
				ls_name	=	dw_sudang.getitemstring(i, 'hpa003m_item_name')
			end if
			if isnull(dw_sudang.getitemnumber(i, 'pay_amt')) then
				ls_amt	=	''
			else
				ls_amt	=	string(dw_sudang.getitemnumber(i, 'pay_amt'), '#,##0')
			end if
		else
			ls_name	=	''
			ls_amt	=	''
		end if
		ls_notetext += '┃'	+	&
							ls_name + space(22 - len(trim(ls_name)))	+ '│ ' 	+ &
							space(11 - len(trim(ls_amt))) + ls_amt

		if i <= li_gongje_cnt then
			if isnull(dw_gongje.getitemstring(i, 'hpa003m_item_name')) then
				ls_name	=	''
			else
				ls_name	=	dw_gongje.getitemstring(i, 'hpa003m_item_name')
			end if
			if isnull(dw_gongje.getitemnumber(i, 'pay_amt')) then
				ls_amt	=	''
			else
				ls_amt	=	string(dw_gongje.getitemnumber(i, 'pay_amt'), '#,##0')
			end if
		else
			ls_name	=	''
			ls_amt	=	''
		end if
		ls_notetext += '┃'	+	&
							ls_name + space(22 - len(trim(ls_name)))	+ '│ ' 	+ &
							space(11 - len(trim(ls_amt))) + ls_amt + '┃~n'
	next

//	// 명칭과 금액
//	for i = li_maxrow + 1 to 18
//		ls_name = dw_print.getitemstring(li_cnt, 'sudang_' + string(i) + '_t')
//		ls_amt  = string(dw_print.getitemnumber(li_cnt, 'hpa015m_sudang_' + string(i)), '#,##0')
//		ls_notetext += '┃'	+	&
//							ls_name + fill(' ', 22 - len(trim(ls_name)))	+ '│ ' 	+ &
//							fill(' ', 11 - len(trim(ls_amt))) + ls_amt	+	&
//							'┃' + fill(' ', 22) + '│ ' + fill(' ', 11) + '┃~n'
//	next

	ls_notetext += '┣━━━━━━━━━━━┿━━━━━━╋━━━━━━━━━━━┿━━━━━━┫~n'
	ls_amt = string(dw_print.getitemnumber(li_cnt, 'sudang_sum'), '#,##0')
	ls_notetext += '┃    합          계    │ ' + space(11 - len(trim(ls_amt))) + ls_amt
	
	ls_amt = string(dw_print.getitemnumber(li_cnt, 'gongje_sum'), '#,##0')
	ls_notetext += '┃    합          계    │ ' + space(11 - len(trim(ls_amt))) + ls_amt	+	'┃~n'
	ls_notetext += '┠───────────┼──────╂───────────┼──────┨~n'
	ls_amt = string(dw_print.getitemnumber(li_cnt, 'chain_amt'), '#,##0')
	ls_notetext += '┃                      │            ┃    차 인 지 급 액    │ ' +	&
						space(11 - len(trim(ls_amt))) + ls_amt + '┃~n'
	ls_notetext += '┗━━━━━━━━━━━┷━━━━━━┻━━━━━━━━━━━┷━━━━━━┛~n'

	m_message.Subject			= string(is_yearmonth, '@@@@년 @@월') + ' 급여 명세서 내역'
	m_message.NoteText		= ls_notetext
	
	// 메일 메시지 전송 
	m_rtn = m_mail_session.mailSend(m_message)
	
	IF m_rtn <> mailReturnSuccess! THEN 
//		m_mail_session.MailLogoff() 
//		DESTROY	m_mail_session 
		f_messagebox('3', '개인번호 : ' + ls_member_no + '~n'	+	&
								'성    명 : ' + ls_kname	  + '~n'	+	&
								'E - Mail : ' + m_message.recipient[1].name + '~n~n메일 보내기를 실패했습니다.!')
		li_errcnt ++
//		return
	else
		li_succnt ++
	END IF
next

m_mail_session.MailLogoff() 
DESTROY	m_mail_session 

if li_errcnt > 0 then
	f_messagebox('1', '총 ' + string(ll_rowcount, '#,##0') + '건의 자료중~n'			+	&
							string(li_succnt, '#,##0') + '건의 메일 전송을 완료했습니다.~n'	+	&
							string(li_errcnt, '#,##0') + '건의 메일 전송을 실패했습니다.~n~n확인 후 다시 실행해 주시기 바랍니다.!')
else
	f_messagebox('1', '총 ' + string(ll_rowcount, '#,##0') + '건의 자료중~n' + string(li_succnt, '#,##0') + '건의 메일 전송을 완료했습니다.!')
end if

return


/*
┏━━━━━━━━━━━┯━━━━━━┳━━━━━━━━━━━┯━━━━━━┓
┃    수  당  내  역    │   금  액   ┃    공  제  내  역    │   금  액   ┃
┣━━━━━━━━━━━┿━━━━━━╋━━━━━━━━━━━┿━━━━━━┫
┃1234567890123456789012│ 111,000,000┃1234567890123456789012│ 111,000,000┃
┃1234567890123456789012│ 111,000,000┃1234567890123456789012│ 111,000,000┃
┃1234567890123456789012│ 111,000,000┃1234567890123456789012│ 111,000,000┃
┃1234567890123456789012│ 111,000,000┃1234567890123456789012│ 111,000,000┃
┃1234567890123456789012│ 111,000,000┃1234567890123456789012│ 111,000,000┃
┃1234567890123456789012│ 111,000,000┃1234567890123456789012│ 111,000,000┃
┃1234567890123456789012│ 111,000,000┃1234567890123456789012│ 111,000,000┃
┣━━━━━━━━━━━┿━━━━━━╋━━━━━━━━━━━┿━━━━━━┫
┃    합          계    │ 111,000,000┃    합          계    │ 111,000,000┃
┠───────────┼──────╂───────────┼──────┨
┃                      │            ┃    차 인 지 급 액    │ 111,000,000┃
┗━━━━━━━━━━━┷━━━━━━┻━━━━━━━━━━━┷━━━━━━┛
*/
end event

type ddlb_1 from dropdownlistbox within w_hpa312p
integer x = 3621
integer y = 324
integer width = 219
integer height = 284
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean allowedit = true
string item[] = {"2","3","5"}
borderstyle borderstyle = stylelowered!
end type

type st_9 from statictext within w_hpa312p
integer x = 3447
integer y = 336
integer width = 169
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "차수"
boolean focusrectangle = false
end type

type st_10 from statictext within w_hpa312p
integer x = 160
integer y = 460
integer width = 320
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "공지 사항"
boolean focusrectangle = false
end type

type dw_print2 from cuo_dwprint within w_hpa312p
integer x = 46
integer y = 568
integer width = 4402
integer height = 1708
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hpa312p_16"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
end type

type dw_data from datawindow within w_hpa312p
event type boolean ue_db_save ( )
integer x = 457
integer y = 436
integer width = 2450
integer height = 104
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa312p_10"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type boolean ue_db_save();////////////////////////////////////////////////////////////////////////////////////////// 
//	이벤트  명 : ue_db_save
//	작성/수정자 : 전희열
//	작성/수정일 : 1999.08.03 (화)
//	기 능 설 명: 자료를 저장한다.
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
THIS.AcceptText()

IF THIS.UPDATE() = 1 THEN
	COMMIT USING SQLCA;
	RETURN TRUE
ELSE
	ROLLBACK USING SQLCA;
	RETURN FALSE
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event constructor;this.SettransObject(sqlca)
end event

type gb_1 from groupbox within w_hpa312p
integer x = 50
integer y = 268
integer width = 4393
integer height = 292
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
end type

