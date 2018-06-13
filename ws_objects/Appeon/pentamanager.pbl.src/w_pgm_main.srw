$PBExportHeader$w_pgm_main.srw
forward
global type w_pgm_main from w_default_templet
end type
type tv_menu from treeview within w_pgm_main
end type
type st_2 from statictext within w_pgm_main
end type
type st_1 from statictext within w_pgm_main
end type
type st_3 from statictext within w_pgm_main
end type
type uc_btinsert from u_picture within w_pgm_main
end type
type uc_btsave from u_picture within w_pgm_main
end type
type uc_getbutton from uo_imgbtn within w_pgm_main
end type
type uc_btdelete from u_picture within w_pgm_main
end type
type st_4 from statictext within w_pgm_main
end type
type tv_preview from treeview within w_pgm_main
end type
type p_2 from picture within w_pgm_main
end type
type p_1 from picture within w_pgm_main
end type
type p_3 from picture within w_pgm_main
end type
type p_4 from picture within w_pgm_main
end type
type r_1 from rectangle within w_pgm_main
end type
type r_4 from rectangle within w_pgm_main
end type
type r_5 from rectangle within w_pgm_main
end type
type r_8 from rectangle within w_pgm_main
end type
end forward

global type w_pgm_main from w_default_templet
string title = "프로그램 등록"
windowstate windowstate = maximized!
tv_menu tv_menu
st_2 st_2
st_1 st_1
st_3 st_3
uc_btinsert uc_btinsert
uc_btsave uc_btsave
uc_getbutton uc_getbutton
uc_btdelete uc_btdelete
st_4 st_4
tv_preview tv_preview
p_2 p_2
p_1 p_1
p_3 p_3
p_4 p_4
r_1 r_1
r_4 r_4
r_5 r_5
r_8 r_8
end type
global w_pgm_main w_pgm_main

type variables
String	imgpath		= "..\img\icon\"
Long		il_handle, il_parent, il_thishandle
Integer	ii_checked
Boolean	ib_modify


end variables

forward prototypes
public subroutine of_setpreview ()
public subroutine of_retrievemenu ()
public function string delete_pgm (string as_parentnode)
public function integer of_getpictureindex (string as_picname, treeview astr_tree)
end prototypes

public subroutine of_setpreview ();TreeViewItem			ltv_item
Integer					li_pic
Long						ll_handle
str_tree					lstr_tree
String					ls_name, ls_pic, ls_spic
long tvi_hdl = 0

DO UNTIL tv_preview.FindItem(RootTreeItem!, 0) = -1
    tv_preview.DeleteItem(tvi_hdl)
LOOP

Declare cur CURSOR FOR
SELECT  	 pgm_no
				,pgm_id
				,pgm_name
				,pgm_kind_code
				,picture
				,select_picture
				,sort_order
				,parent_pgm
	FROM  cddb.pf_pgm_mst
 WHERE pgm_use_yn = 'Y'
	 AND menu_use_yn = 'Y'
	 AND parent_pgm = 'ZZZZZ'
ORDER BY sort_order asc

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
	
	ll_handle = tv_preview.InsertItemLast(0, ltv_item)
loop

Close cur;

tv_preview.ExpandItem( ll_handle )
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
SELECT  pgm_no
			,pgm_id
			,pgm_name
			,pgm_kind_code
			,picture
			,select_picture
			,sort_order
			,parent_pgm
	FROM  cddb.pf_pgm_mst 	
 WHERE parent_pgm = 'ZZZZZ'
ORDER BY sort_order asc

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

public function string delete_pgm (string as_parentnode);String	ls_pgm_no, ls_rtn, ls_parentnode
Long		ll_cnt, i, li_row
String  ls_pgm[]

DECLARE pgm_cur CURSOR FOR
	SELECT PGM_NO FROM CDDB.PF_PGM_MST WHERE PARENT_PGM = :as_parentnode
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
      From cddb.pf_pgm_mst
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

