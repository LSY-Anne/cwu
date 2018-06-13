$PBExportHeader$w_sub_mdi.srw
forward
global type w_sub_mdi from window
end type
type mdi_1 from mdiclient within w_sub_mdi
end type
type ole_proxy from olecustomcontrol within w_sub_mdi
end type
type dw_msg from datawindow within w_sub_mdi
end type
type uo_tab from u_tooltab within w_sub_mdi
end type
end forward

global type w_sub_mdi from window
integer width = 4718
integer height = 3128
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
mdi_1 mdi_1
ole_proxy ole_proxy
dw_msg dw_msg
uo_tab uo_tab
end type
global w_sub_mdi w_sub_mdi

type prototypes
Function boolean AnimateWindow(long lhWnd, long lTm, long lFlags ) library 'user32.dll'
FUNCTION ulong SetCapture(ulong hwnd) LIBRARY "user32.dll"
FUNCTION ulong ReleaseCapture() LIBRARY "user32.dll"
FUNCTION boolean GetCursorPos(REF POINT ipPoint) LIBRARY "user32.dll"
FUNCTION boolean ScreenToClient(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"

FUNCTION ulong RealChildWindowFromPoint (ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
FUNCTION ulong ChildWindowFromPoint(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"

Function Long setMDIClientBorder( ulong hWnd, long index ) library "pbaddon.dll"
end prototypes

type variables

end variables

forward prototypes
public subroutine wf_resize ()
public subroutine wf_select (string as_win)
public subroutine wf_destroywin (string as_winname)
public subroutine wf_sheetresize ()
public function long wf_getmdiwidth ()
public function long wf_getmdiheight ()
public subroutine wf_mdiborder ()
public function integer wf_findwindow (string as_windowname, str_tree astr_tree)
public subroutine wf_set_message (string as_info, string a_msg)
public subroutine wf_set_pgmid (string arg_pgmid)
public function w_base wf_opensheet (string as_title, string as_winname, string as_pgmno, powerobject apbo_arg)
public function w_base wf_opensheetparmlong (string as_title, string as_winname, string as_pgmno, long al_arg)
public function w_base wf_opensheetparmpob (string as_title, string as_winname, string as_pgmno, powerobject apo_arg)
public function w_base wf_opensheetparmstring (string as_title, string as_winname, string as_pgmno, string as_arg)
end prototypes

event ue_postopen();window lw_mdi
lw_mdi = this
gw_mdi = lw_mdi

This.Post wf_resize()
end event

public subroutine wf_resize ();Long   ll_dwheight, ll_wkw, ll_wkh
IF dw_msg.visible THEN
	ll_dwheight = dw_msg.height + PixelsToUnits(2, YPixelsToUnits!)
END IF
ll_wkw 	= this.workspacewidth( )
ll_wkh  	= This.workspaceheight( )

uo_tab.x = PixelsToUnits(2, XPixelsToUnits!)
uo_tab.y = PixelsToUnits(3, YPixelsToUnits!)
uo_tab.width 	= ll_wkw
uo_tab.of_resizetab()

mdi_1.x = uo_tab.x
mdi_1.y = uo_tab.y + uo_tab.height
mdi_1.width  	= ll_wkw

IF dw_msg.visible THEN
	dw_msg.x = uo_tab.x
	dw_msg.y = ll_wkh - dw_msg.height - PixelsToUnits(2, YPixelsToUnits!)
	dw_msg.width = ll_wkw
END IF

mdi_1.height = ll_wkh - mdi_1.y  - PixelsToUnits(2, YPixelsToUnits!)  - ll_dwheight

ole_proxy.y = this.height - 100

wf_sheetresize()
end subroutine

public subroutine wf_select (string as_win);uo_tab.of_select(as_win)
end subroutine

public subroutine wf_destroywin (string as_winname);IF uo_tab.ib_close THEN
	uo_tab.of_destroytab( as_winname)
END IF
end subroutine

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

public function integer wf_findwindow (string as_windowname, str_tree astr_tree);return -1
end function

public subroutine wf_set_message (string as_info, string a_msg);Choose case Upper(as_info)
	case 'ERROR'
		This.dw_msg.object.msg_t.Background.Color = rgb(255,0,0)
	case 'INFO'
		This.dw_msg.object.msg_t.Background.Color = rgb(0,0,255)
	case ELSE
		This.dw_msg.object.msg_t.Background.Color = rgb(218,218,218)
End Choose
This.dw_msg.SetItem(1, 'msg', a_msg)
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

public function w_base wf_opensheet (string as_title, string as_winname, string as_pgmno, powerobject apbo_arg);//V1.9.9.012_  return을 위하여 추가 시켰다.
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

on w_sub_mdi.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.mdi_1=create mdi_1
this.ole_proxy=create ole_proxy
this.dw_msg=create dw_msg
this.uo_tab=create uo_tab
this.Control[]={this.mdi_1,&
this.ole_proxy,&
this.dw_msg,&
this.uo_tab}
end on

on w_sub_mdi.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.ole_proxy)
destroy(this.dw_msg)
destroy(this.uo_tab)
end on

event open;wf_mdiborder()
This.Post Event ue_postopen()
end event

event resize;This.wf_resize()
end event

event closequery;uo_tab.ib_close = False
end event

type mdi_1 from mdiclient within w_sub_mdi
long BackColor=16777215
end type

type ole_proxy from olecustomcontrol within w_sub_mdi
boolean visible = false
integer x = 1856
integer y = 196
integer width = 1550
integer height = 1156
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_sub_mdi.win"
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
end type

type dw_msg from datawindow within w_sub_mdi
boolean visible = false
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

//프로그램 사이즈
ll_x = This.width - Long(This.Describe("pgm_t.width")) - PixelsToUnits(3, XPixelsToUnits!)
ll_temp = ll_x

ls_syntax += " ~n" + "pgm_t.x=" + String(ll_x)

ll_x = ll_x + PixelsToUnits(2, XPixelsToUnits!)
ls_syntax += " ~n" +"p_w.x=" + String(ll_x)

ll_x = ll_x + PixelsToUnits(2, XPixelsToUnits!) + Long(This.Describe("p_w.width"))
ls_syntax += " ~n" +"pgm.x=" + String(ll_x)

//시간 사이즈.
ll_x = ll_temp - Long(This.Describe("td_t.width")) - PixelsToUnits(3, XPixelsToUnits!)
ll_temp = ll_x

ls_syntax += " ~n" +"td_t.x=" + String(ll_x)

ll_x = ll_x + PixelsToUnits(2, XPixelsToUnits!)
ls_syntax += " ~n" +"p_d.x=" + String(ll_x)

ll_x = ll_x + PixelsToUnits(2, XPixelsToUnits!) + Long(This.Describe("p_d.width"))
ls_syntax += " ~n" +"td.x=" + String(ll_x)

//user
ll_x = ll_temp - Long(This.Describe("user_t.width")) - PixelsToUnits(3, XPixelsToUnits!)
ll_temp = ll_x

ls_syntax += " ~n" +"user_t.x=" + String(ll_x)

ll_x = ll_x +  PixelsToUnits(2, XPixelsToUnits!)
ls_syntax += " ~n" +"p_u.x=" + String(ll_x)

ll_x = ll_x + PixelsToUnits(2, XPixelsToUnits!) + Long(This.Describe("p_u.width"))
ls_syntax += " ~n" +"user.x=" + String(ll_x)

//message
ll_msg = PixelsToUnits(3, XPixelsToUnits!)
ls_syntax += " ~n" + "mg_t.x=" + String(ll_msg)

ll_msg = Long(This.Describe("mg_t.width")) + ll_msg + PixelsToUnits(3, XPixelsToUnits!)
ls_syntax += " ~n" + "msg_t.x=" + String(ll_msg)

ll_x = ll_temp - PixelsToUnits(3, XPixelsToUnits!) - ll_msg

ls_syntax += " ~n" +"msg_t.width=" + String(ll_x)

ll_x = ll_x - PixelsToUnits(4, XPixelsToUnits!)
ls_syntax += " ~n" +"msg.width=" + String(ll_x)

This.Modify(ls_syntax)

end event

type uo_tab from u_tooltab within w_sub_mdi
event resize pbm_size
integer width = 2551
integer height = 132
integer taborder = 20
end type

on uo_tab.destroy
call u_tooltab::destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
00w_sub_mdi.bin 
2200000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000040e2127001cac01e00000003000000800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003454cffd6451860e4a40a4d987a4ec8730000000040e2127001cac01e40e2127001cac01e000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000010000000c00000000fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000003000000230900001dde006600200061006c007300670020002c006e0069006500740065006700200072007000780073006f0020002c006e006900650074000003000000230900001dde0073006f00290020002000200065007200750074006e007200200073006f006c0067006e005b002000620070005f006d0062006c00740075006f00740075006e005d0070006f0000006500700020006e00200028002000290072002000740065007200750073006e006c0020006e006f002000670070005b006d0062006f005f00650070005d006e006f0000006800740072006500280020007500200073006e006700690065006e006c0064006e006f002000670070007700720061006d00610020002c006f006c0067006e006c002000610070006100720020006d002000290072002000740065007200750073006e006c0020006e006f002000670070005b006d0062006f005f00680074007200650000005d000024fc0000000000002514000000000000253800000000000025500000000000002574000000000000259a00000000000025b400000000000025c600000000000025e40000000000002606000000000000261e0000000000002648000000000000266e000000000000268c00000000000026a600000000000026ca00000000000026ea000000000000270c0000000000002740000000000000275e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10w_sub_mdi.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
