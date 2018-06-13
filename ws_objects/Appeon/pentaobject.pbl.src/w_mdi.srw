$PBExportHeader$w_mdi.srw
forward
global type w_mdi from window
end type
type mdi_1 from mdiclient within w_mdi
end type
type p_buttomline from picture within w_mdi
end type
type p_leftline from picture within w_mdi
end type
type st_start from statictext within w_mdi
end type
type st_end from statictext within w_mdi
end type
type dw_msg from datawindow within w_mdi
end type
type uo_toolbar from u_toolbar within w_mdi
end type
type st_resize from uo_statictext within w_mdi
end type
type uo_tab from u_tooltab within w_mdi
end type
type st_temp from statictext within w_mdi
end type
type uo_menu from u_treememu within w_mdi
end type
type uo_leftmenu from u_leftmenu within w_mdi
end type
end forward

global type w_mdi from window
boolean visible = false
integer width = 4686
integer height = 2900
boolean titlebar = true
string title = "Untitled"
string menuname = "m_main"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdi!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event ue_postopen ( )
event key_mousemove pbm_mousemove
event ue_checkpoint ( )
mdi_1 mdi_1
p_buttomline p_buttomline
p_leftline p_leftline
st_start st_start
st_end st_end
dw_msg dw_msg
uo_toolbar uo_toolbar
st_resize st_resize
uo_tab uo_tab
st_temp st_temp
uo_menu uo_menu
uo_leftmenu uo_leftmenu
end type
global w_mdi w_mdi

type prototypes
FUNCTION boolean GetCursorPos(REF POINT ipPoint) LIBRARY "user32.dll"
FUNCTION boolean ScreenToClient(long hWnd, ref POINT lpPoint) Library "USER32.DLL"
FUNCTION boolean AnimateWindow(ulong lhWnd, ulong lTm, ulong lFlags ) library 'user32.dll'
FUNCTION long SetCapture(long hwnd) LIBRARY "user32.dll"
FUNCTION long ReleaseCapture() LIBRARY "user32.dll"
FUNCTION long RealChildWindowFromPoint (long hWnd, ref POINT lpPoint) Library "USER32.DLL"
FUNCTION long ChildWindowFromPoint(long hWnd, ref POINT lpPoint) Library "USER32.DLL"
FUNCTION Long setMDIClientBorder( long hWnd, long index ) library "pbaddon.dll"
end prototypes

type variables
Public:
Boolean		ib_resize
Boolean		ib_menufix  = False
Boolean		ib_show		= False
Boolean		_ib_resize		= False
integer 		Orientation = 2
long 			AnimatTime = 180

//Collapsing Bar Control Property
String			callapsingbarcolor		= "230,230,230"
Long			callapsingbarsize		= PixelsToUnits( 20, XPixelsToUnits!)

//V1.9.9.012  메뉴 더들클릭시 닫히게 하는 옵션.
Boolean		ib_dbclk_hide = False
//=============================

Protected:
String			errorcolor
String			inforcolor
String			defaultcolor
Boolean			ib_menubar = false

Private:
n_timing			in_timer
Decimal			INTERVAL		= 2
Boolean			ib_msgheight	= false
Integer			ii_select			= 1
pentaservice	in_penta

CONSTANT long BAR_WIDTH = 25

// Animate the window from left to right
Constant Long AW_HOR_POSITIVE = 1
// Animate the window from right to left
Constant Long AW_HOR_NEGATIVE = 2 
// Animate the window from top to bottom
Constant Long AW_VER_POSITIVE = 4 
// Animate the window from bottom to
Constant Long AW_VER_NEGATIVE = 8
// Makes the window appear to collapse inward
Constant Long AW_CENTER = 16
// Hides the window
Constant Long AW_HIDE = 65536
// Activates the window
Constant Long AW_ACTIVATE = 131072
// Uses slide animation
Constant Long AW_SLIDE = 262144
// Uses a fade effect
Constant Long AW_BLEND = 524288

