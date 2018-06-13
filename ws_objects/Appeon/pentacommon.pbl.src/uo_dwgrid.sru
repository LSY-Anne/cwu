$PBExportHeader$uo_dwgrid.sru
forward
global type uo_dwgrid from u_dwgrid
end type
end forward

global type uo_dwgrid from u_dwgrid
string rowselectcolor = "248,231,237"
string hotbackcolor = "255,255,255"
string nobackcolor = "206,218,236"
string graysepcolor1 = "190,193,198"
string graysepcolor2 = "203,214,236"
string hotlinecolor = "206,218,236"
string nomallinecolor = "206,218,236"
string nofontcolor = "57,91,126"
string hotfontcolor = "57,91,126"
string alternatefirstcolor = "243,244,249"
end type
global uo_dwgrid uo_dwgrid

on uo_dwgrid.create
call super::create
end on

on uo_dwgrid.destroy
call super::destroy
end on

event constructor;call super::constructor;this.setPosition(totop!)
end event

event itemerror;call super::itemerror;Return 1
end event

