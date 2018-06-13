$PBExportHeader$uo_progressbar.sru
$PBExportComments$땍齡쏵똑係痰빵뚤蹶
forward
global type uo_progressbar from userobject
end type
type r_back from rectangle within uo_progressbar
end type
end forward

global type uo_progressbar from userobject
integer width = 1102
integer height = 96
boolean border = true
long backcolor = 67108864
string text = "none"
borderstyle borderstyle = stylelowered!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
r_back r_back
end type
global uo_progressbar uo_progressbar

type prototypes
//
FUNCTION Long GetDC ( Long hwnd) LIBRARY "user32"
FUNCTION Long ReleaseDC ( Long hwnd, Long hdc) LIBRARY "user32"

//
FUNCTION Long TextOut ( Long hdc, Long xpos, Long ypos, String lpString,  Long nCount) LIBRARY "gdi32" ALIAS FOR "TextOutW"
FUNCTION Long SetTextColor ( Long hdc, Long crColor) LIBRARY "gdi32" 
FUNCTION Long SetBkColor ( Long hdc, Long crColor) LIBRARY "gdi32" ALIAS FOR "SetBkColorW"
FUNCTION Long SetBkMode ( Long hdc, Long nBkMode) LIBRARY "gdi32"
end prototypes

type variables
Public:
	String FontColor 			= '0,0,0'
	String BacGroundColor 	= '255,255,255'
	
Private:
//SetBkMode
CONSTANT LONG OPAQUE = 2
CONSTANT LONG TRANSPARENT = 1

//
Long ii_x, ii_y, ir_Step
Long il_hDC

end variables

forward prototypes
public subroutine of_setcolor ()
public subroutine set_position (integer ai_percent)
public subroutine settext (string msg)
public subroutine set_position (integer ai_percent, string msg)
public subroutine setposition (integer ai_percent)
end prototypes

public subroutine of_setcolor ();//FillColor
r_back.FillColor = Long(gf_getpbcolor(BacGroundColor))

//Test Color
SetTextColor(il_hDC, Long(gf_getpbcolor(FontColor)))

end subroutine

public subroutine set_position (integer ai_percent);string ls_msg
integer li_x

This.SetRedraw(FALSE)

//
li_x = ai_percent * ir_step
r_back.width = li_x 

//
ls_msg= string(ai_percent) + "%" 
This.SetRedraw(True) 
	
//
TextOut (il_hDC, ii_x, ii_y, ls_msg, len( ls_msg ) ) 




end subroutine

public subroutine settext (string msg);TextOut (il_hDC, ii_x, ii_y, msg, len( msg ) ) 




end subroutine

public subroutine set_position (integer ai_percent, string msg);string ls_msg
integer li_x

This.SetRedraw(FALSE)
li_x = ai_percent * ir_step
r_back.width = li_x 
This.SetRedraw(True) 

TextOut (il_hDC, ii_x, ii_y, msg, len( msg ) ) 




end subroutine

public subroutine setposition (integer ai_percent);string ls_msg
integer li_x

This.SetRedraw(FALSE)

//
li_x = ai_percent * ir_step
r_back.width = li_x 

//
//ls_msg= string(ai_percent) + "%" 
This.SetRedraw(True) 
	
//
//TextOut (il_hDC, ii_x, ii_y, ls_msg, len( ls_msg ) ) 




end subroutine

on uo_progressbar.create
this.r_back=create r_back
this.Control[]={this.r_back}
end on

on uo_progressbar.destroy
destroy(this.r_back)
end on

event constructor;Integer li_Width, li_Height

//
CHOOSE CASE this.BorderStyle
	CASE StyleLowered!, StyleRaised!
		li_Width = This.Width - 4
		li_Height = This.Height - 4
	CASE StyleBox!, StyleShadowBox!
		li_Width = This.Width - 2
		li_Height = This.Height - 2
	CASE Else
		li_Width = This.Width
		li_Height = This.Height
END CHOOSE

//
r_back.width = 0
r_back.Height = li_Height

//
ii_x = UnitsToPixels(li_Width, XUnitsToPixels!)/2 - 16
ii_y = (UnitsToPixels(li_Height, YUnitsToPixels!) - 16 )/2

//
ir_step = Round(li_Width / 100, 0)

//
il_hDC = GetDC(Handle(This) )

of_setcolor()

//
SetBkMode (il_hDC, TRANSPARENT)    






end event

event destructor;
ReleaseDC(Handle(This), il_hDC)

end event

type r_back from rectangle within uo_progressbar
long linecolor = 134217729
integer linethickness = 1
long fillcolor = 16711680
integer width = 238
integer height = 68
end type