on w_pgm_main.create
int iCurrent
call super::create
this.tv_menu=create tv_menu
this.st_2=create st_2
this.st_1=create st_1
this.st_3=create st_3
this.uc_btinsert=create uc_btinsert
this.uc_btsave=create uc_btsave
this.uc_getbutton=create uc_getbutton
this.uc_btdelete=create uc_btdelete
this.st_4=create st_4
this.tv_preview=create tv_preview
this.p_2=create p_2
this.p_1=create p_1
this.p_3=create p_3
this.p_4=create p_4
this.r_1=create r_1
this.r_4=create r_4
this.r_5=create r_5
this.r_8=create r_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_menu
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.uc_btinsert
this.Control[iCurrent+6]=this.uc_btsave
this.Control[iCurrent+7]=this.uc_getbutton
this.Control[iCurrent+8]=this.uc_btdelete
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.tv_preview
this.Control[iCurrent+11]=this.p_2
this.Control[iCurrent+12]=this.p_1
this.Control[iCurrent+13]=this.p_3
this.Control[iCurrent+14]=this.p_4
this.Control[iCurrent+15]=this.r_1
this.Control[iCurrent+16]=this.r_4
this.Control[iCurrent+17]=this.r_5
this.Control[iCurrent+18]=this.r_8
end on

on w_pgm_main.destroy
call super::destroy
destroy(this.tv_menu)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.uc_btinsert)
destroy(this.uc_btsave)
destroy(this.uc_getbutton)
destroy(this.uc_btdelete)
destroy(this.st_4)
destroy(this.tv_preview)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.p_3)
destroy(this.p_4)
destroy(this.r_1)
destroy(this.r_4)
destroy(this.r_5)
destroy(this.r_8)
end on

event ue_postopen;call super::ue_postopen;dw_tran.SetTransObject(sqlca)
dw_view.SetTransObject(sqlca)

dw_tran.insertrow(0)
gf_openwait()
This.of_retrievemenu()
This.of_setpreview()
gf_closewait()
end event

type ln_templeft from w_default_templet`ln_templeft within w_pgm_main
end type

type ln_tempright from w_default_templet`ln_tempright within w_pgm_main
end type

type ln_temptop from w_default_templet`ln_temptop within w_pgm_main
end type

type ln_tempbuttom from w_default_templet`ln_tempbuttom within w_pgm_main
end type

type ln_tempbutton from w_default_templet`ln_tempbutton within w_pgm_main
end type

type ln_tempstart from w_default_templet`ln_tempstart within w_pgm_main
end type

type uc_retrieve from w_default_templet`uc_retrieve within w_pgm_main
boolean visible = false
end type

type uc_save from w_default_templet`uc_save within w_pgm_main
integer x = 3017
boolean originalsize = false
end type

event uc_save::clicked;call super::clicked;Long		ll_rtn, ll_row, i, ll_handle
String	ls_sql, ls_pgmno, ls_colname, ls_type
s_row	lstr_data
any 		data
String	ls_parentnode, ls_pnode, ls_pnodec, ls_check, ls_oldparentnode
dw_tran.Accepttext( )

IF dw_tran.GetItemStatus(1, 0, Primary!) = NotModified!	 OR dw_tran.GetItemStatus(1, 0, Primary!) = New! 	 THEN 	
	Return
END IF

ls_check = dw_tran.GetItemString(1, 'pgm_kind_code')
IF ls_check = 'P' THEN
	ls_check = dw_tran.GetItemString(1, 'pgm_id')
	IF ls_Check = '' OR IsNull(ls_check) THEN
		Messagebox("Info", "프로그램 아이디를 설정하여 주시기 바랍니다.")
		dw_tran.SetColumn('pgm_id')
		dw_tran.SetFocus()
		Return
	END IF
END IF

ls_parentnode 		= dw_tran.GetItemString(1, 'parent_pgm', Primary!	, False)
ls_oldparentnode	= dw_tran.GetItemString(1, 'parent_pgm', Primary!	, True)
IF IsNull(ls_parentnode) OR ls_parentnode = '' THEN
	messagebox("Info", "상위 메뉴를 등록해 주시기 바랍니다.")
	dw_tran.SetColumn('parent_pgm')
	return
END IF

gf_openwait()
tv_menu.setRedRaw(false)

IF Not ib_modify THEN
	select max(pgm_no)
	into    :ls_pgmno
	from cddb.pf_pgm_mst
	using sqlca;

	IF sqlca.sqlcode < 0 THEN
		Messagebox("Info", "Select Failed : " + sqlca.sqlerrtext)
	ELSE
		IF IsNull(ls_pgmno) THEN 
			ls_pgmno = '00000'
		ELSE
			ls_pgmno = String(Long(ls_pgmno) + 1, '00000')
		END IF
		
		dw_tran.setItem(1, 'pgm_no', ls_pgmno)
	END IF
