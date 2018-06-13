$PBExportHeader$u_leftmenu.sru
forward
global type u_leftmenu from userobject
end type
type rr_1 from roundrectangle within u_leftmenu
end type
type p_bookmark from u_picture within u_leftmenu
end type
type p_tree from u_picture within u_leftmenu
end type
type p_buttom from picture within u_leftmenu
end type
type p_middle from picture within u_leftmenu
end type
type p_top from picture within u_leftmenu
end type
type st_1 from statictext within u_leftmenu
end type
end forward

global type u_leftmenu from userobject
integer width = 1422
integer height = 2072
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_constructor ( )
event ue_treeview ( )
event ue_bookmark ( )
event ue_popbookmark ( )
rr_1 rr_1
p_bookmark p_bookmark
p_tree p_tree
p_buttom p_buttom
p_middle p_middle
p_top p_top
st_1 st_1
end type
global u_leftmenu u_leftmenu

type variables
nvo_tooltip		in_tooltip
end variables

forward prototypes
public subroutine of_init ()
public subroutine of_resize ()
end prototypes

event ue_constructor();p_tree.of_enable(true)
p_bookmark.of_enable(true)

of_resize()

end event

public subroutine of_init ();
end subroutine

public subroutine of_resize ();rr_1.x 			= 0
rr_1.y 			= 0
rr_1.width 		= This.width
rr_1.height 		= this.height

st_1.x				= rr_1.x
st_1.y				= rr_1.y
st_1.width		= rr_1.width
st_1.height		= rr_1.height

p_top.x			= PixelsToUnits(UnitsToPixels(rr_1.x, XUnitsToPixels!), XPixelsToUnits!)
p_top.y			= PixelsToUnits(UnitsToPixels(rr_1.y, YUnitsToPixels!), YPixelsToUnits!)
//p_top.height		= rr_1.height

p_tree.x 		= p_top.x
p_tree.y 		= PixelsToUnits( UnitsToPixels(p_top.y, YUnitsToPixels!) + UnitsToPixels(p_top.height, YUnitsToPixels!) + 2, YPixelsToUnits!)
p_tree.Setposition(ToTop! )

p_bookmark.x 	= p_top.x
p_bookmark.y 	= PixelsToUnits(UnitsToPixels(p_tree.y, YUnitsToPixels!) + UnitsToPixels(p_tree.height, YUnitsToPixels!) + 2, YPixelsToUnits!)
p_bookmark.Setposition(ToTop! )

p_buttom.x		= p_top.x
p_buttom.y 		= rr_1.y + rr_1.height//PixelsToUnits(UnitsToPixels(p_bookmark.y, YUnitsToPixels!) + UnitsToPixels(p_bookmark.width, YUnitsToPixels!) + 1, YPixelsToUnits!)//PixelsToUnits( UnitsToPixels(rr_1.y, YUnitsToPixels!) + UnitsToPixels(rr_1.height, YUnitsToPixels!) - 200, YPixelsToUnits!)
//p_buttom.width = p_top.width
//p_buttom.height = ( rr_1.y  + rr_1.height) - (p_bookmark.y + p_bookmark.height )

p_middle.x		= p_top.x
p_middle.y		= PixelsToUnits(UnitsToPixels(p_top.y, YUnitsToPixels!) + UnitsToPixels(p_top.height, YUnitsToPixels!), YPixelsToUnits!)
p_middle.width = p_top.width
p_middle.height= PixelsToUnits(UnitsToPixels(p_buttom.y, YUnitsToPixels!) - UnitsToPixels(p_middle.y, YUnitsToPixels!), YPixelsToUnits!)

end subroutine

on u_leftmenu.create
this.rr_1=create rr_1
this.p_bookmark=create p_bookmark
this.p_tree=create p_tree
this.p_buttom=create p_buttom
this.p_middle=create p_middle
this.p_top=create p_top
this.st_1=create st_1
this.Control[]={this.rr_1,&
this.p_bookmark,&
this.p_tree,&
this.p_buttom,&
this.p_middle,&
this.p_top,&
this.st_1}
end on

on u_leftmenu.destroy
destroy(this.rr_1)
destroy(this.p_bookmark)
destroy(this.p_tree)
destroy(this.p_buttom)
destroy(this.p_middle)
destroy(this.p_top)
destroy(this.st_1)
end on

event constructor;This.Post Event ue_constructor()
end event

type rr_1 from roundrectangle within u_leftmenu
boolean visible = false
long linecolor = 134217728
integer linethickness = 4
long fillcolor = 16777215
integer x = 5
integer width = 1413
integer height = 2064
integer cornerheight = 40
integer cornerwidth = 55
end type

type p_bookmark from u_picture within u_leftmenu
integer x = 9
integer y = 292
integer width = 78
integer height = 264
string picturename = "..\img\tlr_style\thema_1\bookmark.gif"
boolean callevent = true
string is_event = "ue_bookmark"
end type

event rbuttondown;call super::rbuttondown;Parent.Post Event ue_popbookmark()
end event

type p_tree from u_picture within u_leftmenu
integer x = 5
integer y = 204
integer width = 78
integer height = 272
string picturename = "..\img\tlr_style\thema_1\treemenu.gif"
boolean callevent = true
string is_event = "ue_treeview"
end type

type p_buttom from picture within u_leftmenu
integer x = 5
integer y = 400
integer width = 78
integer height = 12
boolean originalsize = true
string picturename = "..\img\tlr_style\thema_1\leftmenubuttom.gif"
boolean focusrectangle = false
end type

type p_middle from picture within u_leftmenu
integer x = 5
integer y = 192
integer width = 78
integer height = 48
string picturename = "..\img\tlr_style\thema_1\leftmenumiddle.gif"
boolean focusrectangle = false
end type

type p_top from picture within u_leftmenu
integer x = 5
integer y = 84
integer width = 78
integer height = 144
boolean originalsize = true
string picturename = "..\img\tlr_style\thema_1\leftmenutop.gif"
boolean focusrectangle = false
end type

type st_1 from statictext within u_leftmenu
boolean visible = false
integer x = 9
integer width = 1408
integer height = 2064
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
long bordercolor = 31381975
boolean focusrectangle = false
end type