CONSTANT ulong DT_TOP                      		= 0      									//0x00000000
CONSTANT ulong DT_LEFT                     		= 0      									//0x00000000
CONSTANT ulong DT_CENTER                   		= 1      									//0x00000001
CONSTANT ulong DT_RIGHT                    		= 2      									//0x00000002
CONSTANT ulong DT_VCENTER                  	= 4      									//0x00000004
CONSTANT ulong DT_BOTTOM                   	= 8      									//0x00000008
CONSTANT ulong DT_WORDBREAK               	= 16     									//0x00000010
CONSTANT ulong DT_SINGLELINE               	= 32     									//0x00000020
CONSTANT ulong DT_EXPANDTABS              	= 64     									//0x00000040
CONSTANT ulong DT_TABSTOP                  	= 128     								//0x00000080
CONSTANT ulong DT_NOCLIP                   		= 256    									//0x00000100
CONSTANT ulong DT_EXTERNALLEADING      	= 512   	 								//0x00000200
CONSTANT ulong DT_CALCRECT                 	= 1024    								//0x00000400
CONSTANT ulong DT_NOPREFIX                 	= 2048    								//0x00000800
CONSTANT ulong DT_INTERNAL                 	= 4096   									//0x00001000
CONSTANT ulong DT_EDITCONTROL            	= 8192   									//0x00002000
CONSTANT ulong DT_PATH_ELLIPSIS           	= 16384   								//0x00004000
CONSTANT ulong DT_END_ELLIPSIS             	= 32768   								//0x00008000
CONSTANT ulong DT_MODIFYSTRING           	= 65536  								//0x00010000
CONSTANT ulong DT_RTLREADING              	= 131072  								//0x00020000
CONSTANT ulong DT_WORD_ELLIPSIS         	= 262144  								//0x00040000
CONSTANT ulong DT_NOFULLWIDTHCHARBREAK     = 524288  						//0x00080000
CONSTANT ulong DT_HIDEPREFIX               	= 1048576 								//0x00100000
CONSTANT ulong DT_PREFIXONLY               	= 2097152 								//0x00200000


end variables

forward prototypes
public subroutine wf_resize ()
public subroutine wf_select (string as_win)
public subroutine wf_destroywin (string as_winname)
protected function long wf_getanimationflags (boolean ab_hide)
public subroutine wf_hide ()
public subroutine wf_ondisplay ()
public subroutine wf_show (integer ai_tabidx)
public function long wf_findwindow (string as_windowname, ref str_tree astr_item)
public subroutine wf_sheetresize ()
public function long wf_getmdiwidth ()
public function long wf_getmdiheight ()
public subroutine wf_mdiborder ()
public subroutine wf_set_pgmid (string arg_pgmid)
public subroutine wf_set_message (string as_info, string a_msg)
public subroutine wf_menufix ()
public function w_base wf_opensheet (string as_title, string as_winname, string as_pgmno)
public function w_base wf_opensheetparmlong (string as_title, string as_winname, string as_pgmno, long al_arg)
public function w_base wf_opensheetparmpob (string as_title, string as_winname, string as_pgmno, powerobject apo_arg)
public function w_base wf_opensheetparmstring (string as_title, string as_winname, string as_pgmno, string as_arg)
end prototypes

event ue_postopen();ib_menubar = true

ib_resize = true

wf_menufix()

//V1.9.9.013 menufix에 의한 수정.
uo_menu.of_menufix(ib_menufix)
//=====================

This.Visible = True
end event

event ue_checkpoint();POINT lp, lcp
ulong ll
ulong lul

lul = Handle(This)


IF GetCursorPos(lp) THEN
	IF Screentoclient(lul, lp) THEN
		IF lp.x < UnitsToPixels(uo_leftmenu.x, XUnitsToPixels!) OR lp.x > UnitsToPixels(st_resize.x + st_resize.width, XUnitsToPixels!) OR lp.y < UnitsToPixels(uo_menu.y, YUnitsToPixels!) OR lp.y > UnitsToPixels(uo_menu.y + uo_menu.height, YUnitsToPixels!) THEN
			//check if parent has mouse
			IF ib_show AND Not ib_menufix AND Not _ib_resize THEN 
				This.SetRedraw(true) //Vista적용용 
				wf_hide()
			END IF
		END IF	
	END IF
END IF


end event

public subroutine wf_resize ();Long   ll_dwheight, ll_wkw, ll_wkh

this.setRedraw(false)

IF dw_msg.visible THEN
	IF NOt ib_msgheight THEN
		ll_dwheight = dw_msg.height + PixelsToUnits(3, YPixelsToUnits!)
		dw_msg.height = ll_dwheight
		ib_msgheight = Not ib_msgheight
	ELSE
		ll_dwheight = dw_msg.height
	END IF
END IF

ll_wkw 	= this.workspacewidth( )
ll_wkh  	= This.workspaceheight( )
uo_toolbar.x 				= This.workspacex( )
uo_toolbar.y 				= This.workspacey( )
uo_toolbar.width 			= ll_wkw