END IF

ll_rtn = dw_tran.update()
IF ll_rtn < 0 THEN
	Rollback Using sqlca;
	messagebox("Info", "저장 실패")
ELSE
	Commit Using sqlca;
	Parent.of_retrievemenu()
	Parent.of_setpreview( )
END IF

tv_menu.setRedRaw(True)
gf_closewait()

end event

type uc_run from w_default_templet`uc_run within w_pgm_main
boolean visible = false
end type

type uc_print from w_default_templet`uc_print within w_pgm_main
boolean visible = false
end type

type uc_ok from w_default_templet`uc_ok within w_pgm_main
boolean visible = false
end type

type uc_excel from w_default_templet`uc_excel within w_pgm_main
boolean visible = false
end type

type uc_delete from w_default_templet`uc_delete within w_pgm_main
integer x = 2725
end type

event uc_delete::clicked;call super::clicked;String		ls_pgmno, ls_delete[], ls_pgmnode
Long			ll_rtn, delcnt
Datastore	lds_data[]

dw_tran.AcceptText()

ls_pgmno = dw_tran.getItemString(1, 'pgm_no')

IF ls_pgmno = '00000' THEN 
	messagebox("Info", "해당 메뉴는 삭제할 수 없습니다.")
ELSEIF Len(ls_pgmno) = 0 THEN
	uc_insert.TriggerEvent(Clicked!)
ELSE
	IF Messagebox("Question", "시스템에 영향을 줄수 있습니다.~r~n삭제 하시겠습니까?", Question!, YesNo!, 2) = 1 THEN
		IF Trim(ls_pgmno) = '' OR IsNull(ls_pgmno) THEN
			uc_insert.TriggerEvent(Clicked!)
		ELSE
			dw_tran.SetRedRaw(False)
			
			ls_pgmnode = Parent.delete_pgm(ls_pgmno)

			
			//menu일때 menu가 아닐때..
			//==========================================================
			TreeViewItem		ltv_item
			str_tree					lstr_tree
			Long						ll_handle, ll_cnt, ll_row
			String					ls_syntax
			
			ls_pgmno = ls_pgmnode + ls_pgmno
			replaceall(ls_pgmno, ',', "','")
			ls_pgmno = "'" + ls_pgmno + "'"

			ls_syntax = "Delete From CDDB.PF_PGM_BTN WHERE PGM_NO in (" + ls_pgmno + ")"
			EXECUTE IMMEDIATE :ls_syntax Using sqlca;
			IF sqlca.sqlcode <> 0 THEN
				Rollback Using sqlca;
				messagebox("Info", "삭제에 실패하였습니다")
			ELSE
				ls_syntax = "Delete From CDDB.PF_BOOKMARK WHERE PGM_NO in (" + ls_pgmno + ")"
				EXECUTE IMMEDIATE :ls_syntax Using sqlca;
				IF sqlca.sqlcode <> 0 THEN
					Rollback Using sqlca;
					messagebox("Info", "삭제에 실패하였습니다")
				ELSE
					ls_syntax = "Delete From CDDB.PF_PGM_ROLE WHERE PGM_NO in (" + ls_pgmno + ")"
					EXECUTE IMMEDIATE :ls_syntax Using sqlca;
					IF sqlca.sqlcode <> 0 THEN
						Rollback Using sqlca;
						messagebox("Info", "삭제에 실패하였습니다")
					ELSE
						ls_syntax = "Delete From CDDB.PF_PGM_MST WHERE PGM_NO in (" + ls_pgmno + ")"
						EXECUTE IMMEDIATE :ls_syntax Using sqlca;
						IF sqlca.sqlcode <> 0 THEN
							Rollback Using sqlca;
							messagebox("Info", "삭제에 실패하였습니다")
							Return
						ELSE
							Commit Using sqlca;
							uc_insert.TriggerEvent(Clicked!)
						END IF
					END IF
				END IF
			END IF
				
			dw_tran.SetRedRaw(True)
			tv_menu.setRedRaw(false)
			Parent.of_retrievemenu()
			Parent.of_setpreview( )
			
			tv_menu.setRedRaw(True)
			
			dw_view.reset()
			
			ib_modify = False
		END IF
	END IF
END IF
end event

type uc_close from w_default_templet`uc_close within w_pgm_main
boolean visible = false
end type

type uc_cancel from w_default_templet`uc_cancel within w_pgm_main
boolean visible = false
end type

type uc_insert from w_default_templet`uc_insert within w_pgm_main
integer x = 2432
end type

