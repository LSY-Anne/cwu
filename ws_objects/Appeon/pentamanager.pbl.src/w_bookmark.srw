$PBExportHeader$w_bookmark.srw
forward
global type w_bookmark from w_default_response
end type
type tv_menu from treeview within w_bookmark
end type
type tv_bookmark from treeview within w_bookmark
end type
type st_2 from statictext within w_bookmark
end type
type st_3 from statictext within w_bookmark
end type
type p_2 from picture within w_bookmark
end type
type p_3 from picture within w_bookmark
end type
type r_3 from rectangle within w_bookmark
end type
type r_4 from rectangle within w_bookmark
end type
end forward

global type w_bookmark from w_default_response
integer width = 1993
integer height = 1888
string title = "북마크 등록"
tv_menu tv_menu
tv_bookmark tv_bookmark
st_2 st_2
st_3 st_3
p_2 p_2
p_3 p_3
r_3 r_3
r_4 r_4
end type
global w_bookmark w_bookmark

type prototypes

end prototypes

type variables
String		imgpath		= "..\img\icon\"
Long		il_parent, il_selecthandlle
Boolean		ib_drag, ib_insert = false
end variables

forward prototypes
public subroutine of_retrievebookmark ()
public subroutine of_retrievemenu ()
public function boolean checkparenthandle (treeview atv, long handle, long checkhandle)
public function string delete_pgm (string as_parentnode)
public function integer of_getpictureindex (string as_picname, treeview astr_tree)
end prototypes

public subroutine of_retrievebookmark ();TreeViewItem			ltv_item
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

public subroutine of_retrievemenu ();TreeViewItem			ltv_item
Integer					li_pic
Long						ll_handle
str_tree					lstr_tree
String					ls_name, ls_pic, ls_spic
long tvi_hdl = 0

DO UNTIL tv_menu.FindItem(RootTreeItem!, 0) = -1
    tv_menu.DeleteItem(tvi_hdl)
LOOP

Declare cur CURSOR FOR

SELECT Distinct  a.pgm_no				as pgm_no
		,a.pgm_id				as pgm_id
		,a.pgm_name			as pgm_nm
		,a.pgm_kind_code		as pgm_kc
		,a.picture					as pic
		,a.select_picture		as spic
		,a.sort_order				as sort_order
		,a.parent_pgm			as parent_pgm
FROM  cddb.pf_pgm_mst 	a, 
		 cddb.pf_pgm_role	b,
		 cddb.pf_userrole		c
WHERE c.emp_code				= :gs_empCode
    AND b.role_no					= c.role_no
    AND a.pgm_use_yn 			= 'Y'
    AND a.menu_use_yn 		= 'Y'
    AND a.pgm_no					= b.pgm_no 
    AND a.parent_pgm 			= 'ZZZZZ'
ORDER BY a.parent_pgm asc, a.sort_order asc

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

public function boolean checkparenthandle (treeview atv, long handle, long checkhandle);Long			ll_handle
Boolean		lb_rtn
ll_handle = atv.FindItem(ParentTreeItem!, handle)


IF ll_handle = -1 THEN
	lb_rtn = false
ELSE
	IF ll_handle <> checkhandle THEN
		lb_rtn =  checkparenthandle(atv, ll_handle, checkhandle)
	ELSE
		lb_rtn = true
	END IF
END IF

return lb_rtn
end function

public function string delete_pgm (string as_parentnode);String	ls_pgm_no, ls_rtn, ls_parentnode
Long		ll_cnt, i, li_row
String  ls_pgm[]

DECLARE pgm_cur CURSOR FOR
	SELECT PGM_NO FROM CDDB.PF_BOOKMARK WHERE PARENT_PGM = :as_parentnode
using sqlca;

OPEN pgm_cur;

li_row = 1
do while true
	FETCH pgm_cur INTO :ls_pgm_no;
	IF sqlca.sqlcode <> 0 THEN Exit
	
	ls_pgm[li_row] = ls_pgm_no
	li_row++
loop
CLOSE pgm_cur;

li_row = UpperBound(ls_pgm)

