$PBExportHeader$u_treememu.sru
forward
global type u_treememu from userobject
end type
type tv_bookmark from treeview within u_treememu
end type
type tv_menu from treeview within u_treememu
end type
type p_fix_right from picture within u_treememu
end type
type p_fix_left from picture within u_treememu
end type
type st_1 from statictext within u_treememu
end type
end forward

global type u_treememu from userobject
integer width = 882
integer height = 2060
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_construct ( )
event ke_mousemove pbm_mousemove
event ue_selectionchanged ( str_tree astr_tree )
event ue_menufix ( boolean ab_menufix )
tv_bookmark tv_bookmark
tv_menu tv_menu
p_fix_right p_fix_right
p_fix_left p_fix_left
st_1 st_1
end type
global u_treememu u_treememu

type variables
Public:
	String	imgpath		= "..\img\icon\"			//windowSelectImageName
	
	CONSTANT	INTEGER		MENUTREE	= 1
	CONSTANT   INTEGER	BOOKMARK	= 2	
Protected:	
	DataStore		ids_menu
	DataStore		ids_bookmark
	
Private:
	Boolean			ib_menufix = false
end variables

forward prototypes
public subroutine of_resize ()
public subroutine of_selecttab (integer ai_select)
public function long of_findeitem (string as_item, ref str_tree astr_tree)
public function integer of_getpictureindex (string as_picname, treeview astr_tree)
public subroutine of_bookmark ()
public subroutine of_menu (string as_parentpgm)
public subroutine of_setmenu (string as_pgmno)
public subroutine of_menufix (boolean ab_menufix)
end prototypes

event ue_menufix(boolean ab_menufix);//SSC  Event 추가.

//V1.9.9.013 menufix에 대한 수정...
this.of_menufix(ab_menufix)
//===================

end event

public subroutine of_resize ();st_1.x = 0
st_1.y = 0
st_1.width = this.width
st_1.height = this.height
st_1.setPosition(tobottom!)

//SSC  Menu Fix이미지 추가. =====
p_fix_right.x			= this.width - p_fix_right.width
p_fix_right.y			= 0

p_fix_left.x 			= 0
p_fix_left.y			= p_fix_right.y
p_fix_left.height	= p_fix_right.height
p_fix_left.width		= p_fix_right.x
//==========================

tv_menu.x 				= p_fix_left.x
tv_menu.width 			= p_fix_right.x + p_fix_right.width - tv_menu.x
tv_menu.y 				= p_fix_left.y + p_fix_left.height + PixelsToUnits(5 , YPixelsToUnits!)
tv_menu.height 		= this.height - tv_menu.y - PixelsToUnits(2 , YPixelsToUnits!)

tv_bookmark.x 			= tv_menu.x 
tv_bookmark.width 	= tv_menu.width
tv_bookmark.y 			= tv_menu.y
tv_bookmark.height 	= tv_menu.height

end subroutine

public subroutine of_selecttab (integer ai_select);Choose Case ai_select
	Case 1
		tv_menu.visible 			= true
		tv_bookmark.visible 	= false
	Case 2
		tv_menu.visible 			= false
		tv_bookmark.visible 	= true
End Choose
end subroutine

public function long of_findeitem (string as_item, ref str_tree astr_tree);TreeView				ltv_tree
TreeViewItem		ltv_item
Long						ll_handle, ll_rtn

ltv_tree = tv_menu
ll_handle = ltv_tree.FindItem(RootTreeItem!, ll_handle)
do while true
	ll_handle++
	ll_rtn = ltv_tree.GetITem(ll_handle, ltv_item)
	IF ll_rtn <> -1 THEN
		astr_tree = ltv_item.Data
		IF astr_tree.pgm_id = Upper(as_item) THEN
			Exit
		END IF
	ELSE
		Exit
	END IF
loop

return ll_rtn
end function

public function integer of_getpictureindex (string as_picname, treeview astr_tree);Integer		li_cnt, i, idx

