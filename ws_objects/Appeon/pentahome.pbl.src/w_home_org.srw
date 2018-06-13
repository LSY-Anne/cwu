$PBExportHeader$w_home_org.srw
forward
global type w_home_org from w_base
end type
type p_setting from picture within w_home_org
end type
end forward

global type w_home_org from w_base
integer width = 3360
integer height = 2332
string title = "Home"
event ue_postopen ( )
event ue_openwindow ( vector vc )
p_setting p_setting
end type
global w_home_org w_home_org

type prototypes
Function long removeTitleBar( ulong hWnd, long index ) Library "pbaddon.dll"
end prototypes

type variables
Protected:
	Integer   _colcnt    			= 2   //	column갯수.
	Integer	_xpixelgab 			= 2
	Integer	_ypixelgab 			= 2
	Integer	_defualtcount
	
Private:
	n_openwithparm		in_open
	Integer	totalcnt
	vector		setmenu
	Userobject		iuo_data[]
	pentaservice		inv_svc
end variables

forward prototypes
public subroutine wf_setview ()
public subroutine openmenu (long xpos, long ypos, long wpos, long hpos, string as_key)
end prototypes

event ue_postopen();setmenu = Create vector
setmenu.importfile( 'setting.props')
totalcnt = setmenu.getkeycount( )
if totalcnt = 0 then
	setmenu.importfile( 'fulldatasetting.props')
	totalcnt = setmenu.getkeycount( )
end if

IF totalcnt > 0 THEN
	wf_setview()
END IF
end event

event ue_openwindow(vector vc);window		lw_win

IF UPPER(vc.getproperty("opentype")) = "POPUP" THEN
	openwithparm(lw_win, vc, vc.getproperty("window"),  this)
ELSE
	in_open.opensheetwithparm(vc.getproperty("window"), vc, this.ParentWindow ( ))
END IF
end event

public subroutine wf_setview ();long   ll_width , ll_height, ll_x, ll_y, ll_widthEnd
integer	li_hcnt, i, j, li_mod

this.setredraw(false)

li_hcnt	= truncate(totalcnt / _colcnt, 0)
li_mod	= Mod(totalcnt, _colcnt)
IF li_mod > 0 THEN
	li_hcnt ++
END IF

ll_width 		= truncate((this.width - PixelsToUnits(_xpixelgab * (_colcnt + 1), XPixelsToUnits!)) / _colcnt, 0) 
IF li_mod > 0 THEN  ll_widthEnd	= truncate((this.width - PixelsToUnits(_xpixelgab * (li_mod + 1), XPixelsToUnits!)) / li_mod , 0)

ll_height = truncate(((this.height - (p_setting.y + p_setting.height)) - pixelstounits(_ypixelgab * (li_hcnt + 1), ypixelstounits!)) / li_hcnt, 0 )

FOR i = 1 to li_hcnt
	if i > 1 then
		ll_y = ll_y + PixelsToUnits(_ypixelgab , YPixelsToUnits!) + ll_height
	else
		ll_y = PixelsToUnits(_ypixelgab, YPixelsToUnits!) + (p_setting.y + p_setting.height)
	end if
	
	if i = li_hcnt then
		_colcnt = totalcnt - (_colcnt * (li_hcnt - 1))
	end if
	
	IF li_hcnt = i AND li_mod > 0 THEN
		FOR j = 1 TO _colcnt
			if j > 1 then
				ll_x = ll_x + ll_widthEnd + PixelsToUnits(_xpixelgab , XPixelsToUnits!)
			else
				ll_x = PixelsToUnits(_xpixelgab, XPixelsToUnits!)
			end if
			openmenu(ll_x, ll_y, ll_widthEnd, ll_height, setmenu.getnextproperty( ) )
		NEXT
	ELSE
		FOR j = 1 TO _colcnt
			if j > 1 then
				ll_x = ll_x + ll_width + PixelsToUnits(_xpixelgab , XPixelsToUnits!)
			else
				ll_x = PixelsToUnits(_xpixelgab, XPixelsToUnits!)
			end if
			openmenu(ll_x, ll_y, ll_width, ll_height, setmenu.getnextproperty( ) )
		NEXT
	END IF
