$PBExportHeader$uo_comm_send.sru
$PBExportComments$SMS, MAIL 등
forward
global type uo_comm_send from nonvisualobject
end type
end forward

global type uo_comm_send from nonvisualobject
end type
global uo_comm_send uo_comm_send

type variables
long		TYPE_VALUE = 1
long		TYPE_FILE = 2
end variables

forward prototypes
public function integer of_send_sms (string as_code_gb, string as_code, string as_user_id, string as_dest_count, string as_dest_info, string as_msg)
public function integer of_send_mail (string as_user_id, string as_to_mail, string as_subject, string as_msg)
public function integer of_file_upload (string as_area_gb, string as_file_path[], string as_file_name[], string as_key_value1[], string as_key_value2[])
public function integer of_file_download (string as_area_gb, string as_key_value1, string as_key_value2)
end prototypes

public function integer of_send_sms (string as_code_gb, string as_code, string as_user_id, string as_dest_count, string as_dest_info, string as_msg);// sms 보내기
// 아큐먼트 설명
// as_code_gb      : 공통코드(코드구분)
// as_code           : 공통코드(코드) 
//         =>   ( as_code_gb, as_code ) : 보낼 sms 메시지를 공통코드에 설정했을경우에 사용한다.
// as_user_id       : 보내는 사람 User Id
// as_dest_count  : 받는 사람 전화번호 갯수
// as_dest_info    : 받는 사람 ( 예: 홍길동^0103334444|심심해^0193335555 )
// as_msg           : 보낼 sms 메시지
//
// uo_comm_send.of_send_sms( as_code_gb, as_code, as_user_id, as_dest_count, as_dest_info, as_msg )

String  ls_msg, ls_callback, ls_send_msg

parameters	param

param.serverurl = "http://sms.chungwoon.ac.kr/smssend.jsp"

// 보내는 사람 전화번호 가져오기.
SELECT ETC_CD1
   INTO :ls_callback
  FROM CDDB.KCH102D
 WHERE CODE_GB = 'COM01'
     AND CODE       = :as_user_id
 USING SQLCA ;
 
 //  보내는 사람 디폴트 : 교무처
 If ls_callback = '' Or Isnull(ls_callback) Then
	as_user_id = 'academic'
	ls_callback = '0416303112'
End If

If as_msg = '' Or Isnull(as_msg) Then
	// SMS 메시지 가져오기.
	SELECT REMARK
		INTO :ls_send_msg
	  FROM CDDB.KCH102D
	 WHERE CODE_GB = :as_code_gb
		  AND CODE      = :as_code
		  AND USE_YN   = 'Y'
	 USING SQLCA ;
	 
	If sqlca.sqlcode <> 0 Then
		Return -1
	End If
Else
	ls_send_msg = as_msg
End If
 
If as_dest_count = '' Or Isnull(as_dest_count) Then
	Messagebox('확인', '받는 전화의 갯수가 지정되지 않았습니다...확인하세요!')
	Return -1
End If

If as_dest_info = '' Or Isnull(as_dest_info) Then
	Messagebox('확인', '받는 휴대폰전화가 없습니다...확인하세요!')
	Return -1
End If

If ls_send_msg = '' Or Isnull(ls_send_msg) Then
	Messagebox('확인', '보내는 메시지 내용이 없습니다...확인하세요!!')
	Return -1
End If

param.parameter[1].param = "USER_ID"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = as_user_id

// 보내는이
param.parameter[2].param = "CALLBACK"
param.parameter[2].param_type = TYPE_VALUE
param.parameter[2].data = ls_callback

// 메세지 보낼 전화번호 갯수
param.parameter[3].param = "DEST_COUNT"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = as_dest_count

// 받는이
param.parameter[4].param = "DEST_INFO"
param.parameter[4].param_type = TYPE_VALUE
param.parameter[4].data = as_dest_info  // 박구석^01093713219|이주연^0173909690

// 메시지
param.parameter[5].param = "SMS_MSG"
param.parameter[5].param_type = TYPE_VALUE
param.parameter[5].data = ls_send_msg

postsendurl(param, ls_msg)

Return 1
end function

