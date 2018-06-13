$PBExportHeader$w_kch412b.srw
$PBExportComments$예외부서예산신청
forward
global type w_kch412b from w_msheet
end type
type dw_2 from datawindow within w_kch412b
end type
type st_2 from statictext within w_kch412b
end type
type dw_1 from datawindow within w_kch412b
end type
type st_1 from statictext within w_kch412b
end type
type cb_1 from commandbutton within w_kch412b
end type
type gb_2 from groupbox within w_kch412b
end type
end forward

global type w_kch412b from w_msheet
integer width = 4485
integer height = 2380
string title = "로긴화면(로긴부서설정)"
boolean resizable = false
windowtype windowtype = response!
dw_2 dw_2
st_2 st_2
dw_1 dw_1
st_1 st_1
cb_1 cb_1
gb_2 gb_2
end type
global w_kch412b w_kch412b

type variables
Integer ii_count =0
end variables

forward prototypes
public function integer wf_login_pass ()
end prototypes

public function integer wf_login_pass ();//STRING  Pass_word,s_uid ,s_name, s_dept
//Int     i_return,i_admin_code, i_opt1
//int     i_cnt,i_count
//String  S_SABUN
//s_name     = trim(sle_userid.text)   // 사용자 ID 
//Pass_word  = trim(sle_password.text) // 패스워드
//
//s_name	=	 'test'
//
////s_dept 	=	trim(sle_userid.text)
//s_dept	=	trim(dw_1.getitemstring(1, 'code'))
//s_sabun 	=	trim(sle_password.text)
//
//select	group11_code
//into		:i_opt1
//from		cddb.kch003m
//where		rtrim(gwa)	=	:s_dept	;
//
//if sqlca.sqlcode <> 0 then	
//	f_messagebox('1', '부서코드를 정확히 입력해 주시기 바랍니다.!')
//	sle_userid.text	=	''
//	sle_userid.setfocus()
//	return	200
//end if
//
//if s_sabun = '' then
//	choose case	s_dept
//		case	'5112'
//			// 기획처 
//			S_SABUN	=	'0003003'
//	
//		case	'5111'
//			// 교무처
//			S_SABUN	=	'0003004'
//	
//		case	'5133'
//			// 사무처
//			S_SABUN	=	'0003005'
//	
//		case	'5151'
//			// 도서관
//			S_SABUN	=	'0003006'
//	
//	end	choose
//end if
//
//i_return	= 2
//
///*************************************************
//* 현재 소속된 사람인가를 확인한다.               *
//**************************************************/
//IF isnull(s_name) then s_name = ''
//
//IF len(s_name) < 1 then
//	ii_count   ++
//	MessageBox('확인','사용자번호를 입력하여 주십시요.')
//else
//
//   /**********************************************
//    *    사용자 패스를 확인한다                   *
//    ***********************************************/
//
////    SELECT rtrim(empcod) ,empnam 
////	 INTO   :S_SABUN,:s_name
////	 FROM   EMPINF
////    WHERE  empnam    = :s_name     AND  
////  	        pwd       = :Pass_word ;
////           i_count   = ii_count
////
////   IF (SQLCA.SQLCODE = 100) THEN
////	   messagebox("접속 실패", "등록된 사용자가 아닙니다!")
////    	i_count ++
////   elseIF (SQLCA.SQLCODE < 0)  THEN
////	   i_count ++
////   ELSE
//      gstru_uid_uname.uid        = S_SABUN         //사용자명
//      gstru_uid_uname.uname      = s_name          //성명
//      gstru_uid_uname.admin_code = i_admin_code    //관리자 일반 관리자 구분 (1:관지자 입반 관리자 구분)
//		gstru_uid_uname.address    = f_address()
//		gstru_uid_uname.dept_code  = s_dept
//		gstru_uid_uname.dept_opt1  = i_opt1
//	   i_count = 100
////   END IF
//
//  i_count = 100
//   ii_count   = i_count	
//end IF
//CHOOSE CASE ii_count
//   	CASE 100		// 등록자가 있다.
//	   	i_return = 1
//   	CASE 3,4		// 3회이상 시도함.
//	   	i_return = 0
//   	CASE ELSE
//	   	i_return = 100
//END CHOOSE
//
//return i_return
RETURN 0
end function