FOR i = li_row TO 1 Step -1
	Select count(PGM_NO)
	  into :ll_cnt
      From CDDB.PF_BOOKMARK
	Where parent_pgm = :ls_pgm[i]
	using sqlca;
	
	IF ll_cnt > 0 THEN
		ls_rtn += delete_pgm(ls_pgm[i]) + ","
	END IF
	
	ls_rtn += ls_pgm[i] + ","
Next

return ls_rtn
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

on w_bookmark.create
int iCurrent
call super::create
this.tv_menu=create tv_menu
this.tv_bookmark=create tv_bookmark
this.st_2=create st_2
this.st_3=create st_3
this.p_2=create p_2
this.p_3=create p_3
this.r_3=create r_3
this.r_4=create r_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_menu
this.Control[iCurrent+2]=this.tv_bookmark
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.p_3
this.Control[iCurrent+7]=this.r_3
this.Control[iCurrent+8]=this.r_4
end on

on w_bookmark.destroy
call super::destroy
destroy(this.tv_menu)
destroy(this.tv_bookmark)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.p_2)
destroy(this.p_3)
destroy(this.r_3)
destroy(this.r_4)
end on

event ue_postopen;call super::ue_postopen;This.of_retrievebookmark()
This.of_retrievemenu()

end event

type st_1 from w_default_response`st_1 within w_bookmark
end type

type uc_insert from w_default_response`uc_insert within w_bookmark
integer x = 1115
integer width = 274
integer height = 84
boolean originalsize = true
end type

event uc_insert::clicked;call super::clicked;Long						ll_handle, ll_index, ll_row
TreeViewItem		ltv_item, ltv_temp, ltv_itemnode
str_tree					lstr_tree, lstr_temp, lstr_itemnode
String					ls_maxpgmno, ls_node, ls_parentnode
Long						ll_prh, ll_sort

ib_insert = true

ll_handle = tv_bookmark.FindItem(RootTreeItem!, 0)

IF ll_handle = -1 THEN 
	ltv_item.label = gs_empName
	lstr_tree.pgm_no 	= 'G0001'  //가상 프로그램 넘버
	lstr_tree.pgm_nm 	= gs_empName
	lstr_tree.pgm_kd	= 'M'
	lstr_tree.parent_node	= 'ZZZZZ'
	
	//lstr_tree.sort_order = 1
	ltv_item.data = lstr_tree
	ll_index = Parent.of_getpictureindex("tree_icon_folder.gif", tv_bookmark)
	ltv_item.pictureindex = ll_index
	ll_index 		= Parent.of_getpictureindex("tree_icon_select_folder.gif", tv_bookmark)
	ltv_item.selectedpictureindex = ll_index
	ll_handle = tv_bookmark.InsertItemLast( 0, ltv_item)
	tv_bookmark.expanditem(ll_handle)
	Insert Into cddb.pf_bookmark   ( emp_code, pgm_no, pgm_alsname, parent_pgm, sort_order )
	  values(:gs_empCode, 'G0001', :gs_EmpName, 'ZZZZZ', 1 )
	 using sqlca;
	 
	 IF sqlca.sqlcode <> 0 THEN
		rollback using sqlca;
		Messagebox("Error", "메뉴생성중 실패 하였습니다..~r~n" + String(sqlca.sqldbcode) + "::" + sqlca.sqlerrtext)
		return
	 ELSE
		commit using sqlca;
	 END IF
END IF

tv_bookmark.getItem(ll_handle, ltv_temp)
lstr_temp = ltv_temp.data

Select Max(pgm_no)
 Into :ls_maxpgmno
 From cddb.pf_bookmark
using sqlca;

IF Len(ls_maxpgmno) = 0 THEN
	ls_maxpgmno = 'G0001'
ELSE
	ls_maxpgmno = Left(ls_maxpgmno, 1) + String(Long(Mid(ls_maxpgmno, 2)) + 1, '0000') 
END IF

Select Max(sort_order)
  Into :ll_sort
 From cddb.pf_bookmark
Where parent_pgm = :ls_maxpgmno
Using sqlca;

IF IsNull(ll_sort) THEN
	ll_sort = 0
END IF
ll_sort ++

