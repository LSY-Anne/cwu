$PBExportHeader$nvo_tooltip.sru
$PBExportComments$꼇옵柬ToolTip痰빵뚤蹶
forward
global type nvo_tooltip from nonvisualobject
end type
type rect from structure within nvo_tooltip
end type
type toolinfo from structure within nvo_tooltip
end type
type point from structure within nvo_tooltip
end type
type msg from structure within nvo_tooltip
end type
type size from structure within nvo_tooltip
end type
type initcommoncontrols from structure within nvo_tooltip
end type
end forward

type rect from structure
	long		left
	long		top
	long		right
	long		bottom
end type

type toolinfo from structure
	long		cbsize
	long		uflags
	long		hwnd
	long		uid
	rect		rect
	long		hinstance
	long		lpsztext
end type

type point from structure
	long		x
	long		y
end type

type msg from structure
	long		hwnd
	long		message
	long		wparam
	long		lparam
	long		time
	point		pt
end type

type size from structure
	long		l_x
	long		l_y
end type

type initcommoncontrols from structure
	unsignedlong		dwsize
	unsignedlong		dwicc
end type

global type nvo_tooltip from nonvisualobject autoinstantiate
end type

type prototypes
//繫痰왠숭땡檄욋놓迦뺏변鑒
FUNCTION Boolean InitCommonControlsEx( REF INITCOMMONCONTROLS LPINITCOMMONCONTROLS) LIBRARY "comctl32.dll" alias for "InitCommonControlsEx"

//Win32 눗왯변鑒
FUNCTION Long CreateWindowEx( uLong dwExStyle, String lpClassName, String lpWindowName, uLong dwStyle, Long xPos, Long yPos, Long nWidth, Long nHeight, Long hWndParent, Long hMenu, Long hInstance, Long lpParam ) LIBRARY "user32" ALIAS FOR "CreateWindowExW"
FUNCTION Boolean DestroyWindow( Long hWnd ) LIBRARY "user32"

//句口뇹잿변鑒
Function Long ToolTipMsg(Long hWnd, Long uMsg, Long wParam, REF TOOLINFO ToolInfo) LIBRARY "user32.dll" ALIAS FOR "SendMessageW"
Function Long RelayMsg(Long hWnd, Long uMsg, Long wParam, REF MSG Msg) LIBRARY "user32.dll" ALIAS FOR "SendMessageW"
Function uLong SendMessageString( uLong hwnd, uLong Msg, uLong wParam, Ref String lpzString ) Library "user32.dll" ALIAS FOR "SendMessageW"

//코닸밗잿변鑒
Function Long LocalAlloc(Long Flags, Long Bytes) LIBRARY "kernel32.dll"
Function Long LocalFree(Long MemHandle) LIBRARY "kernel32.dll"
Function Long lstrcpy(Long Destination, String Source) LIBRARY "kernel32.dll" alias for "lstrcpy;ansi"






end prototypes

type variables
PUBLIC:
Long 		hWndTT		// Tooltip
Long 		ToolID = 1	//Tooltip코꼬ID
uLong		iul_Handle[]

//깃痙暠깃끽좆
CONSTANT Long TTI_NONE 		= 0
CONSTANT Long TTI_INFO 		= 1
CONSTANT Long TTI_WARNING 	= 2
CONSTANT Long TTI_ERROR 	= 3

PRIVATE:
//왠숭잚츰섟눗왯끽좆
CONSTANT String TOOLTIPS_CLASS	= 'tooltips_class32'
CONSTANT Long 	CW_USEDEFAULT		= 2147483648
CONSTANT Long 	WM_USER 				= 1024
CONSTANT Long 	WS_EX_TOPMOST		= 8
CONSTANT Long  WM_SETFONT        = 48
CONSTANT Long  WM_GETFONT        = 49

//InitCommonControlsEX써뭐놓迦뺏왠숭잚끽좆 
PROTECTED CONSTANT Long ICC_LISTVIEW_CLASSES	= 1	
PROTECTED CONSTANT Long ICC_TREEVIEW_CLASSES	= 2	
PROTECTED CONSTANT Long ICC_BAR_CLASSES		= 4	
PROTECTED CONSTANT Long ICC_TAB_CLASSES		= 8	
PROTECTED CONSTANT Long ICC_UPDOWN_CLASS		= 16	
PROTECTED CONSTANT Long ICC_PROGRESS_CLASS	= 32	
PROTECTED CONSTANT Long ICC_HOTKEY_CLASS		= 64	
PROTECTED CONSTANT Long ICC_ANIMATE_CLASS		= 128	
PROTECTED CONSTANT Long ICC_WIN95_CLASSES		= 255	
PROTECTED CONSTANT Long ICC_DATE_CLASSES		= 256	
PROTECTED CONSTANT Long ICC_USEREX_CLASSES	= 512	
PROTECTED CONSTANT Long ICC_COOL_CLASSES		= 1024	

