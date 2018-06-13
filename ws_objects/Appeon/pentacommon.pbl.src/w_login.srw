$PBExportHeader$w_login.srw
$PBExportComments$System Login
forward
global type w_login from window
end type
type mdi_1 from mdiclient within w_login
end type
type p_close from u_picture within w_login
end type
type p_pass from u_picture within w_login
end type
type p_id from u_picture within w_login
end type
type p_close1 from u_picture within w_login
end type
type cbx_idcheck from checkbox within w_login
end type
type p_ok from u_picture within w_login
end type
type em_emp_code from editmask within w_login
end type
type sle_password from singlelineedit within w_login
end type
type st_1 from statictext within w_login
end type
type st_2 from statictext within w_login
end type
type p_logo from picture within w_login
end type
end forward

global type w_login from window
integer width = 4681
integer height = 3024
boolean titlebar = true
string menuname = "m_dummy"
windowtype windowtype = mdi!
long backcolor = 16777215
boolean toolbarvisible = false
boolean center = true
event ue_postopen ( )
mdi_1 mdi_1
p_close p_close
p_pass p_pass
p_id p_id
p_close1 p_close1
cbx_idcheck cbx_idcheck
p_ok p_ok
em_emp_code em_emp_code
sle_password sle_password
st_1 st_1
st_2 st_2
p_logo p_logo
end type
global w_login w_login

type prototypes
Function long removeTitleBar( ulong hWnd, long index ) Library "pbaddon.dll"
end prototypes

type variables
Integer    ii_LogCnt = 0, ii_Timer=0

end variables

forward prototypes
public subroutine wf_check_id ()
end prototypes

event ue_postopen();vector   lvc_data
lvc_data = Create vector

lvc_data.importfile('saveid.props')
IF lvc_data.getkeycount() > 0 THEN
	cbx_idcheck.Checked = True
	em_emp_code.text = lvc_data.getproperty('saveid')
	sle_password.setfocus() 
END IF

p_ok.of_enable(true)
p_close.of_enable(true)
p_id.of_enable(true)
p_pass.of_enable(true)

Destroy lvc_data


end event

public subroutine wf_check_id ();vector   lvc_data

lvc_data = Create vector

IF cbx_idcheck.Checked THEN
	lvc_data.setproperty('saveid', em_emp_code.text)
	lvc_data.exportfile('saveid.props')
ELSE
	lvc_data.removeall()
	lvc_data.exportfile('saveid.props')
END IF

Destroy lvc_data	

end subroutine

on w_login.create
if this.MenuName = "m_dummy" then this.MenuID = create m_dummy
this.mdi_1=create mdi_1
this.p_close=create p_close
this.p_pass=create p_pass
this.p_id=create p_id
this.p_close1=create p_close1
this.cbx_idcheck=create cbx_idcheck
this.p_ok=create p_ok
this.em_emp_code=create em_emp_code
this.sle_password=create sle_password
this.st_1=create st_1
this.st_2=create st_2
this.p_logo=create p_logo
this.Control[]={this.mdi_1,&
this.p_close,&
this.p_pass,&
this.p_id,&
this.p_close1,&
this.cbx_idcheck,&
this.p_ok,&
this.em_emp_code,&
this.sle_password,&
this.st_1,&
this.st_2,&
this.p_logo}
end on

on w_login.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.p_close)
destroy(this.p_pass)
destroy(this.p_id)
destroy(this.p_close1)
destroy(this.cbx_idcheck)
destroy(this.p_ok)
destroy(this.em_emp_code)
destroy(this.sle_password)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.p_logo)
end on

event open;removeTitleBar(handle(this), 0)
This.Post Event ue_postopen()
end event

event resize;Long   ll_dwheight, ll_wkw, ll_wkh


ll_wkw 	= this.workspacewidth( )
ll_wkh  	= This.workspaceheight( )

////바탕로고 
//p_logo.x = (ll_wkw - p_logo.width) / 2
//p_logo.y = (ll_wkh - p_logo.height)  / 2
//
////클로즈
//p_close.x = p_logo.x + p_logo.width - 95
//p_close.y = p_logo.y + 24
//
////아이디 입력 필드 테두리
//st_1.x = p_logo.x + 2267
//st_1.y = p_logo.y + 1644
//
////아이디 입력 필드
//em_emp_code.x = st_1.x + PixelsToUnits(5, XPixelsToUnits!)
//em_emp_code.y = st_1.y + PixelsToUnits(4, YPixelsToUnits!)
//
////비밀번호 입력 필드 테두리
//st_2.x = st_1.x
//st_2.y = st_1.y + st_1.height + PixelsToUnits(4, YPixelsToUnits!)
//
////비밀번호 입력 필드
//sle_password.x = em_emp_code.x
//sle_password.y = st_2.y + PixelsToUnits(4, YPixelsToUnits!)
//
////아이디 저장하기 체크박스
//cbx_idcheck.x = st_2.x
//cbx_idcheck.y = st_2.y + st_2.height + PixelsToUnits(4, YPixelsTounits!)
//
////OK 그림
//p_ok.x = st_1.x + st_1.width + PixelsToUnits(5, XPixelsToUnits!)
//p_ok.y = st_1.y + PixelsTounits(1, YPixelsToUnits!)
//

