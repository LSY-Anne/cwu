$PBExportHeader$w_progress_popup.srw
$PBExportComments$처리중 메세지를 보낸다.
forward
global type w_progress_popup from window
end type
type st_message from statictext within w_progress_popup
end type
type st_1 from statictext within w_progress_popup
end type
type st_2 from statictext within w_progress_popup
end type
type p_2 from picture within w_progress_popup
end type
type p_1 from picture within w_progress_popup
end type
end forward

global type w_progress_popup from window
integer x = 1134
integer y = 1028
integer width = 1184
integer height = 204
windowtype windowtype = popup!
long backcolor = 15780518
string pointer = "HourGlass!"
event ue_event pbm_custom11
st_message st_message
st_1 st_1
st_2 st_2
p_2 p_2
p_1 p_1
end type
global w_progress_popup w_progress_popup

type variables
int      ii_cnt, ii_color
int      ii_Flag = 0 //0:1,1:2

//n_notify inv_notify
//n_thread inv_thread
//
end variables

forward prototypes
public function integer of_sendmsg (integer ai_flag)
end prototypes

event ue_event;//inv_thread.post    of_dosomething()

end event

public function integer of_sendmsg (integer ai_flag);ii_color++


If ai_flag = 0 Then
	p_1.Visible = True
	p_2.Visible = False
else
	p_2.Visible = True
	p_1.Visible = False	
end IF


IF ii_color = 4 then ii_color = 1

CHOOSE CASE ii_color
	CASE 1
		st_1.textcolor = rgb(0,0,0)
		st_2.textcolor = rgb(0,0,0)
	CASE 2
		st_1.textcolor = rgb(255,0,0)
		st_2.textcolor = rgb(0,0,255)		
	CASE 3
		st_1.textcolor = rgb(0,0,255)
		st_2.textcolor = rgb(255,0,0)
END CHOOSE


return 1
end function

event open;ii_color = 0
f_centerme(this)

timer(0.3) //시간을 0.3초로  동작한다.
//inv_notify = CREATE n_notify
//inv_notify.of_SetPO(this)
//
////// Create Threads/Shared Objects
//IF SharedObjectRegister("n_thread", "SO_THREAD") = Success! THEN
//	IF SharedObjectGet("SO_THREAD", inv_thread) = Success! THEN	
//     	inv_thread.of_PassNotify(inv_notify)
//		//Triggerevent('ue_event')  
//	else
//	   MessageBox("Error", "Could not start Thread 1df")		
//   end if
//ELSE
//	MessageBox("Error", "Could not start Thread 1")
//END IF
//
//


end event

event timer;ii_cnt++
ii_color++

IF ii_cnt = 3 then ii_cnt = 1

If ii_flag = 0 Then
	ii_flag     = 1 
	p_1.Visible = True
	p_2.Visible = False
else
	ii_flag     = 0 	
	p_2.Visible = True
	p_1.Visible = False	
end IF


IF ii_color = 4 then ii_color = 1

CHOOSE CASE ii_color
	CASE 1
		st_1.textcolor = rgb(0,0,0)
		st_2.textcolor = rgb(0,0,0)
	CASE 2
		st_1.textcolor = rgb(255,0,0)
		st_2.textcolor = rgb(0,0,255)		
	CASE 3
		st_1.textcolor = rgb(0,0,255)
		st_2.textcolor = rgb(255,0,0)
END CHOOSE

end event

on w_progress_popup.create
this.st_message=create st_message
this.st_1=create st_1
this.st_2=create st_2
this.p_2=create p_2
this.p_1=create p_1
this.Control[]={this.st_message,&
this.st_1,&
this.st_2,&
this.p_2,&
this.p_1}
end on

on w_progress_popup.destroy
destroy(this.st_message)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.p_2)
destroy(this.p_1)
end on

event close;//SharedObjectUnRegister("SO_THREAD")
//SetNull(inv_notify)
////// Destroy notify objects
//
//DESTROY inv_notify
//
end event

type st_message from statictext within w_progress_popup
integer x = 219
integer y = 216
integer width = 1582
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 15780518
boolean enabled = false
string text = "잠시만 기다려 주십시오..."
boolean focusrectangle = false
end type

type st_1 from statictext within w_progress_popup
integer x = 229
integer y = 24
integer width = 535
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 15780518
boolean enabled = false
string text = "처리 중입니다. "
boolean focusrectangle = false
end type

type st_2 from statictext within w_progress_popup
integer x = 224
integer y = 112
integer width = 914
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 15780518
boolean enabled = false
string text = "잠시만 기다려 주십시요..."
boolean focusrectangle = false
end type

type p_2 from picture within w_progress_popup
boolean visible = false
integer x = 27
integer y = 24
integer width = 169
integer height = 148
boolean originalsize = true
string picturename = "D:\프로젝트\images\Work2.jpg"
boolean focusrectangle = false
end type

type p_1 from picture within w_progress_popup
integer x = 27
integer y = 24
integer width = 178
integer height = 148
string picturename = "..\BMP\WORK1.BMP"
boolean focusrectangle = false
end type

