$PBExportHeader$uo_statictext.sru
forward
global type uo_statictext from statictext
end type
end forward

global type uo_statictext from statictext
integer width = 18
integer height = 412
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
event ue_mousemove pbm_mousemove
event ue_bottondown pbm_lbuttondown
event ue_bottonup pbm_lbuttonup
end type
global uo_statictext uo_statictext

type variables
Long			il_color
DragObject 	ido_left, ido_right
Char			ic_flag
Long			il_width

Boolean		ib_enable = False
end variables

forward prototypes
public subroutine of_setpointer ()
public subroutine of_setobject (dragobject ado_left, dragobject ado_right, character ac_flag)
public subroutine of_enable (boolean ab_tf)
end prototypes

event ue_mousemove;IF ib_enable THEN
	of_SetPointer()
	
	Long			xyposition
	Boolean		lb_tf = False
	
	This.bringtotop = True
	
	IF ic_flag = 'H' THEN
		xyposition  = Parent.DYNAMIC PointerX()
		
		IF flags <> 0 THEN
			IF xyposition < ido_left.x + (il_width * 2) THEN
				lb_tf = True
			ELSE
				IF xyposition > ido_right.x + ido_right.width - (il_width * 3) THEN
					lb_tf = True
				ELSE
					This.x = This.x + xpos
					lb_tf = False
				END IF
			END IF
		ELSE
			lb_tf = False
		END IF
		
		IF lb_tf THEN
			return -1
		END IF
	ELSEIF ic_flag = 'V' THEN
	
		xyposition	= Parent.DYNAMIC PointerY()
	
		IF flags <> 0 THEN
			IF xyposition < ido_left.Y + (il_width * 2) THEN
				lb_tf = True
			ELSE
				IF xyposition > ido_right.Y + ido_right.Height - (il_width * 3) THEN
					lb_tf = True
				ELSE
					This.Y = This.Y + ypos
					lb_tf = False
				END IF
			END IF
		ELSE
			lb_tf = False
		END IF
		
		IF lb_tf THEN
			return -1
		END IF
	END IF
END IF
end event

event ue_bottondown;IF ib_enable THEN
	of_SetPointer()
	
	this.BackColor = rgb(100, 100, 100)
END IF
end event

event ue_bottonup;IF ib_enable THEN
	of_SetPointer()
	
	This.BackColor = il_color
	
	Integer		pos
	String		label
	alignment	alig
	
	IF ic_flag = 'H' THEN
		ido_left.width 	= This.x - ido_left.x
		ido_right.width 	= (ido_right.x + ido_right.width) - (This.x + This.Width)
		ido_right.x	  		= This.x + This.Width
		
	ELSEIF ic_flag = 'V' THEN
		
		ido_left.Height 	= This.Y - ido_left.Y
		ido_right.Height 	= (ido_right.Y + ido_right.Height) - (This.y + This.Height)
		ido_right.Y	  		= This.Y + This.Height
		
	END IF
END IF
end event

public subroutine of_setpointer ();Choose Case ic_flag
	Case 'H'
		This.Pointer	= 'SizeWE!'
	Case 'V'
		This.Pointer	= 'SizeNS!'
	Case Else
End Choose
end subroutine

public subroutine of_setobject (dragobject ado_left, dragobject ado_right, character ac_flag);Integer li_luwidth, li_rdwidth 
ido_left 	= ado_left
ido_right	= ado_right
ic_flag		= Upper(ac_flag)

IF ic_flag = 'H' THEN
	il_width		= ido_right.X - (ido_left.X + ido_left.Width)
	
	This.Width 	= il_width
ELSEIF ic_flag = 'V' THEN
	il_width		= ido_right.Y - (ido_left.Y + ido_left.Height)
	
	This.Height = il_width
END IF

end subroutine

public subroutine of_enable (boolean ab_tf);ib_enable = ab_tf
end subroutine

on uo_statictext.create
end on

on uo_statictext.destroy
end on

event constructor;of_SetPointer()

il_color = This.BackColor
//il_color = rgb(255,255,255)
end event

