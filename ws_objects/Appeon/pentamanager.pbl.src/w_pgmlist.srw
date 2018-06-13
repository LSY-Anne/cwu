$PBExportHeader$w_pgmlist.srw
forward
global type w_pgmlist from w_default_response
end type
type tv_menu from treeview within w_pgmlist
end type
type dw_btnlist from uo_dwlv within w_pgmlist
end type
type st_2 from statictext within w_pgmlist
end type
type st_3 from statictext within w_pgmlist
end type
type st_4 from statictext within w_pgmlist
end type
type tv_preview from treeview within w_pgmlist
end type
type st_5 from statictext within w_pgmlist
end type
type p_2 from picture within w_pgmlist
end type
type p_1 from picture within w_pgmlist
end type
type p_3 from picture within w_pgmlist
end type
type p_4 from picture within w_pgmlist
end type
type r_1 from rectangle within w_pgmlist
end type
type r_2 from rectangle within w_pgmlist
end type
type r_6 from rectangle within w_pgmlist
end type
type r_7 from rectangle within w_pgmlist
end type
end forward

global type w_pgmlist from w_default_response
integer width = 3881
integer height = 2056
string title = "Role 프로그램 선택"
tv_menu tv_menu
dw_btnlist dw_btnlist
st_2 st_2
st_3 st_3
st_4 st_4
tv_preview tv_preview
st_5 st_5
p_2 p_2
p_1 p_1
p_3 p_3
p_4 p_4
r_1 r_1
r_2 r_2
r_6 r_6
r_7 r_7
end type
global w_pgmlist w_pgmlist

type variables
String	imgpath		= "..\img\icon\"
Long		il_handle
String	is_roleno


end variables

forward prototypes
public subroutine of_retrievemenu ()
public subroutine of_setpreview ()
public subroutine of_setdata (string as_pgmno)
public subroutine of_deletedata (string as_pgmno)
public function integer of_getpictureindex (string as_picname, treeview astr_tree)
end prototypes

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
	FROM  cddb.pf_pgm_mst pf_pgm_mst	
 WHERE parent_pgm = 'ZZZZZ'
     AND pgm_use_yn = 'Y'
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
SELECT a.pgm_no					as pgm_no
			,a.pgm_id					as pgm_id
			,a.pgm_name			as pgm_nm
			,a.pgm_kind_code		as pgm_kc
			,a.picture					as pic
			,a.select_picture		as spic
			,a.sort_order				as sort_order
			,a.parent_pgm			as parent_pgm
	FROM  cddb.pf_pgm_mst 	a, 
			 cddb.pf_pgm_role	 b
 WHERE a.pgm_use_yn 		= 'Y'
	  AND b.role_no 			= :is_roleno
	  AND a.pgm_no			= b.pgm_no	
	  AND a.parent_pgm = 'ZZZZZ'
ORDER BY a.parent_pgm asc,  a.sort_order asc

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
	
	li_pic = This.of_getpictureindex( ls_pic, tv_preview)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = This.of_getpictureindex( ls_spic, tv_preview)
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

public subroutine of_setdata (string as_pgmno);Long		ll_cnt, i, ll_rtn, ll_row
String	ls_pgmno

DataStore		lds_data
lds_data = Create DataStore
lds_data.DataObject = 'd_search_pgm'
lds_data.SetTransObject(sqlca)

IF sqlca.sqlcode = 0 THEN
	ll_cnt = lds_data.retrieve(as_pgmno)	
END IF

IF ll_cnt > 0 THEN
	FOR i = ll_cnt TO 1 Step -1
		ll_rtn = dw_multi.rowcount()
		ls_pgmno = lds_data.getItemString(i, 1)
		IF dw_multi.Find("pgm_no='" + ls_pgmno + "'", 1, ll_rtn) = 0 THEN
			ll_row = dw_multi.Insertrow(0)
			dw_multi.SetItem(ll_row, 'role_no', is_roleno)
			dw_multi.SetItem(ll_row, 'pgm_no',  lds_data.getItemString(i, 1))
			dw_multi.SetItem(ll_row, 'pgm_id',  lds_data.getItemString(i, 2))
			dw_multi.SetItem(ll_row, 'pgm_name',  lds_data.getItemString(i, 3))
		END IF
		
		of_setdata( ls_pgmno )
	NEXT
