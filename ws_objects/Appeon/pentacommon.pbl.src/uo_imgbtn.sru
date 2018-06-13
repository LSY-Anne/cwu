$PBExportHeader$uo_imgbtn.sru
forward
global type uo_imgbtn from u_imagebtn
end type
end forward

global type uo_imgbtn from u_imagebtn
string fontcolor = "80,88,111"
string selectfontcolor = "80,88,111"
string enablefontcolor = "187,187,187"
string fontface = "돋움"
integer fontsize = 9
integer textgaby = -1
integer clickedtextygab = 1
string filepath = "..\img\btn\"
string front_select = "btn_fton.gif"
boolean callevent = true
end type
global uo_imgbtn uo_imgbtn

type variables
Protected:
	Boolean	DebugTF = false
end variables

on uo_imgbtn.create
call super::create
end on

on uo_imgbtn.destroy
call super::destroy
end on

event constructor;call super::constructor;IF DebugTF THEN messagebox("Info", this.classname() + ": W/" + String(this.width) + " | H/" + String(this.height))

end event

type st_text from u_imagebtn`st_text within uo_imgbtn
end type

type p_1 from u_imagebtn`p_1 within uo_imgbtn
end type

type designedw from u_imagebtn`designedw within uo_imgbtn
end type

