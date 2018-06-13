$PBExportHeader$w_hst001h.srw
$PBExportComments$부대품코드조회 response
forward
global type w_hst001h from w_response
end type
type dw_head from datawindow within w_hst001h
end type
type gb_1 from groupbox within w_hst001h
end type
type gb_2 from groupbox within w_hst001h
end type
end forward

global type w_hst001h from w_response
integer width = 3881
integer height = 1720
string title = "부대품코드 조회"
dw_head dw_head
gb_1 gb_1
gb_2 gb_2
end type
global w_hst001h w_hst001h

forward prototypes
public subroutine wf_ok (integer ai_row)
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_ok (integer ai_row);
gstru_uid_uname.s_parm[1] = dw_responst.object.item_no[ai_row]
gstru_uid_uname.s_parm[2] = dw_responst.object.item_name[ai_row]
gstru_uid_uname.s_parm[3] = string(dw_responst.object.item_class[ai_row])
gstru_uid_uname.s_parm[4] = dw_responst.object.item_stand_size[ai_row]
gstru_uid_uname.s_parm[5] = dw_responst.object.model[ai_row]


end subroutine

public subroutine wf_retrieve ();
string ls_item_no, ls_item_name

dw_head.accepttext()

ls_item_no = trim(dw_head.object.c_item_no[1]) + '%'
ls_item_name = trim(dw_head.object.c_item_name[1]) + '%'

IF ISNULL(ls_item_no) THEN ls_item_no = '%'
IF ISNULL(ls_item_name) THEN ls_item_name = '%'

dw_responst.setredraw(false)
dw_responst.retrieve( ls_item_no, ls_item_name ) 
dw_responst.setredraw(true)
dw_responst.setfocus()
end subroutine

on w_hst001h.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.gb_2
end on

on w_hst001h.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;
dw_head.reset()
dw_head.insertrow(0)

dw_head.object.c_item_name[1] = message.stringparm

f_childretrieve(dw_responst,"item_class","item_class")            // 품목구분

//datawindowchild idw_child
//dw_responst.getchild ("item_class", idw_child)         // 품목구분 
//idw_child.settransobject (sqlca)
//idw_child.retrieve( 'item_class' )

dw_responst.reset()

wf_retrieve()



end event

type pb_cancel from w_response`pb_cancel within w_hst001h
integer x = 3584
integer y = 1476
integer taborder = 40
end type

type pb_ok from w_response`pb_ok within w_hst001h
integer x = 3296
integer y = 1476
integer taborder = 30
end type

event pb_ok::clicked;call super::clicked;
int li_row

IF dw_responst.rowcount() <> 0 THEN

	li_row   = dw_responst.getrow() 
	
	wf_ok(li_row)
	
	closewithreturn(parent,'O')

END IF
end event

type st_sttitle00001 from w_response`st_sttitle00001 within w_hst001h
integer y = 1480
integer width = 3264
integer height = 104
end type

type dw_responst from w_response`dw_responst within w_hst001h
integer x = 50
integer y = 260
integer width = 3794
integer height = 1196
string dataobject = "d_hst001h_1"
end type

event dw_responst::key_enter;call super::key_enter;
int li_row

IF dw_responst.rowcount() <> 0 THEN

	li_row   = this.getrow() 
	
	wf_ok(li_row)
	
	closewithreturn(parent,'O')

END IF
end event

event dw_responst::doubleclicked;call super::doubleclicked;
IF dw_responst.rowcount() <> 0 THEN

	wf_ok(row)
	
	closewithreturn(parent,'O')

END IF

end event

event dw_responst::rowfocuschanged;call super::rowfocuschanged;//this.selectrow( 0, false )
//this.selectrow( currentrow, true )
end event

type dw_head from datawindow within w_hst001h
event ue_keydown pbm_dwnprocessenter
integer x = 59
integer y = 92
integer width = 1838
integer height = 92
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst001h_2"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
wf_retrieve()
end event

type gb_1 from groupbox within w_hst001h
integer x = 32
integer y = 28
integer width = 1906
integer height = 176
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회조건"
end type

type gb_2 from groupbox within w_hst001h
integer x = 37
integer y = 212
integer width = 3831
integer height = 1252
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = styleraised!
end type

