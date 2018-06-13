$PBExportHeader$w_response_ancestor.srw
forward
global type w_response_ancestor from w_ancresponse
end type
type uc_cancel from u_picture within w_response_ancestor
end type
type uc_ok from u_picture within w_response_ancestor
end type
type uc_excelroad from u_picture within w_response_ancestor
end type
type uc_excel from u_picture within w_response_ancestor
end type
type uc_save from u_picture within w_response_ancestor
end type
type uc_delete from u_picture within w_response_ancestor
end type
type uc_insert from u_picture within w_response_ancestor
end type
type uc_retrieve from u_picture within w_response_ancestor
end type
type ln_temptop from line within w_response_ancestor
end type
type ln_1 from line within w_response_ancestor
end type
type ln_2 from line within w_response_ancestor
end type
type ln_3 from line within w_response_ancestor
end type
end forward

global type w_response_ancestor from w_ancresponse
uc_cancel uc_cancel
uc_ok uc_ok
uc_excelroad uc_excelroad
uc_excel uc_excel
uc_save uc_save
uc_delete uc_delete
uc_insert uc_insert
uc_retrieve uc_retrieve
ln_temptop ln_temptop
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
end type
global w_response_ancestor w_response_ancestor

on w_response_ancestor.create
int iCurrent
call super::create
this.uc_cancel=create uc_cancel
this.uc_ok=create uc_ok
this.uc_excelroad=create uc_excelroad
this.uc_excel=create uc_excel
this.uc_save=create uc_save
this.uc_delete=create uc_delete
this.uc_insert=create uc_insert
this.uc_retrieve=create uc_retrieve
this.ln_temptop=create ln_temptop
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uc_cancel
this.Control[iCurrent+2]=this.uc_ok
this.Control[iCurrent+3]=this.uc_excelroad
this.Control[iCurrent+4]=this.uc_excel
this.Control[iCurrent+5]=this.uc_save
this.Control[iCurrent+6]=this.uc_delete
this.Control[iCurrent+7]=this.uc_insert
this.Control[iCurrent+8]=this.uc_retrieve
this.Control[iCurrent+9]=this.ln_temptop
this.Control[iCurrent+10]=this.ln_1
this.Control[iCurrent+11]=this.ln_2
this.Control[iCurrent+12]=this.ln_3
end on

on w_response_ancestor.destroy
call super::destroy
destroy(this.uc_cancel)
destroy(this.uc_ok)
destroy(this.uc_excelroad)
destroy(this.uc_excel)
destroy(this.uc_save)
destroy(this.uc_delete)
destroy(this.uc_insert)
destroy(this.uc_retrieve)
destroy(this.ln_temptop)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
end on

type uc_cancel from u_picture within w_response_ancestor
integer x = 2953
integer y = 44
integer width = 306
integer height = 96
string picturename = "..\img\topBtn_cancel.gif"
end type

type uc_ok from u_picture within w_response_ancestor
integer x = 2633
integer y = 44
integer width = 306
integer height = 96
boolean originalsize = false
string picturename = "..\img\topBtn_ok.gif"
end type

type uc_excelroad from u_picture within w_response_ancestor
integer x = 2217
integer y = 44
integer width = 402
integer height = 96
boolean originalsize = false
string picturename = "..\img\topBtn_excelroad.gif"
end type

type uc_excel from u_picture within w_response_ancestor
integer x = 1897
integer y = 44
integer width = 306
integer height = 96
boolean originalsize = false
string picturename = "..\img\topBtn_excel.gif"
end type

type uc_save from u_picture within w_response_ancestor
integer x = 1577
integer y = 44
integer width = 306
integer height = 96
boolean originalsize = false
string picturename = "..\img\topBtn_save.gif"
end type

type uc_delete from u_picture within w_response_ancestor
integer x = 1257
integer y = 44
integer width = 306
integer height = 96
boolean originalsize = false
string picturename = "..\img\topBtn_delete.gif"
end type

type uc_insert from u_picture within w_response_ancestor
integer x = 937
integer y = 44
integer width = 306
integer height = 96
boolean originalsize = false
string picturename = "..\img\topBtn_input.gif"
end type

type uc_retrieve from u_picture within w_response_ancestor
integer x = 617
integer y = 44
integer width = 306
integer height = 96
boolean originalsize = false
string picturename = "..\img\topBtn_retrieve.gif"
end type

type ln_temptop from line within w_response_ancestor
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 172
integer endx = 3305
integer endy = 172
end type

type ln_1 from line within w_response_ancestor
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 1516
integer endx = 3305
integer endy = 1516
end type

type ln_2 from line within w_response_ancestor
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 46
integer endx = 46
integer endy = 1572
end type

type ln_3 from line within w_response_ancestor
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 3255
integer endx = 3255
integer endy = 1572
end type