IF IsNull(as_picname) OR Trim(as_picname) = "" THEN return idx

li_cnt = UpperBound(astr_tree.picturename)

FOR i = 1 TO li_cnt
	IF imgpath + as_picname = astr_tree.picturename[i] THEN
		idx = i
		Exit
	END IF
NEXT

IF idx = 0 THEN
	idx = astr_tree.addpicture(imgpath + as_picname)
	astr_tree.picturename[idx] = imgpath + as_picname
END IF

return idx

end function

public subroutine of_bookmark ();TreeViewItem			ltv_item
Integer					li_pic
Long						ll_handle
str_tree					lstr_tree
String					ls_name, ls_pic, ls_spic
long tvi_hdl = 0

DO UNTIL tv_bookmark.FindItem(RootTreeItem!, 0) = -1
    tv_bookmark.DeleteItem(tvi_hdl)
LOOP

Declare cur CURSOR FOR

SELECT    a.pgm_no						as pgm_no
					,b.pgm_id					as pgm_id
					,b.pgm_name			as pgm_nm
					,b.pgm_kind_code		as pgm_kc
					,b.picture  				as pic
					,b.select_picture		as spic
					,a.sort_order				as sort_order
					,a.parent_pgm			as parent_pgm
					,a.pgm_alsname			as pgm_alsname
		  FROM	 cddb.pf_bookmark		a
				 	,cddb.pf_pgm_mst		b
					,cddb.pf_pgm_role		c
					,cddb.pf_userrole			d
		WHERE	a.pgm_no				= b.pgm_no
			AND a.emp_code			= :gs_empCode
			AND b.pgm_use_yn 		= 'Y'
			AND b.menu_use_yn 	= 'Y'
			AND b.pgm_no				= c.pgm_no
			AND a.emp_code			= d.emp_code
			AND c.role_no				= d.role_no
			AND a.parent_pgm		= 'ZZZZZ'

	  union

	Select pgm_no								as pgm_no
			 ,''											as pgm_id
			,''											as pgm_nm
			,'M'										as pgm_kc
			,'tree_icon_folder.gif' 			as pic
			,'tree_icon_select_folder.gif'		as spic
			,sort_order							as sort_order
			,parent_pgm							as parent_pgm
			,pgm_alsname						as pgm_alsname
	  from cddb.pf_bookmark 
	 where emp_code 		= :gs_empCode
		and pgm_no 				like 'G%'		
		AND parent_pgm		= 'ZZZZZ'
Order By parent_pgm asc, sort_order asc

Using sqlca;

open cur;

do while true
	fetch cur 
	  into :lstr_tree.pgm_no
	      , :lstr_tree.pgm_id
		  , :lstr_tree.pgm_nm
		  , :lstr_tree.pgm_kd
		  , :ls_pic 
		  , :ls_spic
		  , :lstr_tree.sort_order
		  , :lstr_tree.parent_node
		  , :ls_name;
	
	IF sqlca.sqlcode <> 0 THEN Exit
	
	li_pic = This.of_getpictureindex( ls_pic, tv_bookmark)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = This.of_getpictureindex( ls_spic, tv_bookmark)
	IF li_pic > 0 THEN
		ltv_Item.SelectedPictureIndex = li_pic
	END IF

	//V1.9.9.008  Null일 경우 Len으로 체크가 되지 않는다.
	//IF Len(lstr_tree.pgm_nm) = 0 THEN
	IF IsNull(lstr_tree.pgm_nm) OR Len(lstr_tree.pgm_nm) = 0 THEN
		lstr_tree.pgm_nm = ls_name
	END IF

	ltv_item.Data				= lstr_tree
	ltv_item.Label			= lstr_tree.pgm_nm
	
	ltv_item.Children 	= True
	
	ll_handle = tv_bookmark.InsertItemLast(0, ltv_item)
loop

Close cur;

tv_bookmark.ExpandItem( ll_handle )

end subroutine