//ToolTip句口
CONSTANT Long TTM_ADDTOOL 				= WM_USER + 4
CONSTANT Long TTM_DELTOOL 				= WM_USER + 5
CONSTANT Long TTM_NEWTOOLRECT			= WM_USER + 6
CONSTANT Long TTM_RELAYEVENT 			= WM_USER + 7
CONSTANT Long TTM_UPDATETIPTEXT		= WM_USER + 12
CONSTANT Long TTM_TRACKACTIVATE		= WM_USER + 17
CONSTANT Long TTM_TRACKPOSITION		= WM_USER + 18
CONSTANT Long TTM_SETMAXTIPWIDTH		= 1048
CONSTANT Long TTM_GETMAXTIPWIDTH		= WM_USER + 25
CONSTANT Long TTM_SETTIPBKCOLOR		= WM_USER + 19
CONSTANT Long TTM_SETTIPTEXTCOLOR	= WM_USER + 20
CONSTANT Long TTM_SETTITLEA 			= WM_USER + 32

//Tooltip깃街
CONSTANT Long TTF_CENTERTIP 	= 2
CONSTANT Long TTF_RTLREADING	= 4
CONSTANT Long TTF_SUBCLASS		= 16
CONSTANT Long TTF_TRACK			= 32
CONSTANT Long TTF_ABSOLUTE		= 128
CONSTANT Long TTF_TRANSPARENT	= 256
CONSTANT Long TTF_DI_SETITEM	= 32768
CONSTANT Long TTS_BALLOON 		= 64




end variables

forward prototypes
public function long of_getfont ()
public subroutine of_create ()
public function integer of_removetool (dragobject ado_object, integer ai_toolid)
public subroutine of_relaymsg (dragobject ado_object)
public subroutine of_setfont (long hfont)
public subroutine of_setmaxwidth (long al_maxwidth)
public subroutine of_settipbkcolor (unsignedlong aul_color)
public subroutine of_settiptextcolor (unsignedlong aul_color)
public subroutine of_settipposition (integer ai_x, integer ai_y)
public subroutine of_settiptext (dragobject ado_object, long al_uid, long al_tiptext)
public subroutine of_settiptext (dragobject ado_object, long al_uid, string as_tiptext)
public function integer of_addtool (dragobject ado_object, string as_tiptext, integer ai_flags)
public subroutine of_settiptitle (integer ai_icon, string as_title)
public subroutine of_settrack (dragobject ado_object, integer ai_uid, boolean ab_status)
public subroutine of_updatetiprect (dragobject ado_object, long al_uid, long al_left, long al_top, long al_right, long al_bottom)
end prototypes

public function long of_getfont ();uLong			lul_Font

lul_Font = Send( hWndTT, WM_GETFONT, 0, 0 )

Return lul_Font
end function

public subroutine of_create ();hWndTT = CreateWindowEx( 					&
	WS_EX_TOPMOST,							&
	TOOLTIPS_CLASS,							&
	"", 												&
	TTF_CENTERTIP + TTS_BALLOON + 1, 	&
	CW_USEDEFAULT, CW_USEDEFAULT, 	&
	CW_USEDEFAULT, CW_USEDEFAULT,	&
	0,													&
	0,													&
	Handle(GetApplication()),					&
	0 													)


end subroutine

public function integer of_removetool (dragobject ado_object, integer ai_toolid);TOOLINFO ToolInfo
Integer	li_Width, li_Height

ToolInfo.cbSize 	= 40
ToolInfo.uFlags 	= TTF_SUBCLASS 
ToolInfo.hWnd		= Handle( ado_Object )
ToolInfo.hInstance= 0 
ToolInfo.uID		= ai_ToolID
iul_Handle[ToolID] = ToolInfo.hWnd

ToolTipMsg( hWndTT, TTM_DELTOOL, 0, ToolInfo )

Return 1

end function

public subroutine of_relaymsg (dragobject ado_object);MSG Msg

Msg.hWnd		= Handle(ado_Object)
Msg.Message	= 512
Msg.WParam 	= Message.WordParm
Msg.LParam 	= Message.LongParm

RelayMsg(hWndTT,TTM_RELAYEVENT,0,Msg)


end subroutine

