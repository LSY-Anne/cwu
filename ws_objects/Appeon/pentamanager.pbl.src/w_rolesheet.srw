$PBExportHeader$w_rolesheet.srw
forward
global type w_rolesheet from w_ancsheet
end type
type uc_retrieve from u_picture within w_rolesheet
end type
type uc_save from u_picture within w_rolesheet
end type
type uc_run from u_picture within w_rolesheet
end type
type uc_print from u_picture within w_rolesheet
end type
type uc_ok from u_picture within w_rolesheet
end type
type uc_excel from u_picture within w_rolesheet
end type
type uc_delete from u_picture within w_rolesheet
end type
type uc_close from u_picture within w_rolesheet
end type
type uc_cancel from u_picture within w_rolesheet
end type
type uc_insert from u_picture within w_rolesheet
end type
end forward

global type w_rolesheet from w_ancsheet
uc_retrieve uc_retrieve
uc_save uc_save
uc_run uc_run
uc_print uc_print
uc_ok uc_ok
uc_excel uc_excel
uc_delete uc_delete
uc_close uc_close
uc_cancel uc_cancel
uc_insert uc_insert
end type
global w_rolesheet w_rolesheet

on w_rolesheet.create
int iCurrent
call super::create
this.uc_retrieve=create uc_retrieve
this.uc_save=create uc_save
this.uc_run=create uc_run
this.uc_print=create uc_print
this.uc_ok=create uc_ok
this.uc_excel=create uc_excel
this.uc_delete=create uc_delete
this.uc_close=create uc_close
this.uc_cancel=create uc_cancel
this.uc_insert=create uc_insert
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uc_retrieve
this.Control[iCurrent+2]=this.uc_save
this.Control[iCurrent+3]=this.uc_run
this.Control[iCurrent+4]=this.uc_print
this.Control[iCurrent+5]=this.uc_ok
this.Control[iCurrent+6]=this.uc_excel
this.Control[iCurrent+7]=this.uc_delete
this.Control[iCurrent+8]=this.uc_close
this.Control[iCurrent+9]=this.uc_cancel
this.Control[iCurrent+10]=this.uc_insert
end on

on w_rolesheet.destroy
call super::destroy
destroy(this.uc_retrieve)
destroy(this.uc_save)
destroy(this.uc_run)
destroy(this.uc_print)
destroy(this.uc_ok)
destroy(this.uc_excel)
destroy(this.uc_delete)
destroy(this.uc_close)
destroy(this.uc_cancel)
destroy(this.uc_insert)
end on

type ln_templeft from w_ancsheet`ln_templeft within w_rolesheet
end type

type ln_tempright from w_ancsheet`ln_tempright within w_rolesheet
end type

type ln_temptop from w_ancsheet`ln_temptop within w_rolesheet
end type

type ln_tempbuttom from w_ancsheet`ln_tempbuttom within w_rolesheet
end type

type ln_tempbutton from w_ancsheet`ln_tempbutton within w_rolesheet
end type

type ln_tempstart from w_ancsheet`ln_tempstart within w_rolesheet
end type

type uc_retrieve from u_picture within w_rolesheet
integer x = 2825
integer y = 36
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_retrieve.gif"
end type

type uc_save from u_picture within w_rolesheet
integer x = 3954
integer y = 36
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_save.gif"
end type

type uc_run from u_picture within w_rolesheet
integer x = 2153
integer y = 36
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_execu.gif"
end type

type uc_print from u_picture within w_rolesheet
integer x = 3497
integer y = 36
integer width = 215
integer height = 72
boolean bringtotop = true
string picturename = "..\img\button\topBtn_print01.gif"
end type

type uc_ok from u_picture within w_rolesheet
integer x = 2377
integer y = 36
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_ok.gif"
end type

type uc_excel from u_picture within w_rolesheet
integer x = 3730
integer y = 36
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_excel.gif"
end type

type uc_delete from u_picture within w_rolesheet
integer x = 3273
integer y = 36
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_delete.gif"
end type

type uc_close from u_picture within w_rolesheet
integer x = 4178
integer y = 36
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_close.gif"
end type

type uc_cancel from u_picture within w_rolesheet
integer x = 2601
integer y = 36
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_cancel.gif"
end type

type uc_insert from u_picture within w_rolesheet
integer x = 3049
integer y = 36
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_add.gif"
end type