public subroutine of_menu (string as_parentpgm);TreeViewItem			ltv_item
Integer					li_pic
Long						ll_handle
str_tree					lstr_tree
String					ls_name, ls_pic, ls_spic
long tvi_hdl = 0

DO UNTIL tv_menu.FindItem(RootTreeItem!, 0) = -1
    tv_menu.DeleteItem(tvi_hdl)
LOOP

Declare cur CURSOR FOR

SELECT  Distinct a.pgm_no					as pgm_no
			,a.pgm_id					as pgm_id
			,a.pgm_name				as pgm_nm
			,a.pgm_kind_code			as pgm_kc
			,a.picture					as pic
			,a.select_picture			as spic
			,a.sort_order				as sort_order
			,a.parent_pgm				as parent_pgm
	FROM  cddb.pf_pgm_mst 	a, 
			 cddb.pf_pgm_role	b,
			 cddb.pf_userrole		c
 WHERE  c.emp_code				= :gs_empcode
	  AND b.role_no						= c.role_no
	  AND a.pgm_use_yn 			= 'Y'
	  AND a.menu_use_yn 			= 'Y'
	  AND a.pgm_no					= b.pgm_no   
	  AND a.pgm_no 					= :as_parentpgm
	ORDER BY a.parent_pgm asc , a.sort_order

Using sqlca;

open cur;

do while true
	fetch cur 
	  into :lstr_tree.pgm_no
	      , :lstr_tree.pgm_id
		  , :lstr_tree.pgm_nm
		  , :lstr_tree.pgm_kd
		  , :ls_pic 
		  , :ls_spic
		  , :lstr_tree.sort_order
		  , :lstr_tree.parent_node;
	
	IF sqlca.sqlcode <> 0 THEN Exit
	
	li_pic = This.of_getpictureindex( ls_pic, tv_menu)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = This.of_getpictureindex( ls_spic, tv_menu)
	IF li_pic > 0 THEN
		ltv_Item.SelectedPictureIndex = li_pic
	END IF

	ltv_item.Data				= lstr_tree
	ltv_item.Label			= lstr_tree.pgm_nm
	
	ltv_item.Children 	= True
	
	ll_handle = tv_menu.InsertItemLast(0, ltv_item)
loop

Close cur;

tv_menu.ExpandItem( ll_handle )
end subroutine

public subroutine of_setmenu (string as_pgmno);of_menu(as_pgmno)
end subroutine

public subroutine of_menufix (boolean ab_menufix);//V1.9.9.013  menufix에 의한 함수 추가.
ib_menufix = ab_menufix

IF ab_menufix THEN
 p_fix_right.picturename = "..\img\tlr_style\thema_1\menufix_right_fix.gif"
ELSE
 p_fix_right.picturename = "..\img\tlr_style\thema_1\menufix_right_nonfix.gif"
END IF
//==================================

end subroutine

on u_treememu.create
this.tv_bookmark=create tv_bookmark
this.tv_menu=create tv_menu
this.p_fix_right=create p_fix_right
this.p_fix_left=create p_fix_left
this.st_1=create st_1
this.Control[]={this.tv_bookmark,&
this.tv_menu,&
this.p_fix_right,&
this.p_fix_left,&
this.st_1}
end on

on u_treememu.destroy
destroy(this.tv_bookmark)
destroy(this.tv_menu)
destroy(this.p_fix_right)
destroy(this.p_fix_left)
destroy(this.st_1)
end on

event constructor;ids_menu = Create DataStore
ids_bookmark = Create DataStore
of_resize()
end event

type tv_bookmark from treeview within u_treememu
integer x = 32
integer y = 88
integer width = 841
integer height = 1844
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 23494034
long backcolor = 16777215
boolean border = false
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event doubleclicked;str_tree		lstr_tree
TreeViewItem		ltv_item

IF handle > 0 THEN
	This.GetItem(handle, ltv_item)
	
	lstr_tree = ltv_item.Data
	
	IF lstr_tree.pgm_kd = "P" THEN
		Event ue_selectionchanged(lstr_tree)
	END IF
