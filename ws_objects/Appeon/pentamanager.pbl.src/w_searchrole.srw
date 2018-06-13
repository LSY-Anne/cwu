$PBExportHeader$w_searchrole.srw
forward
global type w_searchrole from w_default_templet_nodw
end type
type tab_search from tab within w_searchrole
end type
type tabpage_1 from userobject within tab_search
end type
type p_1 from picture within tabpage_1
end type
type p_2 from picture within tabpage_1
end type
type r_7 from rectangle within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type dw_role from uo_dwlv within tabpage_1
end type
type r_5 from rectangle within tabpage_1
end type
type r_6 from rectangle within tabpage_1
end type
type dw_empcode from uo_dwlv within tabpage_1
end type
type dw_cond from datawindow within tabpage_1
end type
type r_4 from rectangle within tabpage_1
end type
type tv_totalmenu from treeview within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type uc_retrieve1 from u_picture within tabpage_1
end type
type tabpage_1 from userobject within tab_search
p_1 p_1
p_2 p_2
r_7 r_7
st_3 st_3
dw_role dw_role
r_5 r_5
r_6 r_6
dw_empcode dw_empcode
dw_cond dw_cond
r_4 r_4
tv_totalmenu tv_totalmenu
st_1 st_1
uc_retrieve1 uc_retrieve1
end type
type tabpage_2 from userobject within tab_search
end type
type p_5 from picture within tabpage_2
end type
type p_4 from picture within tabpage_2
end type
type p_3 from picture within tabpage_2
end type
type r_10 from rectangle within tabpage_2
end type
type r_12 from rectangle within tabpage_2
end type
type dw_pgm_role from uo_dwlv within tabpage_2
end type
type st_5 from statictext within tabpage_2
end type
type dw_role_user from uo_dwlv within tabpage_2
end type
type st_4 from statictext within tabpage_2
end type
type r_1 from rectangle within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type tv_menu from treeview within tabpage_2
end type
type tabpage_2 from userobject within tab_search
p_5 p_5
p_4 p_4
p_3 p_3
r_10 r_10
r_12 r_12
dw_pgm_role dw_pgm_role
st_5 st_5
dw_role_user dw_role_user
st_4 st_4
r_1 r_1
st_2 st_2
tv_menu tv_menu
end type
type tab_search from tab within w_searchrole
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from u_bottomtab within w_searchrole
end type
end forward

global type w_searchrole from w_default_templet_nodw
string title = "Role 조회"
tab_search tab_search
uo_1 uo_1
end type
global w_searchrole w_searchrole

type variables
String	imgpath		= "..\img\icon\"
String	is_empno
end variables

forward prototypes
public subroutine wf_setmenu_pgm (treeview atv_view)
public subroutine wf_setmenu_emp (treeview atv_view, string as_empno)
public function integer of_getpictureindex (string as_picname, treeview astr_tree)
end prototypes

public subroutine wf_setmenu_pgm (treeview atv_view);TreeViewItem			ltv_item
Integer					li_pic
Long						ll_handle
str_tree					lstr_tree
String					ls_name, ls_pic, ls_spic
long tvi_hdl = 0

DO UNTIL atv_view.FindItem(RootTreeItem!, 0) = -1
    atv_view.DeleteItem(tvi_hdl)
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
	
	li_pic = This.of_getpictureindex( ls_pic, atv_view)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = This.of_getpictureindex( ls_spic, atv_view)
	IF li_pic > 0 THEN
		ltv_Item.SelectedPictureIndex = li_pic
	END IF

	ltv_item.Data				= lstr_tree
	ltv_item.Label			= lstr_tree.pgm_nm
	
	ltv_item.Children 	= True
	
	ll_handle = atv_view.InsertItemLast(0, ltv_item)
loop

Close cur;

atv_view.ExpandItem( ll_handle )
end subroutine

public subroutine wf_setmenu_emp (treeview atv_view, string as_empno);TreeViewItem			ltv_item
Integer					li_pic
Long						ll_handle
str_tree					lstr_tree
String					ls_name, ls_pic, ls_spic
long tvi_hdl = 0