END IF

end subroutine

public subroutine of_deletedata (string as_pgmno);Long		ll_cnt, i, ll_rtn, ll_row
String	ls_pgmno

DataStore		lds_data
lds_data = Create DataStore
lds_data.DataObject = 'd_search_pgm'
lds_data.SetTransObject(sqlca)

IF sqlca.sqlcode = 0 THEN
	ll_cnt = lds_data.retrieve(as_pgmno)	
END IF

IF ll_cnt > 0 THEN
	FOR i = ll_cnt TO 1 Step -1
		ll_rtn = dw_multi.rowcount()
		ls_pgmno = lds_data.getItemString(i, 1)
		ll_row = dw_multi.Find("pgm_no='" + ls_pgmno + "'", 1, ll_rtn)
		IF ll_row > 0 THEN
			dw_multi.deleterow(ll_row)
		END IF
		
		of_deletedata( ls_pgmno )
	NEXT
END IF

end subroutine

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
	idx = astr_tree.AddPicture(imgpath + as_picname)
END IF

return idx

end function

on w_pgmlist.create
int iCurrent
call super::create
this.tv_menu=create tv_menu
this.dw_btnlist=create dw_btnlist
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.tv_preview=create tv_preview
this.st_5=create st_5
this.p_2=create p_2
this.p_1=create p_1
this.p_3=create p_3
this.p_4=create p_4
this.r_1=create r_1
this.r_2=create r_2
this.r_6=create r_6
this.r_7=create r_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_menu
this.Control[iCurrent+2]=this.dw_btnlist
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.tv_preview
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.p_2
this.Control[iCurrent+9]=this.p_1
this.Control[iCurrent+10]=this.p_3
this.Control[iCurrent+11]=this.p_4
this.Control[iCurrent+12]=this.r_1
this.Control[iCurrent+13]=this.r_2
this.Control[iCurrent+14]=this.r_6
this.Control[iCurrent+15]=this.r_7
end on

on w_pgmlist.destroy
call super::destroy
destroy(this.tv_menu)
destroy(this.dw_btnlist)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.tv_preview)
destroy(this.st_5)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.p_3)
destroy(this.p_4)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_6)
destroy(this.r_7)
end on

event ue_postopen;call super::ue_postopen;is_roleno = Message.StringParm
dw_btnlist.SetTransObject(sqlca)
dw_multi.SetTransObject(sqlca)

IF Trim(is_roleno) = '' OR IsNull(is_roleno) THEN
	Messagebox("Info", "Role No가 없습니다.~r~n종료하겠습니다.")
	Close(THis)
END IF

gf_openwait()
dw_multi.retrieve(is_roleno)
of_retrievemenu()
of_setpreview()
gf_closewait()
end event

type st_1 from w_default_response`st_1 within w_pgmlist
end type

type uc_insert from w_default_response`uc_insert within w_pgmlist
boolean visible = false
integer y = 40
end type

type uc_cancel from w_default_response`uc_cancel within w_pgmlist
boolean visible = false
integer x = 3584
integer y = 40
integer taborder = 60
end type

type uc_close from w_default_response`uc_close within w_pgmlist
integer x = 3552
integer y = 40
boolean originalsize = false
end type

event uc_close::clicked;call super::clicked;Close(Parent)
end event

type uc_delete from w_default_response`uc_delete within w_pgmlist
integer x = 2967
integer y = 40
integer taborder = 50
end type

event uc_delete::clicked;call super::clicked;String	ls_arg, ls_node
Long		ll_row, ll_rtn, ll_cnt, i
s_row	lstr_data

ll_row 	= dw_multi.getRow()

ls_arg	= dw_multi.GetItemString(ll_row, 'pgm_no')

of_deletedata(ls_arg)

ll_row = dw_multi.Find("pgm_no='" + ls_arg + "'", 1, dw_multi.rowcount())
IF ll_row > 0 THEN dw_multi.DeleteRow(ll_row)
	
uc_save.PostEvent(Clicked!)


end event

type uc_excel from w_default_response`uc_excel within w_pgmlist
boolean visible = false
integer y = 40
end type

