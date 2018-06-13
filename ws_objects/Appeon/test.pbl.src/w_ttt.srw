$PBExportHeader$w_ttt.srw
forward
global type w_ttt from w_ancsheet
end type
type p_1 from u_picture within w_ttt
end type
type uo_1 from uo_imgbtn within w_ttt
end type
end forward

global type w_ttt from w_ancsheet
p_1 p_1
uo_1 uo_1
end type
global w_ttt w_ttt

on w_ttt.create
int iCurrent
call super::create
this.p_1=create p_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_ttt.destroy
call super::destroy
destroy(this.p_1)
destroy(this.uo_1)
end on

type ln_templeft from w_ancsheet`ln_templeft within w_ttt
end type

type ln_tempright from w_ancsheet`ln_tempright within w_ttt
end type

type ln_temptop from w_ancsheet`ln_temptop within w_ttt
end type

type ln_tempbuttom from w_ancsheet`ln_tempbuttom within w_ttt
end type

type ln_tempbutton from w_ancsheet`ln_tempbutton within w_ttt
end type

type ln_tempstart from w_ancsheet`ln_tempstart within w_ttt
end type

type p_1 from u_picture within w_ttt
integer x = 160
integer y = 208
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_search.gif"
end type

type uo_1 from uo_imgbtn within w_ttt
integer x = 146
integer y = 96
integer taborder = 20
boolean bringtotop = true
string #btnname = "한글입니다. 알았지요..."
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

