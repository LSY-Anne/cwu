$PBExportHeader$w_ancestor.srw
forward
global type w_ancestor from w_ancsheet
end type
type uc_retrieve from u_picture within w_ancestor
end type
type uc_insert from u_picture within w_ancestor
end type
type uc_delete from u_picture within w_ancestor
end type
type uc_save from u_picture within w_ancestor
end type
type uc_excel from u_picture within w_ancestor
end type
type uc_excelroad from u_picture within w_ancestor
end type
type uc_printpreview from u_picture within w_ancestor
end type
type uc_print from u_picture within w_ancestor
end type
type uc_confirmpreview from u_picture within w_ancestor
end type
type uc_confirm from u_picture within w_ancestor
end type
type uc_help from u_picture within w_ancestor
end type
end forward

global type w_ancestor from w_ancsheet
uc_retrieve uc_retrieve
uc_insert uc_insert
uc_delete uc_delete
uc_save uc_save
uc_excel uc_excel
uc_excelroad uc_excelroad
uc_printpreview uc_printpreview
uc_print uc_print
uc_confirmpreview uc_confirmpreview
uc_confirm uc_confirm
uc_help uc_help
end type
global w_ancestor w_ancestor

on w_ancestor.create
int iCurrent
call super::create
this.uc_retrieve=create uc_retrieve
this.uc_insert=create uc_insert
this.uc_delete=create uc_delete
this.uc_save=create uc_save
this.uc_excel=create uc_excel
this.uc_excelroad=create uc_excelroad
this.uc_printpreview=create uc_printpreview
this.uc_print=create uc_print
this.uc_confirmpreview=create uc_confirmpreview
this.uc_confirm=create uc_confirm
this.uc_help=create uc_help
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uc_retrieve
this.Control[iCurrent+2]=this.uc_insert
this.Control[iCurrent+3]=this.uc_delete
this.Control[iCurrent+4]=this.uc_save
this.Control[iCurrent+5]=this.uc_excel
this.Control[iCurrent+6]=this.uc_excelroad
this.Control[iCurrent+7]=this.uc_printpreview
this.Control[iCurrent+8]=this.uc_print
this.Control[iCurrent+9]=this.uc_confirmpreview
this.Control[iCurrent+10]=this.uc_confirm
this.Control[iCurrent+11]=this.uc_help
end on

on w_ancestor.destroy
call super::destroy
destroy(this.uc_retrieve)
destroy(this.uc_insert)
destroy(this.uc_delete)
destroy(this.uc_save)
destroy(this.uc_excel)
destroy(this.uc_excelroad)
destroy(this.uc_printpreview)
destroy(this.uc_print)
destroy(this.uc_confirmpreview)
destroy(this.uc_confirm)
destroy(this.uc_help)
end on

type ln_templeft from w_ancsheet`ln_templeft within w_ancestor
end type

type ln_tempright from w_ancsheet`ln_tempright within w_ancestor
end type

type ln_temptop from w_ancsheet`ln_temptop within w_ancestor
end type

type ln_tempbuttom from w_ancsheet`ln_tempbuttom within w_ancestor
end type

type uc_retrieve from u_picture within w_ancestor
integer x = 754
integer y = 44
integer width = 306
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_retrieve.gif"
end type

type uc_insert from u_picture within w_ancestor
integer x = 1074
integer y = 44
integer width = 306
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_input.gif"
end type

type uc_delete from u_picture within w_ancestor
integer x = 1394
integer y = 44
integer width = 306
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_delete.gif"
end type

type uc_save from u_picture within w_ancestor
integer x = 1714
integer y = 44
integer width = 306
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_save.gif"
end type

type uc_excel from u_picture within w_ancestor
integer x = 2034
integer y = 44
integer width = 306
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_excel.gif"
end type

type uc_excelroad from u_picture within w_ancestor
integer x = 2354
integer y = 44
integer width = 402
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_excelroad.gif"
end type

type uc_printpreview from u_picture within w_ancestor
integer x = 2770
integer y = 44
integer width = 402
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_preview.gif"
end type

type uc_print from u_picture within w_ancestor
integer x = 3186
integer y = 44
integer width = 306
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_print.gif"
end type

type uc_confirmpreview from u_picture within w_ancestor
integer x = 3506
integer y = 44
integer width = 402
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_setview.gif"
end type

type uc_confirm from u_picture within w_ancestor
integer x = 3922
integer y = 44
integer width = 402
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_set.gif"
end type

type uc_help from u_picture within w_ancestor
integer x = 4338
integer y = 44
integer width = 105
integer height = 96
boolean bringtotop = true
string picturename = "..\img\topBtn_help.gif"
end type

