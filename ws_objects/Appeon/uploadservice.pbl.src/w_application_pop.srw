$PBExportHeader$w_application_pop.srw
forward
global type w_application_pop from window
end type
type st_3 from statictext within w_application_pop
end type
type dw_2 from uo_dwgrid within w_application_pop
end type
type st_2 from statictext within w_application_pop
end type
type p_close from u_picture within w_application_pop
end type
type p_save from u_picture within w_application_pop
end type
type p_delete from u_picture within w_application_pop
end type
type p_insert from u_picture within w_application_pop
end type
type dw_1 from uo_dwfree within w_application_pop
end type
type st_1 from statictext within w_application_pop
end type
end forward

global type w_application_pop from window
integer width = 2811
integer height = 1856
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event ue_postopen ( )
st_3 st_3
dw_2 dw_2
st_2 st_2
p_close p_close
p_save p_save
p_delete p_delete
p_insert p_insert
dw_1 dw_1
st_1 st_1
end type
global w_application_pop w_application_pop

type variables
Private:
	Boolean			ib_update

end variables

event ue_postopen();String		ls_path

p_insert.of_enable(true)
p_delete.of_enable(true)
p_save.of_enable(true)
p_close.of_enable(true)

ls_path = getcurrentdir() + "\plugin\serverdata.xml"
IF FileExists(ls_path) THEN
	dw_2.ImportFile(XML!, ls_path)
	dw_2.resetupdate()
END IF

dw_1.insertrow(0)
end event

on w_application_pop.create
this.st_3=create st_3
this.dw_2=create dw_2
this.st_2=create st_2
this.p_close=create p_close
this.p_save=create p_save
this.p_delete=create p_delete
this.p_insert=create p_insert
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.st_3,&
this.dw_2,&
this.st_2,&
this.p_close,&
this.p_save,&
this.p_delete,&
this.p_insert,&
this.dw_1,&
this.st_1}
end on

on w_application_pop.destroy
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.p_close)
destroy(this.p_save)
destroy(this.p_delete)
destroy(this.p_insert)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;Post Event ue_postopen()
end event

type st_3 from statictext within w_application_pop
integer width = 2802
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16777215
long backcolor = 29928598
string text = "■ Application Configur"
boolean border = true
long bordercolor = 29928598
boolean focusrectangle = false
end type

type dw_2 from uo_dwgrid within w_application_pop
integer x = 46
integer y = 624
integer width = 2720
integer height = 1180
integer taborder = 20
string dataobject = "d_applicationdata_grid"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;dw_1.reset()
dw_2.rowscopy(currentrow, currentrow, Primary!, dw_1, 1, Primary!)
dw_1.resetupdate()
end event

event doubleclicked;call super::doubleclicked;IF row > 0 THEN
	Vector 	lvc_data
	lvc_data = Create Vector
	
	lvc_data.setProperty('application'		, dw_2.getItemString(row, 'application')			)
	lvc_data.setProperty('uploadserver'		, dw_2.getItemString(row, 'uploadserver')		)
	lvc_data.setProperty('downloadserver', dw_2.getItemString(row, 'downloadserver')	)
	
	CloseWithReturn(Parent, lvc_data)
END IF
end event

type st_2 from statictext within w_application_pop
integer x = 46
integer y = 620
integer width = 2720
integer height = 1188
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
long bordercolor = 29992855
boolean focusrectangle = false
end type

type p_close from u_picture within w_application_pop
integer x = 2505
integer y = 116
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_close.gif"
end type

event clicked;call super::clicked;Close(parent)
end event

type p_save from u_picture within w_application_pop
integer x = 2222
integer y = 116
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_save.gif"
end type

event clicked;call super::clicked;Long		ll_row
dw_1.Accepttext( )

Choose Case dw_1.getItemStatus( 1, 0, Primary!)
	Case NewModified!
		dw_1.rowscopy( 1, 1, Primary!, dw_2, 1, Primary!)
		dw_2.resetupdate()
		dw_2.setrow(1)
		dw_1.resetupdate()
	Case DataModified!
		ll_row = dw_2.getRow()
		dw_2.setItem(ll_row, 1, dw_1.getItemString(1, 1) )
		dw_2.setItem(ll_row, 2, dw_1.getItemString(1, 2) )
		dw_2.setItem(ll_row, 3, dw_1.getItemString(1, 3) )
		dw_2.resetupdate()
END Choose

dw_2.saveas(getcurrentdir() + "\plugin\serverdata.xml", XML!, False)
end event

type p_delete from u_picture within w_application_pop
integer x = 1938
integer y = 116
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_1.reset()
dw_2.deleterow(dw_2.getRow())
end event

type p_insert from u_picture within w_application_pop
integer x = 1655
integer y = 116
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_add.gif"
end type

event clicked;call super::clicked;dw_1.reset()
dw_1.insertrow(1)
end event

type dw_1 from uo_dwfree within w_application_pop
integer x = 46
integer y = 244
integer width = 2720
integer height = 348
integer taborder = 10
string dataobject = "d_applicationdata"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_1 from statictext within w_application_pop
integer x = 46
integer y = 240
integer width = 2720
integer height = 356
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
long bordercolor = 29992855
boolean focusrectangle = false
end type

