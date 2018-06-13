$PBExportHeader$w_httpfile_example.srw
forward
global type w_httpfile_example from window
end type
type cb_12 from commandbutton within w_httpfile_example
end type
type cb_11 from commandbutton within w_httpfile_example
end type
type cb_10 from commandbutton within w_httpfile_example
end type
type cb_9 from commandbutton within w_httpfile_example
end type
type cb_8 from commandbutton within w_httpfile_example
end type
type cb_7 from commandbutton within w_httpfile_example
end type
type cb_5 from commandbutton within w_httpfile_example
end type
type cb_3 from commandbutton within w_httpfile_example
end type
type cb_2 from commandbutton within w_httpfile_example
end type
type sle_password from singlelineedit within w_httpfile_example
end type
type sle_file2 from singlelineedit within w_httpfile_example
end type
type cb_6 from commandbutton within w_httpfile_example
end type
type sle_f from singlelineedit within w_httpfile_example
end type
type sle_mail from singlelineedit within w_httpfile_example
end type
type st_13 from statictext within w_httpfile_example
end type
type cb_sendmain from commandbutton within w_httpfile_example
end type
type mle_message from multilineedit within w_httpfile_example
end type
type st_12 from statictext within w_httpfile_example
end type
type st_11 from statictext within w_httpfile_example
end type
type st_10 from statictext within w_httpfile_example
end type
type st_9 from statictext within w_httpfile_example
end type
type st_8 from statictext within w_httpfile_example
end type
type st_7 from statictext within w_httpfile_example
end type
type sle_subject from singlelineedit within w_httpfile_example
end type
type sle_to from singlelineedit within w_httpfile_example
end type
type sle_mailer from singlelineedit within w_httpfile_example
end type
type sle_from from singlelineedit within w_httpfile_example
end type
type sle_smtp from singlelineedit within w_httpfile_example
end type
type sle_dwservelturl from singlelineedit within w_httpfile_example
end type
type st_6 from statictext within w_httpfile_example
end type
type sle_upservleturl from singlelineedit within w_httpfile_example
end type
type st_5 from statictext within w_httpfile_example
end type
type st_4 from statictext within w_httpfile_example
end type
type sle_file from singlelineedit within w_httpfile_example
end type
type cb_4 from commandbutton within w_httpfile_example
end type
type st_3 from statictext within w_httpfile_example
end type
type sle_3 from singlelineedit within w_httpfile_example
end type
type st_2 from statictext within w_httpfile_example
end type
type sle_2 from singlelineedit within w_httpfile_example
end type
type cb_servletdownload from commandbutton within w_httpfile_example
end type
type st_1 from statictext within w_httpfile_example
end type
type sle_directurl from singlelineedit within w_httpfile_example
end type
type cb_fileupload from commandbutton within w_httpfile_example
end type
type cb_1 from commandbutton within w_httpfile_example
end type
type gb_1 from groupbox within w_httpfile_example
end type
type gb_2 from groupbox within w_httpfile_example
end type
type gb_3 from groupbox within w_httpfile_example
end type
type gb_4 from groupbox within w_httpfile_example
end type
type gb_5 from groupbox within w_httpfile_example
end type
type ln_1 from line within w_httpfile_example
end type
end forward

global type w_httpfile_example from window
integer width = 2766
integer height = 2864
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_12 cb_12
cb_11 cb_11
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_5 cb_5
cb_3 cb_3
cb_2 cb_2
sle_password sle_password
sle_file2 sle_file2
cb_6 cb_6
sle_f sle_f
sle_mail sle_mail
st_13 st_13
cb_sendmain cb_sendmain
mle_message mle_message
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
sle_subject sle_subject
sle_to sle_to
sle_mailer sle_mailer
sle_from sle_from
sle_smtp sle_smtp
sle_dwservelturl sle_dwservelturl
st_6 st_6
sle_upservleturl sle_upservleturl
st_5 st_5
st_4 st_4
sle_file sle_file
cb_4 cb_4
st_3 st_3
sle_3 sle_3
st_2 st_2
sle_2 sle_2
cb_servletdownload cb_servletdownload
st_1 st_1
sle_directurl sle_directurl
cb_fileupload cb_fileupload
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
ln_1 ln_1
end type
global w_httpfile_example w_httpfile_example