lstr_itemnode.pgm_no 	= ls_maxpgmno
lstr_itemnode.pgm_nm 	= '그룹을 설정하세요'
lstr_itemnode.pgm_kd	= 'M'
lstr_itemnode.sort_order = ll_sort
lstr_itemnode.parent_node = lstr_temp.pgm_no
ltv_itemnode.data = lstr_itemnode
ll_index 		= Parent.of_getpictureindex("tree_icon_folder.gif", tv_bookmark)
ltv_itemnode.pictureindex 				= ll_index
ll_index 		= Parent.of_getpictureindex("tree_icon_select_folder.gif", tv_bookmark)
ltv_itemnode.selectedpictureindex = ll_index
ltv_itemnode.label = '그룹을 설정하세요'

ll_handle = tv_bookmark.InsertItemLast( ll_handle, ltv_itemnode )

tv_bookmark.selectitem(ll_handle)
tv_bookmark.EditLabel(ll_handle)

Insert Into cddb.pf_bookmark   ( emp_code, pgm_no, pgm_alsname, parent_pgm, sort_order )
  values(:gs_empCode, :ls_maxpgmno, :lstr_itemnode.pgm_nm, :lstr_temp.pgm_no, :ll_sort )
 using sqlca;
 
 IF sqlca.sqlcode <> 0 THEN
	rollback using sqlca;
	Messagebox("Error", "메뉴생성중 실패 하였습니다.~r~n" + String(sqlca.sqldbcode) + "::" + sqlca.sqlerrtext)
	tv_bookmark.Deleteitem(ll_handle)
	return
 ELSE
	commit using sqlca;
 END IF

ib_insert = false

end event

type uc_cancel from w_default_response`uc_cancel within w_bookmark
boolean visible = false
end type

type uc_close from w_default_response`uc_close within w_bookmark
integer x = 1682
integer width = 274
integer height = 84
end type

event uc_close::clicked;call super::clicked;CloseWithreturn(Parent, '')
end event

type uc_delete from w_default_response`uc_delete within w_bookmark
integer x = 1399
integer width = 274
integer height = 84
boolean originalsize = true
end type

event uc_delete::clicked;call super::clicked;TreeViewItem		ltv_item
str_tree					lstr_tree
Long						ll_handle, ll_cnt, ll_row, ll_rtn
String					ls_pgmno, ls_rtn, ls_syntax

IF tv_bookmark.GetItem(il_selecthandlle, ltv_item) = 1 AND il_selecthandlle > 0 THEN
	lstr_tree = ltv_item.data
	ls_pgmno = lstr_tree.pgm_no
	ls_pgmno = delete_pgm(ls_pgmno) + ls_pgmno
	
	replaceall(ls_pgmno, ',', "','")
	ls_pgmno = "'" + ls_pgmno + "'"
	ls_syntax = "Delete From CDDB.PF_BOOKMARK WHERE emp_code = '" + gs_empcode + "' and PGM_NO in (" + ls_pgmno + ")"
	EXECUTE IMMEDIATE :ls_syntax Using sqlca;
	
	IF sqlca.sqlcode <> 0 THEN
		Rollback Using sqlca;
		messagebox("Info", "삭제에 실패하였습니다")
	ELSE
		Commit Using sqlca;
		of_retrievebookmark()
	END IF 
END IF

end event

type uc_excel from w_default_response`uc_excel within w_bookmark
boolean visible = false
end type

type uc_ok from w_default_response`uc_ok within w_bookmark
boolean visible = false
integer width = 274
integer height = 84
end type

type uc_print from w_default_response`uc_print within w_bookmark
boolean visible = false
end type

type uc_run from w_default_response`uc_run within w_bookmark
boolean visible = false
integer width = 274
integer height = 84
end type

type uc_save from w_default_response`uc_save within w_bookmark
boolean visible = false
integer x = 1445
boolean originalsize = false
end type

event uc_save::clicked;call super::clicked;//ids_pgmmaster.acceptText()
//
//IF ids_pgmmaster.update() < 0 THEN
//	Messagebox("Info", "저장에 실패하였습니다.")
//	Rollback Using sqlca;
//ELSE
//	Commit Using sqlca;
//END IF

end event

type uc_retrieve from w_default_response`uc_retrieve within w_bookmark
boolean visible = false
end type

type dw_multi from w_default_response`dw_multi within w_bookmark
boolean visible = false
end type

