$PBExportHeader$w_menu_treestyle.srw
forward
global type w_menu_treestyle from w_anccontrol
end type
type tv_menu from treeview within w_menu_treestyle
end type
type st_1 from statictext within w_menu_treestyle
end type
end forward

global type w_menu_treestyle from w_anccontrol
integer width = 914
integer height = 1824
boolean titlebar = false
boolean controlmenu = false
boolean border = false
windowtype windowtype = child!
long backcolor = 31507906
event ue_selectionchanged ( str_tree astr_tree )
tv_menu tv_menu
st_1 st_1
end type
global w_menu_treestyle w_menu_treestyle

type variables
Public:
	String	imgpath		= "..\img\icon\"			//windowSelectImageName
	dragobject		idrg
	String	is_map
end variables

forward prototypes
public function integer of_getpictureindex (string as_picname, treeview astr_tree)
public subroutine of_menu (string as_parentpgm)
public subroutine wf_beforclose ()
public subroutine wf_afteropen ()
end prototypes

event ue_selectionchanged(str_tree astr_tree);/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 같은윈도우  여러개 실행하기
		 작업 = pgm_id 를 pgm_no로 수정.
	작업자  : 김영재 송상철
====================================*/
//IF Not uo_tab.of_select( astr_tree.pgm_id) THEN
IF Not gw_mdi.uo_tab.of_select( astr_tree.pgm_no) THEN
//====================================

	IF astr_tree.pgm_kd = "P" THEN
		IF gw_mdi.uo_tab.of_createtab(astr_tree) < 0 THEN
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
			gw_mdi.uo_tab.of_select(astr_tree.pgm_no)
			//====================================
		END IF
	END IF
END IF

end event

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

public subroutine wf_beforclose ();idrg.x = 0
end subroutine

public subroutine wf_afteropen ();IF  is_map = "right" THEN
	idrg.x = this.x + this.width
END IF

end subroutine

on w_menu_treestyle.create
int iCurrent
call super::create
this.tv_menu=create tv_menu
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_menu
this.Control[iCurrent+2]=this.st_1
end on

on w_menu_treestyle.destroy
call super::destroy
destroy(this.tv_menu)
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;Vector	lvc 
lvc= Message.PowerObjectParm

IF IsValid(lvc)THEN
	of_menu(lvc.getproperty("pgm_no"))
	lvc.getProperty("dragobject", idrg)
	is_map = lvc.getProperty("map")
	IF  is_map = "right" THEN
		tempwidth = idrg.width
		tempheight = idrg.height
	END IF
END IF
end event

event open;call super::open;tv_menu.y = PixelsToUnits(5, YPixelsToUnits!)
tv_menu.x = PixelsToUnits(5, XPixelsToUnits!)
st_1.x = 0
st_1.y = 0

st_1.resize(this.width, this.height)
tv_menu.resize( this.width - PixelsToUnits(5 * 2, XPixelsToUnits!), this.height - PixelsToUnits(5 * 2, YPixelsToUnits!))	

end event

type tv_menu from treeview within w_menu_treestyle
integer x = 73
integer y = 8
integer width = 846
integer height = 1876
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
//		of_menu(lstr_tree.pgm_no)
	END IF
END IF
end event

type st_1 from statictext within w_menu_treestyle
integer width = 773
integer height = 272
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
long bordercolor = 25123898
boolean focusrectangle = false
end type