DO UNTIL atv_view.FindItem(RootTreeItem!, 0) = -1
    atv_view.DeleteItem(tvi_hdl)
LOOP

Declare cur CURSOR FOR

SELECT Distinct a.pgm_no				as pgm_no
		,a.pgm_id					as pgm_id
		,a.pgm_name			as pgm_nm
		,a.pgm_kind_code		as pgm_kc
		,a.picture					as pic
		,a.select_picture		as spic
		,a.sort_order				as sort_order
		,a.parent_pgm			as parent_pgm
FROM  cddb.pf_pgm_mst 	a, 
		 cddb.pf_pgm_role		b,
		 cddb.pf_userrole		c
WHERE c.emp_code			= :as_empno
    AND b.role_no				= c.role_no
    AND a.pgm_use_yn 		= 'Y'
    AND a.pgm_no				= b.pgm_no 
    AND a.parent_pgm 		= 'ZZZZZ'
ORDER BY a.parent_pgm asc,a.sort_order asc

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
	
	li_pic = This.of_getpictureindex( ls_pic, atv_view)
	IF li_pic > 0 THEN
		ltv_Item.PictureIndex = li_pic
	END IF
	
	li_pic = This.of_getpictureindex( ls_spic, atv_view)
	IF li_pic > 0 THEN
		ltv_Item.SelectedPictureIndex = li_pic
	END IF

	ltv_item.Data				= lstr_tree
	ltv_item.Label			= lstr_tree.pgm_nm
	
	ltv_item.Children 	= True
	
	ll_handle = atv_view.InsertItemLast(0, ltv_item)
loop

Close cur;

atv_view.ExpandItem( ll_handle )
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

on w_searchrole.create
int iCurrent
call super::create
this.tab_search=create tab_search
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_search
this.Control[iCurrent+2]=this.uo_1
end on

on w_searchrole.destroy
call super::destroy
destroy(this.tab_search)
destroy(this.uo_1)
end on

event ue_postopen;call super::ue_postopen;tab_search.tabpage_1.dw_empcode.SetTransObject(sqlca)
tab_search.tabpage_1.dw_role.SetTransObject(sqlca)
tab_search.tabpage_2.dw_pgm_role.SetTransObject(sqlca)
tab_search.tabpage_2.dw_role_user.SetTransObject(sqlca)

wf_setmenu_pgm(tab_search.tabpage_2.tv_menu)

tab_search.tabpage_1.dw_cond.insertrow(0)
tab_search.tabpage_1.dw_cond.SetItem(1, 'type', 1)

end event

type ln_templeft from w_default_templet_nodw`ln_templeft within w_searchrole
end type

type ln_tempright from w_default_templet_nodw`ln_tempright within w_searchrole
end type

type ln_temptop from w_default_templet_nodw`ln_temptop within w_searchrole
end type

type ln_tempbuttom from w_default_templet_nodw`ln_tempbuttom within w_searchrole
end type

type ln_tempbutton from w_default_templet_nodw`ln_tempbutton within w_searchrole
end type

type ln_tempstart from w_default_templet_nodw`ln_tempstart within w_searchrole
end type

type uc_retrieve from w_default_templet_nodw`uc_retrieve within w_searchrole
boolean visible = false
end type

type uc_save from w_default_templet_nodw`uc_save within w_searchrole
boolean visible = false
end type

type uc_run from w_default_templet_nodw`uc_run within w_searchrole
boolean visible = false
end type

type uc_print from w_default_templet_nodw`uc_print within w_searchrole
boolean visible = false
end type

type uc_ok from w_default_templet_nodw`uc_ok within w_searchrole
boolean visible = false
end type

type uc_excel from w_default_templet_nodw`uc_excel within w_searchrole
boolean visible = false
end type

type uc_delete from w_default_templet_nodw`uc_delete within w_searchrole
boolean visible = false
end type

type uc_close from w_default_templet_nodw`uc_close within w_searchrole
boolean visible = false
end type