type ln_templeft from w_default_response`ln_templeft within w_bookmark
end type

type ln_tempright from w_default_response`ln_tempright within w_bookmark
end type

type ln_tempstart from w_default_response`ln_tempstart within w_bookmark
end type

type ln_4 from w_default_response`ln_4 within w_bookmark
end type

type ln_temptop from w_default_response`ln_temptop within w_bookmark
end type

type ln_tempbutton from w_default_response`ln_tempbutton within w_bookmark
end type

type tv_menu from treeview within w_bookmark
integer x = 50
integer y = 240
integer width = 923
integer height = 1528
integer taborder = 10
boolean dragauto = true
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string pointer = "HyperLink!"
long textcolor = 23494034
boolean border = false
boolean disabledragdrop = false
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event begindrag;TreeViewItem		ltv_item
str_tree					lstr_tree

il_parent = handle

IF handle > 0 THEN
	IF This.GetItem(handle, ltv_item) = -1 THEN 
		il_parent  = 0
		This.Drag(Cancel!)
	ELSE
		lstr_tree = ltv_item.data
		IF lstr_tree.pgm_kd = 'M' THEN 
			il_parent  = 0
			This.Drag(Cancel!)
		END IF
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

SELECT Distinct  a.pgm_no				as pgm_no
		,a.pgm_id				as pgm_id
		,a.pgm_name			as pgm_nm
		,a.pgm_kind_code		as pgm_kc
		,a.picture					as pic
		,a.select_picture		as spic
		,a.sort_order				as sort_order
		,a.parent_pgm			as parent_pgm
FROM  cddb.pf_pgm_mst 	a, 
		 cddb.pf_pgm_role	b,
		 cddb.pf_userrole		c
WHERE c.emp_code				= :gs_empCode
    AND b.role_no					= c.role_no
    AND a.pgm_use_yn 			= 'Y'
    AND a.menu_use_yn 		= 'Y'
    AND a.pgm_no					= b.pgm_no 
    AND a.parent_pgm 			= :lstr_tree.pgm_no
ORDER BY a.parent_pgm asc, a.sort_order asc

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
	
	li_pic = Parent.of_getpictureindex( ls_pic, this)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = Parent.of_getpictureindex( ls_spic, this)
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

type tv_bookmark from treeview within w_bookmark
integer x = 1010
integer y = 240
integer width = 933
integer height = 1528
integer taborder = 20
boolean dragauto = true
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string pointer = "HyperLink!"
long textcolor = 23494034
boolean border = false
boolean editlabels = true
boolean disabledragdrop = false
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event selectionchanged;il_selecthandlle = newhandle

TreeViewItem		ltv_item
str_tree					lstr_tree

IF getItem(newhandle, ltv_item) > 0 THEN
	lstr_tree = ltv_item.data
	IF lstr_tree.pgm_kd = 'P' THEN
		This.EditLabels = false
	ELSE
		This.EditLabels = True
	END IF
END IF
end event

event endlabeledit;TreeViewItem		ltv_item
str_tree					lstr_data
Long						ll_row

IF handle > 0 THEN
	IF This.GetItem(handle, ltv_item) = -1 THEN return
	lstr_data = ltv_item.data
	lstr_data.pgm_nm = newtext
	
	Update cddb.pf_bookmark
	     set pgm_alsname = :newtext
	  where pgm_no = : lstr_data.pgm_no
	using sqlca;
	
	IF sqlca.sqlcode <> 0 THEN
		Rollback using sqlca;
		Messagebox("Error", "수정에 실패 하였습니다.")
		return 1
	ELSE
		Commit using sqlca;
	END IF
END IF
end event

event dragdrop;Long		ll_parenthandle, ll_handle, ll_childhandle
Long		ll_rtn, i
Long		ll_maxorder, ll_row, ll_currenthandle, ll_currentorder, ll_temporder
String	ls_findpgm[]
String	ls_pgmno, ls_gubun, ls_rtn, ls_NewParentNode, ls_OldParentNode, ls_oldNode, ls_newnode, ls_node, ls_classname
TreeViewItem		ltv_DragItem, ltv_DropItem, ltv_item
str_tree					lstr_Drag, lstr_Drop, lstr_item
TreeView				ltv_tree

