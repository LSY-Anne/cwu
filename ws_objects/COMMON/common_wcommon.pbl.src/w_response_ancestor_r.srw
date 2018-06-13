$PBExportHeader$w_response_ancestor_r.srw
$PBExportComments$팝업 상속윈도우 (조회 )
forward
global type w_response_ancestor_r from w_ancresponse
end type
type uc_retrieve from u_picture within w_response_ancestor_r
end type
type uc_ok from u_picture within w_response_ancestor_r
end type
type uc_cancel from u_picture within w_response_ancestor_r
end type
type ln_temptop from line within w_response_ancestor_r
end type
type ln_1 from line within w_response_ancestor_r
end type
type ln_2 from line within w_response_ancestor_r
end type
type ln_3 from line within w_response_ancestor_r
end type
end forward

global type w_response_ancestor_r from w_ancresponse
integer width = 1573
uc_retrieve uc_retrieve
uc_ok uc_ok
uc_cancel uc_cancel
ln_temptop ln_temptop
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
end type
global w_response_ancestor_r w_response_ancestor_r

on w_response_ancestor_r.create
int iCurrent
call super::create
this.uc_retrieve=create uc_retrieve
this.uc_ok=create uc_ok
this.uc_cancel=create uc_cancel
this.ln_temptop=create ln_temptop
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uc_retrieve
this.Control[iCurrent+2]=this.uc_ok
this.Control[iCurrent+3]=this.uc_cancel
this.Control[iCurrent+4]=this.ln_temptop
this.Control[iCurrent+5]=this.ln_1
this.Control[iCurrent+6]=this.ln_2
this.Control[iCurrent+7]=this.ln_3
end on

on w_response_ancestor_r.destroy
call super::destroy
destroy(this.uc_retrieve)
destroy(this.uc_ok)
destroy(this.uc_cancel)
destroy(this.ln_temptop)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
end on

type uc_retrieve from u_picture within w_response_ancestor_r
integer x = 571
integer y = 44
integer width = 265
integer height = 84
string picturename = "..\img\button\topBtn_retrieve.gif"
end type

type uc_ok from u_picture within w_response_ancestor_r
integer x = 891
integer y = 44
integer width = 265
integer height = 84
string picturename = "..\img\button\topBtn_ok.gif"
end type

type uc_cancel from u_picture within w_response_ancestor_r
integer x = 1211
integer y = 44
integer width = 265
integer height = 84
string picturename = "..\img\button\topBtn_cancel.gif"
end type

type ln_temptop from line within w_response_ancestor_r
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 172
integer endx = 1563
integer endy = 172
end type

type ln_1 from line within w_response_ancestor_r
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 1516
integer endx = 1563
integer endy = 1516
end type

type ln_2 from line within w_response_ancestor_r
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 46
integer endx = 46
integer endy = 1572
end type

type ln_3 from line within w_response_ancestor_r
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 1513
integer endx = 1513
integer endy = 1572
end type