event uc_insert::clicked;call super::clicked;dw_tran.reset()
dw_tran.insertrow(0)
dw_tran.Modify('pgm_use_yn.protect=0')
dw_view.reset()

ib_modify = false
il_handle = 0
end event

type dw_tran from w_default_templet`dw_tran within w_pgm_main
integer x = 1472
integer y = 240
integer width = 1819
integer height = 1012
string dataobject = "d_pgm_master"
end type

event dw_tran::dragdrop;call super::dragdrop;TreeViewItem		ltv_item
TreeView				ltv_menu
str_tree					lstr_tree

ltv_menu = source

IF row > 0 THEN
	IF dwo.name = 'parent_pgm' THEN
		IF il_parent > 1 OR This.GetItemStatus(1,0,Primary!) = NewModified! THEN
			ltv_menu.GetItem(il_parent, ltv_item)
			lstr_tree = ltv_item.data
			IF lstr_tree.pgm_kd = 'M' THEN
				String 	ls_sql, ls_arg
				Long		ll_rtn, ll_sortorder
				String		ls_node
				s_row		lstr_data
		
				select max(sort_order)
				 into  :ll_sortorder
				  from 	cddb.pf_pgm_mst
				where parent_pgm = :lstr_tree.pgm_no
				
				Using sqlca;
				
				IF IsNull(ll_sortorder) THEN ll_sortorder = 0
				
				This.SetItem(1, 'parent_pgm', lstr_tree.pgm_no)
				
				ll_sortorder++
				This.SetItem(1, 'sort_order', ll_sortorder)
			END IF
		END IF
	ELSEIF dwo.name = 'pgm_no' THEN
		ib_modify = True
		il_handle = il_parent
		ltv_menu.GetItem(il_handle, ltv_item)
		
		lstr_tree	= ltv_item.Data
		
		dw_tran.retrieve(lstr_tree.pgm_no)
		dw_view.retrieve(lstr_tree.pgm_no)
		
		IF lstr_tree.pgm_kd = 'M' THEN
			uc_getbutton.Enabled = false
			This.Modify('pgm_use_yn.protect=1')
		ELSE
			uc_getbutton.Enabled = true
			This.Modify('pgm_use_yn.protect=0')
		END IF
	END IF
END IF
end event

event dw_tran::itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'pgm_kind_code'
		IF data = 'M' THEN
			This.SetItem(1, 'pgm_id', '')
			This.SetItem(1, 'pgm_use_yn', 'Y')
			This.Modify('pgm_use_yn.protect=1')
		ELSE
			This.SetItem(1, 'pgm_use_yn', 'Y')
			This.Modify('pgm_use_yn.protect=0')
		END IF
	CASE 'pgm_id'
		IF Trim(data) = '' OR IsNull(data) THEN
			This.SetItem(1, 'pgm_kind_code', 'M')
		ELSE
			This.SetItem(1, 'pgm_kind_code', 'P')
		END IF
END CHOOSE
end event

event dw_tran::doubleclicked;call super::doubleclicked;IF dwo.name = 'pgm_id' THEN
	OpenwithParm(w_window_pop, '', Parent)
	//V1.9.9.017   w_window_pop을 띄우고 난후 갑을 받아 오지 못함. 
	Vector lvc_data
	lvc_data = Message.PowerObjectParm
	IF IsValid(lvc_data) THEN
		This.SetItem(row, dwo.name, Upper(lvc_data.getProperty("classname")))
		This.SetItem(row, "pgm_name", lvc_data.getProperty("comment"))
	END IF
	//==============================
	//	String ls_win
	//	ls_win = Message.StringParm
	//	IF Not IsNull(ls_win) AND Trim(ls_win) <> '' THEN
	//		This.SetItem(row, dwo.name, Upper(ls_win))
	//	END IF
	//==============================
END IF
end event

type dw_view from w_default_templet`dw_view within w_pgm_main
integer x = 1467
integer y = 1488
integer width = 1829
integer height = 624
string dataobject = "d_pgm_btn_master"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type tv_menu from treeview within w_pgm_main
integer x = 50
integer y = 236
integer width = 1385
integer height = 1876
integer taborder = 10
boolean dragauto = true
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 23494034
boolean border = false
boolean disabledragdrop = false
boolean trackselect = true
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event begindrag;//il_handle = handle
il_parent = handle
end event