on w_kch412b.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_2=create st_2
this.dw_1=create dw_1
this.st_1=create st_1
this.cb_1=create cb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_2
end on

on w_kch412b.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;datawindowchild	ldwc_temp

dw_1.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve(1, 3) = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF
dw_1.InsertRow(0)
dw_1.Object.code[1] = gstru_uid_uname.dept_code

dw_2.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve(gstru_uid_uname.uid) = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF
dw_2.InsertRow(0)
dw_2.Object.code[1] = gstru_uid_uname.dept_code

end event

type ln_templeft from w_msheet`ln_templeft within w_kch412b
end type

type ln_tempright from w_msheet`ln_tempright within w_kch412b
end type

type ln_temptop from w_msheet`ln_temptop within w_kch412b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_kch412b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_kch412b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_kch412b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_kch412b
end type

type uc_insert from w_msheet`uc_insert within w_kch412b
end type

type uc_delete from w_msheet`uc_delete within w_kch412b
end type

type uc_save from w_msheet`uc_save within w_kch412b
end type

type uc_excel from w_msheet`uc_excel within w_kch412b
end type

type uc_print from w_msheet`uc_print within w_kch412b
end type

type st_line1 from w_msheet`st_line1 within w_kch412b
end type

type st_line2 from w_msheet`st_line2 within w_kch412b
end type

type st_line3 from w_msheet`st_line3 within w_kch412b
end type

type uc_excelroad from w_msheet`uc_excelroad within w_kch412b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_kch412b
end type

type dw_2 from datawindow within w_kch412b
integer x = 1733
integer y = 904
integer width = 1125
integer height = 92
integer taborder = 90
string title = "none"
string dataobject = "ddw_login_gwa"
boolean border = false
boolean livescroll = true
end type

type st_2 from statictext within w_kch412b
integer x = 1358
integer y = 908
integer width = 370
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 25058105
long backcolor = 31112622
string text = "변경부서"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_kch412b
integer x = 1733
integer y = 704
integer width = 1125
integer height = 92
integer taborder = 10
boolean enabled = false
string dataobject = "ddw_sosok501_group_opt1"
boolean border = false
boolean livescroll = true
end type

type st_1 from statictext within w_kch412b
integer x = 1358
integer y = 712
integer width = 370
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 25058105
long backcolor = 31112622
string text = "현재부서"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_kch412b
integer x = 1961
integer y = 1172
integer width = 448
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확인"
boolean default = true
end type

event clicked;Window	aw_ActiveSheet
string	ls_cur_gwa, ls_new_gwa, ls_new_gwa_name

ls_cur_gwa = dw_1.getitemstring(1, 'code')
ls_new_gwa = dw_2.getitemstring(1, 'code')
ls_new_gwa_name = dw_2.Object.code_name[1]

gstru_uid_uname.dept_code = ls_new_gwa

gs_DeptCode  = ls_new_gwa
gs_DeptName = ls_new_gwa_name

Messagebox('확인', '로긴 부서정보가 변경되었습니다. 모든 창을 닫은 후 다시 작업하세요!')

//// 현재부서와 변경부서의 확인
//if ls_cur_gwa = ls_new_gwa then
//	close(parent)
//	return
//end if
//
//// 열린 모든 윈도우 Close
//aw_ActiveSheet = w_frame.GetFirstSheet()
//
//DO WHILE isValid(aw_ActiveSheet)
//	IF UPPER(aw_ActiveSheet.ClassName()) <> 'W_KCH000Q' THEN
//		close(aw_ActiveSheet)
//		aw_ActiveSheet = w_frame.GetFirstSheet()
//	ELSE
//		aw_ActiveSheet = w_frame.GetNextSheet(aw_ActiveSheet)
//	END IF
//LOOP

end event

type gb_2 from groupbox within w_kch412b
integer x = 1339
integer y = 620
integer width = 1577
integer height = 480
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31112622
end type