type uc_cancel from w_default_templet_nodw`uc_cancel within w_searchrole
boolean visible = false
end type

type uc_insert from w_default_templet_nodw`uc_insert within w_searchrole
boolean visible = false
end type

type tab_search from tab within w_searchrole
integer x = 55
integer y = 28
integer width = 4393
integer height = 2012
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
boolean showtext = false
tabposition tabposition = tabsonbottom!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_search.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_search.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_search
integer x = 18
integer y = 16
integer width = 4357
integer height = 1948
long backcolor = 16777215
string text = "사용자"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
p_1 p_1
p_2 p_2
r_7 r_7
st_3 st_3
dw_role dw_role
r_5 r_5
r_6 r_6
dw_empcode dw_empcode
dw_cond dw_cond
r_4 r_4
tv_totalmenu tv_totalmenu
st_1 st_1
uc_retrieve1 uc_retrieve1
end type

on tabpage_1.create
this.p_1=create p_1
this.p_2=create p_2
this.r_7=create r_7
this.st_3=create st_3
this.dw_role=create dw_role
this.r_5=create r_5
this.r_6=create r_6
this.dw_empcode=create dw_empcode
this.dw_cond=create dw_cond
this.r_4=create r_4
this.tv_totalmenu=create tv_totalmenu
this.st_1=create st_1
this.uc_retrieve1=create uc_retrieve1
this.Control[]={this.p_1,&
this.p_2,&
this.r_7,&
this.st_3,&
this.dw_role,&
this.r_5,&
this.r_6,&
this.dw_empcode,&
this.dw_cond,&
this.r_4,&
this.tv_totalmenu,&
this.st_1,&
this.uc_retrieve1}
end on

on tabpage_1.destroy
destroy(this.p_1)
destroy(this.p_2)
destroy(this.r_7)
destroy(this.st_3)
destroy(this.dw_role)
destroy(this.r_5)
destroy(this.r_6)
destroy(this.dw_empcode)
destroy(this.dw_cond)
destroy(this.r_4)
destroy(this.tv_totalmenu)
destroy(this.st_1)
destroy(this.uc_retrieve1)
end on

type p_1 from picture within tabpage_1
integer x = 3145
integer y = 20
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_2 from picture within tabpage_1
integer x = 1733
integer y = 20
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type r_7 from rectangle within tabpage_1
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 31439244
integer x = 3145
integer y = 76
integer width = 1170
integer height = 1836
end type

type st_3 from statictext within tabpage_1
integer x = 3218
integer y = 16
integer width = 562
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 25123896
long backcolor = 16777215
string text = "사용 권한"
boolean focusrectangle = false
end type

type dw_role from uo_dwlv within tabpage_1
integer x = 3145
integer y = 80
integer width = 1170
integer height = 1828
integer taborder = 50
string dataobject = "d_role_search"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type r_5 from rectangle within tabpage_1
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 32305380
integer x = 41
integer y = 124
integer width = 1650
integer height = 120
end type

type r_6 from rectangle within tabpage_1
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 31439244
integer x = 41
integer y = 268
integer width = 1646
integer height = 1640
end type

type dw_empcode from uo_dwlv within tabpage_1
integer x = 41
integer y = 272
integer width = 1646
integer height = 1632
integer taborder = 40
string dataobject = "d_empcode"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemfocuschanged;call super::itemfocuschanged;IF row > 0 THEN
	String			ls_empcode
	String			ls_sql, ls_temp

	is_empno = This.GetItemString(row, 'emp_code')
	
	ls_temp = dw_role.GetSqlSelect()
	ls_sql = ls_temp + ",  cddb.pf_userrole			b	~r~n" + &
			   " where 	a.role_no		= b.role_no ~r~n" + &
			   "     and  b.emp_code		= '" + is_empno + "'"
	dw_role.SetSqlSelect(ls_sql)	
	dw_role.retrieve()
	dw_role.SetSqlSelect(ls_temp)
	
	wf_setmenu_emp(tv_totalmenu, is_empno)
END IF
end event