type uc_ok from w_default_response`uc_ok within w_pgmlist
boolean visible = false
integer x = 3072
integer y = 40
integer taborder = 40
end type

type uc_print from w_default_response`uc_print within w_pgmlist
boolean visible = false
integer y = 40
end type

type uc_run from w_default_response`uc_run within w_pgmlist
boolean visible = false
integer y = 40
end type

type uc_save from w_default_response`uc_save within w_pgmlist
integer x = 3259
integer y = 40
end type

event uc_save::clicked;call super::clicked;Long		ll_rtn, ll_dcnt, ll_mcnt, i, ll_icnt
DWItemStatus		ldwis_temp

dw_multi.AcceptText()

ll_dcnt  = dw_multi.DeletedCount()
ll_mcnt = dw_multi.ModifiedCount()

ll_rtn = dw_multi.rowcount()

FOR i = ll_rtn To 1 Step -1
	ldwis_temp = dw_multi.getItemStatus(i, 0, Primary!	)
	IF ldwis_temp = NewModified! THEN ll_icnt++
NEXT

IF ll_mcnt = 0 AND ll_dcnt = 0 THEN return

ll_rtn = dw_multi.update()
IF ll_rtn > 0 THEN
	//V1.9.9.022  Transaction 처리 
	Commit Using sqlca;
	//========================
	IF ll_icnt + ll_dcnt > 0 THEN
		of_setpreview()
	END IF
ELSE
	//V1.9.9.022  Transaction 처리 
	Rollback Using sqlca;
	//========================
	messagebox("Info", "저장 실패")
END IF
end event

type uc_retrieve from w_default_response`uc_retrieve within w_pgmlist
boolean visible = false
integer y = 40
end type

type dw_multi from w_default_response`dw_multi within w_pgmlist
integer x = 1088
integer y = 228
integer width = 1883
integer height = 896
integer taborder = 20
string dataobject = "d_pgmrole"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_multi::dragdrop;call super::dragdrop;TreeView				ltv_menu
TreeViewItem		ltv_item
String					ls_syntax, ls_arg, ls_node
Long						ll_row, ll_rtn, ll_cnt, i, ll_parenthandle
str_tree					lstr_data
s_row					lstr_itemdata

ltv_menu = source

ltv_menu.getItem(il_handle, ltv_item )
lstr_data	= ltv_item.data

ll_rtn = dw_multi.rowcount()
IF dw_multi.Find("pgm_no='" + lstr_data.pgm_no + "'", 1, ll_rtn) = 0 THEN
	ll_row = This.Insertrow(0)
	This.SetItem(ll_row, 'role_no', is_roleno)
	This.SetItem(ll_row, 'pgm_no', lstr_data.pgm_no)
	This.SetItem(ll_row, 'pgm_name', lstr_data.pgm_nm)
	This.SetItem(ll_row, 'pgm_id', lstr_data.pgm_id)
END IF
ls_arg	= 	lstr_data.pgm_no			 

ll_parenthandle = il_handle

do while True
	ll_parenthandle = ltv_menu.FindItem(ParentTreeItem!,	ll_parenthandle )
	IF ll_parenthandle = -1 THEN Exit
	ltv_menu.getItem(ll_parenthandle, ltv_item )
	lstr_data	= ltv_item.data
	ll_rtn = dw_multi.rowcount()
	IF dw_multi.Find("pgm_no='" + lstr_data.pgm_no + "'",1, ll_rtn) = 0 THEN
		ll_row = This.Insertrow(0)
		This.SetItem(ll_row, 'role_no', is_roleno)
		This.SetItem(ll_row, 'pgm_no', lstr_data.pgm_no)
		This.SetItem(ll_row, 'pgm_name', lstr_data.pgm_nm)
		This.SetItem(ll_row, 'pgm_id', lstr_data.pgm_id)
	END IF
Loop

of_setdata(ls_arg )

uc_save.postEvent(Clicked!)
end event