IF ib_resize THEN
   uo_toolbar.of_resize()
END IF

uo_tab.x 				= PixelsToUnits(15, XPixelsToUnits!)//uo_leftmenu.x //st_resize.x + st_resize.width
uo_tab.y 				= uo_toolbar.y + uo_toolbar.height
uo_tab.width 		= ll_wkw - uo_tab.x - PixelsToUnits(15, XPixelsToUnits!)

uo_leftmenu.x				= 0//PixelsToUnits(2, XPixelsToUnits!)
uo_leftmenu.y				= uo_tab.y + uo_tab.height //uo_toolbar.y + uo_toolbar.height //+ PixelsToUnits(2, YPixelsToUnits!)

uo_leftmenu.height		= ll_wkh - uo_leftmenu.y  - PixelsToUnits(2, YPixelsToUnits!) - ll_dwheight

//modify
st_start.width		= uo_tab.x
st_start.x				= 0
st_start.y				= uo_tab.y
st_start.height		= ll_wkh - uo_tab.y

uo_menu.x 					= uo_leftmenu.x + uo_leftmenu.p_tree.x + uo_leftmenu.p_tree.width + PixelsToUnits( 2, XPixelsToUnits!)
uo_menu.y 					= uo_leftmenu.y + PixelsToUnits(4, YPixelsToUnits!)
uo_menu.height 			= uo_leftmenu.y + uo_leftmenu.height - (uo_menu.y + PixelsToUnits(2, YPixelsToUnits!)) - ll_dwheight

//SSC  IF로 묵음. ==================
IF Not ib_menufix THEN
	st_resize.x 					= uo_leftmenu.x + uo_leftmenu.width
	st_resize.y 					= uo_leftmenu.y
	st_resize.height 			= ll_wkh - st_resize.y  - PixelsToUnits(2, YPixelsToUnits!) - ll_dwheight // - dw_msg.height
	st_resize.width 				= 14
	st_resize.of_Enable(true)
	st_resize.BringToTop 		= False

//V1.9.9.013  menufix 설정에 의한 수정.
ELSE
 st_resize.y      = uo_leftmenu.y
 st_resize.height    = ll_wkh - st_resize.y  - PixelsToUnits(2, YPixelsToUnits!) - ll_dwheight // - dw_msg.height
 st_resize.width     = 14
 st_resize.of_Enable(true)
END IF
//============================
//resize용
st_temp.x 			= st_resize.x + st_resize.width
st_temp.width 		= ll_wkw - st_temp.x

mdi_1.y 				= uo_tab.y + uo_tab.height + PixelsToUnits(2, YPixelsToUnits!)
mdi_1.x 				= st_resize.x + st_resize.width
mdi_1.height 		= ll_wkh - mdi_1.y  - PixelsToUnits(2, YPixelsToUnits!)  - ll_dwheight

st_end.width			= PixelsToUnits(15, XPixelsToUnits!)
st_end.x				= ll_wkw - st_end.width
st_end.y				= uo_toolbar.y + uo_toolbar.height
st_end.height		= ll_wkh - uo_tab.y

p_leftline.x = mdi_1.x + mdi_1.width
p_leftline.y = mdi_1.y
p_leftline.width = PixelsToUnits(2, XPixelsToUnits!)
p_leftline.height = mdi_1.height
p_leftline.setposition(totop!)

p_buttomline.x = mdi_1.x
p_buttomline.y = mdi_1.y + mdi_1.width
p_buttomline.height = PixelsToUnits(2, YPixelsToUnits!)
p_buttomline.width = mdi_1.width
p_buttomline.setposition(totop!)


IF Not ib_menufix THEN
	mdi_1.width  	= ll_wkw - mdi_1.x - PixelsToUnits(15, XPixelsToUnits!)
ELSE
//SSC 하나만 처리하면 된다.
//	IF (ll_wkw - mdi_1.x) > 4480 THEN
		mdi_1.width  	= ll_wkw - mdi_1.x  - PixelsToUnits(15, XPixelsToUnits!)
//	ELSE
//		mdi_1.width		= 4480
//	END IF
END IF

IF dw_msg.visible THEN
	dw_msg.x = uo_tab.x
	dw_msg.y = ll_wkh - dw_msg.height
	dw_msg.width = uo_tab.width
END IF

IF ib_resize THEN
	uo_tab.of_resizetab()
END IF

uo_leftmenu.of_resize()
uo_menu.of_resize()

wf_sheetresize()

