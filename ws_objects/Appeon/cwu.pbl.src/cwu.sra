$PBExportHeader$cwu.sra
$PBExportComments$Generated Application Object
forward
global type cwu from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
Window  					gs_ActiveWindow    			// 액티브윈도우
DataWindow  				gdw_msg          				// 메세지데이터윈도우
w_mdi						gw_mdi							// MDI Window

String  						gs_PgmId                     		// 프로그램ID
String  						gs_PgmNo						// 프로그램 index

String							gs_password					// 비밀번호
String  						gs_empCode					// 사원코드
String  						gs_empName					// 사원명
String  						gs_DeptCode            			// 부서코드
String  						gs_DeptName           			// 부서명
String  						gs_ip                           		// 사용자 IP
String  						gs_print_log_yn				// 프린트Log 사용여부

n_login						gn_login							//로그인 하기위한 NVO
vector						gvc_val								//자유롭게 사용하기 위한 propertis

CONSTANT LONG 		SW_SHOWNORMAR 			= 1

CONSTANT STRING 	REGKEY 							= ''	//"HKEY_CURRENT_USER\SOFTWARE"
CONSTANT STRING 	REGNM 								= '' 	//"SESSION"
CONSTANT LONG		KOR									= 1    //gf_settoggle에서 한글키로 바꿀때 쓰인다.
CONSTANT LONG		ENG									= 0    //gf_settoggle에서 영문키로 바꿀때 쓰인다.

//청운대학교 사용
n_func func

String							gs_acct_name
Integer						gi_acct_class = 1					// 회계단위
Integer						gi_dept_opt						// 부서구분(단위, 주관, 예산)

// 청운기존시스템 사용 (사용처가많이 일괄로 빼지못함)
s_uid_uname gstru_uid_uname		// 현재사용자정보
end variables

global type cwu from application
string appname = "cwu"
end type
global cwu cwu

type prototypes

end prototypes

type variables
String  is_IdleFlag 
end variables

event idle;String	ls_parm, ls_nulstring, ls_url
String	ls_id, ls_pw, ls_conpw

IF Messagebox("프로그램 종료", "1시간동안 사용하지 않아 접속 종료 합니다.~r~n다시 로그인 하시기 바랍니다.", StopSign!, OK!) = 1 THEN
	SetNull(ls_nulstring)
	ls_url = ''  //해당 URL를 연다.
	
	//Run Explore
	//ShellExecute(0, ls_nulstring, ls_url, ls_nulstring, ls_nulstring, SW_SHOWNORMAR)
	
	//login page 이동.
	Halt //Close(w_pf_main)
END IF
end event

on cwu.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String		ls_temp
Integer	li_rtn

Vector	vc

//// Profile EAS Demo DB V105 Unicode
//SQLCA.DBMS = "ODBC"
//SQLCA.AutoCommit = False
//SQLCA.DBParm = "ConnectString='DSN=EAS Demo DB V105 Unicode;UID=dba;PWD=sql'"

// Profile cwuadmin
SQLCA.DBMS = "O84 Oracle8/8i (8.x.4+)"
SQLCA.LogPass = "roqkfwk"
SQLCA.ServerName = "cwuadmin"
SQLCA.LogId = "developer"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""
//SQLCA.DBParm = "DisableUnicode=1"

// Profile BoneSvr
//SQLCA.DBMS = "O84 Oracle8/8i (8.x.4+)"
//SQLCA.LogPass = "roqkfwk"
//SQLCA.ServerName = "bonesvr"
//SQLCA.LogId = "developer"
//SQLCA.AutoCommit = False
//SQLCA.DBParm = ""

CONNECT USING SQLCA;

IF sqlca.sqlcode <> 0 THEN
	vc = Create Vector
	
	vc.SetProperty("err_win",	'')
	vc.SetProperty("err_plce",	'Application sim의 Open Event의 DB Connect')
	vc.SetProperty("err_line",	'14')
	vc.SetProperty("err_win",	String(SQLCA.SQLDBCode))
	vc.SetProperty("err_win",	'DataBase Connect 시 ~r~n' + SQLCA.SQLErrText)

	OpenWithParm(w_system_error, vc)
	
	Destroy vc
	
	Halt close
END IF

/* 웹에서 어떤 값을 받아야 한다. */
//======= penta 송상철 수정 ==================
gvc_val = getconvertcommandparm(commandparm())

//Appeon5 - Appeon6일때는 주석 처리.
//===========================
//ls_temp = gvc_val.getProperty("webappname")
//ls_temp = Mid(ls_temp, 2)
//ls_temp = Left(ls_temp, Pos(ls_temp , '/') - 1)
//gvc_val.setproperty('webappname', ls_temp)
//===========================

//======= penta 송상철 수정 ===================

gn_login			= Create n_login

IF NOT isValid(func) THEN func = CREATE n_func

Vector 	lvc_data
String  	ls_rtn, ls_opentype
String		ls_parm, ls_nulstring, ls_url
pentaservice		service

ls_opentype = gvc_val.getproperty('opentype')
Choose Case ls_opentype
	Case '' 
		Open(w_login)	// Logging
	Case 'SSO'
		//login id와 비밀 번호를 아래를 수정하여 사용한다.
		//이때 파라메터 는 webappname/?id=admin&password=admin&opentype=SSO형태로 web application을 호출 해준다.
		IF sessioncheck("http://eagles10.chungwoon.ac.kr/cutis/getsession.jsp", "", 1, ls_rtn) THEN
			lvc_data = getconvertcommandparm(ls_rtn)
			IF Not gn_login.of_login(lvc_data.getProperty("id"), lvc_data.getProperty("passwd"), ls_opentype ) THEN
				SetNull(ls_nulstring)
				//나중에 linkpage주소 알려 주시면 그쪽으로 작성해 주세요.
				ls_url = 'http://www.penta.co.kr'
				service.of_ShellExecute(0, ls_nulstring, ls_url, ls_nulstring, ls_nulstring, SW_SHOWNORMAR)
				Halt close
			END IF
		ELSE
			Halt close
		END IF
	Case ELSE
		IF sessioncheck("http://eagles10.chungwoon.ac.kr/cutis/getsession.jsp", "", 1, ls_rtn) THEN
			lvc_data = getconvertcommandparm(ls_rtn)
			IF Not gn_login.of_login(lvc_data.getProperty("id"), lvc_data.getProperty("passwd"),  ls_opentype) THEN
				SetNull(ls_nulstring)
				//나중에 linkpage주소 알려 주시면 그쪽으로 작성해 주세요.
				ls_url = 'http://www.penta.co.kr'
				service.of_ShellExecute(0, ls_nulstring, ls_url, ls_nulstring, ls_nulstring, SW_SHOWNORMAR)
				Halt close
			ELSE
				Open(w_sub_mdi)
			END IF
		ELSE
			Halt close
		END IF
End Choose

end event

event close;Disconnect Using SQLCA;
//a
end event

on cwu.create
appname="cwu"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

