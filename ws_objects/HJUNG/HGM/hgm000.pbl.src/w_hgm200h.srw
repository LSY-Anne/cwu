$PBExportHeader$w_hgm200h.srw
$PBExportComments$사원 조회 response(교원,직원)
forward
global type w_hgm200h from w_response
end type
type dw_head from datawindow within w_hgm200h
end type
type gb_1 from groupbox within w_hgm200h
end type
type gb_2 from groupbox within w_hgm200h
end type
end forward

global type w_hgm200h from w_response
integer width = 2117
integer height = 1976
string title = "인사정보조회"
dw_head dw_head
gb_1 gb_1
gb_2 gb_2
end type
global w_hgm200h w_hgm200h

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_ok (integer ai_row)
end prototypes

public subroutine wf_retrieve ();
string ls_id, ls_name

dw_head.accepttext()

ls_id = trim(dw_head.object.c_id[1]) + '%'
ls_name = trim(dw_head.object.c_name[1]) + '%'

IF ISNULL(ls_id) THEN ls_id = '%'
IF ISNULL(ls_name) THEN ls_name = '%'

dw_responst.setredraw(false)
dw_responst.retrieve( ls_id, ls_name ) 
dw_responst.setredraw(true)
dw_responst.setfocus()

end subroutine

public subroutine wf_ok (integer ai_row);
gstru_uid_uname.s_parm[1] = dw_responst.object.id[ai_row]
gstru_uid_uname.s_parm[2] = dw_responst.object.name[ai_row]



end subroutine

on w_hgm200h.create
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

on w_hgm200h.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;
dw_head.reset()
dw_head.insertrow(0)

dw_head.object.c_id[1] = message.stringparm

dw_responst.reset()
f_childretrieve(dw_responst,"jikwi_code","jikwi_code") 
wf_retrieve()



end event

type pb_cancel from w_response`pb_cancel within w_hgm200h
integer x = 1797
integer y = 1772
integer taborder = 40
end type

type pb_ok from w_response`pb_ok within w_hgm200h
integer x = 1509
integer y = 1772
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

type st_sttitle00001 from w_response`st_sttitle00001 within w_hgm200h
integer y = 1772
integer width = 1495
integer height = 88
end type

type dw_responst from w_response`dw_responst within w_hgm200h
integer x = 59
integer y = 284
integer width = 2002
integer height = 1476
string dataobject = "d_hgm200h_2"
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

type dw_head from datawindow within w_hgm200h
event ue_keydown pbm_dwnprocessenter
integer x = 59
integer y = 92
integer width = 1413
integer height = 92
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm200h_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
wf_retrieve()
end event

type gb_1 from groupbox within w_hgm200h
integer x = 32
integer y = 28
integer width = 2034
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

type gb_2 from groupbox within w_hgm200h
integer x = 37
integer y = 212
integer width = 2034
integer height = 1540
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = styleraised!
end type