p_leftline.x = mdi_1.x + mdi_1.width
p_leftline.y = uo_tab.y + uo_tab.height
p_leftline.width = PixelsToUnits(2, XPixelsToUnits!)
p_leftline.height = mdi_1.y + mdi_1.height - p_leftline.y 
p_leftline.setposition(totop!)

p_buttomline.x = uo_tab.x
p_buttomline.y = mdi_1.y + mdi_1.height
p_buttomline.height = PixelsToUnits(2, YPixelsToUnits!)
p_buttomline.width = p_leftline.x + p_leftline.width - p_buttomline.x
p_buttomline.setposition(totop!)

This.setRedRaw(true)

end subroutine

public subroutine wf_select (string as_win);uo_tab.of_select(as_win)
end subroutine

public subroutine wf_destroywin (string as_winname);IF uo_tab.ib_close THEN
	uo_tab.of_destroytab( as_winname)
END IF
end subroutine

protected function long wf_getanimationflags (boolean ab_hide);long ll_ret

CHOOSE CASE Orientation
	CASE 1 //top
		IF ab_hide THEN
			ll_ret = AW_SLIDE + AW_VER_NEGATIVE + AW_HIDE
		ELSE
			ll_ret = AW_SLIDE + AW_VER_POSITIVE + AW_ACTIVATE
		END IF
	CASE 2 //left
		IF ab_hide THEN
			ll_ret = AW_SLIDE + AW_HOR_NEGATIVE + AW_HIDE
		ELSE
			ll_ret = AW_SLIDE + AW_HOR_POSITIVE + AW_ACTIVATE
		END IF
	CASE 3 //right
		IF ab_hide THEN
			ll_ret = AW_SLIDE + AW_HOR_POSITIVE + AW_HIDE
		ELSE
			ll_ret = AW_SLIDE + AW_HOR_NEGATIVE + AW_ACTIVATE
		END IF
	CASE 4 //bottom
		IF ab_hide THEN
			ll_ret = AW_SLIDE + AW_VER_POSITIVE + AW_HIDE
		ELSE
			ll_ret = AW_SLIDE + AW_VER_NEGATIVE + AW_ACTIVATE
		END IF
END CHOOSE

RETURN ll_ret
end function

public subroutine wf_hide ();uo_leftmenu.width = uo_leftmenu.x + uo_leftmenu.p_tree.x + uo_leftmenu.p_tree.width +  PixelstoUnits(2, XPixelsToUnits!)
uo_leftmenu.st_1.visible = false
uo_leftmenu.st_1.setposition(tobottom!)
uo_leftmenu.of_resize()
uo_leftmenu.setposition(TOTOP!)

st_resize.visible = False
st_resize.x = uo_leftmenu.x + uo_leftmenu.width

ib_show = False

/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = Appeon6에서 Animation이 실행 되지 않음.
		 작업 = AnimationTime이 이미 정의되어 있는 문자 이기 때문에 AnimationTime을 AnimatTime으로 변경.
	작업자  : 김영재 송상철
====================================*/
AnimateWindow(Handle(uo_menu), AnimatTime, wf_GetAnimationFlags(TRUE))
//====================================

uo_menu.setposition(ToTop!)
wf_ondisplay()

//V1.9.9.015  vista에서 슬라이드가 계속 남아 있기 때문에 적용 시킴.
this.setredraw(true)
//=========================================


end subroutine

public subroutine wf_ondisplay ();IF ib_show THEN
	IF Not IsValid(in_timer) THEN
		in_timer = CREATE n_timing
		in_timer.event ke_setparent(this, "ue_checkpoint")
		in_timer.Start(INTERVAL)
	END IF
ELSE
	IF ISVALID(in_timer) THEN
		in_timer.Stop()
		DESTROY in_timer
	END IF
END IF
end subroutine

public subroutine wf_show (integer ai_tabidx);ii_select = ai_tabidx
uo_menu.of_selecttab( ai_tabidx )

ib_show = True

Long		ll_handle

ll_handle = Handle(uo_menu)
/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = Appeon6에서 Animation이 실행 되지 않음.
		 작업 = AnimationTime이 이미 정의되어 있는 문자 이기 때문에 AnimationTime을 AnimatTime으로 변경.
	작업자  : 김영재 송상철
====================================*/
AnimateWindow(ll_handle, AnimatTime, wf_GetAnimationFlags(False))
//====================================

//V1.9.9.013  menufix에 의한 수정.
uo_leftmenu.width = uo_leftmenu.p_bookmark.width + uo_menu.width + PixelsToUnits(2 * 2, XPixelsToUnits!)
//======================
//uo_leftmenu.width = uo_leftmenu.width + uo_menu.width + PixelsToUnits(2 * 2, XPixelsToUnits!)
//======================