NEXT

this.setredraw(true)
end subroutine

public subroutine openmenu (long xpos, long ypos, long wpos, long hpos, string as_key);userobject 	u_to_open
integer		li_cnt, i
String			ls_temp
vector  vc
vc = Create vector
vc.importfile(setmenu.getproperty(as_key))
li_cnt = vc.getfindkeycount('arg')
FOR i = li_cnt to 1 step -1
	ls_temp = gvc_val.getproperty(vc.getproperty('arg' + string(i)))
	IF ls_temp = '' THEN ls_temp = vc.getproperty('arg' + string(i))
	vc.setproperty('arg' + String(i), ls_temp)
NEXT

OpenUserObjectWithParm(u_to_open, vc, 'u_homelist', xpos, ypos)

u_to_open.Dynamic Post Event ue_resize(wpos, hpos)
u_to_open.Dynamic Post event ue_retrieve()

li_cnt = UpperBound(iuo_data) + 1

iuo_data[li_cnt] = u_to_open

end subroutine

on w_home_org.create
int iCurrent
call super::create
this.p_setting=create p_setting
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_setting
end on

on w_home_org.destroy
call super::destroy
destroy(this.p_setting)
end on

event activate;gs_PgmId = Upper(This.ClassName())
gs_activewindow = This
window		parentwin

parentwin = This.Parentwindow()

IF This.windowtype = MAIN! THEN parentwin.Dynamic wf_select(this.getpgmno())

f_set_message('', '', parentwin)			// 메세지 초기화
f_set_PgmId(gs_PgmId, parentwin)	// 프로그램 ID Setting

This.x = 0
This.y = 0
This.width = parentwin.Dynamic wf_getmdiwidth()
This.height = parentwin.Dynamic wf_getmdiheight()


end event

event open;/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 같은윈도우  여러개 실행하기
		 작업 = ancestor를 window에서 w_base로 수정.
	작업자  : 김영재 송상철
====================================*/
removeTitleBar(handle(this), 0)
This.Post Event ue_postopen()
end event

event resize;long   ll_width , ll_height, ll_x, ll_y
integer	li_hcnt, i, j, li_totalcnt, li_cnt

li_totalcnt 	= upperbound(iuo_data)

if li_totalcnt > 0 then
	ll_width = truncate((this.width - PixelsToUnits(_xpixelgab * (_colcnt + 1), XPixelsToUnits!)) / _colcnt, 0) 
	
	li_hcnt	= truncate(totalcnt / _colcnt, 0)
	IF Mod(totalcnt, _colcnt) > 0 THEN
		li_hcnt ++
	END IF
	
	ll_height = truncate(((this.height - (p_setting.y + p_setting.height)) - pixelstounits(_ypixelgab * (li_hcnt + 1), ypixelstounits!)) / li_hcnt, 0 )
	
	FOR i = 1 to li_hcnt
		if i > 1 then
			ll_y += PixelsToUnits(_ypixelgab, YPixelsToUnits!) + ll_height
		else
			ll_y = PixelsToUnits(_ypixelgab, YPixelsToUnits!) + (p_setting.y + p_setting.height)
		end if
		
		if i = li_hcnt then
			_colcnt = li_totalcnt - (_colcnt * (li_hcnt - 1))
		end if
		
		FOR j = 1 TO _colcnt
			
			if j > 1 then
				ll_x += ll_width + PixelsToUnits(_xpixelgab, XPixelsToUnits!)
			else
				ll_x = PixelsToUnits(_xpixelgab, XPixelsToUnits!)
			end if
			li_cnt++
			
			iuo_data[li_cnt].x 	= ll_x
			iuo_data[li_cnt].y 	= ll_y
			iuo_data[li_cnt].dynamic event ue_resize(ll_width, ll_height)
		NEXT
	NEXT
end if
end event

type p_setting from picture within w_home_org
integer x = 23
integer y = 16
integer width = 233
integer height = 72
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "..\img\icon\home_setting.gif"
boolean focusrectangle = false
end type

event clicked;long  ll_rtn, i
open(w_homesetting)

end event

