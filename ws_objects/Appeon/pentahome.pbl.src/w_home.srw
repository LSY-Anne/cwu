$PBExportHeader$w_home.srw
forward
global type w_home from w_base
end type
type dw_schedule from datawindow within w_home
end type
type uob_calendar from uo_calendar1 within w_home
end type
type p_1 from picture within w_home
end type
type p_bbs_more from picture within w_home
end type
type dw_notice from uo_grid within w_home
end type
type dw_gongi from uo_grid within w_home
end type
type p_setting from picture within w_home
end type
type p_3 from picture within w_home
end type
end forward

global type w_home from w_base
integer width = 4576
integer height = 2332
string title = "Home"
event ue_postopen ( )
event ue_openwindow ( vector vc )
dw_schedule dw_schedule
uob_calendar uob_calendar
p_1 p_1
p_bbs_more p_bbs_more
dw_notice dw_notice
dw_gongi dw_gongi
p_setting p_setting
p_3 p_3
end type
global w_home w_home

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

event ue_postopen();//setmenu = Create vector
//setmenu.importfile( 'setting.props')
//totalcnt = setmenu.getkeycount( )
//if totalcnt = 0 then
//	setmenu.importfile( 'fulldatasetting.props')
//	totalcnt = setmenu.getkeycount( )
//end if
//
//IF totalcnt > 0 THEN
//	wf_setview()
//END IF

Vector lvc_data

// 공통코드 Setup
lvc_data = Create Vector
lvc_data.setProperty('column1', 'area_gb')  //업무구분
lvc_data.setProperty('key1', 'AREA_GB')

func.of_dddw( dw_notice,lvc_data)

SetRedraw(False)

dw_gongi.SetTransObject(SQLCA)
dw_gongi.Retrieve()

dw_notice.SetTransObject(SQLCA)
dw_notice.Retrieve()

SetRedraw(True)


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

on w_home.create
int iCurrent
call super::create
this.dw_schedule=create dw_schedule
this.uob_calendar=create uob_calendar
this.p_1=create p_1
this.p_bbs_more=create p_bbs_more
this.dw_notice=create dw_notice
this.dw_gongi=create dw_gongi
this.p_setting=create p_setting
this.p_3=create p_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_schedule
this.Control[iCurrent+2]=this.uob_calendar
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.p_bbs_more
this.Control[iCurrent+5]=this.dw_notice
this.Control[iCurrent+6]=this.dw_gongi
this.Control[iCurrent+7]=this.p_setting
this.Control[iCurrent+8]=this.p_3
end on

on w_home.destroy
call super::destroy
destroy(this.dw_schedule)
destroy(this.uob_calendar)
destroy(this.p_1)
destroy(this.p_bbs_more)
destroy(this.dw_notice)
destroy(this.dw_gongi)
destroy(this.p_setting)
destroy(this.p_3)
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

SetRedraw(False)

dw_gongi.SetTransObject(SQLCA)
dw_gongi.Retrieve()

dw_notice.SetTransObject(SQLCA)
dw_notice.Retrieve()

SetRedraw(True)

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

type dw_schedule from datawindow within w_home
integer x = 91
integer y = 1164
integer width = 768
integer height = 836
integer taborder = 20
string title = "none"
string dataobject = "d_schedule"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SQLCA)
end event

type uob_calendar from uo_calendar1 within w_home
integer x = 87
integer y = 524
integer height = 576
integer taborder = 20
end type

on uob_calendar.destroy
call uo_calendar1::destroy
end on

event constructor;call super::constructor;Date				ldt_selecteDate
String	ls_date

ls_date = func.of_get_sdate('yyyymmdd')
ls_date = String(ls_date, '@@@@-@@-@@')

ldt_selecteDate = Date(ls_date)
uob_calendar.init_cal(ldt_selecteDate)

dw_schedule.Retrieve(Left(ls_date, 4)+Mid(ls_date, 6, 2) + '01', Left(ls_date, 4)+Mid(ls_date, 6, 2) + '31')
end event

event ue_doubleclicked;call super::ue_doubleclicked;String	ls_curDate_new, ls_class
date		ld_curDate_new, ld_date 

ld_curDate_new = uob_calendar.uf_get_selected_date( )
ls_curDate_new = String(ld_curDate_new, 'YYYY/MM/DD')

end event

event ue_clicked;call super::ue_clicked;String	ls_curDate_new
date		ld_curDate_new

ld_curDate_new = uob_calendar.uf_get_selected_date( )
ls_curDate_new = String(ld_curDate_new, 'YYYYMMDD')

dw_schedule.Retrieve(Left(ls_curDate_new, 6)+ '01', Left(ls_curDate_new, 6) + '31')
end event

type p_1 from picture within w_home
integer x = 4155
integer y = 1296
integer width = 183
integer height = 52
string picturename = "..\img\login\board_more.gif"
boolean focusrectangle = false
end type

event clicked;in_open.OpenSheetWithParm("W_SYS204A", "", gw_mdi)

end event

type p_bbs_more from picture within w_home
integer x = 4155
integer y = 368
integer width = 183
integer height = 52
boolean originalsize = true
string picturename = "..\img\login\board_more.gif"
boolean focusrectangle = false
end type

event clicked;in_open.OpenSheetWithParm("W_SYS201A", "", gw_mdi)

end event

type dw_notice from uo_grid within w_home
integer x = 1097
integer y = 1416
integer width = 3218
integer height = 600
integer taborder = 20
string dataobject = "d_notice"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_gongi from uo_grid within w_home
integer x = 1097
integer y = 484
integer width = 3218
integer height = 588
integer taborder = 10
string dataobject = "d_gongi"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetPosition(totop!)
end event

event doubleclicked;call super::doubleclicked;Vector lvc_data
String	ls_board_gb, ls_make_dt
Integer li_board_seq

lvc_data = Create Vector

If row < 1 Then Return

ls_board_gb = This.Object.board_gb[row]
ls_make_dt = This.Object.make_dt[row]
li_board_seq = This.Object.board_seq[row]

lvc_data.setProperty('board_gb', ls_board_gb)				//공지사항구분
lvc_data.setProperty('make_dt', ls_make_dt)				//작성일자
lvc_data.setProperty('board_seq', String(li_board_seq))	//공지사항SEQ
lvc_data.SetProperty("parm_cnt", "1")

OpenWithParm(w_sys202a, lvc_data)

end event

type p_setting from picture within w_home
boolean visible = false
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

type p_3 from picture within w_home
integer x = 9
integer y = 252
integer width = 4411
integer height = 1836
boolean originalsize = true
string picturename = "..\img\login\board_main.JPG"
boolean focusrectangle = false
end type