event dragdrop;Long		ll_parenthandle, ll_handle, ll_childhandle
Long		ll_rtn, i
Long		ll_maxorder, ll_row, ll_currenthandle, ll_currentorder, ll_temporder
String	ls_findpgm[]
String	ls_pgmno, ls_gubun, ls_rtn, ls_NewParentNode, ls_OldParentNode, ls_oldNode, ls_newnode, ls_node
TreeViewItem		ltv_DragItem, ltv_DropItem, ltv_item
str_tree					lstr_Drag, lstr_Drop, lstr_item

This.ExpandItem(il_parent)
IF messagebox("Info", "메뉴의 위치를 수정 하시겠습니까?", Question!, YesNo!, 2) = 1 THEN
	uc_insert.TriggerEvent(Clicked!)
	
	ll_handle = This.FindItem(RootTreeItem!, 0)
	IF handle >= ll_handle THEN
		IF il_parent <> handle THEN
			//Drag한 node의 값을 가지고 있는다.
			IF This.GetItem(il_parent, ltv_DragItem) = 1 THEN
				lstr_Drag = ltv_DragItem.data
				ls_pgmno = lstr_Drag.PGM_NO
				IF This.GetItem(handle, ltv_DropItem) = 1 THEN
					lstr_Drop = ltv_DropItem.data
				END IF			
				
				//부모를 찾는다. node
				Choose Case True
					Case (lstr_Drag.pgm_kd = 'M' AND lstr_Drop.pgm_kd = 'M') OR (lstr_Drag.pgm_kd = 'P' AND lstr_Drop.pgm_kd = 'M' )
						IF messagebox("Question", "하위 메뉴로 추가 하시겠습니까?", Question!, YesNo!, 2) = 1 THEN
							ls_gubun = 'L'
						ELSE
							ll_parenthandle = This.FindItem(ParentTreeItem!, handle)
							ls_gubun = 'I'
						END IF
					Case (lstr_Drag.pgm_kd = 'M' AND lstr_Drop.pgm_kd = 'P') OR (lstr_Drag.pgm_kd = 'P' AND lstr_Drop.pgm_kd = 'P' )
						ll_parenthandle = This.FindItem(ParentTreeItem!, handle)
						ls_gubun = 'I' //InsertItem
				END CHOOSE
				
				IF ls_gubun = 'I' THEN
					This.getItem(ll_parenthandle, ltv_item)
					lstr_item = ltv_item.data
					
					DataStore	lds_data 
					lds_data = Create DataStore
					
					lds_data.dataobject = 'd_pgm_sortupdate'
					lds_data.setTransObject(sqlca)
					
					lds_data.retrieve(lstr_item.pgm_no, lstr_drag.pgm_no)
					
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
				ELSEIF ls_gubun = 'L' THEN
					select max(sort_order)
					  into :ll_maxorder
					  from cddb.pf_pgm_mst 
				    where parent_pgm = :lstr_drop.pgm_no
					using sqlca;
					
					IF IsNull(ll_maxorder) THEN
						ll_maxorder = 0
					END IF
					
					ll_maxorder++
					Update cddb.pf_pgm_mst
						  set parent_pgm = :lstr_drop.pgm_no
						      ,sort_order = :ll_maxorder
					  where pgm_no = :lstr_drag.pgm_no
					using sqlca;
					
					IF sqlca.sqlcode <> 0 THEN
						Rollback using sqlca;
						messagebox("Error", "위치 이동에 실패 했습니다")
						return
					END IF
					
				END IF
				
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
				
				Parent.of_retrievemenu()
				Parent.of_setpreview( )
				
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
							this.SelectItem(ll_parenthandle)
							Exit
						End If
						ll_parenthandle = This.FindItem(NextTreeItem!, ll_parenthandle)
					loop
				NEXT
				//==================================
				This.setRedRaw(True)
				gf_closewait()
	
			END IF
		END IF
	END IF
END IF	

end event

event clicked;This.SelectItem(handle)

end event

event selectionchanged;TreeViewItem	item
str_tree					lstr_tree
this.getItem(newhandle, item)
IF newhandle > 0 THEN
	lstr_tree = item.data
	f_set_message(lstr_tree.pgm_id, "INFO", gw_mdi)