event doubleclicked;call super::doubleclicked;if row > 0 then
	vector 	vc
	
	vc = create vector
	
	vc.setproperty('type', '3')
	vc.setproperty('title', this.getitemstring(row, 'emp_name') + ' 권한 복사')
	vc.setproperty('code', this.getitemstring(row, 'dept_code'))
	vc.setproperty('name', this.getitemstring(row, 'dept_name'))
	vc.setproperty('emp_code', this.getitemstring(row, 'emp_code'))
	openwithparm(w_emp_code, vc)
end if
end event

type dw_cond from datawindow within tabpage_1
event ue_keyenter pbm_dwnprocessenter
integer x = 46
integer y = 128
integer width = 1641
integer height = 112
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_empcode_cond"
boolean border = false
boolean livescroll = true
end type

event ue_keyenter;uc_retrieve1.PostEvent(Clicked!)
end event

event itemchanged;IF row > 0 THEN
	CHOOSE CASE getColumnName()
		CASE 'code'
			This.SetItem(1,'name', '')
		CASE 'name'
			This.SetItem(1,'code', '')
		CASE ELSE
			IF Long(data) = 1 THEN
				This.Modify('code.Edit.Limit=5')
			ELSE
				This.Modify('code.Edit.Limit=5')
			END IF
			This.SetItem(1,'name', '')
			This.SetItem(1,'code', '')
	END CHOOSE
END IF
end event

type r_4 from rectangle within tabpage_1
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 16777215
integer x = 1723
integer y = 76
integer width = 1394
integer height = 1836
end type

type tv_totalmenu from treeview within tabpage_1
event ue_checked ( long handle )
integer x = 1728
integer y = 80
integer width = 1385
integer height = 1828
integer taborder = 30
boolean dragauto = true
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 33554432
boolean border = false
boolean disabledragdrop = false
boolean trackselect = true
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

SELECT Distinct a.pgm_no				as pgm_no
		,a.pgm_id					as pgm_id
		,a.pgm_name			as pgm_nm
		,a.pgm_kind_code		as pgm_kc
		,a.picture					as pic
		,a.select_picture		as spic
		,a.sort_order				as sort_order
		,a.parent_pgm			as parent_pgm
FROM  cddb.pf_pgm_mst 	a, 
		 cddb.pf_pgm_role		b,
		 cddb.pf_userrole		c
WHERE c.emp_code			= :is_empno
    AND b.role_no				= c.role_no
    AND a.pgm_use_yn 		= 'Y'
    AND a.pgm_no				= b.pgm_no 
    AND a.parent_pgm 		= :lstr_tree.pgm_no
ORDER BY a.parent_pgm asc,a.sort_order asc

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

type st_1 from statictext within tabpage_1
integer x = 1797
integer y = 16
integer width = 562
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 25123896
long backcolor = 16777215
string text = "사용 프로그램"
boolean focusrectangle = false
end type

type uc_retrieve1 from u_picture within tabpage_1
integer x = 1422
integer y = 12
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_search.gif"
end type

event clicked;call super::clicked;String 	ls_temp = '%'
String	ls_code, ls_name
Long		ll_type
dw_cond.AcceptText()
ll_type = dw_cond.GetItemNumber(1, 'type')

ls_code = dw_cond.GetItemString(1, 'code')
IF 	IsNull(ls_code) THEN ls_code = ''
ls_code += ls_temp
	
ls_name	= dw_cond.GetItemString(1, 'name')
IF IsNull(ls_name) THEN ls_name = ''
ls_name = ls_temp + ls_name + ls_temp

IF ll_type = 1 THEN
	dw_empcode.retrieve('%', '%', ls_code , ls_name)
ELSE
	dw_empcode.retrieve(ls_code , ls_name, '%', '%')
END IF
end event

type tabpage_2 from userobject within tab_search
integer x = 18
integer y = 16
integer width = 4357
integer height = 1948
long backcolor = 16777215
string text = "프로그램"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
p_5 p_5
p_4 p_4
p_3 p_3
r_10 r_10
r_12 r_12
dw_pgm_role dw_pgm_role
st_5 st_5
dw_role_user dw_role_user
st_4 st_4
r_1 r_1
st_2 st_2
tv_menu tv_menu
end type

