$PBExportHeader$w_common_rgt.srw
$PBExportComments$학사용 조회(등록) 상속윈도우(프리폼용)
forward
global type w_common_rgt from w_msheet
end type
type dw_con from uo_dwfree within w_common_rgt
end type
type dw_main from uo_dw within w_common_rgt
end type
end forward

global type w_common_rgt from w_msheet
integer height = 2448
dw_con dw_con
dw_main dw_main
end type
global w_common_rgt w_common_rgt

event open;call super::open;dw_con.InsertRow(0)
end event

on w_common_rgt.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_common_rgt.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

type ln_templeft from w_msheet`ln_templeft within w_common_rgt
integer endy = 2328
end type

type ln_tempright from w_msheet`ln_tempright within w_common_rgt
integer endy = 2328
end type

type ln_temptop from w_msheet`ln_temptop within w_common_rgt
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_common_rgt
integer beginy = 2292
integer endy = 2292
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_common_rgt
end type

type ln_tempstart from w_msheet`ln_tempstart within w_common_rgt
end type

type uc_retrieve from w_msheet`uc_retrieve within w_common_rgt
end type

type uc_insert from w_msheet`uc_insert within w_common_rgt
end type

type uc_delete from w_msheet`uc_delete within w_common_rgt
end type

type uc_save from w_msheet`uc_save within w_common_rgt
end type

type uc_excel from w_msheet`uc_excel within w_common_rgt
end type

type uc_print from w_msheet`uc_print within w_common_rgt
end type

type st_line1 from w_msheet`st_line1 within w_common_rgt
end type

type st_line2 from w_msheet`st_line2 within w_common_rgt
end type

type st_line3 from w_msheet`st_line3 within w_common_rgt
end type

type uc_excelroad from w_msheet`uc_excelroad within w_common_rgt
end type

type dw_con from uo_dwfree within w_common_rgt
integer x = 50
integer y = 164
integer width = 4384
integer height = 188
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

type dw_main from uo_dw within w_common_rgt
integer x = 50
integer y = 356
integer width = 4384
integer height = 1920
integer taborder = 30
boolean bringtotop = true
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