public subroutine of_setfont (long hfont);Send( hWndTT, WM_SETFONT, hFont, 1 )

end subroutine

public subroutine of_setmaxwidth (long al_maxwidth);Send( hWndTT, TTM_SETMAXTIPWIDTH, 0, UnitsToPixels( al_MaxWidth, xUnitsToPixels! ) )

Return
end subroutine

public subroutine of_settipbkcolor (unsignedlong aul_color);Send( hWndTT, TTM_SETTIPBKCOLOR, aul_Color, 0 )
end subroutine

public subroutine of_settiptextcolor (unsignedlong aul_color);Send( hWndTT, TTM_SETTIPTEXTCOLOR, aul_Color, 0 )
end subroutine

public subroutine of_settipposition (integer ai_x, integer ai_y);Send( hWndTT, TTM_TRACKPOSITION, 0, Long( ai_X, ai_Y ) )
end subroutine

public subroutine of_settiptext (dragobject ado_object, long al_uid, long al_tiptext);TOOLINFO ToolInfo

ToolInfo.hWnd		= Handle( ado_Object )
ToolInfo.uID		= al_uID
ToolInfo.lpszText	= al_TipText

ToolTipMsg( hWndTT, TTM_UPDATETIPTEXT, 0, ToolInfo )
end subroutine

public subroutine of_settiptext (dragobject ado_object, long al_uid, string as_tiptext);Long	lpszText

lpszText = LocalAlloc( 0, 2000 )
lStrCpy( lpszText, Left( as_TipText, 2000 ) )
of_SetTipText( ado_Object, al_uId, lpszText )

LocalFree( lpszText )
end subroutine

public function integer of_addtool (dragobject ado_object, string as_tiptext, integer ai_flags);TOOLINFO ToolInfo
Integer	li_Width, li_Height
 
ToolInfo.cbSize 	= 40
ToolInfo.uFlags 	= TTF_SUBCLASS
ToolInfo.hWnd		= Handle( ado_Object )
ToolInfo.hInstance= 0  
ToolInfo.uID		= ToolID

iul_Handle[ToolID] = ToolInfo.hWnd

ToolID++
ToolInfo.lpszText	= LocalAlloc( 0, 120 )
POST LocalFree( ToolInfo.lpszText ) 

lStrCpy( ToolInfo.lpszText, Left( as_tiptext, 120 ) )

ToolInfo.Rect.Left	= 0
ToolInfo.Rect.Top 	= 0
ToolInfo.Rect.Right	= UnitsToPixels( ado_Object.Width, XUnitsToPixels! )
ToolInfo.Rect.Bottom	= UnitsToPixels( ado_Object.Height, YUnitsToPixels! )

If ToolTipMsg( hWndTT, TTM_ADDTOOL, 0, ToolInfo ) = 0 Then
	MessageBox("INFO","Not Add ToolTip!",StopSign!,Ok!)
	Return( -1 )
End If

Return ( ToolID - 1 )

end function

public subroutine of_settiptitle (integer ai_icon, string as_title);SendMessageString( hWndTT, TTM_SETTITLEA, ai_Icon, as_Title )
end subroutine

public subroutine of_settrack (dragobject ado_object, integer ai_uid, boolean ab_status);TOOLINFO ToolInfo

ToolInfo.cbSize	= 40
ToolInfo.hWnd		= Handle( ado_Object )
ToolInfo.uID		= ai_uID

If ab_Status Then 
	ToolTipMsg( hWndTT, TTM_TRACKACTIVATE, 1, ToolInfo )
Else
	ToolTipMsg( hWndTT, TTM_TRACKACTIVATE, 0, ToolInfo )
End If
end subroutine

public subroutine of_updatetiprect (dragobject ado_object, long al_uid, long al_left, long al_top, long al_right, long al_bottom);TOOLINFO ToolInfo

ToolInfo.hWnd	= Handle( ado_Object )
ToolInfo.uID	= al_uID

ToolInfo.Rect.Left	= al_Left
ToolInfo.Rect.Top		= al_Top
ToolInfo.Rect.Right	= al_Right
ToolInfo.Rect.Bottom	= al_Bottom

ToolTipMsg( hWndTT, TTM_NEWTOOLRECT, 0, ToolInfo )

end subroutine

on nvo_tooltip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_tooltip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;INITCOMMONCONTROLS	lICC

lICC.dwSize = 2 * 4
lICC.dwICC	= ICC_TAB_CLASSES

InitCommonControlsEx( lICC )

This.of_Create()

RETURN 0





end event

event destructor;DestroyWindow(hWndTT)
end event

