$PBExportHeader$u_toolbar.sru
forward
global type u_toolbar from userobject
end type
type p_buttom from picture within u_toolbar
end type
type p_title from picture within u_toolbar
end type
type p_right from picture within u_toolbar
end type
type uo_1 from u_toptab within u_toolbar
end type
type uo_private from u_private_info within u_toolbar
end type
type uo_intra from u_interface_info within u_toolbar
end type
type p_left from picture within u_toolbar
end type
end forward

global type u_toolbar from userobject
boolean visible = false
integer width = 3520
integer height = 544
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_construct ( )
event ue_tree ( )
event ue_logout ( )
event ue_close ( )
event ue_insert ( )
event ue_save ( )
event ue_delete ( )
event ue_print ( )
event ue_intranet ( )
event ue_openpgm ( )
event ue_setmenu ( str_tree astr_tree )
event ue_next ( )
event ue_back ( )
event ue_search ( string as_cust )
p_buttom p_buttom
p_title p_title
p_right p_right
uo_1 uo_1
uo_private uo_private
uo_intra uo_intra
p_left p_left
end type
global u_toolbar u_toolbar

type prototypes

end prototypes

type variables
Private:
	DataStore		ids_tool
	nvo_tooltip	inv_Tooltip
end variables

forward prototypes
public subroutine of_resize ()
public subroutine of_setenable (string objectname, boolean enabledtf)
public subroutine of_select (integer ai_index, boolean ab_retrieve)
end prototypes

public subroutine of_resize ();/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 리사이즈시 또 조회 및 불필요한 스크립터 반복수행
		 작업 = init 주석처리, resize호출
	작업자  : 김영재 송상철
====================================*/
//uo_1.of_init()
uo_1.of_resize()
//====================================

uo_private.x = PixelsToUnits(210, XPixelsToUnits!) //230
uo_private.y = PixelsToUnits(-1, YPixelsToUnits!)
uo_intra.x = This.width - uo_intra.width - PixelstoUnits(20, XPixelsToUnits!) //50
uo_intra.y = PixelsToUnits(-1, YPixelsToUnits!)
p_left.setposition(totop!)
uo_private.setPosition(totop!)
This.height = uo_1.height 
This.Visible = True



end subroutine

public subroutine of_setenable (string objectname, boolean enabledtf);
end subroutine

public subroutine of_select (integer ai_index, boolean ab_retrieve);/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 처음 오픈시 대분류, 메뉴를 3번씩 조회하는문제 및 같은 이벤트 여러번수행.
		 작업 = of_select 함수 추가. uo_1.of_select 호출.
	작업자  : 김영재 송상철
====================================*/
uo_1.of_select( ai_index, ab_retrieve)
//====================================
end subroutine

on u_toolbar.create
this.p_buttom=create p_buttom
this.p_title=create p_title
this.p_right=create p_right
this.uo_1=create uo_1
this.uo_private=create uo_private
this.uo_intra=create uo_intra
this.p_left=create p_left
this.Control[]={this.p_buttom,&
this.p_title,&
this.p_right,&
this.uo_1,&
this.uo_private,&
this.uo_intra,&
this.p_left}
end on

on u_toolbar.destroy
destroy(this.p_buttom)
destroy(this.p_title)
destroy(this.p_right)
destroy(this.uo_1)
destroy(this.uo_private)
destroy(this.uo_intra)
destroy(this.p_left)
end on

event constructor;CHOOSE CASE Parent.Typeof()	
	CASE Window!
		window lw
		lw = Parent
		This.BackColor 	= lw.BackColor
		This.width 		= lw.width
	CASE Tab!
		tab ltb
		ltb = Parent
		This.BackColor = ltb.BackColor
		This.width 		= ltb.width
	CASE UserObject!
		userobject luo
		luo = Parent
		This.BackColor = luo.BackColor
		This.width 		= luo.width
END CHOOSE

/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 리사이즈시 또 조회 및 불필요한 스크립터 반복수행
		 작업 = resize추석 처리.
	작업자  : 김영재 송상철
====================================*/
//This.of_resize()
//====================================
end event

type p_buttom from picture within u_toolbar
boolean visible = false
integer x = 1047
integer y = 296
integer width = 32
integer height = 44
string picturename = "..\img\tlr_style\thema_1\top_bottom.gif"
boolean focusrectangle = false
end type

type p_title from picture within u_toolbar
boolean visible = false
integer x = 485
integer width = 608
integer height = 252
string picturename = "..\img\tlr_style\thema_1\top_title.gif"
boolean focusrectangle = false
end type

type p_right from picture within u_toolbar
boolean visible = false
integer x = 402
integer width = 41
integer height = 296
string picturename = "..\img\tlr_style\thema_1\top_right.gif"
boolean focusrectangle = false
end type

type uo_1 from u_toptab within u_toolbar
integer width = 3515
integer height = 352
integer taborder = 20
end type

on uo_1.destroy
call u_toptab::destroy
end on

event constructor;call super::constructor;This.Visible = True
end event

event ue_setroll;call super::ue_setroll;Parent.Event ue_setmenu(astr_data)
end event

type uo_private from u_private_info within u_toolbar
integer x = 178
integer width = 1125
integer height = 120
integer taborder = 20
boolean bringtotop = true
end type

event constructor;call super::constructor;uo_private.of_setname(gs_empName + '  ' + gs_deptname)
uo_private.SetPosition(totop!)
uo_intra.SetPosition(totop!)
end event

on uo_private.destroy
call u_private_info::destroy
end on

event ue_home;call super::ue_home;Parent.PostEvent('ue_intranet')
end event

type uo_intra from u_interface_info within u_toolbar
event ue_logout ( )
integer x = 1938
integer width = 1399
integer height = 124
integer taborder = 20
boolean bringtotop = true
end type

event ue_logout();Parent.PostEvent('ue_logout')
end event

on uo_intra.destroy
call u_interface_info::destroy
end on

event ue_search;call super::ue_search;Parent.Post Event ue_search(as_cust)
end event

type p_left from picture within u_toolbar
integer width = 1221
integer height = 292
boolean bringtotop = true
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "..\img\tlr_style\thema_1\top_left.gif"
boolean focusrectangle = false
end type

event clicked;parent.Event ue_intranet()
end event