public function integer of_send_mail (string as_user_id, string as_to_mail, string as_subject, string as_msg);// MAIL 보내기
// 아큐먼트 설명:
// as_user_id   : 보내는 사람 메일계정
// as_to_mail  : 받는사람 메일 주소
// as_subject  : 메일주소
// as_msg      : 메일내용
//
// uo_comm_send.of_send_mail( as_user_id, as_to_mail, as_subject, as_msg )

String ls_mailer, ls_from_mail, ls_password 

parameters	param

param.serverurl = "http://localhost:8080/pentadispatcher/PentaSendMailServlet"

// 보내는 사람 
SELECT FNAME,    REMARK,         ETC_CD1
  INTO :ls_mailer, :ls_from_mail, :ls_password 
  FROM CDDB.KCH102D
 WHERE CODE_GB = 'COM03'
   AND CODE    = :as_user_id
 USING SQLCA ;

param.parameter[1].param = "SMTP"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = "mail.chungwoon.ac.kr"

//  공통코드(보내는사람 메일주소)
param.parameter[2].param = "FROM"
param.parameter[2].param_type = TYPE_VALUE
param.parameter[2].data = ls_from_mail

// 공통코드(보내는사람 이름)
param.parameter[3].param = "MAILER"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = ls_mailer

// 받는사람 메일주소
param.parameter[4].param = "TO"
param.parameter[4].param_type = TYPE_VALUE
param.parameter[4].data = as_to_mail

// 메일제목
param.parameter[5].param = "SUBJECT"
param.parameter[5].param_type = TYPE_VALUE
param.parameter[5].data = as_subject

// 메일내용
param.parameter[6].param = "MESSAGE"
param.parameter[6].param_type = TYPE_VALUE

// 메일내용을 db에 html형식으로 넣어놓고 내용을 변경한다.(추후 로직변경)
String ls_msg
ls_msg = Trim(as_msg)
replaceall(ls_msg, '{title}', "홍길동 고객님에 대한 메일입니다.")
replaceall(ls_msg, '{message}', "내일 출발합니다.")
param.parameter[6].data = ls_msg

// 보내는사람메일주소(공통코드)
param.parameter[7].param = "USER"
param.parameter[7].param_type = TYPE_VALUE
param.parameter[7].data = ls_from_mail

// 보내는사람메일비번(공통코드)
param.parameter[8].param = "PASSWORD"
param.parameter[8].param_type = TYPE_VALUE
param.parameter[8].data = ls_password

param.parameter[9].param = "AUTH"
param.parameter[9].param_type = TYPE_VALUE
param.parameter[9].data = "true"

param.parameter[10].param = "SSL"
param.parameter[10].param_type = TYPE_VALUE
param.parameter[10].data = "false"

param.parameter[11].param = "VERBOSE"
param.parameter[11].param_type = TYPE_VALUE
param.parameter[11].data = "false"


postsendurl(param, ls_msg)

Return 1


end function

public function integer of_file_upload (string as_area_gb, string as_file_path[], string as_file_name[], string as_key_value1[], string as_key_value2[]);// 파일 업로드.
// 아큐먼트 설명:
// as_area_gb          : 업무구분(파일서버 하위폴더로 사용)
// as_file_path[]       : 파일경로
// as_file_name[]     : 파일이름
// as_key_value1[]   : 업로드한 파일데이타와  연결할 키값1
// as_key_value2[]   : 업로드한 파일데이타와  연결할 키값2
//
// 사용예)
//uo_comm_send  u_comm_send
//
//u_comm_send = Create u_comm_send
//as_area_gb         = 'haksa'
//as_file_path[1]    = '파일경로'
//as_file_name[1]   = '파일명'
//as_key_value1[1] = '키값1'
//as_key_value2[1] = ''
//
//u_comm_send.of_file_upload( as_area_gb, as_file_path[], as_file_name[], as_key_value1[], as_key_value2[] )

String  ls_file_dt, ls_seq, ls_new_file_name[], ls_errtext
Long    ll_cnt,      i,         j,      ll_seq
parameters	param

param.serverurl = "http://fs.chungwoon.ac.kr:8080/pentadispatcher/PentaUploadServlet"

param.parameter[1].param = "UPLOAD_FILE_PATH"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = as_area_gb  //서버 파일 폴더.

param.parameter[2].param = "useftp"
param.parameter[2].param_type = TYPE_VALUE
param.parameter[2].data = "false"

