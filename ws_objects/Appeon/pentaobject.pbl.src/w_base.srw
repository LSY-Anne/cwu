$PBExportHeader$w_base.srw
forward
global type w_base from window
end type
end forward

global type w_base from window
integer width = 3465
integer height = 1924
boolean titlebar = true
string title = "Untitled"
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
end type
global w_base w_base

type variables
Private :

	String is_pgm_no
end variables

forward prototypes
public subroutine setpgmno (string as_pgmno)
public function string getpgmno ()
end prototypes

public subroutine setpgmno (string as_pgmno);is_pgm_no = as_pgmno
end subroutine

public function string getpgmno ();return is_pgm_no
end function

on w_base.create
end on

on w_base.destroy
end on

event open;/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 같은윈도우  여러개 실행하기
		 작업 = 신규 추가 윈도우
	작업자  : 김영재 송상철
====================================*/
end event

