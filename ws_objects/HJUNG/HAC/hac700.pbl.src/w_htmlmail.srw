$PBExportHeader$w_htmlmail.srw
$PBExportComments$e-mail 보내기....
forward
global type w_htmlmail from window
end type
type sle_file3 from singlelineedit within w_htmlmail
end type
type cb_file3 from commandbutton within w_htmlmail
end type
type cb_file2 from commandbutton within w_htmlmail
end type
type cb_file1 from commandbutton within w_htmlmail
end type
type sle_file2 from singlelineedit within w_htmlmail
end type
type sle_file1 from singlelineedit within w_htmlmail
end type
type st_4 from statictext within w_htmlmail
end type
type st_1 from statictext within w_htmlmail
end type
type sle_from_email from singlelineedit within w_htmlmail
end type
type sle_to_email from singlelineedit within w_htmlmail
end type
type st_6 from statictext within w_htmlmail
end type
type sle_subject from singlelineedit within w_htmlmail
end type
type cb_1 from commandbutton within w_htmlmail
end type
type mle_body from multilineedit within w_htmlmail
end type
type sle_from_name from singlelineedit within w_htmlmail
end type
type st_3 from statictext within w_htmlmail
end type
type st_2 from statictext within w_htmlmail
end type
type sle_to_name from singlelineedit within w_htmlmail
end type
end forward

global type w_htmlmail from window
integer width = 2661
integer height = 1992
boolean titlebar = true
string title = "SMTP Mail Send"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
sle_file3 sle_file3
cb_file3 cb_file3
cb_file2 cb_file2
cb_file1 cb_file1
sle_file2 sle_file2
sle_file1 sle_file1
st_4 st_4
st_1 st_1
sle_from_email sle_from_email
sle_to_email sle_to_email
st_6 st_6
sle_subject sle_subject
cb_1 cb_1
mle_body mle_body
sle_from_name sle_from_name
st_3 st_3
st_2 st_2
sle_to_name sle_to_name
end type
global w_htmlmail w_htmlmail

on w_htmlmail.create
this.sle_file3=create sle_file3
this.cb_file3=create cb_file3
this.cb_file2=create cb_file2
this.cb_file1=create cb_file1
this.sle_file2=create sle_file2
this.sle_file1=create sle_file1
this.st_4=create st_4
this.st_1=create st_1
this.sle_from_email=create sle_from_email
this.sle_to_email=create sle_to_email
this.st_6=create st_6
this.sle_subject=create sle_subject
this.cb_1=create cb_1
this.mle_body=create mle_body
this.sle_from_name=create sle_from_name
this.st_3=create st_3
this.st_2=create st_2
this.sle_to_name=create sle_to_name
this.Control[]={this.sle_file3,&
this.cb_file3,&
this.cb_file2,&
this.cb_file1,&
this.sle_file2,&
this.sle_file1,&
this.st_4,&
this.st_1,&
this.sle_from_email,&
this.sle_to_email,&
this.st_6,&
this.sle_subject,&
this.cb_1,&
this.mle_body,&
this.sle_from_name,&
this.st_3,&
this.st_2,&
this.sle_to_name}
end on

on w_htmlmail.destroy
destroy(this.sle_file3)
destroy(this.cb_file3)
destroy(this.cb_file2)
destroy(this.cb_file1)
destroy(this.sle_file2)
destroy(this.sle_file1)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.sle_from_email)
destroy(this.sle_to_email)
destroy(this.st_6)
destroy(this.sle_subject)
destroy(this.cb_1)
destroy(this.mle_body)
destroy(this.sle_from_name)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_to_name)
end on

type sle_file3 from singlelineedit within w_htmlmail
integer x = 55
integer y = 1544
integer width = 2235
integer height = 92
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_file3 from commandbutton within w_htmlmail
integer x = 2304
integer y = 1544
integer width = 114
integer height = 88
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "..."
end type

event clicked;string docname, named
//		 파일경로 파일이름

sle_file2.text = ''

integer get_file
		  get_file = GetFileOpenName("파일찾기", &
  		           + docname, named, "", &
					  + "PDF 파일 (*.PDF),*.PDF," &
					  + "모든파일 (*.*),*.*")
		 
sle_file2.text = sle_file2.text + docname
end event

type cb_file2 from commandbutton within w_htmlmail
integer x = 2304
integer y = 1444
integer width = 114
integer height = 88
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "..."
end type

event clicked;string docname, named
//		 파일경로 파일이름

sle_file2.text = ''