uo_leftmenu.st_1.visible = true
uo_leftmenu.st_1.setposition(tobottom!)
uo_leftmenu.of_resize()
uo_leftmenu.setposition(TOTOP!)
uo_menu.setposition(ToTop!)

st_resize.visible = True
st_resize.x = uo_leftmenu.x + uo_leftmenu.width

//V1.9.9.013  menufix에 의한 수정..
st_temp.x    = st_resize.x + st_resize.width
//=======================

IF Not ib_menufix THEN
	wf_ondisplay()
END IF
end subroutine

public function long wf_findwindow (string as_windowname, ref str_tree astr_item);return uo_menu.of_findeitem(as_windowname, astr_item)

end function

public subroutine wf_sheetresize ();window		lw_active, lw_act
lw_active = This.GetFirstSheet()
lw_act = This.GetActiveSheet ()

do while true
	IF IsValid(lw_active) THEN
		lw_active.width = mdi_1.width
		lw_active.height = mdi_1.height
		lw_active =  This.GetNextSheet(lw_active)
	ELSE
		Exit
	END IF
loop

end subroutine

public function long wf_getmdiwidth ();return mdi_1.width
end function

public function long wf_getmdiheight ();return mdi_1.height
end function

public subroutine wf_mdiborder ();setMDIClientBorder(handle(mdi_1), 3)
end subroutine

public subroutine wf_set_pgmid (string arg_pgmid);//******************************************************************//
// 프로그램명   : f_set_pgmid		                                   //
// 프로그램설명 : MDI WIndow 하단에 Active Window Id를 Display 한다.//
// 작성일자     : 2000년 6월 12일                                   //
// 작성자명     : 이혜경                                            //
//																						  //
// Argument     : 없음						 								     //
// Return Code  : 없음                                              //
//******************************************************************//

//w_hanamainMain.dw_msg.SetItem(1, 'pgm', arg_PgmId)
This.dw_msg.SetItem(1, 'pgm', arg_PgmId)
end subroutine

public subroutine wf_set_message (string as_info, string a_msg);Choose case Upper(as_info)
	case 'ERROR'
		This.dw_msg.object.msg_t.Background.Color = Long(gf_getpbcolor(errorcolor))
	case 'INFO'
		This.dw_msg.object.msg_t.Background.Color = Long(gf_getpbcolor(inforcolor))
	case ELSE
		This.dw_msg.object.msg_t.Background.Color = Long(gf_getpbcolor(defaultcolor))
End Choose
This.dw_msg.SetItem(1, 'msg', a_msg)
end subroutine

public subroutine wf_menufix ();//SSC신규 추가 함수 ..
IF ib_menufix THEN
	wf_show(ii_select)
ELSE
	wf_hide()
END IF

end subroutine

public function w_base wf_opensheet (string as_title, string as_winname, string as_pgmno);//V1.9.9.012_  return을 위하여 추가 시켰다.
w_base		lw_return

//V1.9.9.012_  select가 있는지 찾기 위해서는 pgm_no로 찾아야 한다.
IF Not uo_tab.of_select(as_pgmno, lw_return) THEN
//=========================================
//IF Not uo_tab.of_select(as_winname) THEN
//=========================================
	
	//V1.9.9.012  return을 해주어야 한다.
	lw_return = uo_tab.of_opensheet(as_title, as_winname, as_pgmno)
	//======================================
	//uo_tab.of_opensheet(as_title, as_winname, as_pgmno)
	//======================================
END IF

//V1.9.9.012_  return을 위하여 추가 시켰다.
return lw_return

end function

public function w_base wf_opensheetparmlong (string as_title, string as_winname, string as_pgmno, long al_arg);//V1.9.9.012_  return을 위하여 추가 시켰다.
w_base		lw_return

//V1.9.9.012_  select가 있는지 찾기 위해서는 pgm_no로 찾아야 한다.
IF Not uo_tab.of_select(as_pgmno, lw_return) THEN
//=========================================
//IF Not uo_tab.of_select(as_winname) THEN
//=========================================

	//V1.9.9.012  return을 해주어야 한다.
	lw_return = uo_tab.of_opensheetparm(as_title, as_winname, as_pgmno, al_arg)
	//=======================================
	//uo_tab.of_opensheetparm(as_title, as_winname, as_pgmno, al_arg)
	//=======================================
END IF

