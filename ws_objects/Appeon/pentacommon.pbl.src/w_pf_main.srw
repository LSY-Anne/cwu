$PBExportHeader$w_pf_main.srw
forward
global type w_pf_main from w_mdi
end type
type sle_1 from singlelineedit within w_pf_main
end type
end forward

global type w_pf_main from w_mdi
string title = "CWU Information System"
string icon = ""
string errorcolor = "240,241,247"
string inforcolor = "240,241,247"
string defaultcolor = "240,241,247"
event ue_set_msg pbm_custom01
sle_1 sle_1
end type
global w_pf_main w_pf_main

type prototypes
FUNCTION boolean ShowWindow (ulong hWnd, int nCmdShow) Library "USER32.DLL"
end prototypes

type variables
String is_pgm_no
end variables

forward prototypes
public subroutine wf_setenable (string as_true, string as_false)
end prototypes

event ue_set_msg;String	ls_Version, ls_change
DateTime	ldt_today
Long		ll_rday, ll_rtime

// Message Line Setting
This.dw_msg.InsertRow(0)
This.dw_msg.SetITem(1, 'msg' , '')
This.dw_msg.SetITem(1, 'pgm' , gs_PgmId)

end event

public subroutine wf_setenable (string as_true, string as_false);This.uo_toolbar.of_setenable( as_true, true)
This.uo_toolbar.of_setenable( as_false , False)
end subroutine

on w_pf_main.create
int iCurrent
call super::create
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
end on

on w_pf_main.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_1)
end on

event ue_postopen;call super::ue_postopen;gs_PgmId 	= Upper(This.ClassName())
gs_pgmNo	= '00000'

This.TriggerEvent("ue_set_msg")

uo_menu.of_bookmark()
//Timer(600)

/* title */
This.title = This.title

/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 리사이즈시 또 조회 및 불필요한 스크립터 반복수행
		 작업 = 조회를 한번만 하기 위하여 of_select호출.
	작업자  : 김영재 송상철
====================================*/
uo_toolbar.of_select(1, true)
//====================================

OpenSheet(w_home, this, 1, Original!)
/**************************************************/
end event

event close;call super::close;String	ls_ToDay, ls_Time
Long		ll_LoginCnt
String	ls_os, ls_ip
Environment env
INTEGER     	resp
String 	ls_syntax, ls_arg
Long		ll_rtn
s_row	lstr_data

//ls_ToDay = f_GetDate1()
//ls_Time  = String(f_GetTime(), 'hhmmss')

/* Variable Setting */
resp = GetEnvironment(env)     //시스템 환경을 읽어오는 함수

CHOOSE  CASE env.OSType         //OS TYPE(파워빌더는 7개 인식)
	CASE aix!
	     sle_1.Text = 'AIX'
	CASE hpux!
	     sle_1.Text = 'HPUX'
	CASE macintosh!
	     sle_1.Text = 'MacIntosh'
	CASE osf1!
	     sle_1.Text  = 'OSF1'
	CASE sol2!
	     sle_1.Text  = 'Solaris 2'
	CASE Windows!
	     sle_1.Text = 'Windows'
	CASE Windowsnt!
	     sle_1.Text  = 'Windows NT'
	CASE ELSE
	     sle_1.Text = 'etc'
END CHOOSE

ls_os = Trim(sle_1.Text)
end event

type p_buttomline from w_mdi`p_buttomline within w_pf_main
end type

type p_leftline from w_mdi`p_leftline within w_pf_main
end type

type st_start from w_mdi`st_start within w_pf_main
end type

type st_end from w_mdi`st_end within w_pf_main
end type

type dw_msg from w_mdi`dw_msg within w_pf_main
integer height = 72
end type

type uo_toolbar from w_mdi`uo_toolbar within w_pf_main
integer x = 0
integer height = 372
end type

event uo_toolbar::ue_setmenu;call super::ue_setmenu;//
//Vector	lvc_data
//
//lvc_data = Create Vector
//lvc_data.setProperty("x", String(uo_leftmenu.x + uo_leftmenu.width - PixelsToUnits(5, XPixelsToUnits!)))
//lvc_data.setProperty("y", String(uo_leftmenu.y))
//lvc_data.setProperty("width", String(uo_leftmenu.width))
//lvc_data.setProperty("height", String(uo_leftmenu.height))
//
//is_pgm_no = astr_tree.pgm_no
//lvc_data.setProperty("pgm_no", astr_tree.pgm_no)
//lvc_data.setProperty("dragobject", uo_toolbar)
//lvc_data.setProperty("map", "right")
//lvc_data.setProperty("winclose", "false")
//
//openwithparm(w_menu_treestyle, lvc_data)


uo_menu.of_setmenu(astr_tree.pgm_no )

uo_leftmenu.Event ue_treeview()
end event

event uo_toolbar::ue_logout;call super::ue_logout;Close(parent)
end event

event uo_toolbar::ue_intranet;call super::ue_intranet;window  lw_ac
Long		ll_handle
lw_ac = Parent.GetFirstSheet()

do while IsValid(lw_ac)
	IF Upper(lw_ac.className()) = 'W_HOME' THEN
		ll_handle = handle(lw_ac)
		IF ll_handle > 0 THEN 
			IF ShowWindow(ll_handle, 9) THEN lw_ac.SetFocus()
		END IF
		Exit
	END IF
	
	lw_ac = Parent.GetNextSheet(lw_ac)
loop
end event

event uo_toolbar::ue_search;call super::ue_search;//고객조회
//Popup 띄우기.


//Sheet 띄우기
//n_openwithparm   ln_open
//Vector				lvc_data
//lvc_data		= Create Vector
//ln_open.Opensheetwithparm( 'windowname', lvc_data, Parent)
end event

type st_resize from w_mdi`st_resize within w_pf_main
integer y = 232
end type

type uo_tab from w_mdi`uo_tab within w_pf_main
integer x = 133
integer y = 352
end type

event uo_tab::ue_setroll;call super::ue_setroll;//roll관리한다.
IF UPPER(TRIM(gs_PgmId)) <> UPPER(TRIM(astr_data.pgm_id)) AND Not (astr_data.pgm_id = '' or IsNull(astr_data.pgm_id))THEN
	gs_PgmNo			= astr_data.pgm_no
	gs_PgmId			= astr_data.pgm_id
	gs_print_log_yn	= astr_data.print_log
	
//	String		ls_syntax, ls_arg
//	ls_syntax =  "INSERT INTO DAT_ACS_MENU_DETAIL_LOG( MENU_CODE, MEMBER_ID, ACCESS_DATE )  ~r~n" + &
//					"        VALUES ( ? , ? , sysdate) "
//	ls_arg		= gs_PgmId + SOH + gs_empCode
//	
//	gnv_sql.of_update( ls_syntax, ls_arg)
END IF

end event

type st_temp from w_mdi`st_temp within w_pf_main
end type

type uo_menu from w_mdi`uo_menu within w_pf_main
end type

type uo_leftmenu from w_mdi`uo_leftmenu within w_pf_main
end type

event uo_leftmenu::ue_treeview;call super::ue_treeview;//w_menu_treestyle.of_menu(is_pgm_no)
//w_menu_treestyle.wf_show()
end event

event uo_leftmenu::ue_bookmark;call super::ue_bookmark;//Vector	lvc_data
//w_menu_treestyle.wf_hide(lvc_data)
end event

type sle_1 from singlelineedit within w_pf_main
boolean visible = false
integer x = 1637
integer y = 960
integer width = 590
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