END IF
end event

event itemexpanding;TreeViewItem 			ltv_item
Integer					li_pic
long						i, ll_cnt
str_tree					lstr_tree
String					ls_name, ls_pic, ls_spic

this.getitem( handle, ltv_item )

IF ltv_item.ExpandedOnce THEN Return
lstr_tree 	= ltv_item.data

Declare cur CURSOR FOR

SELECT    a.pgm_no						as pgm_no
					,b.pgm_id					as pgm_id
					,b.pgm_name			as pgm_nm
					,b.pgm_kind_code		as pgm_kc
					,b.picture  				as pic
					,b.select_picture		as spic
					,a.sort_order				as sort_order
					,a.parent_pgm			as parent_pgm
					,a.pgm_alsname			as pgm_alsname
		  FROM	 cddb.pf_bookmark		a
				 	,cddb.pf_pgm_mst		b
					,cddb.pf_pgm_role		c
					,cddb.pf_userrole			d
		WHERE	a.pgm_no				= b.pgm_no
			AND a.emp_code			= :gs_empCode
			AND b.pgm_use_yn 		= 'Y'
			AND b.menu_use_yn 	= 'Y'
			AND b.pgm_no				= c.pgm_no
			AND a.emp_code			= d.emp_code
			AND c.role_no				= d.role_no
			AND a.parent_pgm		= :lstr_tree.pgm_no

	  union

	Select pgm_no								as pgm_no
			 ,''											as pgm_id
			,''											as pgm_nm
			,'M'										as pgm_kc
			,'tree_icon_folder.gif' 			as pic
			,'tree_icon_select_folder.gif'		as spic
			,sort_order							as sort_order
			,parent_pgm							as parent_pgm
			,pgm_alsname						as pgm_alsname
	  from cddb.pf_bookmark 
	 where emp_code 						= :gs_empCode
		and pgm_no 								like 'G%'		
		AND parent_pgm						= :lstr_tree.pgm_no
Order By parent_pgm asc, sort_order asc

Using sqlca;

open cur;

do while true
	fetch cur 
	  into :lstr_tree.pgm_no
	      , :lstr_tree.pgm_id
		  , :lstr_tree.pgm_nm
		  , :lstr_tree.pgm_kd
		  , :ls_pic 
		  , :ls_spic
		  , :lstr_tree.sort_order
		  , :lstr_tree.parent_node
		  , :ls_name;
	
	IF sqlca.sqlcode <> 0 THEN Exit
	
	li_pic = of_getpictureindex( ls_pic, this)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = of_getpictureindex( ls_spic, this)
	IF li_pic > 0 THEN
		ltv_Item.SelectedPictureIndex = li_pic
	END IF
	
	//V1.9.9.008  Null일 경우 Len으로 체크가 되지 않는다.
	//IF Len(lstr_tree.pgm_nm) = 0 THEN
	IF IsNull(lstr_tree.pgm_nm) OR Len(lstr_tree.pgm_nm) = 0 THEN
		lstr_tree.pgm_nm = ls_name
	END IF
	
	ltv_item.Data				= lstr_tree
	ltv_item.Label			= lstr_tree.pgm_nm
	
	ltv_item.Selected		= False
	
	IF lstr_tree.pgm_kd = "M" THEN
		ltv_item.Children 	= True
	ELSE
		ltv_item.Children 	= False
	END IF
	
	This.InsertItemLast ( handle, ltv_Item)

loop

Close cur;
end event

event key;IF key = KeyF5! THEN
	of_bookmark()
END IF
end event

type tv_menu from treeview within u_treememu
integer x = 23
integer y = 92
integer width = 846
integer height = 1844
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 23494034
long backcolor = 16777215
boolean border = false
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event doubleclicked;str_tree		lstr_tree
TreeViewItem		ltv_item