Boolean	 lb_insert
IF checkparenthandle(this, handle, il_parent) THEN
	ib_drag = false
	return
END IF

ls_classname = source.Classname() 
This.ExpandItem(il_parent)

IF ls_classname = This.Classname() THEN
	IF messagebox("Info", "메뉴의 위치를 수정 하시겠습니까?", Question!, YesNo!, 2) = 2 THEN Return
	lb_insert = false
ELSE
	lb_insert = true
	ltv_tree = source
END IF

ll_handle = This.FindItem(RootTreeItem!, 0)
IF handle >= ll_handle THEN
	IF il_parent <> handle THEN
		//Drag한 node의 값을 가지고 있는다.
		
		IF lb_insert THEN
			ltv_tree.GetItem(il_parent, ltv_DragItem)
		ELSE
			IF This.GetItem(il_parent, ltv_DragItem) < 0 THEN Return
		END IF	

		lstr_Drag = ltv_DragItem.data
		ls_pgmno = lstr_Drag.PGM_NO
		
		IF This.GetItem(handle, ltv_DropItem) = 1 THEN
			lstr_Drop = ltv_DropItem.data
		END IF			
		
		//부모를 찾는다. node
		Choose Case True
			Case (lstr_Drag.pgm_kd = 'M' AND lstr_Drop.pgm_kd = 'M') OR (lstr_Drag.pgm_kd = 'P' AND lstr_Drop.pgm_kd = 'M' )
				IF messagebox("Question", "하위 메뉴로 추가 하시겠습니까?", Question!, YesNo!, 2) = 1 THEN
					ls_gubun = 'L'  //InsertItemLast
				ELSE
					ll_parenthandle = This.FindItem(ParentTreeItem!, handle)
					ls_gubun = 'I' //InsertItem
				END IF
			Case (lstr_Drag.pgm_kd = 'M' AND lstr_Drop.pgm_kd = 'P') OR (lstr_Drag.pgm_kd = 'P' AND lstr_Drop.pgm_kd = 'P' )
				ll_parenthandle = This.FindItem(ParentTreeItem!, handle)
				ls_gubun = 'I' //InsertItem
		END CHOOSE
		
		
		IF ls_gubun = 'I' THEN
//===================================
			This.getItem(ll_parenthandle, ltv_item)
			lstr_item = ltv_item.data
			
			DataStore	lds_data 
			lds_data = Create DataStore
			
			lds_data.dataobject = 'd_bookmark_sortupdate'
			lds_data.setTransObject(sqlca)
			
			lds_data.retrieve(lstr_item.pgm_no, lstr_drag.pgm_no, gs_empcode)
			
			lds_data.setfilter("parent_pgm = '" + lstr_item.pgm_no + "'")
			lds_data.filter()
			
			lds_data.setsort('sort_order asc')
			lds_data.sort()
			
			ll_temporder = 0
			ll_maxorder = 0
			ll_row = lds_data.rowcount()
			FOR i = 1 TO ll_row
				
				IF lds_data.getItemString(i, 'pgm_no') = lstr_Drop.pgm_no THEN
					ll_maxorder = i
				END IF
				
				IF ll_maxorder < i AND ll_maxorder > 0 THEN
					ll_temporder = 10000
				END IF
				
				lds_data.setItem(i, 'sort_order', i + ll_temporder)
			Next
			
			lds_data.setfilter('')
			lds_data.filter()
			
			ll_row = lds_data.find("pgm_no = '" + lstr_drag.pgm_no + "'", 1, lds_data.rowcount())
			IF ll_row = 0 THEN
				ll_row = lds_data.insertrow(0)
				lds_data.setItem(ll_row, 'emp_code', gs_empcode)
				lds_data.setItem(ll_row, 'pgm_no', lstr_Drag.pgm_no )
				lds_data.setItem(ll_row, 'pgm_alsname', lstr_Drag.pgm_nm )
			END IF
			lds_data.setItem(ll_row, 'parent_pgm', lstr_item.pgm_no)
			lds_data.setItem(ll_row, 'sort_order', ll_maxorder + 1 )
			
			lds_data.accepttext( )
			
			lds_data.sort()
			ll_row = lds_data.rowcount()
			FOR i = 1 TO ll_row
				lds_data.setItem(i, 'sort_order', i )
			Next
			
			IF lds_data.update() < 0 THEN
				Rollback using sqlca;
				messagebox("Error", "위치 이동에 실패 했습니다")
				return
			END IF
			
			Destroy lds_data
