$PBExportHeader$u_progressbar.sru
forward
global type u_progressbar from uo_progressbar
end type
end forward

global type u_progressbar from uo_progressbar
long backcolor = 16777215
string fontcolor = "95,95,95"
string bacgroundcolor = "140,185,223"
end type
global u_progressbar u_progressbar

on u_progressbar.create
call super::create
end on

on u_progressbar.destroy
call super::destroy
end on

type r_back from uo_progressbar`r_back within u_progressbar
end type