IF handle > 0 THEN
	This.GetItem(handle, ltv_item)
	
	lstr_tree = ltv_item.Data
	
	IF lstr_tree.pgm_kd = "P" THEN
		Event ue_selectionchanged(lstr_tree)
	END IF
END IF

end event

event itemexpanding;TreeViewItem 			ltv_item
Integer					li_pic
long						i, ll_cnt
str_tree					lstr_tree
String					ls_name, ls_pic, ls_spic

this.getitem( handle, ltv_item )

IF ltv_item.ExpandedOnce THEN Return
lstr_tree 	= ltv_item.data

Declare cur CURSOR FOR

SELECT  Distinct a.pgm_no					as pgm_no
			,a.pgm_id					as pgm_id
			,a.pgm_name				as pgm_nm
			,a.pgm_kind_code			as pgm_kc
			,a.picture					as pic
			,a.select_picture			as spic
			,a.sort_order				as sort_order
			,a.parent_pgm				as parent_pgm
	FROM  cddb.pf_pgm_mst 	a, 
			 cddb.pf_pgm_role	b,
			 cddb.pf_userrole		c
 WHERE  c.emp_code				= :gs_empcode
	  AND b.role_no						= c.role_no
	  AND a.pgm_use_yn 			= 'Y'
	  AND a.menu_use_yn 			= 'Y'
	  AND a.pgm_no					= b.pgm_no   
	  AND a.parent_pgm 			= :lstr_tree.pgm_no
	ORDER BY a.parent_pgm asc , a.sort_order

Using sqlca;

open cur;

do while true
	fetch cur 
	  into :lstr_tree.pgm_no
	      , :lstr_tree.pgm_id
		  , :lstr_tree.pgm_nm
		  , :lstr_tree.pgm_kd
		  , :ls_pic 
		  , :ls_spic
		  , :lstr_tree.sort_order
		  , :lstr_tree.parent_node;
	
	IF sqlca.sqlcode <> 0 THEN Exit
	
	li_pic = of_getpictureindex( ls_pic, this)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = of_getpictureindex( ls_spic, this)
	IF li_pic > 0 THEN
		ltv_Item.SelectedPictureIndex = li_pic
	END IF

	ltv_item.Data				= lstr_tree
	ltv_item.Label			= lstr_tree.pgm_nm
	
	ltv_item.Selected		= False
	
	IF lstr_tree.pgm_kd = "M" THEN
		ltv_item.Children 	= True
	ELSE
		ltv_item.Children 	= False
	END IF
	
	This.InsertItemLast ( handle, ltv_Item)

loop

Close cur;
end event

event key;IF key = KeyF5! THEN 
	treeviewItem   ltvitem
	Long		ll_handle
	ll_handle = This.FindItem(RootTreeItem!, 0)
	IF This.GetItem(ll_handle, ltvitem) = 1 THEN
		str_tree		lstr_tree
		lstr_tree = ltvitem.Data
		of_setmenu(lstr_tree.pgm_no)
	END IF
END IF
end event

type p_fix_right from picture within u_treememu
integer x = 238
integer width = 105
integer height = 84
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "..\img\tlr_style\thema_1\menufix_right_nonfix.gif"
boolean focusrectangle = false
end type

event clicked;//SSC 이미지 추가.
ib_menufix = Not ib_menufix

//V1.9.9.013 menufix 설정에 따른 수정.
//IF ib_menufix THEN
//	this.picturename = "..\img\tlr_style\thema_1\menufix_right_fix.gif"
//ELSE
//	this.picturename = "..\img\tlr_style\thema_1\menufix_right_nonfix.gif"
//END IF

parent. Event ue_menufix(ib_menufix)


end event

type p_fix_left from picture within u_treememu
integer x = 37
integer width = 82
integer height = 84
string picturename = "..\img\tlr_style\thema_1\menufix_left.gif"
boolean focusrectangle = false
end type

type st_1 from statictext within u_treememu
integer width = 878
integer height = 2052
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