type prototypes

end prototypes

type variables
long		TYPE_VALUE = 1
long		TYPE_FILE = 2
end variables

on w_httpfile_example.create
this.cb_12=create cb_12
this.cb_11=create cb_11
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_5=create cb_5
this.cb_3=create cb_3
this.cb_2=create cb_2
this.sle_password=create sle_password
this.sle_file2=create sle_file2
this.cb_6=create cb_6
this.sle_f=create sle_f
this.sle_mail=create sle_mail
this.st_13=create st_13
this.cb_sendmain=create cb_sendmain
this.mle_message=create mle_message
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.sle_subject=create sle_subject
this.sle_to=create sle_to
this.sle_mailer=create sle_mailer
this.sle_from=create sle_from
this.sle_smtp=create sle_smtp
this.sle_dwservelturl=create sle_dwservelturl
this.st_6=create st_6
this.sle_upservleturl=create sle_upservleturl
this.st_5=create st_5
this.st_4=create st_4
this.sle_file=create sle_file
this.cb_4=create cb_4
this.st_3=create st_3
this.sle_3=create sle_3
this.st_2=create st_2
this.sle_2=create sle_2
this.cb_servletdownload=create cb_servletdownload
this.st_1=create st_1
this.sle_directurl=create sle_directurl
this.cb_fileupload=create cb_fileupload
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.ln_1=create ln_1
this.Control[]={this.cb_12,&
this.cb_11,&
this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_5,&
this.cb_3,&
this.cb_2,&
this.sle_password,&
this.sle_file2,&
this.cb_6,&
this.sle_f,&
this.sle_mail,&
this.st_13,&
this.cb_sendmain,&
this.mle_message,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.sle_subject,&
this.sle_to,&
this.sle_mailer,&
this.sle_from,&
this.sle_smtp,&
this.sle_dwservelturl,&
this.st_6,&
this.sle_upservleturl,&
this.st_5,&
this.st_4,&
this.sle_file,&
this.cb_4,&
this.st_3,&
this.sle_3,&
this.st_2,&
this.sle_2,&
this.cb_servletdownload,&
this.st_1,&
this.sle_directurl,&
this.cb_fileupload,&
this.cb_1,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.gb_5,&
this.ln_1}
end on

on w_httpfile_example.destroy
destroy(this.cb_12)
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_5)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.sle_password)
destroy(this.sle_file2)
destroy(this.cb_6)
destroy(this.sle_f)
destroy(this.sle_mail)
destroy(this.st_13)
destroy(this.cb_sendmain)
destroy(this.mle_message)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.sle_subject)
destroy(this.sle_to)
destroy(this.sle_mailer)
destroy(this.sle_from)
destroy(this.sle_smtp)
destroy(this.sle_dwservelturl)
destroy(this.st_6)
destroy(this.sle_upservleturl)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_file)
destroy(this.cb_4)
destroy(this.st_3)
destroy(this.sle_3)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.cb_servletdownload)
destroy(this.st_1)
destroy(this.sle_directurl)
destroy(this.cb_fileupload)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.ln_1)
end on

type cb_12 from commandbutton within w_httpfile_example
integer x = 2226
integer y = 2152
integer width = 457
integer height = 128
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "mail"
end type

event clicked;String 	ls_req_status
String	ls_xml_request
String	ls_xml_response
Integer	li_rtn
Boolean	lb_rtn

//internetexception		inetException

OleObject req
req = CREATE oleobject
li_rtn = req.ConnectToNewObject("Msxml2.XMLHTTP.3.0")
IF li_rtn < 0 THEN
	messagebox("", "XMLHttpRequest Connect OLE Object : " )
	lb_rtn = False
