$PBExportHeader$w_common_ms.srw
$PBExportComments$multi & single input
forward
global type w_common_ms from w_commonsheet
end type
type dw_master from uo_dwlv within w_common_ms
end type
type dw_child01 from uo_dwfree within w_common_ms
end type
type st_parent from statictext within w_common_ms
end type
type st_child01 from statictext within w_common_ms
end type
end forward

global type w_common_ms from w_commonsheet
dw_master dw_master
dw_child01 dw_child01
st_parent st_parent
st_child01 st_child01
end type
global w_common_ms w_common_ms

type variables

end variables

forward prototypes
public subroutine wf_retrieve_check (u_dw adw)
end prototypes

public subroutine wf_retrieve_check (u_dw adw);long		ll_mcnt,ll_dcnt,ll_ret

adw.acceptText()

ll_mcnt = adw.ModifiedCount()
ll_dcnt = adw.DeletedCount() 

if ll_mcnt > 0 or ll_dcnt > 0 then
	ll_ret = messagebox('♣ 알림 ♣','변경사항을 저장하시겠습니까?',Question!,OKCancel! ,2)

	if ll_ret = 1 then
		if event ue_save() = -1 then return
	end if
end if

end subroutine

on w_common_ms.create
int iCurrent
call super::create
this.dw_master=create dw_master
this.dw_child01=create dw_child01
this.st_parent=create st_parent
this.st_child01=create st_child01
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_master
this.Control[iCurrent+2]=this.dw_child01
this.Control[iCurrent+3]=this.st_parent
this.Control[iCurrent+4]=this.st_child01
end on

on w_common_ms.destroy
call super::destroy
destroy(this.dw_master)
destroy(this.dw_child01)
destroy(this.st_parent)
destroy(this.st_child01)
end on

event ue_insert;call super::ue_insert;long		ll_mcnt,ll_dcnt,ll_ret

ll_mcnt = dw_child01.ModifiedCount()
ll_dcnt = dw_child01.DeletedCount() 

if ll_mcnt > 0 or ll_dcnt > 0 then
	ll_ret = messagebox('♣ 알림 ♣','변경사항을 저장하시겠습니까?',Question!,OKCancel! ,2)

	if ll_ret = 1 then
		if event ue_save() = -1 then return
	end if
end if

dw_child01.reset()

event ue_setitem(dw_child01,dw_child01.insertrow(0))
end event

event ue_save;call super::ue_save;Integer	li_rtn

li_rtn = AncestorReturnValue
IF li_rtn = 1 THEN
	event ue_retrieve()
END IF

return li_rtn
end event

event ue_delete;call super::ue_delete;long		ll_mcnt,ll_ret

if dw_child01.rowcount() = 0 then return 

ll_ret = messagebox('♣ 알림 ♣','해당자료를 삭제하시겠습니까?',Question!,OKCancel! ,2)

if event ue_checkdelete(dw_child01,1) then
	dw_child01.deleterow(1)
	if ll_ret = 1 then
		if event ue_save() = -1 then return
	end if
end if

end event

type ln_templeft from w_commonsheet`ln_templeft within w_common_ms
end type

type ln_tempright from w_commonsheet`ln_tempright within w_common_ms
end type

type ln_temptop from w_commonsheet`ln_temptop within w_common_ms
end type

type ln_tempbuttom from w_commonsheet`ln_tempbuttom within w_common_ms
end type

type ln_tempbutton from w_commonsheet`ln_tempbutton within w_common_ms
end type

type ln_tempstart from w_commonsheet`ln_tempstart within w_common_ms
end type

type p_retrieve from w_commonsheet`p_retrieve within w_common_ms
end type

type p_insert from w_commonsheet`p_insert within w_common_ms
end type

type p_delete from w_commonsheet`p_delete within w_common_ms
end type

type p_save from w_commonsheet`p_save within w_common_ms
end type

type p_excel from w_commonsheet`p_excel within w_common_ms
end type

type p_excelload from w_commonsheet`p_excelload within w_common_ms
end type

type p_preview from w_commonsheet`p_preview within w_common_ms
end type

type p_print from w_commonsheet`p_print within w_common_ms
end type

type dw_master from uo_dwlv within w_common_ms
string tag = "settrans=true"
integer x = 46
integer y = 164
integer width = 1175
integer height = 352
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow = 0 then return

//dw_child01 datawindow check
if dw_child01.rowcount() > 0 then	wf_retrieve_check(dw_child01)

wf_retrieve(dw_master,currentrow,dw_child01)

end event

type dw_child01 from uo_dwfree within w_common_ms
string tag = "settrans=true&trans=true&index=1"
integer x = 46
integer y = 648
integer width = 1175
integer height = 352
integer taborder = 20
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_parent from statictext within w_common_ms
integer x = 46
integer y = 160
integer width = 1175
integer height = 360
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
long bordercolor = 29992855
boolean focusrectangle = false
end type

type st_child01 from statictext within w_common_ms
integer x = 46
integer y = 644
integer width = 1175
integer height = 360
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
long bordercolor = 29992855
boolean focusrectangle = false
end type