param.parameter[3].param = "SERVER"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = "ftp://210.108.181.107:2100" 

param.parameter[4].param = "USER"
param.parameter[4].param_type = TYPE_VALUE
param.parameter[4].data = "admin"

param.parameter[5].param = "PASSWORD"
param.parameter[5].param_type = TYPE_VALUE
param.parameter[5].data = "admin"

param.parameter[6].param = "PASSIVE"
param.parameter[6].param_type = TYPE_VALUE
param.parameter[6].data = "true"

ll_cnt      = UpperBound(as_file_name[])
ls_file_dt = func.of_get_sdate('YYYYMMDD')

For i = 1 To ll_cnt
	
	SELECT NVL(MAX(FILE_SEQ), 0) + 1
	   INTO :ll_seq
	   FROM CDDB.CWU_FILE
	 WHERE AREA_GB = :as_area_gb
	     AND FILE_DT   = :ls_file_dt
	 USING SQLCA ;
	
	 ls_seq = string(ll_seq, '00000')
	 
	 ls_new_file_name[i] = ls_file_dt + ls_seq + Trim(as_file_name[i])
	 
	INSERT INTO CDDB.CWU_FILE
	              ( AREA_GB,              FILE_DT,               FILE_SEQ,        FILE_NAME,                    FILE_NEW_NAME,
		            KEY_VALUE1,         KEY_VALUE2,         WORKER,         WORK_DATE,                 IPADDR )
	  VALUES ( :as_area_gb,         :ls_file_dt,             :ll_seq,            Trim(:as_file_name[i]),   :ls_new_file_name[i],
	                :as_key_value1[i],  :as_key_value2[i],  :gs_empcode,  sysdate,                          :gs_ip ) USING SQLCA ;
						 
	If sqlca.sqlcode <> 0 Then
		ls_errtext = sqlca.sqlerrtext
		Rollback using sqlca ;
		Messagebox("오류", "파일관리에 데이타저장시 오류!" +&
		                               "~n" + ls_errtext)
		Return -1
	End If
	
	j = i + 6
	param.parameter[j].param = "uploadfile" + string(i)
	param.parameter[j].param_type = TYPE_FILE
	param.parameter[j].data            = Trim(as_file_path[i])   //파일경로
	param.parameter[j].rename       =  ls_new_file_name[i]   //변경될 파일 이름	
Next

fileuploadexprogress(param)

Return 1

end function

public function integer of_file_download (string as_area_gb, string as_key_value1, string as_key_value2);// 파일 다운로드.
// 아큐먼트 설명:
// as_area_gb       : 업무구분(파일서버 하위폴더명)
// as_key_value1   : 업로드한 파일데이타와  연결할 키값1
// as_key_value2   : 업로드한 파일데이타와  연결할 키값2
//
// 사용예)
//uo_comm_send  u_comm_send
//
//u_comm_send = Create u_comm_send
//as_area_gb     = 'haksa'
//as_key_value1 = '키값1'
//as_key_value2 = ''
//
//u_comm_send.of_file_download( as_area_gb, as_key_value1, as_key_value2 )

String  ls_file_name, ls_file_new_name

parameters	param

param.serverurl = "http://fs.chungwoon.ac.kr:8080/pentadispatcher/PentaDownloadServlet"

GetFolder( "DownLoad File Save Directory", param.defaultpath )

SELECT FILE_NAME,    FILE_NEW_NAME
   INTO :ls_file_name, :ls_file_new_name
  FROM CDDB.CWU_FILE
 WHERE AREA_GB         = :as_area_gb
	  AND KEY_VALUE1   = :as_key_value1
	  AND KEY_VALUE2   LIKE :as_key_value2 || '%'
 USING SQLCA ;
 
 If sqlca.sqlcode <> 0 Then
	Messagebox("오류", "파일관리내역에 존재하지 않는 파일입니다!")
	Return -1
End If

param.filename = ls_file_new_name

param.parameter[1].param = "DOWNLOAD_FILE_PATH"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = as_area_gb

param.parameter[2].param = "downloadfile"
param.parameter[2].param_type = TYPE_VALUE
param.parameter[2].data = ls_file_new_name

param.parameter[3].param = "useftp"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = "false"

DownloadServletProgress(param)

Return 1

end function

on uo_comm_send.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_comm_send.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