ELSE
	//login =======================
	req.open ("POST", "http://sms.chungwoon.ac.kr/login", false)
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	req.send ("userId=admin&userPwd=rp4400&x=15&y=22")
	
	ls_req_status = Trim(req.StatusText)
	
	IF req.Status <> 200 THEN
		Messagebox("", "HTTP request failed : " + String(req.Status) + " : " + ls_req_status )
		lb_rtn = False
	ELSE
		//Messagebox("", String(req.responseText) )
		//replaceall(as_returnmsg, " ~r~n", "")
		//replaceall(as_returnmsg, "~r~n", "")
		lb_rtn = True
	END IF

	
	//sms
	req.open ("POST", "http://sms.chungwoon.ac.kr/smssend", false)
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	req.send ("smsText=01063637230%3A0173909690%3A&smsTextName=%BC%F6%BD%C5%C0%DA%3A%BC%F6%BD%C5%C0%DA%3A&smsSaveText=01063637230%3A0173909690%3A&userHakNum=F0072&userHakPasswd=c1031sh&smsMsg=tttt&smsPublic=1&smsOther1=&smsOther3=&smsPhone=0416303129&smsAddText=")
	
	ls_req_status = Trim(req.StatusText)
	
	IF req.Status <> 200 THEN
		Messagebox("", "HTTP request failed : " + String(req.Status) + " : " + ls_req_status )
		lb_rtn = False
	ELSE
		//Messagebox("", String(req.responseText) )
		//replaceall(as_returnmsg, " ~r~n", "")
		//replaceall(as_returnmsg, "~r~n", "")
		lb_rtn = True
	END IF

END IF



req.DisconnectObject()

end event

type cb_11 from commandbutton within w_httpfile_example
integer x = 2226
integer y = 1972
integer width = 457
integer height = 128
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Login"
end type

event clicked;String 		ls_msg 
//
//
//parameters	param
//
//param.serverurl = "http://sms.chungwoon.ac.kr/login"
//
//param.parameter[1].param = "userId"
//param.parameter[1].param_type = TYPE_VALUE
//param.parameter[1].data = "admin"
//
//param.parameter[2].param = "userPwd"
//param.parameter[2].param_type = TYPE_VALUE
//param.parameter[2].data = "rp4400"
//
//param.parameter[3].param = "x"
//param.parameter[3].param_type = TYPE_VALUE
//param.parameter[3].data = "15"
//
//param.parameter[4].param = "y"
//param.parameter[4].param_type = TYPE_VALUE
//param.parameter[4].data = "22"
//
//postsendurl(param, ls_msg)
//messagebox("Info", ls_msg)
//
//
//

sessioncheck("http://sms.chungwoon.ac.kr/login", "userId=admin&userPwd=rp4400&x=15&y=22", 1, ls_msg)

end event

type cb_10 from commandbutton within w_httpfile_example
integer x = 2226
integer y = 1820
integer width = 457
integer height = 128
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SMS"
end type

event clicked;String 		ls_msg 


parameters	param

param.serverurl = "http://sms.chungwoon.ac.kr/smssend"

param.parameter[1].param = "smsText"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = "01063637230%3A0173909690%3A"

param.parameter[2].param = "smsTextName"
param.parameter[2].param_type = TYPE_VALUE
param.parameter[2].data = "%BC%F6%BD%C5%C0%DA%3A%BC%F6%BD%C5%C0%DA%3A"

param.parameter[3].param = "smsSaveText"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = "01063637230%3A0173909690%3A"

param.parameter[4].param = "userHakNum"
param.parameter[4].param_type = TYPE_VALUE
param.parameter[4].data = "F0072"


param.parameter[5].param = "userHakPasswd"
param.parameter[5].param_type = TYPE_VALUE
param.parameter[5].data = "c1031sh"

param.parameter[6].param = "smsMsg"
param.parameter[6].param_type = TYPE_VALUE
param.parameter[6].data = "tttt"