//V1.9.9.012_  return을 위하여 추가 시켰다.
return lw_return
end function

public function w_base wf_opensheetparmpob (string as_title, string as_winname, string as_pgmno, powerobject apo_arg);//V1.9.9.012_  return을 위하여 추가 시켰다.
w_base		lw_return

//V1.9.9.012_  select가 있는지 찾기 위해서는 pgm_no로 찾아야 한다.
IF Not uo_tab.of_select(as_pgmno, lw_return) THEN
//=========================================
//IF Not uo_tab.of_select(as_winname) THEN
//=========================================
	
	//V1.9.9.012  return을 해주어야 한다.
	lw_return = uo_tab.of_opensheetparm(as_title, as_winname, as_pgmno, apo_arg)
	//========================================
	//uo_tab.of_opensheetparm(as_title, as_winname, as_pgmno, apo_arg)
	//========================================
END IF

//V1.9.9.012_  return을 위하여 추가 시켰다.
return lw_return

end function

public function w_base wf_opensheetparmstring (string as_title, string as_winname, string as_pgmno, string as_arg);//V1.9.9.012_  return을 위하여 추가 시켰다.
w_base		lw_return

//V1.9.9.012_  select가 있는지 찾기 위해서는 pgm_no로 찾아야 한다.
IF Not uo_tab.of_select(as_pgmno, lw_return) THEN
//=========================================
//IF Not uo_tab.of_select(as_winname) THEN
//=========================================

	//V1.9.9.012  return을 해주어야 한다.
	lw_return = uo_tab.of_opensheetparm(as_title, as_winname, as_pgmno, as_arg)
	//=======================================
	//uo_tab.of_opensheetparm(as_title, as_winname, as_pgmno, as_arg)
	//=======================================
END IF

//V1.9.9.012_  return을 위하여 추가 시켰다.
return lw_return
end function

on w_mdi.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.mdi_1=create mdi_1
this.p_buttomline=create p_buttomline
this.p_leftline=create p_leftline
this.st_start=create st_start
this.st_end=create st_end
this.dw_msg=create dw_msg
this.uo_toolbar=create uo_toolbar
this.st_resize=create st_resize
this.uo_tab=create uo_tab
this.st_temp=create st_temp
this.uo_menu=create uo_menu
this.uo_leftmenu=create uo_leftmenu
this.Control[]={this.mdi_1,&
this.p_buttomline,&
this.p_leftline,&
this.st_start,&
this.st_end,&
this.dw_msg,&
this.uo_toolbar,&
this.st_resize,&
this.uo_tab,&
this.st_temp,&
this.uo_menu,&
this.uo_leftmenu}
end on

on w_mdi.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.p_buttomline)
destroy(this.p_leftline)
destroy(this.st_start)
destroy(this.st_end)
destroy(this.dw_msg)
destroy(this.uo_toolbar)
destroy(this.st_resize)
destroy(this.uo_tab)
destroy(this.st_temp)
destroy(this.uo_menu)
destroy(this.uo_leftmenu)
end on

event open;wf_mdiborder()
gw_mdi = This
st_resize.of_setobject( uo_menu, st_temp, "H")

//V1.9.9.022   Menufix를 자동 저장 하게 하는 요청\이 들어옴.
Vector		lvc_data
lvc_data = Create Vector
lvc_data.importfile("menufix.prop")
Choose Case lvc_data.getProperty("menufixed")
	CASE 'true'
		ib_menufix = true
	CASE 'false'
		ib_menufix = false
	CASE ELSE
END CHoose
Destroy lvc_data
//====================================

This.Post Event ue_postopen()
end event

event resize;/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 리사이즈시 또 조회 및 불필요한 스크립터 반복수행
		 작업 = ib_resize check
	작업자  : 김영재 송상철
====================================*/
IF ib_resize THEN
	This.wf_resize()
END IF
//uo_1.of_resize()
end event

type mdi_1 from mdiclient within w_mdi
long BackColor=16777215
end type

type p_buttomline from picture within w_mdi
integer x = 4631
integer y = 584
integer width = 5
integer height = 8
string picturename = "..\img\tlr_style\thema_1\buttomline.gif"
boolean focusrectangle = false
end type

type p_leftline from picture within w_mdi
integer x = 4631
integer y = 476
integer width = 9
integer height = 4
string picturename = "..\img\tlr_style\thema_1\rightline.gif"
boolean focusrectangle = false
end type