event dw_multi::rowfocuschanged;call super::rowfocuschanged;String	ls_pgmno
Long		ll_row
IF currentrow > 0 THEN
	stringtokenizer		lnv_token
	ls_pgmno = This.GetItemString(currentrow, 'pgm_no')
	IF Not IsNull(ls_pgmno) AND ls_pgmno <> '' THEN 
		dw_btnlist.retrieve(ls_pgmno)
		
		ls_pgmno	= This.GetItemString(currentrow, 'use_btn')
		IF IsNull(ls_pgmno) THEN ls_pgmno = ''
		
		lnv_token.SetTokenizer(ls_pgmno, ',')
		do while lnv_token.hasmoretokens( )
			ls_pgmno	= lnv_token.nexttoken( )
			ll_row	= dw_btnlist.rowcount()
			ll_row	= dw_btnlist.Find("btn_id='" + ls_pgmno + "'", 1, ll_row)
			dw_btnlist.setItem(ll_row, 'checkbox', 1)
		Loop
	END IF
END IF	

end event

event dw_multi::itemchanged;call super::itemchanged;IF row > 0 THEN
	CHOOSE CASE dwo.name
		CASE 'insert_yn', 'update_yn','delete_yn', 'print_yn'
			String	ls_pgmid 
			Long		ll_row, ll_rowcnt
			ls_pgmid 	= This.GetItemString(row, 'pgm_id')
			ll_row 		= 1
			ll_rowcnt 	= This.rowcount()
			do while true
				IF ll_row > ll_rowcnt THEN Exit
				ll_row = This.Find("pgm_id='" + ls_pgmid + "'", ll_row, ll_rowcnt)
				IF ll_row = 0 THEN return
				IF ll_row <> row THEN
					This.SetItem(ll_row, dwo.name, data)
				END IF
				ll_row++
			loop
	END CHOOSE
		
END IF
end event

type ln_templeft from w_default_response`ln_templeft within w_pgmlist
end type

type ln_tempright from w_default_response`ln_tempright within w_pgmlist
end type

type ln_tempstart from w_default_response`ln_tempstart within w_pgmlist
end type

type ln_4 from w_default_response`ln_4 within w_pgmlist
end type

type ln_temptop from w_default_response`ln_temptop within w_pgmlist
end type

type ln_tempbutton from w_default_response`ln_tempbutton within w_pgmlist
end type

type tv_menu from treeview within w_pgmlist
event ue_postconstructor ( )
integer x = 50
integer y = 228
integer width = 1006
integer height = 1712
integer taborder = 10
boolean dragauto = true
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

event begindrag;il_handle = handle
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
	FROM  cddb.pf_pgm_mst pf_pgm_mst	
 WHERE parent_pgm = :lstr_tree.pgm_no
     AND pgm_use_yn = 'Y'
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

type dw_btnlist from uo_dwlv within w_pgmlist
integer x = 1088
integer y = 1236
integer width = 1883
integer height = 704
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_btn_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String		ls_pgmno, ls_btnid, ls_btn
Long			ll_row, ll_rowcnt
		
IF row > 0 THEN
	IF dwo.name = 'checkbox' THEN
		ls_pgmno 	= This.getItemString(row, 'pgm_no')
		ls_btnid		= This.GetItemstring(row, 'btn_id')
		ll_row 		= 1
		ll_rowcnt	= dw_multi.rowcount()
		do while true
			IF ll_row > ll_rowcnt THEN Exit
			
			ll_row 		= dw_multi.Find("pgm_no='" + ls_pgmno + "'", ll_row, ll_rowcnt)
			
			IF ll_row <= 0 THEN Exit
			
			ls_btn		= dw_multi.GetItemString(ll_row, 'use_btn')
			IF IsNull(ls_btn) THEN ls_btn = ''
			IF Long(data) = 0 THEN
				replaceall(ls_btn, "," + ls_btnid , "")
				replaceall(ls_btn, ls_btnid, "")
				dw_multi.setItem(ll_row, 'use_btn', ls_btn)
			ELSE
				IF Len(ls_btn) > 0 THEN ls_btn += ","
				ls_btn += ls_btnid
				dw_multi.setItem(ll_row, 'use_btn', ls_btn)
			END IF	
			ll_row++
		loop	
	END IF
END IF
end event

event doubleclicked;call super::doubleclicked;String	ls_data, ls_data_origin, ls_ColumnName, ls_syntax
String	ls_tkt_no, ls_conj_no
Long		i, ll_cnt, ll_data