integer get_file
		  get_file = GetFileOpenName("파일찾기", &
  		           + docname, named, "", &
					  + "PDF 파일 (*.PDF),*.PDF," &
					  + "모든파일 (*.*),*.*")
		 
sle_file2.text = sle_file2.text + docname
end event

type cb_file1 from commandbutton within w_htmlmail
integer x = 2304
integer y = 1348
integer width = 114
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "..."
end type

event clicked;string docname, named
//		 파일경로 파일이름

sle_file1.text = ''

integer get_file
		  get_file = GetFileOpenName("파일찾기", &
  		           + docname, named, "", &
					  + "PDF 파일 (*.PDF),*.PDF," &
					  + "모든파일 (*.*),*.*")
		 
sle_file1.text = sle_file1.text + docname
end event

type sle_file2 from singlelineedit within w_htmlmail
integer x = 55
integer y = 1444
integer width = 2235
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_file1 from singlelineedit within w_htmlmail
integer x = 55
integer y = 1348
integer width = 2235
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_htmlmail
integer x = 41
integer y = 1248
integer width = 283
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "첨부 파일"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_htmlmail
integer x = 41
integer y = 360
integer width = 283
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "본문"
boolean focusrectangle = false
end type

type sle_from_email from singlelineedit within w_htmlmail
integer x = 1262
integer y = 144
integer width = 1349
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_to_email from singlelineedit within w_htmlmail
integer x = 1262
integer y = 20
integer width = 1349
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_htmlmail
integer x = 41
integer y = 256
integer width = 283
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "제목"
boolean focusrectangle = false
end type

type sle_subject from singlelineedit within w_htmlmail
integer x = 366
integer y = 248
integer width = 2235
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_htmlmail
integer x = 2153
integer y = 1720
integer width = 402
integer height = 84
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "보내기"
end type

event clicked;// Send Button Clicked Event --------------------------------------------------------------------------------------------------
// Version 		: SMTP MAIL TEST VERSION
// FONT 		   : VERDANA , 9
// Tab Size 		: 4
// PB Version 	: PB 8.0.2
// Setting		: Step 1: Copy .DLL file.
//				   :		  C:\> COPY SASMTP.DLL C:\WINNT\SYSTEM32
//				   : Step 2: Register .DLL file.
//				   :		  C:\> REGSVR32 C:\WINNT\SYSTEM32\SASMTP.DLL
//					: 이것은 SASMTP 이전 버전이 없다는 가정하에서의 setting입니다. 
//					: 있을 경우에는 우선 이전버전을 지우고서 하셔야 합니다.
// 원본			: PBDN 자료실의 175 번 ( 천산님의 자료 )
// 수정			: 숨은 참조를 추가.. // 02-06-26  ㅡ,.ㅡㅋ''
// Others		: http://www.softartisans.com/softartisans/whatsnew.html 
//					: 위의 사이트에 가면 DLL을 구할 수 가 있습니다. 물론 공짜 입니다. 하지만 몇몇 기능제한이 있습니다.
//					: 정품은 기능제한 없습니다. 근데.. 왜...기능제한이 있는걸 쓰느냐??  던이 없으니깐... Y..Y''
//					: 만약 못 찾으시면 아래 자료실 175번에 천산님의 원본소스와 dll 이 있습니다.
//-------------------------------------------------------------------------------------------------------------------------------------

OLEObject	smtp
Integer		iRet
Boolean		ls_return
long        i, iPos
string      Test_name

smtp = CREATE OLEObject
iRet = smtp.ConnectToNewObject ( "SoftArtisans.SMTPMail" )

IF iRet <> 0 THEN
	MessageBox ( "ConnectToNewObject Error", iRet )
	return
ENd IF

smtp.RemoteHost 		= "seilsteel.com"		  // SMTP MAIL SERVER ADDRESS (or  IP)
smtp.CustomCharSet 	= "ks_c_5601-1987"	  // 한글은 ks_c_5601-1987 이다 ...  특별히 지정을 하지 않으면 US-ASCII or ISO-8859-1
smtp.ContentType 	   = "text/html"		     // mailer.ContentType = "text/html"
smtp.FromName 		   = sle_from_name.text		  // 보내는 사람의 이름을 적는곳.
smtp.FromAddress 	   = sle_from_email.text       // 보내는 사람의 메일 Address를 적는곳.
smtp.ReplyTo 			= sle_from_email.text       // 답장을 받을 곳의 메일을 적는곳. 

