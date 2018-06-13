$PBExportHeader$n_login.sru
forward
global type n_login from nonvisualobject
end type
end forward

global type n_login from nonvisualobject
end type
global n_login n_login

type variables
String	is_ostype
String	is_id
String	is_pw
String 	is_ip
String	is_conpw
end variables

forward prototypes
private function integer of_login_check (string as_id, string as_pw)
public subroutine getloginparm (ref string as_id, ref string as_pw, ref string as_conpw)
public function boolean of_login (string as_id, string as_pw, string as_conpw)
end prototypes

private function integer of_login_check (string as_id, string as_pw);/*==========================================================

	Function Name : of_login_check
	Return Value	: Integer		-1/사원번호 오류, -3/비밀번호 오류, 0/성공
	Parameter		:
	Argument Name			Type				  Description
	----------------------------------------------------------------------------------
	val			as_id				String				login id
	val			as_p				String				login password
	
	Commant: 로그인 하기 위한 함수 
			수정을 하시려면 이부분을 수정해 주시기 바랍니다.
	
==========================================================*/

Long		ll_LoginCnt=0, ll_rtn, i
String		ls_Password, ls_FiredYn, ls_ToDay, ls_Time, ls_ip
String		ls_sql, ls_temp[], ls_arg, ls_gubun
s_row		lstr_data

//AS_ID = String(as_id, '@@@@@')

SELECT A.EMP_CODE
		  ,A.EMP_NAME
		  ,A.DEPT_CODE
		  ,C.DEPT_NAME
		  ,A.PASSWORD
 INTO  :gs_empCode
 		,:gs_empName
		,:gs_deptCode
		,:gs_deptName
		,:gs_password
FROM cddb.pf_employee    		A
		,cddb.pf_department			C
WHERE A.DEPT_CODE 	= C.DEPT_CODE
	AND A.EMP_CODE		= :as_id
Using sqlca;

/*
SELECT   upmu_gubun
			,member_no
			,member_name
			,gwa
			,gwa_name
			,sys.CryptIT.decrypt(PASSWORD,'cwu')
  INTO	 :ls_gubun
  			,:gs_empCode
			,:gs_empName
			,:gs_deptCode
			,:gs_deptName
			,:gs_password
  FROM v_login_info
WHERE member_no = :as_id
Using sqlca;
*/
IF sqlca.sqlcode <> 0 THEN 
	messagebox("Error", "사원번호 오류!")
	Return -1	// 사원번호 오류
END IF

IF as_pw <> gs_password THEN
	messagebox("Error", "비밀번호 오류!")
	Return -3	// 비밀번호 오류
END IF

IF ls_gubun = '1' AND is_conpw <> 'EXTERNAL' THEN
	messagebox("Error", "학생정보시스템으로 다시 접속해 주시기 바랍니다.")
	Return -4
END IF
//gs_empCode = String(gs_empCode, '@@@@@')
//gs_deptCode = String(gs_deptCode, '@@@@@@@@@')

gvc_val.setproperty('emp_code', gs_empCode)
gvc_val.setproperty('emp_name', gs_empName)
gvc_val.setproperty('dept_code', gs_deptCode)
gvc_val.setproperty('dept_name', gs_deptName)

Return 0

end function

public subroutine getloginparm (ref string as_id, ref string as_pw, ref string as_conpw);as_id 			= is_id
as_pw		= is_pw
as_conpw	= is_conpw
end subroutine

public function boolean of_login (string as_id, string as_pw, string as_conpw);Int	 li_rtn=0

Pointer	pnt
pnt = SetPointer(HourGlass!)

// 입력누락 Check
IF as_id = '' THEN
	Beep(1)
	SetPointer(pnt)
	Return False
END IF

IF as_pw = '' THEN
	Beep(1)
	SetPointer(pnt)
	Return False
END IF

is_id 			= as_id
is_pw 		= as_pw
is_conpw	= as_conpw

// 사원번호, 비밀번호 Check 및 LogIn Insert
IF of_login_check(as_id, as_pw) < 0 THEN
	Beep(1)
	SetPointer(pnt)
	Return False
END IF
Idle(3600)	// Application Idle Event Excute

//******************************************************************************************************//
SetPointer(pnt)
Choose Case as_conpw
	Case ""
		//파워빌더로 실행시는 오픈을 먼저한다.
		IF appeongetclienttype() = 'PB' THEN
			Open(w_pf_main)
			Close(w_login)
		ELSE
			Close(w_login)
			Open(w_pf_main)
		END IF
	Case 'SSO'
		Open(w_pf_main)
End Choose

return true
end function

on n_login.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_login.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