END IF
ii_checked 	= item.StatePictureIndex
il_thishandle	= newhandle
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
SELECT  pgm_no
			,pgm_id
			,pgm_name
			,pgm_kind_code
			,picture
			,select_picture
			,sort_order
			,parent_pgm
	FROM  cddb.pf_pgm_mst 	
 WHERE parent_pgm = :lstr_tree.pgm_no
ORDER BY sort_order asc

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
	
	li_pic = Parent.of_getpictureindex( ls_pic, tv_menu)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = Parent.of_getpictureindex( ls_spic, tv_menu)
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

type st_2 from statictext within w_pgm_main
integer x = 123
integer y = 172
integer width = 553
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "전체 프로그램 메뉴"
boolean focusrectangle = false
end type

type st_1 from statictext within w_pgm_main
integer x = 1541
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
long textcolor = 25123896
long backcolor = 16777215
string text = "Program"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pgm_main
integer x = 1545
integer y = 1420
integer width = 402
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "Button List"
boolean focusrectangle = false
end type

type uc_btinsert from u_picture within w_pgm_main
integer x = 2446
integer y = 1292
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_add.gif"
end type

event clicked;call super::clicked;String 	ls_pgmno, ls_pgmid
Long		ll_row

IF dw_tran.rowcount() > 0 THEN
	IF dw_tran.GetItemString(1, "pgm_kind_code") = 'P' THEN
		ls_pgmno	= dw_tran.GetItemString(1, "pgm_no") 
		ls_pgmid	= dw_tran.GetItemString(1, "pgm_id") 
		IF Not ( IsNull(ls_pgmno) OR ls_pgmno = '' ) THEN
			ll_row = dw_view.insertrow(0)
			dw_view.SetItem(ll_row, 'pgm_no', ls_pgmno)
			//V1.9.9.019  추가 한다음 바로 저장하면 에러가 남..
			dw_view.SetItemStatus(ll_row, 0, Primary!, NotModified!)
			//=================================
			dw_view.ScrollToRow(ll_row)
		END IF
	END IF
END IF
end event

type uc_btsave from u_picture within w_pgm_main
integer x = 3031
integer y = 1292
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_save.gif"
end type

event clicked;call super::clicked;IF dw_view.update() < 0 THEN
	Rollback using sqlca;
	Long		ll_row, ll_cnt, ll_colcnt, i, j
	String	ls_colname, ls_type
	any		data
	ll_colcnt = dw_view.Object.Datawindow.Column.Count
	ll_cnt		 = dw_view.rowcount()
	
	FOR i = ll_cnt TO 1 Step -1 
		FOR j = ll_colcnt To 1 Step -1
			ls_colname = dw_view.Describe("#" + String(j) + ".name")
			ls_type = dw_view.Describe(ls_colname + ".ColType")
			CHOOSE CASE TRUE
				CASE Pos(Upper(ls_type), 'CHAR', 1) > 0
					data	 = dw_view.GetItemString(i, ls_colname, Primary!, True)
				CASE Pos(Upper(ls_type), 'ULONG', 1) > 0 OR Pos(Upper(ls_type), 'INT', 1) > 0 OR Pos(Upper(ls_type), 'LONG', 1) > 0 OR Pos(Upper(ls_type), 'REAL', 1) > 0 
					data	 = dw_view.GetItemNumber(i, ls_colname, Primary!, True)
				CASE Pos(Upper(ls_type), 'DATETIME', 1) = 0 AND Pos(Upper(ls_type), 'DATE', 1) > 0
					data	 = dw_view.GetItemDate(i, ls_colname, Primary!, True)
				CASE Pos(Upper(ls_type), 'DATETIME', 1) > 0 
					data	 = dw_view.GetItemDateTime(i,ls_colname, Primary!, True)
				CASE Pos(Upper(ls_type), 'DECIMAL', 1) > 0
					data	 = dw_view.GetItemDecimal(i, ls_colname, Primary!, True)
				CASE Pos(Upper(ls_type), 'TIME', 1) > 0 OR Pos(Upper(ls_type), 'TIMESTAMP', 1) > 0 
					data	 = dw_view.GetItemTime(i, ls_colname, Primary!, True)
			END CHOOSE
			dw_view.setItem(i, ls_colname, data)
		NEXT
	Next
	
	dw_view.AcceptText()
	dw_view.resetupdate()
ELSE
	Commit using sqlca;
END IF


end event

type uc_getbutton from uo_imgbtn within w_pgm_main
integer x = 1477
integer y = 1292
integer width = 631
integer height = 72
integer taborder = 20
boolean bringtotop = true
string btnname = "프로그램 버튼 Sync"
end type