end event

type mdi_1 from mdiclient within w_login
long BackColor=268435456
end type

type p_close from u_picture within w_login
integer x = 3726
integer y = 768
integer width = 215
integer height = 64
string picturename = "..\img\login\login_close.gif"
end type

event clicked;call super::clicked;Close(Parent)
end event

type p_pass from u_picture within w_login
integer x = 3579
integer y = 1644
integer width = 270
integer height = 64
string picturename = "..\img\login\pass_search.gif"
end type

event clicked;call super::clicked;String	ls_id, ls_pw, ls_conpw, ls_encript
s_row	lstr_data

ls_id		= em_emp_code.Text
ls_pw		= sle_password.Text
ls_conpw	= ''

wf_check_id()

/* 데이터베이스 바꾸기 */
gn_login.of_login(ls_id, ls_pw, ls_conpw)

end event

type p_id from u_picture within w_login
integer x = 3319
integer y = 1644
integer width = 247
integer height = 64
string picturename = "..\img\login\id_search.gif"
end type

event clicked;call super::clicked;String	ls_id, ls_pw, ls_conpw, ls_encript
s_row	lstr_data

ls_id		= em_emp_code.Text
ls_pw		= sle_password.Text
ls_conpw	= ''

wf_check_id()

/* 데이터베이스 바꾸기 */
gn_login.of_login(ls_id, ls_pw, ls_conpw)

end event

type p_close1 from u_picture within w_login
boolean visible = false
integer x = 4334
integer y = 524
integer width = 55
integer height = 48
boolean enabled = false
string picturename = "..\img\tab\closetooltab.gif"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cbx_idcheck from checkbox within w_login
boolean visible = false
integer x = 2263
integer y = 2348
integer width = 78
integer height = 84
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 25988236
long backcolor = 33028088
boolean checked = true
end type

event clicked;wf_check_id()
end event

type p_ok from u_picture within w_login
integer x = 3557
integer y = 1300
integer width = 293
integer height = 192
string picturename = "..\img\login\login_ok.gif"
end type

event clicked;call super::clicked;String	ls_id, ls_pw, ls_conpw, ls_encript
s_row	lstr_data

ls_id		= em_emp_code.Text
ls_pw		= sle_password.Text
ls_conpw	= ''

wf_check_id()

/* 데이터베이스 바꾸기 */
gn_login.of_login(ls_id, ls_pw, ls_conpw)

end event

type em_emp_code from editmask within w_login
integer x = 3104
integer y = 1320
integer width = 411
integer height = 64
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 25988236
long backcolor = 33422845
boolean border = false
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXX"
boolean autoskip = true
string minmax = "0~~5"
end type

event getfocus;gf_settoggle(HANDLE(this), ENG)
end event

type sle_password from singlelineedit within w_login
event ue_keydown pbm_keydown
integer x = 3099
integer y = 1408
integer width = 421
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Tahoma"
long textcolor = 25988236
long backcolor = 33422845
boolean border = false
boolean autohscroll = false
boolean password = true
integer limit = 20
end type

event ue_keydown;/* pbm_dwnkey */
String	ls_col

CHOOSE CASE key
// 서브 윈도우
	CASE Keyenter!
      p_ok.postEvent(clicked!) 
	  RETURN 1
END CHOOSE

end event

type st_1 from statictext within w_login
boolean visible = false
integer x = 3090
integer y = 1316
integer width = 434
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 33422845
boolean border = true
long bordercolor = 29014714
boolean focusrectangle = false
end type

type st_2 from statictext within w_login
boolean visible = false
integer x = 3090
integer y = 1404
integer width = 434
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 33422845
boolean border = true
long bordercolor = 29014714
boolean focusrectangle = false
end type

type p_logo from picture within w_login
integer y = 496
integer width = 4681
integer height = 1800
boolean originalsize = true
string picturename = "..\img\login\login_bg.jpg"
boolean focusrectangle = false
end type

