$PBExportHeader$pentaframe.sra
$PBExportComments$PentaSystemTestApplication
forward
global type pentaframe from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
Window  					gs_ActiveWindow    				// 액티브윈도우
DataWindow  			gdw_msg          					// 메세지데이터윈도우
w_mdi						gw_mdi									// MDI Window

String  						gs_PgmId                     		// 프로그램ID
String  						gs_PgmNo								// 프로그램 index

String						gs_password							// 비밀번호
String  						gs_empCode							// 사원코드
String  						gs_empName							// 사원명
String  						gs_DeptCode            			// 부서코드
String  						gs_DeptName           			// 부서명
String  						gs_ip                           		// 사용자 IP
String  						gs_print_log_yn						// 프린트Log 사용여부

n_login						gn_login							//로그인 하기위한 NVO
vector						gvc_val								//자유롭게 사용하기 위한 propertis

CONSTANT LONG 		SW_SHOWNORMAR 			= 1

CONSTANT STRING 	REGKEY 							= ''	//"HKEY_CURRENT_USER\SOFTWARE"
CONSTANT STRING 	REGNM 								= '' 	//"SESSION"
CONSTANT LONG		KOR									= 1    //gf_settoggle에서 한글키로 바꿀때 쓰인다.
CONSTANT LONG		ENG									= 0    //gf_settoggle에서 영문키로 바꿀때 쓰인다.
end variables

global type pentaframe from application
string appname = "pentaframe"
end type
global pentaframe pentaframe

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

on pentaframe.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String		ls_temp
Integer	li_rtn

//// Profile EAS Demo DB V105 Unicode
//SQLCA.DBMS = "ODBC"
//SQLCA.AutoCommit = False
//SQLCA.DBParm = "ConnectString='DSN=EAS Demo DB V105 Unicode;UID=dba;PWD=sql'"

//// Profile cwuadmin
//SQLCA.DBMS = "O84 Oracle8/8i (8.x.4+)"
//SQLCA.LogPass = "roqkfwk"
//SQLCA.ServerName = "cwuadmin"
//SQLCA.LogId = "developer"
//SQLCA.AutoCommit = False
//SQLCA.DBParm = ""

// Profile BoneSvr
SQLCA.DBMS = "O84 Oracle8/8i (8.x.4+)"
SQLCA.LogPass = "roqkfwk"
SQLCA.ServerName = "bonesvr"
SQLCA.LogId = "developer"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

CONNECT USING SQLCA;

IF sqlca.sqlcode <> 0 THEN
	Messagebox("Error", "Connect Database Failed : " + sqlca.sqlerrtext)
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

IF gvc_val.getproperty('opentype') = '' THEN
	Open(w_login)	// Logging
ELSEIF gvc_val.getproperty('opentype') = 'SSO' THEN
	//login id와 비밀 번호를 아래를 수정하여 사용한다.
	//이때 파라메터 는 webappname/?id=admin&password=admin&opentype=SSO형태로 web application을 호출 해준다.
ELSE
	Open(w_sub_mdi)
END IF



end event

event close;Disconnect Using SQLCA;
end event

on pentaframe.create
appname="pentaframe"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