param.parameter[7].param = "smsPublic"
param.parameter[7].param_type = TYPE_VALUE
param.parameter[7].data = "1"

param.parameter[8].param = "smsOther1"
param.parameter[8].param_type = TYPE_VALUE
param.parameter[8].data = ""

param.parameter[9].param = "smsOther3"
param.parameter[9].param_type = TYPE_VALUE
param.parameter[9].data = ""

param.parameter[10].param = "smsPhone"
param.parameter[10].param_type = TYPE_VALUE
param.parameter[10].data = "0416303129"

param.parameter[11].param = "smsAddText"
param.parameter[11].param_type = TYPE_VALUE
param.parameter[11].data = ""


//postsendurl(param, ls_msg)
//messagebox("Info", ls_msg)
//
//
Long i, ll_cnt
ll_cnt = UpperBound(param.parameter)
String ls_parm

FOR i = 1 TO ll_cnt
	ls_parm += param.parameter[i].param + "=" + param.parameter[i].data
	IF i < ll_cnt THEN
		ls_parm += "&"
	END IF
NEXT
sessioncheck("http://sms.chungwoon.ac.kr/smssend", ls_parm, 1, ls_msg)
end event

type cb_9 from commandbutton within w_httpfile_example
integer x = 1042
integer width = 402
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "none"
end type

event clicked;Boolean		lboolean
Long			llong
Integer		liteger
Date			ldate
DateTime	ldatetime
Decimal		ldecimal
Double		ldouble
real			lreal
String		lstring
Time			ltime
UnsignedInteger	luinteger
UnsignedLong		lulong
Character	lchar

lboolean 	= true
llong		 	= -2147483647
liteger		= 32767
ldate			= today()
ldatetime	= DateTime(today(), Now())
ldecimal		= 12345678901234.5678901234
ldouble		= -123456789012345
lreal			= 1234567890
lstring		= "만세"
ltime			= Now()
luinteger	= 65535
lulong		= 4294967295
lchar			= 'C'

Vector	lvc_data
lvc_data = Create Vector
lvc_data.setProperty('key1', lboolean)
lvc_data.setProperty('key2', llong)
lvc_data.setProperty('key3', liteger)
lvc_data.setProperty('key4', ldate)
lvc_data.setProperty('key5', ldatetime)
lvc_data.setProperty('key6', ldecimal)
lvc_data.setProperty('key7', ldouble)
lvc_data.setProperty('key8', lreal)
lvc_data.setProperty('key9', lstring)
lvc_data.setProperty('key10', ltime)
lvc_data.setProperty('key11', luinteger)
lvc_data.setProperty('key12', lulong )
lvc_data.setProperty('key13', lchar)

String 	ls_data[]
ls_data = {'강원도', '강나루', '강하루'}
lvc_data.setProperty('array', ls_data)

Integer	li_cnt, i
li_cnt = lvc_data.getfindkeycount('key')
FOR i = 1 TO li_cnt
	Messagebox('key'+ String(i), String(lvc_data.getProperty('key'+ String(i))))
NEXT

ls_data = lvc_data.getProperty('array')
FOR i = 1 TO UpperBound(ls_data)
	MessageBox("keyarray" , ls_data[i])
NEXT


end event

type cb_8 from commandbutton within w_httpfile_example
integer x = 1943
integer y = 260
integer width = 741
integer height = 84
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "FileUpLoadEx"
end type

event clicked;parameters	param

param.serverurl = Trim(sle_upservleturl.text)

param.parameter[1].param = "UPLOAD_FILE_PATH"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = "200803"  //서버 파일 폴더.

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

param.parameter[7].param = "uploadfile1"
param.parameter[7].param_type = TYPE_FILE
param.parameter[7].data = Trim(sle_3.text)  //파일경로
param.parameter[7].rename = trim(sle_file.text) //변경될 파일 이름

param.parameter[8].param = "uploadfile2"
param.parameter[8].param_type = TYPE_FILE
param.parameter[8].data = Trim(sle_f.text)  //파일경로
param.parameter[8].rename = trim(sle_file2.text) //변경될 파일 이름