//Test_name = 'cobe@DreamWiz.com;cobe@seilsteel.com;'
//
//iPos = pos(Test_name,";")

//do while iPos > 0

//	smtp.AddRecipient ( "조항민", left(Test_name, iPos -1) )	// 필요한 만큼 많은 받는 사람을 붙일 수 있다.
	smtp.AddRecipient ( sle_to_name.text, sle_to_email.text )          // OBJECT.AddRecipient ([in] Name as String, E-mail as String)
	
//	ls_return = smtp.AddBCC ('name', 'webmaster@seilsteel.com')  // 숨은참조 : OBJECT.AddBCC([in] Name as String, E-mail as String)
//																	        // 참조     : OBJECT.AddCC ([in] Name as String, E-mail as String)
//	IF ls_return = FALSE THEN   
//		MessageBox("ERROR","숨은 참조실패")
//	END IF
	
	smtp.Subject = sle_subject.text                             // 제목
		 
	smtp.Live = TRUE
	smtp.HtmlText = mle_body.text                              // 본문
	
//	Test_name = right(Test_name, len(Test_name) - iPos)
//	iPos = pos(Test_name , ";")															
//loop
	smtp.AddAttachment(sle_file1.text)		// 파일첨부 : OBJECT.AddAttachment ([in] Filename as String)  :  경로를 의미		
	smtp.AddAttachment(sle_file2.text)     // 파일첨부는 TEST 안해봤음....	

IF smtp.SendMail = TRUE THEN
//	smtp.ClearBCCs								   // 숨은 참조 Clear
	MessageBox ( "Mail", "OK" )
ELSE
	MessageBox ( "Mail", "FAIL" )
END IF


//////////////////////////////////////////////////////////////////////////////////////////////
//
// Function Name : gf_mailsend
//
// Return  : Integer  [-1 : LogIn Error, -2 : MailSend Error, 0 : Success]
//
// Argument  : Arg_EMail => 받을 유저의 메일 주소
// Arg_FilePath => 첨부할 파일 위치 (단, 끝에 \을 붙이지 않는다.) 
// Arg_FileName => 첨부할 파일 명
// Arg_MailHead => 메일의 제목
// Arg_MailNote => 메일의 내용
//
// Example  : gf_mailsend("ericryu@yahoo.co.kr", "c:", "test.hwp", "테스트용", "테스트용입니다.")
//
// Update Date  : 2001.06.30 [토요일]
//
//////////////////////////////////////////////////////////////////////////////////////////////
//MAILSESSION M_S
//MAILRETURNCODE M
//MAILMESSAGE M_MESSAGE
//MailFileDescription MF
//
// MAIL SESSION OPEN
//M_S = CREATE MAILSESSION
//M = M_S.MAILLOGON()
//
//IF M <> MAILRETURNSUCCESS! THEN
//DESTROY M_S
//RETURN "MAILERR01"
//END IF
//
// 파일을 첨부합니다.
//MF.FileName = "HDSPY16.DLL" // 첨부 FileName
//MF.PathName = "C:\HNC\Hwp\HDSPY16.DLL" // 첨부 File의 Full Path Name
//M_MESSAGE.AttachmentFile[1] = MF // Mial에 알려줌
//
// MAIL MESSAGE스트럭처에 MESSAGE입력
//M_MESSAGE.RECIPIENT[1].NAME = "cobe@DreaWiz.com" // Mail 주소
//M_MESSAGE.SUBJECT = "Test" // 제목
//M_MESSAGE.NOTETEXT = "Test" // MultiLineEdit에 있는 내용 (전송내용)
//
// MAIL 전송
//M = M_S.MAILSEND(M_MESSAGE)
//
//IF M <> MAILRETURNSUCCESS! THEN
//M = M_S.MAILLOGOFF()
//DESTROY M_S
//RETURN "MAILERR02"
//END IF
//
// MAIL SESSION CLOSE
//M = M_S.MAILLOGOFF()
//DESTROY M_S
//RETURN "SUCCESS"
//
end event

type mle_body from multilineedit within w_htmlmail
integer x = 50
integer y = 440
integer width = 2551
integer height = 792
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type sle_from_name from singlelineedit within w_htmlmail
integer x = 814
integer y = 144
integer width = 443
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_htmlmail
integer y = 152
integer width = 814
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "보내는사람 이름/E-MAIL주소"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_htmlmail
integer y = 44
integer width = 805
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "받는 사람 이름/E-MAIL 주소"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_to_name from singlelineedit within w_htmlmail
integer x = 814
integer y = 20
integer width = 443
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