type st_start from statictext within w_mdi
integer x = 4622
integer y = 240
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_end from statictext within w_mdi
integer x = 4622
integer y = 172
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
boolean focusrectangle = false
end type

type dw_msg from datawindow within w_mdi
integer y = 2648
integer width = 3666
integer height = 68
integer taborder = 30
string dataobject = "d_message_main"
boolean border = false
boolean livescroll = true
end type

event resize;String 	ls_syntax
Long		ll_x, ll_temp, ll_msg

ll_msg = This.height - Long(This.Describe("msg_t.height"))

ls_syntax += ' ~n '  + "Datawindow.Detail.Height=" + String(this.height)
ls_syntax += ' ~n '  + "msg_t.y=" + String(ll_msg)
ls_syntax += ' ~n '  + "pgm_t.y=" + String(ll_msg)
ls_syntax += ' ~n '  + "p_m.y=" + String(ll_msg + PixelsToUnits(3, YPixelsToUnits!)) 
ls_syntax += ' ~n '  + "p_w.y=" + String(ll_msg + PixelsToUnits(3, YPixelsToUnits!))
ls_syntax += ' ~n '  + "msg.y=" + String(ll_msg + PixelsToUnits(2, YPixelsToUnits!))
ls_syntax += ' ~n '  + "pgm.y=" + String(ll_msg + PixelsToUnits(2, YPixelsToUnits!))

//프로그램 사이즈
ll_x = This.width - Long(This.Describe("pgm_t.width"))
ll_temp = ll_x

ls_syntax += " ~n" + "pgm_t.x=" + String(ll_x)

ll_x = ll_x + PixelsToUnits(2, XPixelsToUnits!)
ls_syntax += " ~n" +"p_w.x=" + String(ll_x)

ll_x = ll_x + PixelsToUnits(2, XPixelsToUnits!) + Long(This.Describe("p_w.width"))
ls_syntax += " ~n" +"pgm.x=" + String(ll_x)

//Message
ls_syntax += " ~n" + "msg_t.x=0"

ll_x = ll_temp - PixelsToUnits(2, XPixelsToUnits!)
ls_syntax += " ~n" +"msg_t.width=" + String(ll_x)

ll_x = ll_x - PixelsToUnits(4, XPixelsToUnits!)
ls_syntax += " ~n" +"msg.width=" + String(ll_x)

This.Modify(ls_syntax)
end event

type uo_toolbar from u_toolbar within w_mdi
integer x = 5
integer width = 4626
integer height = 348
integer taborder = 40
end type

event ue_tree;call super::ue_tree;ib_menufix = Not ib_menufix

wf_resize()
end event

event ue_next;call super::ue_next;uo_tab.of_next()
end event

event ue_back;call super::ue_back;uo_tab.of_back()
end event

event ue_close;call super::ue_close;String ls_classname
window		lw_active

lw_active = Parent.GetActiveSheet()

Parent.SetRedRaw(False)
IF IsValid(lw_active) THEN 
	Close(lw_active)
END IF
Parent.SetRedRaw(True)
end event

on uo_toolbar.destroy
call u_toolbar::destroy
end on

type st_resize from uo_statictext within w_mdi
integer x = 2405
integer y = 516
integer width = 14
integer textsize = -11
integer weight = 700
string facename = "Tahoma"
string pointer = "SizeWE!"
long textcolor = 16777215
long backcolor = 16777215
alignment alignment = center!
long bordercolor = 16777215
end type

event ue_bottonup;call super::ue_bottonup;//SSC menufix 수정.
_ib_resize = False

//V1.9.9.013  menufix에 의한 수정.  위치 변경
//IF ib_menufix THEN
//	Parent.wf_resize()
//END IF

uo_menu.of_resize()
uo_leftmenu.width			= uo_leftmenu.x + uo_leftmenu.p_tree.x + uo_leftmenu.p_tree.width + uo_menu.width + PixelsToUnits(6 , XPixelsToUnits!) 
uo_leftmenu.of_resize()

st_resize.x 					= uo_leftmenu.x + uo_leftmenu.width
st_temp.x					= st_resize.x + st_resize.width

//V1.9.9.013  menufix에 의한 수정.  위치 변경
IF ib_menufix THEN
	Parent.wf_resize()
END IF

uo_tab.of_resizetab()



end event

event ue_bottondown;call super::ue_bottondown;_ib_resize = True
end event

type uo_tab from u_tooltab within w_mdi
event resize pbm_size
integer y = 356
integer width = 2551
integer height = 132
integer taborder = 20
end type

on uo_tab.destroy
call u_tooltab::destroy
end on