fileuploadex(param)

end event

type cb_7 from commandbutton within w_httpfile_example
integer x = 1943
integer y = 352
integer width = 741
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "FileUpLoadProgress"
end type

event clicked;parameters	param

param.serverurl = Trim(sle_upservleturl.text)

param.parameter[1].param = "UPLOAD_FILE_PATH"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = "chungwoon/sales"  //서버 파일 폴더.

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

param.parameter[7].param = "uploadfile1"
param.parameter[7].param_type = TYPE_FILE
param.parameter[7].data = Trim(sle_3.text)  //파일경로
param.parameter[7].rename = trim(sle_file.text) //변경될 파일 이름

param.parameter[8].param = "uploadfile2"
param.parameter[8].param_type = TYPE_FILE
param.parameter[8].data = Trim(sle_f.text)  //파일경로
param.parameter[8].rename = trim(sle_file2.text) //변경될 파일 이름

fileuploadexprogress(param)

end event

type cb_5 from commandbutton within w_httpfile_example
integer x = 1943
integer y = 164
integer width = 741
integer height = 84
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "FileUpLoadDLL"
end type

event clicked;parameters	param

param.serverurl = Trim(sle_upservleturl.text)

param.parameter[1].param = "UPLOAD_FILE_PATH"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = "200803"  //서버 파일 폴더.

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

param.parameter[7].param = "uploadfile1"
param.parameter[7].param_type = TYPE_FILE
param.parameter[7].data = Trim(sle_3.text)  //파일경로
param.parameter[7].rename = trim(sle_file.text) //변경될 파일 이름

param.parameter[8].param = "uploadfile2"
param.parameter[8].param_type = TYPE_FILE
param.parameter[8].data = Trim(sle_f.text)  //파일경로
param.parameter[8].rename = trim(sle_file2.text) //변경될 파일 이름

fileuploaddll(param)

end event

type cb_3 from commandbutton within w_httpfile_example
integer x = 2043
integer y = 636
integer width = 402
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "none"
end type

event clicked;String ls_file , ls_path, ls_filepath


GetFileSaveName("test", ls_filepath, ls_file, "All", "*.*")

//ls_path =  Left( ls_path, Pos(ls_path, ls_file) - 1 )
//ls_path =  Left( ls_path, LastPos(ls_path, "\") - 1 )