on uc_getbutton.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;Long					ll_cnt, ll_row, i
s_row				lstr_data
str_tree				lstr_tree
treeviewItem		ltv_item
String				ls_btnid
String				ls_pgmno, ls_pgmid

IF dw_tran.rowcount() > 0 THEN
	IF dw_tran.GetItemString(1, "pgm_kind_code") = 'P' THEN
		ls_pgmno	= dw_tran.GetItemString(1, "pgm_no") 
		ls_pgmid	= dw_tran.GetItemString(1, "pgm_id") 
		IF Not ( IsNull(ls_pgmno) OR ls_pgmno = '' ) THEN
			IF FindObject(ls_pgmid) THEN
				gf_getbuttonlist(ls_pgmid, lstr_data)
				ll_cnt = UpperBound(lstr_data.row)
				FOR i = ll_cnt TO 1 Step -1
					ll_row = dw_view.Find("btn_id='" +  lstr_data.row[i].data[1] + "'", 1, dw_view.rowcount())
					IF ll_Row = 0 THEN
						ll_row = dw_view.Insertrow(0)
						dw_view.SetItem(ll_row, 'pgm_no', ls_pgmno)
						dw_view.SetItem(ll_row, 'btn_id', lstr_data.row[i].data[1])
						dw_view.SetItem(ll_row, 'visible', lstr_data.row[i].data[2])
					ELSE
						dw_view.SetItem(ll_row, 'visible', lstr_data.row[i].data[2])
					END IF
				NEXT
			ELSE
				MessageBox("Info", "해당 " + ls_pgmid + "가 존재하지 않습니다.")
			END IF
		END IF
	END IF
END IF

dw_view.setsort('visible A')
dw_view.sort()
end event

type uc_btdelete from u_picture within w_pgm_main
integer x = 2738
integer y = 1292
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_view.deleterow(0)

IF dw_view.update() < 0 THEN
	Rollback using sqlca;
	messagebox("Info", "삭제 실패")
	dw_view.RowsMove ( 1, dw_view.DeletedCount ( ) , Delete!, dw_view, dw_view.rowcount() + 1, Primary! )	
ELSE
	Commit using sqlca;
END IF
end event

type st_4 from statictext within w_pgm_main
integer x = 3397
integer y = 172
integer width = 672
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "사용 프로그램 미리보기"
boolean focusrectangle = false
end type

type tv_preview from treeview within w_pgm_main
event ue_postconstructor ( )
integer x = 3328
integer y = 240
integer width = 1106
integer height = 1872
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 23494034
boolean border = false
boolean disabledragdrop = false
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event itemexpanding;TreeViewItem 			ltv_item
Integer					li_pic
long						i, ll_cnt
str_tree					lstr_tree
String					ls_name, ls_pic, ls_spic

this.getitem( handle, ltv_item )

IF ltv_item.ExpandedOnce THEN Return
lstr_tree 	= ltv_item.data

Declare cur CURSOR FOR
SELECT  	 pgm_no
				,pgm_id
				,pgm_name
				,pgm_kind_code
				,picture
				,select_picture
				,sort_order
				,parent_pgm
	FROM  cddb.pf_pgm_mst
 WHERE pgm_use_yn = 'Y'
	 AND menu_use_yn = 'Y'
	 AND parent_pgm = :lstr_tree.pgm_no
ORDER BY sort_order asc
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
	
	li_pic = Parent.of_getpictureindex( ls_pic, tv_preview)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = Parent.of_getpictureindex( ls_spic, tv_preview)
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

type p_2 from picture within w_pgm_main
integer x = 50
integer y = 172
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_pgm_main
integer x = 1467
integer y = 172
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_pgm_main
integer x = 3323
integer y = 172
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_4 from picture within w_pgm_main
integer x = 1472
integer y = 1420
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type r_1 from rectangle within w_pgm_main
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 46
integer y = 232
integer width = 1394
integer height = 1884
end type

type r_4 from rectangle within w_pgm_main
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 1472
integer y = 236
integer width = 1819
integer height = 1020
end type

type r_5 from rectangle within w_pgm_main
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 1467
integer y = 1484
integer width = 1829
integer height = 632
end type

type r_8 from rectangle within w_pgm_main
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 3323
integer y = 236
integer width = 1115
integer height = 1880
end type