on tabpage_2.create
this.p_5=create p_5
this.p_4=create p_4
this.p_3=create p_3
this.r_10=create r_10
this.r_12=create r_12
this.dw_pgm_role=create dw_pgm_role
this.st_5=create st_5
this.dw_role_user=create dw_role_user
this.st_4=create st_4
this.r_1=create r_1
this.st_2=create st_2
this.tv_menu=create tv_menu
this.Control[]={this.p_5,&
this.p_4,&
this.p_3,&
this.r_10,&
this.r_12,&
this.dw_pgm_role,&
this.st_5,&
this.dw_role_user,&
this.st_4,&
this.r_1,&
this.st_2,&
this.tv_menu}
end on

on tabpage_2.destroy
destroy(this.p_5)
destroy(this.p_4)
destroy(this.p_3)
destroy(this.r_10)
destroy(this.r_12)
destroy(this.dw_pgm_role)
destroy(this.st_5)
destroy(this.dw_role_user)
destroy(this.st_4)
destroy(this.r_1)
destroy(this.st_2)
destroy(this.tv_menu)
end on

type p_5 from picture within tabpage_2
integer x = 2661
integer y = 56
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_4 from picture within tabpage_2
integer x = 1463
integer y = 56
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_3 from picture within tabpage_2
integer x = 41
integer y = 56
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type r_10 from rectangle within tabpage_2
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 31439244
integer x = 2665
integer y = 116
integer width = 1650
integer height = 1796
end type

type r_12 from rectangle within tabpage_2
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 31439244
integer x = 1467
integer y = 116
integer width = 1170
integer height = 1796
end type

type dw_pgm_role from uo_dwlv within tabpage_2
integer x = 1467
integer y = 120
integer width = 1170
integer height = 1788
integer taborder = 40
string dataobject = "d_role_search"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_5 from statictext within tabpage_2
integer x = 1527
integer y = 56
integer width = 562
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 25123896
long backcolor = 16777215
string text = "사용 권한"
boolean focusrectangle = false
end type

type dw_role_user from uo_dwlv within tabpage_2
integer x = 2665
integer y = 120
integer width = 1650
integer height = 1788
integer taborder = 40
string dataobject = "d_role_empcode"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_4 from statictext within tabpage_2
integer x = 2725
integer y = 56
integer width = 562
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 25123896
long backcolor = 16777215
string text = "프로그램 사용자"
boolean focusrectangle = false
end type

type r_1 from rectangle within tabpage_2
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 46
integer y = 116
integer width = 1394
integer height = 1796
end type

type st_2 from statictext within tabpage_2
integer x = 105
integer y = 56
integer width = 553
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 25123896
long backcolor = 16777215
string text = "전체 프로그램 메뉴"
boolean focusrectangle = false
end type

type tv_menu from treeview within tabpage_2
event ue_checked ( long handle )
integer x = 50
integer y = 120
integer width = 1385
integer height = 1788
integer taborder = 30
boolean dragauto = true
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 33554432
boolean border = false
boolean disabledragdrop = false
boolean trackselect = true
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event clicked;String		ls_sql, ls_temp
TreeViewItem		item
str_tree				lstr_data

IF This.GetItem(handle, item) > 0 THEN
	lstr_data = item.Data
	ls_temp = dw_pgm_role.getSqlSelect()
	ls_sql = ls_temp + ", 	cddb.pf_pgm_role			b  	~r~n" + &
				"   where 	a.role_no	= b.role_no  	~r~n" + & 
				"      and 	b.pgm_no	= '" + lstr_data.pgm_no + "'"
	
	dw_pgm_role.SetSqlSelect(ls_sql)
	dw_pgm_role.retrieve()
	dw_pgm_role.SetSqlSelect(ls_temp)
	dw_role_user.Retrieve(lstr_data.pgm_no)
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

type uo_1 from u_bottomtab within w_searchrole
integer x = 585
integer y = 1964
integer taborder = 30
boolean bringtotop = true
string selecttabobject = "tab_search"
end type

on uo_1.destroy
call u_bottomtab::destroy
end on