ls_ColumnName = dwo.name
IF ls_columnName = "" OR IsNull(ls_columnName) THEN Return
ls_columnName = Left(ls_columnName, Pos(ls_columnName, '_hfx') - 1)

IF ls_columnName = 'checkbox' THEN
	This.SetRedraw(FALSE)
	ls_data_origin = Trim(Describe(dwo.name + ".text"))
	IF IsNull(ls_data_origin) THEN ls_data_origin = ''
	IF ls_data_origin = '√' THEN
		ls_data = '0'
	ELSE
		ls_data = '1'
	END IF

	ll_cnt = This.RowCount()
	FOR i = 1 TO ll_cnt
		This.SetItem(i, ls_columnName, Long(ls_data))
		This.Trigger Event ItemChanged(i, This.Object.CheckBox, ls_data)
	NEXT
	
	This.SetRedraw(TRUE)

	IF ls_data = '0' THEN
		ls_syntax = ls_columnName + "_hfx.text=''~r~n " + ls_columnName + "_nml.text=''"
		//
	ELSE
		ls_syntax = ls_columnName + "_hfx.text='√'~r~n " + ls_columnName + "_nml.text='√'"
		//
	END IF
	ls_syntax = This.Modify(ls_syntax)
END IF
end event

type st_2 from statictext within w_pgmlist
integer x = 110
integer y = 160
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
string text = "프로그램 사용 메뉴"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pgmlist
integer x = 1147
integer y = 160
integer width = 626
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
string text = "Role 등록 프로그램"
boolean focusrectangle = false
end type

type st_4 from statictext within w_pgmlist
integer x = 1152
integer y = 1168
integer width = 626
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
string text = "프로그램 버튼 List"
boolean focusrectangle = false
end type

type tv_preview from treeview within w_pgmlist
integer x = 3003
integer y = 228
integer width = 823
integer height = 1712
integer taborder = 30
string dragicon = "Project!"
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
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event clicked;TreeViewItem		ltv_item
Long						ll_row
str_tree					lstr_data

IF This.GetItem(handle, ltv_item) > 0 THEN
	lstr_data = ltv_item.Data

	ll_row 	= dw_multi.rowcount()
	ll_row	= dw_multi.Find("pgm_no='" + lstr_data.pgm_no + "'", 1, ll_row)
	IF ll_row > 0 THEN
		dw_multi.setRow(ll_row)
		dw_multi.scrollToRow(ll_row)
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

SELECT a.pgm_no					as pgm_no
			,a.pgm_id					as pgm_id
			,a.pgm_name			as pgm_nm
			,a.pgm_kind_code		as pgm_kc
			,a.picture					as pic
			,a.select_picture		as spic
			,a.sort_order				as sort_order
			,a.parent_pgm			as parent_pgm
	FROM  cddb.pf_pgm_mst 	a, 
			 cddb.pf_pgm_role 	b
 WHERE a.pgm_use_yn 		= 'Y'
	  AND b.role_no 			= :is_roleno
	  AND a.pgm_no			= b.pgm_no	
	  AND a.parent_pgm = :lstr_tree.pgm_no
ORDER BY a.parent_pgm asc,  a.sort_order asc

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

type st_5 from statictext within w_pgmlist
integer x = 3086
integer y = 160
integer width = 608
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
string text = "Role 등록 미리보기"
boolean focusrectangle = false
end type

type p_2 from picture within w_pgmlist
integer x = 50
integer y = 160
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_pgmlist
integer x = 1088
integer y = 160
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_pgmlist
integer x = 1088
integer y = 1168
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_4 from picture within w_pgmlist
integer x = 3003
integer y = 160
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type r_1 from rectangle within w_pgmlist
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 46
integer y = 224
integer width = 1015
integer height = 1720
end type

type r_2 from rectangle within w_pgmlist
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 1088
integer y = 224
integer width = 1883
integer height = 904
end type

type r_6 from rectangle within w_pgmlist
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 1088
integer y = 1232
integer width = 1883
integer height = 712
end type

type r_7 from rectangle within w_pgmlist
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 2999
integer y = 224
integer width = 832
integer height = 1720
end type