//===================================
		ELSEIF ls_gubun = 'L' THEN
//===================================						
			select max(sort_order)
			  into :ll_maxorder
			  from cddb.pf_bookmark 
			 where parent_pgm = :lstr_drop.pgm_no
				  and emp_code = :gs_empcode
			using sqlca;
			
			IF IsNull(ll_maxorder) THEN
				ll_maxorder = 0
			END IF
			
			ll_maxorder++
			
			IF lb_insert THEN
				Insert into cddb.pf_bookmark ( emp_code, pgm_no, pgm_alsname, parent_pgm, sort_order )
				 values ( :gs_empcode, :lstr_Drag.pgm_no, :lstr_Drag.pgm_nm, :lstr_drop.pgm_no, :ll_maxorder)
				using sqlca;
			ELSE
				Update cddb.pf_bookmark
					  set parent_pgm = :lstr_drop.pgm_no
							,sort_order = :ll_maxorder
				  where pgm_no = :lstr_drag.pgm_no
						and emp_code = :gs_empcode
				using sqlca;
			END IF		
			
			IF sqlca.sqlcode <> 0 THEN
				Rollback using sqlca;
				messagebox("Error", "위치 이동에 실패 했습니다")
				return
			END IF
//===================================						
		END IF

//==========================================================
		commit using sqlca;
		
		gf_openwait()
		This.setRedRaw(False)
		
		//옮겨진 Data 찾기. =================
		ll_parenthandle = handle
		i = 1
		ls_findpgm[i] = lstr_drop.pgm_no
		do while true
			ll_parenthandle = This.FindItem(ParentTreeItem!, ll_parenthandle)
			IF ll_parenthandle < 0 THEN Exit
			
			This.getItem(ll_parenthandle, ltv_item)
			lstr_item = ltv_item.data
			i++
			ls_findpgm[i] = lstr_item.pgm_no
		loop
		
		Parent.of_retrievebookmark()
		
		ll_parenthandle = This.FindItem(RootTreeITem!, 0)
		This.Expanditem( ll_parenthandle )
		ll_row = UpperBound(ls_findpgm) - 1
		
		FOR i = ll_row TO 1 Step -1
			ll_parenthandle = This.FindItem(ChildTreeItem!, ll_parenthandle)
			do while ll_parenthandle > -1
				This.getItem(ll_parenthandle, ltv_item)
				lstr_item = ltv_item.data
				IF ls_findpgm[i] = lstr_item.pgm_no THEN
					this.Expanditem(ll_parenthandle)
					this.selectitem(ll_parenthandle)
					Exit
				End If
				ll_parenthandle = This.FindItem(NextTreeItem!, ll_parenthandle)
			loop
		NEXT
		//==================================
		This.setRedRaw(True)
		gf_closewait()
//==========================================================
	END IF
END IF

ib_drag = False


end event

event begindrag;il_parent = handle
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
	
	li_pic = Parent.of_getpictureindex( ls_pic, this)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = Parent.of_getpictureindex( ls_spic, this)
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

event dragwithin;ib_drag = true
end event

type st_2 from statictext within w_bookmark
integer x = 114
integer y = 172
integer width = 402
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 20286463
long backcolor = 16777215
string text = "메뉴"
long bordercolor = 31439244
boolean focusrectangle = false
end type

type st_3 from statictext within w_bookmark
integer x = 1074
integer y = 172
integer width = 402
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 20286463
long backcolor = 16777215
string text = "북마크"
long bordercolor = 31439244
boolean focusrectangle = false
end type

type p_2 from picture within w_bookmark
integer x = 50
integer y = 172
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_bookmark
integer x = 1010
integer y = 172
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type r_3 from rectangle within w_bookmark
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 46
integer y = 236
integer width = 933
integer height = 1536
end type

type r_4 from rectangle within w_bookmark
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 1006
integer y = 236
integer width = 942
integer height = 1536
end type