ls_path = Left(ls_filepath, LastPos(ls_filepath, "\") - 1)
ls_file 	= Mid(ls_filepath, LastPos(ls_filepath, "\") + Len("\"))

messagebox("", ls_path)
messagebox("", ls_file)

end event

type cb_2 from commandbutton within w_httpfile_example
integer x = 2011
integer y = 472
integer width = 402
integer height = 84
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Fax"
end type

event clicked;parameters	param

param.serverurl = "http://124.137.16.101/fax_send_ftp.asp"
param.parameter[1].param = "c_send_user_id"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = "demo1"

param.parameter[2].param = "c_send_user_name"
param.parameter[2].param_type = TYPE_VALUE
param.parameter[2].data = "데모사용자1"

param.parameter[3].param = "c_cover_yn"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = "N"

param.parameter[4].param = "c_cover_idx"
param.parameter[4].param_type = TYPE_VALUE
param.parameter[4].data = "14"

param.parameter[5].param = "c_sendgb"
param.parameter[5].param_type = TYPE_VALUE
param.parameter[5].data = "Q"

param.parameter[6].param = "c_select"
param.parameter[6].param_type = TYPE_VALUE
param.parameter[6].data = ""

param.parameter[7].param = "c_addr_idx"
param.parameter[7].param_type = TYPE_VALUE
param.parameter[7].data = ""

param.parameter[8].param = "c_recv_user_name"
param.parameter[8].param_type = TYPE_VALUE
param.parameter[8].data = ""

param.parameter[9].param = "c_recv_user_fax"
param.parameter[9].param_type = TYPE_VALUE
param.parameter[9].data = ""

param.parameter[10].param = "c_select"
param.parameter[10].param_type = TYPE_VALUE
param.parameter[10].data = "개인"

param.parameter[11].param = "c_addr_idx"
param.parameter[11].param_type = TYPE_VALUE
param.parameter[11].data = ""

param.parameter[12].param = "c_recv_user_name"
param.parameter[12].param_type = TYPE_VALUE
param.parameter[12].data = "지미션"

param.parameter[13].param = "c_recv_user_fax"
param.parameter[13].param_type = TYPE_VALUE
param.parameter[13].data = "123-4567"

param.parameter[14].param = "filename1"
param.parameter[14].param_type = TYPE_VALUE
param.parameter[14].data = "교육비납증명서.xls"

param.parameter[15].param = "filename2"
param.parameter[15].param_type = TYPE_VALUE
param.parameter[15].data = "기부금 명세서.xls"

param.parameter[16].param = "filename3"
param.parameter[16].param_type = TYPE_VALUE
param.parameter[16].data = "기부금영수증.xls"

String  ls_rtn
postsendurl(param, ls_rtn)
messagebox("", ls_rtn)
//fileupload(param)

end event

type sle_password from singlelineedit within w_httpfile_example
integer x = 1307
integer y = 1924
integer width = 878
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_file2 from singlelineedit within w_httpfile_example
integer x = 55
integer y = 956
integer width = 1431
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_6 from commandbutton within w_httpfile_example
integer x = 1495
integer y = 412
integer width = 343
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "File"
end type

event clicked;String ls_path, ls_filename, ls_default

ls_default = GetCurrentDirectory()

if GetFileOpenName ("Open", ls_path, ls_filename, "All Files", "All Files (*.*),*.*", ls_default, 18) < 1 then return

ChangeDirectory(ls_default)

sle_f.text 			= ls_path
sle_file2.text 	= ls_filename
end event

type sle_f from singlelineedit within w_httpfile_example
integer x = 55
integer y = 412
integer width = 1431
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_mail from singlelineedit within w_httpfile_example
integer x = 55
integer y = 1732
integer width = 1888
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "http://madam/pentadispatcher/PentaSendMailServlet"
borderstyle borderstyle = stylelowered!
end type

type st_13 from statictext within w_httpfile_example
integer x = 55
integer y = 1664
integer width = 498
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Send Mail"
boolean focusrectangle = false
end type

type cb_sendmain from commandbutton within w_httpfile_example
integer x = 2226
integer y = 1668
integer width = 457
integer height = 128
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Send Mail"
end type

event clicked;parameters	param

param.serverurl = Trim(sle_mail.text)

param.parameter[1].param = "SMTP"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = Trim(sle_smtp.text)

param.parameter[2].param = "FROM"
param.parameter[2].param_type = TYPE_VALUE
param.parameter[2].data = Trim(sle_from.text)

param.parameter[3].param = "MAILER"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = Trim(sle_mailer.text)

param.parameter[4].param = "TO"
param.parameter[4].param_type = TYPE_VALUE
param.parameter[4].data = Trim(sle_to.text)

param.parameter[5].param = "SUBJECT"
param.parameter[5].param_type = TYPE_VALUE
param.parameter[5].data = Trim(sle_subject.text)

param.parameter[6].param = "MESSAGE"
param.parameter[6].param_type = TYPE_VALUE
String ls_msg
ls_msg = Trim(mle_message.text)
replaceall(ls_msg, '{title}', "홍길동 고객님에 대한 메일입니다.")
replaceall(ls_msg, '{message}', "내일 출발합니다.")
param.parameter[6].data = ls_msg

param.parameter[7].param = "USER"
param.parameter[7].param_type = TYPE_VALUE
param.parameter[7].data = Trim(sle_from.text)

param.parameter[8].param = "PASSWORD"
param.parameter[8].param_type = TYPE_VALUE
param.parameter[8].data = Trim(sle_password.text)

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
messagebox("Info", ls_msg)


end event

type mle_message from multilineedit within w_httpfile_example
integer x = 439
integer y = 2308
integer width = 1746
integer height = 428
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "MailTest"
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type st_12 from statictext within w_httpfile_example
integer x = 55
integer y = 2132
integer width = 343
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TO"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_11 from statictext within w_httpfile_example
integer x = 55
integer y = 2324
integer width = 343
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "MESSAGE"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_10 from statictext within w_httpfile_example
integer x = 55
integer y = 2228
integer width = 343
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SUBJECT"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_9 from statictext within w_httpfile_example
integer x = 55
integer y = 2036
integer width = 343
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "MAILER"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_8 from statictext within w_httpfile_example
integer x = 55
integer y = 1844
integer width = 343
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SMTP Server"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_httpfile_example
integer x = 55
integer y = 1940
integer width = 343
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "FROM"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_subject from singlelineedit within w_httpfile_example
integer x = 439
integer y = 2212
integer width = 1746
integer height = 84
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Test"
borderstyle borderstyle = stylelowered!
end type

type sle_to from singlelineedit within w_httpfile_example
integer x = 439
integer y = 2116
integer width = 1746
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "test@nate.com"
borderstyle borderstyle = stylelowered!
end type

type sle_mailer from singlelineedit within w_httpfile_example
integer x = 439
integer y = 2020
integer width = 1746
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "홍길동"
borderstyle borderstyle = stylelowered!
end type

type sle_from from singlelineedit within w_httpfile_example
integer x = 439
integer y = 1924
integer width = 855
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "testuser@localhost.co.kr"
borderstyle borderstyle = stylelowered!
end type

type sle_smtp from singlelineedit within w_httpfile_example
integer x = 443
integer y = 1832
integer width = 1746
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "mail.localhost.co.kr"
borderstyle borderstyle = stylelowered!
end type

type sle_dwservelturl from singlelineedit within w_httpfile_example
integer x = 55
integer y = 700
integer width = 1888
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "http://madam/pentadispatcher/PentaDownloadServlet"
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_httpfile_example
integer x = 55
integer y = 640
integer width = 498
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "File DownLoad"
boolean focusrectangle = false
end type

type sle_upservleturl from singlelineedit within w_httpfile_example
integer x = 55
integer y = 160
integer width = 1888
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "http://madam/pentadispatcher/PentaUploadServlet"
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_httpfile_example
integer x = 55
integer y = 100
integer width = 498
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "File UpLoad"
boolean focusrectangle = false
end type

type st_4 from statictext within w_httpfile_example
integer x = 55
integer y = 800
integer width = 370
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Download File"
boolean focusrectangle = false
end type

type sle_file from singlelineedit within w_httpfile_example
integer x = 55
integer y = 868
integer width = 1431
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_httpfile_example
integer x = 1495
integer y = 320
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "File"
end type

event clicked;String ls_path, ls_filename, ls_default

ls_default = GetCurrentDirectory()

if GetFileOpenName ("Open", ls_path, ls_filename, "All Files", "All Files (*.*),*.*", ls_default, 18) < 1 then return

ChangeDirectory(ls_default)
sle_3.text 		= ls_path
sle_file.text 	= ls_filename
end event

type st_3 from statictext within w_httpfile_example
integer x = 55
integer y = 256
integer width = 343
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Upload File"
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_httpfile_example
integer x = 55
integer y = 320
integer width = 1431
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_httpfile_example
integer x = 55
integer y = 1400
integer width = 869
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "FILE_PATH"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_httpfile_example
integer x = 55
integer y = 1464
integer width = 1431
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_servletdownload from commandbutton within w_httpfile_example
integer x = 1943
integer y = 864
integer width = 741
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Servlet FileDownload"
end type

event clicked;parameters	param

param.serverurl = Trim(sle_dwservelturl.text)

//param.defaultpath = getcurrentdir() + "\temp"
//IF Not DirectoryExists(param.defaultpath) THEN
//	CreateDirectory(param.defaultpath)
//END IF
GetFolder( "DownLoad File Save Directory", param.defaultpath )

param.filename = trim(sle_file.text)

param.parameter[1].param = "DOWNLOAD_FILE_PATH"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = "chungwoon/sales"

param.parameter[2].param = "downloadfile"
param.parameter[2].param_type = TYPE_VALUE
param.parameter[2].data = trim(sle_file.text)

param.parameter[3].param = "useftp"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = "false"

//param.parameter[4].param = "SERVER"
//param.parameter[4].param_type = TYPE_VALUE
//param.parameter[4].data = "ftp://124.137.16.101"
//
//param.parameter[5].param = "USER"
//param.parameter[5].param_type = TYPE_VALUE
//param.parameter[5].data = "sejoongfax"
//
//param.parameter[6].param = "PASSWORD"
//param.parameter[6].param_type = TYPE_VALUE
//param.parameter[6].data = "sejoongfax"
//
//param.parameter[7].param = "PASSIVE"
//param.parameter[7].param_type = TYPE_VALUE
//param.parameter[7].data = "true"

//DownloadServlet(param)
DownloadServletProgress(param)
end event

type st_1 from statictext within w_httpfile_example
integer x = 55
integer y = 1144
integer width = 498
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "File DownLoad"
boolean focusrectangle = false
end type

type sle_directurl from singlelineedit within w_httpfile_example
integer x = 55
integer y = 1204
integer width = 1888
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "http://madam/pentadispatcher/uploadfile"
borderstyle borderstyle = stylelowered!
end type

type cb_fileupload from commandbutton within w_httpfile_example
integer x = 1943
integer y = 76
integer width = 741
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "FileUpLoad"
end type

event clicked;parameters	param

param.serverurl = Trim(sle_upservleturl.text)
param.parameter[1].param = "UPLOAD_FILE_PATH"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = "200803"  //서버 파일 폴더.

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

param.parameter[7].param = "uploadfile1"
param.parameter[7].param_type = TYPE_FILE
param.parameter[7].data = Trim(sle_3.text)  //파일경로
param.parameter[7].rename = trim(sle_file.text) //변경될 파일 이름

param.parameter[8].param = "uploadfile2"
param.parameter[8].param_type = TYPE_FILE
param.parameter[8].data = Trim(sle_f.text)  //파일경로
param.parameter[8].rename = trim(sle_file2.text) //변경될 파일 이름

fileupload(param)

end event

type cb_1 from commandbutton within w_httpfile_example
integer x = 1943
integer y = 1204
integer width = 741
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Direct FileDownLoad"
end type

event clicked;parameters		lstr_file

lstr_file.serverurl = Trim(sle_directurl.Text)

GetFolder( "DownLoad File Save Directory", lstr_file.defaultpath )
lstr_file.filename = Mid(lstr_file.serverurl, LastPos(lstr_file.serverurl, '/') + Len("/"))
DirectDownload(lstr_file)

end event

type gb_1 from groupbox within w_httpfile_example
integer x = 18
integer y = 576
integer width = 2706
integer height = 488
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step 2. Servlet file download"
end type

type gb_2 from groupbox within w_httpfile_example
integer x = 18
integer y = 1076
integer width = 2706
integer height = 244
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step 3. Direct file download"
end type

type gb_3 from groupbox within w_httpfile_example
integer x = 18
integer y = 1320
integer width = 2706
integer height = 260
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Share : Direct file download"
end type

type gb_4 from groupbox within w_httpfile_example
integer x = 18
integer y = 28
integer width = 2706
integer height = 528
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step 1. File upload "
end type

type gb_5 from groupbox within w_httpfile_example
integer x = 18
integer y = 1588
integer width = 2706
integer height = 1176
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step 4. Send Mail"
end type

type ln_1 from line within w_httpfile_example
long linecolor = 33554432
integer linethickness = 4
integer beginx = 2341
integer beginy = 172
integer endx = 2569
integer endy = 372
end type

