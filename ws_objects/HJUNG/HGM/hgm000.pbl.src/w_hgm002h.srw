$PBExportHeader$w_hgm002h.srw
$PBExportComments$품목 조회 ----------------------자산등재 팝업
forward
global type w_hgm002h from w_response
end type
type dw_head from datawindow within w_hgm002h
end type
type pb_retrieve from u_picture within w_hgm002h
end type
type gb_1 from groupbox within w_hgm002h
end type
type gb_2 from groupbox within w_hgm002h
end type
end forward

global type w_hgm002h from w_response
integer width = 2889
integer height = 1684
string title = "품목 조회"
dw_head dw_head
pb_retrieve pb_retrieve
gb_1 gb_1
gb_2 gb_2
end type
global w_hgm002h w_hgm002h

type variables
integer li_item_middle
end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_ok (integer ai_row)
end prototypes

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

public subroutine wf_ok (integer ai_row);
gstru_uid_uname.s_parm[1] = dw_responst.object.item_no[ai_row]
gstru_uid_uname.s_parm[2] = dw_responst.object.item_name[ai_row]
gstru_uid_uname.s_parm[3] = dw_responst.object.item_middle[ai_row]
gstru_uid_uname.s_parm[4] = dw_responst.object.midd_name[ai_row]
gstru_uid_uname.s_parm[5] = string(dw_responst.object.item_class[ai_row])
gstru_uid_uname.s_parm[6] = dw_responst.object.item_stand_size[ai_row]
gstru_uid_uname.s_parm[7] = dw_responst.object.model[ai_row]
//IF 	ISNULL(dw_responst.object.model[ai_row]) OR dw_responst.object.model[ai_row] = ""	THEN
//		gstru_uid_uname.s_parm[7] = dw_responst.object.item_stand_size[ai_row]
//ELSE			
//		gstru_uid_uname.s_parm[7] = dw_responst.object.model[ai_row]
//END IF	



end subroutine

on w_hgm002h.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.pb_retrieve=create pb_retrieve
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.pb_retrieve
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.gb_2
end on

on w_hgm002h.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.pb_retrieve)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;
dw_head.reset()
dw_head.insertrow(0)
s_uid_uname	ls_middle

//dw_head.object.c_item_name[1] = message.stringparm
dw_head.object.c_item_no[1] = message.stringparm

//ls_middle = message.powerobjectparm
//if ls_middle.uid = "c_item_name"	then
//	dw_head.object.c_item_name[1] = ls_middle.uname
//else
//	dw_head.object.c_item_no[1] = ls_middle.uname
//end if
f_childretrieve(dw_responst,"item_class","item_class")            // 품목구분

dw_responst.reset()


wf_retrieve()



end event

type pb_cancel from w_response`pb_cancel within w_hgm002h
integer x = 2574
integer y = 1480
integer taborder = 40
end type

type pb_ok from w_response`pb_ok within w_hgm002h
integer x = 2286
integer y = 1480
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

type st_sttitle00001 from w_response`st_sttitle00001 within w_hgm002h
integer y = 1480
integer width = 1966
integer height = 96
end type

type dw_responst from w_response`dw_responst within w_hgm002h
integer x = 41
integer y = 260
integer width = 2793
integer height = 1196
string dataobject = "d_hgm002h_1"
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

type dw_head from datawindow within w_hgm002h
event ue_keydown pbm_dwnprocessenter
integer x = 59
integer y = 92
integer width = 1838
integer height = 92
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm001h_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
wf_retrieve()
end event

type pb_retrieve from u_picture within w_hgm002h
integer x = 1998
integer y = 1480
integer width = 274
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_retrieve.gif"
end type

event clicked;call super::clicked;
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
end event

type gb_1 from groupbox within w_hgm002h
integer x = 32
integer y = 28
integer width = 2821
integer height = 176
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회조건"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_hgm002h
integer x = 27
integer y = 212
integer width = 2821
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