type st_temp from statictext within w_mdi
boolean visible = false
integer x = 983
integer y = 176
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type uo_menu from u_treememu within w_mdi
boolean visible = false
integer x = 128
integer y = 516
integer height = 2096
integer taborder = 30
boolean bringtotop = true
end type

event ue_selectionchanged;call super::ue_selectionchanged;/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 같은윈도우  여러개 실행하기
		 작업 = pgm_id 를 pgm_no로 수정.
	작업자  : 김영재 송상철
====================================*/
//IF Not uo_tab.of_select( astr_tree.pgm_id) THEN
IF Not uo_tab.of_select( astr_tree.pgm_no) THEN
//====================================

	IF astr_tree.pgm_kd = "P" THEN
		IF uo_tab.of_createtab(astr_tree) < 0 THEN
			Messagebox("Info", astr_tree.pgm_nm + "이 등록 되지 않았습니다. ~r~n등록 후 사용 하시기 바랍니다.")
		ELSE
			/*====================================
				V1.9.9 Bug Fix
				작업내용
					 현상 = 같은윈도우  여러개 실행하기
					 작업 = pgm_id 를 pgm_no로 수정.
				작업자  : 김영재 송상철
			====================================*/
			//uo_tab.of_select(astr_tree.pgm_id)
			uo_tab.of_select(astr_tree.pgm_no)
			//====================================

			//V1.9.9.012  Menu 더블 클릭시 바로 닫히게 하기.
			IF NOt ib_menufix AND ib_dbclk_hide THEN
				wf_hide()
			END IF
			//================================
		END IF
	END IF
END IF
end event

on uo_menu.destroy
call u_treememu::destroy
end on

event constructor;call super::constructor;/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 리사이즈시 또 조회 및 불필요한 스크립터 반복수행
		 작업 = visible를 false로 수정.
	작업자  : 김영재 송상철
====================================*/
end event

event ue_menufix;call super::ue_menufix;//SSC menufix
//V1.9.9.014  Appeon에서는 지시자의 불명확성으로 인하여 동작을 하지 않음.
parent.ib_menufix = ab_menufix
//====================
//ib_menufix = ab_menufix
//====================

//V1.9.9.022   Menufix를 자동 저장 하게 하는 요청\이 들어옴.
Vector		lvc_data
lvc_data = Create Vector
lvc_data.setProperty("menufixed", String(ab_menufix))
lvc_data.exportfile("menufix.prop")
Destroy lvc_data
//====================================

IF ab_menufix THEN
	wf_ondisplay()
ELSE
	wf_menufix()
END IF

wf_resize()

end event

type uo_leftmenu from u_leftmenu within w_mdi
event destroy ( )
integer x = 5
integer y = 500
integer taborder = 40
end type

on uo_leftmenu.destroy
call u_leftmenu::destroy
end on

event ue_treeview;call super::ue_treeview;Long		ll_x1, ll_y1, ll_x2, ll_y2, ll_posx, ll_posy
Boolean		lb_tf

IF Not ib_menubar THEN
	IF Not ib_menufix THEN
		//IF xpos > 0 AND xpos < this.width AND ypos > 0 AND ypos < this.height THEN
			IF Not ib_show THEN
				wf_show(uo_menu.MENUTREE)
				uo_menu.SetFocus()
				uo_menu.of_resize()
			END IF
	
			IF ii_select <> uo_menu.MENUTREE THEN
				//ii_select = uo_menu.MENUTREE
				wf_hide()
			END IF
		//END IF
	ELSE
		IF ib_menufix THEN uo_menu.of_selecttab( uo_menu.MENUTREE )
	END IF
END IF

ib_menubar = false

Parent.SetRedRaw(True)
end event

event ue_bookmark;call super::ue_bookmark;IF Not ib_menufix THEN
//	IF xpos > 0 AND xpos < this.width AND ypos > 0 AND ypos < this.height THEN
		IF Not ib_show THEN
			wf_show(uo_menu.BOOKMARK)
			uo_menu.SetFocus()
			uo_menu.of_resize()
		END IF
		
		IF ii_select <> uo_menu.BOOKMARK THEN
			//ii_select = uo_menu.BOOKMARK
			wf_hide()
		END IF
//	END IF
ELSE
	uo_menu.of_selecttab( uo_menu.BOOKMARK )
END IF

Parent.SetRedRaw(True)

end event

event ue_popbookmark;call super::ue_popbookmark;OpenWithparm(w_bookmark, '')

uo_menu.of_bookmark()
end event

