$PBExportHeader$uo_dwlv.sru
forward
global type uo_dwlv from u_dwlv
end type
end forward

global type uo_dwlv from u_dwlv
string linecolor = "190,193,198"
string colselectcolor = "255,0,0"
string hotbackcolor = "255,255,255"
string nobackcolor = "206,218,236"
string graysepcolor = "190,193,198"
string graysepcolor2 = "203,214,236"
string hotlinecolor = "206,218,236"
string nomallinecolor = "206,218,236"
string alternatefirstcolor = "243,244,249"
string nofontcolor = "57,91,126"
string hotfontcolor = "57,91,126"
boolean usegrid = true
end type
global uo_dwlv uo_dwlv

on uo_dwlv.create
call super::create
end on

on uo_dwlv.destroy
call super::destroy
end on

event constructor;call super::constructor;this.setPosition(totop!)
end event

event itemerror;call super::itemerror;Return 1
end event

