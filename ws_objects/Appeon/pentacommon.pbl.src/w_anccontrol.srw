$PBExportHeader$w_anccontrol.srw
forward
global type w_anccontrol from window
end type
end forward

global type w_anccontrol from window
integer width = 869
integer height = 864
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
event ue_postopen ( )
event ue_checkpoint ( )
end type
global w_anccontrol w_anccontrol

type prototypes
Function boolean AnimateWindow(long lhWnd, long lTm, long lFlags ) library 'user32.dll'
FUNCTION ulong SetCapture(ulong hwnd) LIBRARY "user32.dll"
FUNCTION ulong ReleaseCapture() LIBRARY "user32.dll"
FUNCTION boolean GetCursorPos(REF POINT ipPoint) LIBRARY "user32.dll"
FUNCTION boolean ScreenToClient(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
end prototypes

type variables
Protected :
	/*====================================
		V1.9.9 Bug Fix
		작업내용
			 현상 = Appeon6에서 Animation이 실행 되지 않음.
			 작업 = AnimationTime이 이미 정의되어 있는 문자 이기 때문에 AnimationTime을 AnimatTime으로 변경.
		작업자  : 김영재 송상철
	====================================*/
	long 			AnimatTime = 180
	//====================================
	
	integer 		Orientation = 1
	Vector			ivc_data
	Decimal			INTERVAL		= 1	
	
	Long			tempwidth = 0
	Long			tempheight = 0
Private :
	n_timing		in_timer
	Boolean			ib_close = false
	Boolean			ib_winclose = true
Public :
	CONSTANT Integer	TOP2BUTTOM = 1
	CONSTANT Integer	BUTTOM2TOP = 2
	CONSTANT Integer	LEFT2RIGHT = 3
	CONSTANT Integer	RIGHT2LEFT = 4
	CONSTANT Integer	TOPRIGHT2BUTTOMLEFT = 5
	CONSTANT Integer	BUTTOMRIGHT2TOPLEFT = 6
	
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
	CONSTANT ulong DT_CENTER                   		= 1      								//0x00000001
	CONSTANT ulong DT_RIGHT                    		= 2      									//0x00000002
	CONSTANT ulong DT_VCENTER                  	= 4      									//0x00000004
	CONSTANT ulong DT_BOTTOM                   	= 8      									//0x00000008
	CONSTANT ulong DT_WORDBREAK               = 16     								//0x00000010
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
public subroutine wf_ondisplay ()
protected function long wf_getanimationflags (boolean ab_hide)
public subroutine wf_show ()
public subroutine wf_hide (vector avc_data)
public subroutine wf_beforclose ()
public subroutine wf_afteropen ()
end prototypes

event ue_postopen();this.setposition(totop!)
wf_show()
end event

event ue_checkpoint();POINT lp, lcp
ulong ll
ulong lul

lul = Handle(This)

IF GetCursorPos(lp) THEN
	IF Screentoclient(lul, lp) THEN
		IF lp.x  < 0 OR lp.x > UnitsToPixels(this.width + tempwidth, XUnitsToPixels!) OR lp.y  < 0 OR lp.y > UnitsToPixels(this.height + tempheight, YUnitsToPixels!) THEN
			//check if parent has mouse
			ib_close = true
			wf_hide(ivc_data)
		END IF	
	END IF
END IF
end event

public subroutine wf_ondisplay ();IF Not IsValid(in_timer) THEN
	in_timer = CREATE n_timing
	in_timer.event ke_setparent(this, "ue_checkpoint")
	in_timer.Start(INTERVAL)
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
	CASE 2 //bottom
		IF ab_hide THEN
			ll_ret = AW_SLIDE + AW_VER_POSITIVE + AW_HIDE
		ELSE
			ll_ret = AW_SLIDE + AW_VER_NEGATIVE + AW_ACTIVATE
		END IF
	CASE 3 //left
		IF ab_hide THEN
			ll_ret = AW_SLIDE + AW_HOR_NEGATIVE + AW_HIDE
		ELSE
			ll_ret = AW_SLIDE + AW_HOR_POSITIVE + AW_ACTIVATE
		END IF
	CASE 4 //right
		IF ab_hide THEN
			ll_ret = AW_SLIDE + AW_HOR_POSITIVE + AW_HIDE
		ELSE
			ll_ret = AW_SLIDE + AW_HOR_NEGATIVE + AW_ACTIVATE
		END IF
	CASE 5 //topleft
		IF ab_hide THEN
			ll_ret = AW_SLIDE + AW_VER_NEGATIVE + AW_HOR_NEGATIVE  + AW_HIDE
		ELSE
			ll_ret = AW_SLIDE + AW_VER_POSITIVE + AW_HOR_POSITIVE + AW_ACTIVATE
		END IF
	CASE 6 //buttomleft
		IF ab_hide THEN
			ll_ret = AW_SLIDE + AW_VER_NEGATIVE + AW_HOR_POSITIVE + AW_HIDE
		ELSE
			ll_ret = AW_SLIDE + AW_VER_POSITIVE + AW_HOR_NEGATIVE  + AW_ACTIVATE
		END IF
END CHOOSE

RETURN ll_ret
end function

public subroutine wf_show ();/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = Appeon6에서 Animation이 실행 되지 않음.
		 작업 = AnimationTime이 이미 정의되어 있는 문자 이기 때문에 AnimationTime을 AnimatTime으로 변경.
	작업자  : 김영재 송상철
====================================*/
AnimateWindow(Handle(This), AnimatTime, wf_GetAnimationFlags(False))
//====================================

wf_afteropen()

This.Show()

This.setRedraw(True)

wf_ondisplay()
end subroutine

public subroutine wf_hide (vector avc_data);/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = Appeon6에서 Animation이 실행 되지 않음.
		 작업 = AnimationTime이 이미 정의되어 있는 문자 이기 때문에 AnimationTime을 AnimatTime으로 변경.
	작업자  : 김영재 송상철
====================================*/
wf_beforclose()

AnimateWindow(Handle(this), AnimatTime, wf_GetAnimationFlags(TRUE))
//====================================
//this.hide()

IF ib_winclose THEN
	IF ib_close THEN
		Close(this)
	ELSE
		CloseWithReturn(This, avc_data)
	END IF
END IF
end subroutine

public subroutine wf_beforclose ();
end subroutine

public subroutine wf_afteropen ();
end subroutine

on w_anccontrol.create
end on

on w_anccontrol.destroy
end on

event open;long				ll_x, ll_y, ll_width, ll_height, ll_thisx, ll_thisy
Long				ll_pospw, ll_postw, ll_posph, ll_posth
ulong			lul
POINT 			lp
vector			vc
Boolean			lb_true

vc = Message.PowerObjectParm
IF IsValid(vc) THEN
	ll_x = long(vc.getproperty('x'))
	ll_y = long(vc.getproperty('y'))
	ll_width = Long(vc.getproperty('width'))
	ll_height = Long(vc.getProperty('height'))
	IF vc.getProperty('winclose') = 'false' THEN
		ib_winclose = false
	END IF
	
	IF Not (this.windowType = child!) THEN
		lul = Handle(This)
		IF GetCursorPos(lp) THEN
			IF Screentoclient(lul, lp) THEN
				
				ll_pospw = ParentWindow ( ).x + ParentWindow ( ).width
				ll_posph = ParentWindow ( ).y + ParentWindow ( ).height
				
				ll_thisx = pixelstounits(lp.x + 2, xpixelstounits!) - ll_x
				ll_thisy = pixelstounits(lp.y + 5, ypixelstounits!) + ll_y
				
				ll_postw = ll_thisx + this.width
				ll_posth = ll_thisy + this.height
				
				IF ll_postw > ll_pospw THEN
					this.x = ll_thisx - (ll_postw - ll_pospw) - pixelsToUnits(2, XPixelsToUnits!)
				ELSE
					this.x = ll_thisx
				END IF
				
				IF ll_posth > ll_posph THEN
					this.y = ll_thisy - (this.height + ll_height) - pixelstounits(5, ypixelstounits!)
					CHOOSE CASE Orientation
						CASE TOP2BUTTOM
							Orientation = BUTTOM2TOP
						CASE TOPRIGHT2BUTTOMLEFT
							Orientation = BUTTOMRIGHT2TOPLEFT
					END CHOOSE
				ELSE
					this.y = ll_thisy
				END IF
				
			END IF
		END IF
	ELSE
		this.x = ll_x
		this.y = ll_y
		this.height = ll_height
	END IF
END IF

this.hide( )
ivc_data = Create Vector

this.Post Event ue_postopen()
end event

event key;Choose Case key
	Case KeyEscape!
		Close(This)
End Choose
end event

event closequery;IF ISVALID(in_timer) THEN
	in_timer.Stop()
	DESTROY in_timer
END IF

end event

