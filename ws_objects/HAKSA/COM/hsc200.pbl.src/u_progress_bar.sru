$PBExportHeader$u_progress_bar.sru
$PBExportComments$[청운대]Progress Bar 입니다. UserObject 함수가 2개 있읍니다.
forward
global type u_progress_bar from userobject
end type
type rc_2 from rectangle within u_progress_bar
end type
type st_1 from statictext within u_progress_bar
end type
end forward

global type u_progress_bar from userobject
integer width = 1303
integer height = 88
boolean border = true
long backcolor = 16777215
long tabtextcolor = 33554432
event append_effect pbm_timer
rc_2 rc_2
st_1 st_1
end type
global u_progress_bar u_progress_bar

type variables
// Determines if the progress bar has touched the 
// percentage text
boolean    ib_invert
long MaxValue
decimal AppendValue

end variables

forward prototypes
public subroutine uf_init (double ar_maxvalue)
public subroutine uf_set_position (double currentvalue)
end prototypes

event append_effect;//AppendValue += 0.1
////ln_1.width = sin(AppendValue) * this.width
//ln_1.visible = true
//if sin(AppendValue) = 1 then
//	AppendValue = 0
//end if
end event

public subroutine uf_init (double ar_maxvalue);maxvalue = ar_MaxValue
AppendValue = 0
timer(0.05)

rc_2.width = 0
rc_2.visible = true

//st_1.text = "Wait"
st_1.textcolor = RGB(0,0,255)
st_1.BackColor = RGB(255,255,255)
st_1.y = 12
st_1.x = this.width/2






end subroutine

public subroutine uf_set_position (double currentvalue);


//if Int (CurrentValue) = 0 then
//	ib_invert = false
//	st_1.TextColor = RGB (0, 0, 255)
//	st_1.BackColor = RGB (255, 255, 255)	
//end if
//

st_1.Backcolor = RGB(0,0,255)
st_1.textColor = RGB(255,255,255)
rc_2.width = (CurrentValue/MaxValue) * this.width
rc_2.visible = true

if CurrentValue = MaxValue then
	st_1.text = "완료"
else
	st_1.text = String ((CurrentValue/MaxValue) * 100,'##.0') + '%'
end if
//st_1.y = 12
//st_1.x = rc_2.width - st_1.width - 10

//if not ib_invert then
//	if rc_2.width >= st_1.x then
//		ib_invert = true
//		ll_color = st_1.textcolor
//		st_1.TextColor = st_1.BackColor
//		st_1.BackColor = ll_color
//	end if
//end if

end subroutine

on u_progress_bar.create
this.rc_2=create rc_2
this.st_1=create st_1
this.Control[]={this.rc_2,&
this.st_1}
end on

on u_progress_bar.destroy
destroy(this.rc_2)
destroy(this.st_1)
end on

type rc_2 from rectangle within u_progress_bar
boolean visible = false
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 16711680
integer width = 32
integer height = 144
end type

type st_1 from statictext within u_progress_bar
integer x = 9
integer y = 108
integer width = 151
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 16711680
string text = "0%"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

