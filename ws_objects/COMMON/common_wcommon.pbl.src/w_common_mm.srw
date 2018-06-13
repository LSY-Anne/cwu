$PBExportHeader$w_common_mm.srw
$PBExportComments$multi & multi input
forward
global type w_common_mm from w_commonsheet
end type
type st_parent from statictext within w_common_mm
end type
type dw_parent from uo_dwlvin within w_common_mm
end type
type st_child01 from statictext within w_common_mm
end type
type dw_child01 from uo_dwlvin within w_common_mm
end type
end forward

global type w_common_mm from w_commonsheet
st_parent st_parent
dw_parent dw_parent
st_child01 st_child01
dw_child01 dw_child01
end type
global w_common_mm w_common_mm

type variables
//is_parm 사용법
//ex)1;2;3;4
//구분자 -> ; 
string	is_parm
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

on w_common_mm.create
int iCurrent
call super::create
this.st_parent=create st_parent
this.dw_parent=create dw_parent
this.st_child01=create st_child01
this.dw_child01=create dw_child01
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_parent
this.Control[iCurrent+2]=this.dw_parent
this.Control[iCurrent+3]=this.st_child01
this.Control[iCurrent+4]=this.dw_child01
end on

on w_common_mm.destroy
call super::destroy
destroy(this.st_parent)
destroy(this.dw_parent)
destroy(this.st_child01)
destroy(this.dw_child01)
end on

event ue_delete;call super::ue_delete;long ll_row

ll_row = idw_current.getrow()

IF ll_row < 1 THEN RETURN

IF Not EVENT ue_checkdelete(idw_current,ll_row) THEN return

idw_current.DeleteRow(ll_row)

IF wf_save(true) < 0 THEN
	rollback using sqlca;
	Messagebox("Error",  "저장에 실패 하였습니다.")
ELSE
	commit using sqlca;
	Messagebox('Information','저장에 성공 하였습니다.')
END IF

event ue_retrieve()

end event

event ue_insert;call super::ue_insert;long	ll_insertrow

ll_insertrow = idw_current.insertrow(0)

if idw_current.event ue_insert_check(ll_insertrow) = -1 then 
	idw_current.deleterow(ll_insertrow)
	return
end if

event ue_setitem(idw_current,ll_insertrow)
end event

event ue_setitem;call super::ue_setitem;//parent, child중 어떤 데이타 윈도우인지 체크해서 기본값을 셋팅함.
//idw_current = dw_parent or idw_current = dw_child01
end event

type ln_templeft from w_commonsheet`ln_templeft within w_common_mm
end type

type ln_tempright from w_commonsheet`ln_tempright within w_common_mm
end type

type ln_temptop from w_commonsheet`ln_temptop within w_common_mm
end type

type ln_tempbuttom from w_commonsheet`ln_tempbuttom within w_common_mm
end type

type ln_tempbutton from w_commonsheet`ln_tempbutton within w_common_mm
end type

type ln_tempstart from w_commonsheet`ln_tempstart within w_common_mm
end type

type p_retrieve from w_commonsheet`p_retrieve within w_common_mm
end type

type p_insert from w_commonsheet`p_insert within w_common_mm
end type

type p_delete from w_commonsheet`p_delete within w_common_mm
end type

type p_save from w_commonsheet`p_save within w_common_mm
end type

type p_excel from w_commonsheet`p_excel within w_common_mm
end type

type p_excelload from w_commonsheet`p_excelload within w_common_mm
end type

type p_preview from w_commonsheet`p_preview within w_common_mm
end type

type p_print from w_commonsheet`p_print within w_common_mm
end type

type st_parent from statictext within w_common_mm
integer x = 46
integer y = 160
integer width = 1175
integer height = 360
boolean bringtotop = true
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

type dw_parent from uo_dwlvin within w_common_mm
string tag = "settrans=true&trans=true&index=1"
integer x = 46
integer y = 164
integer width = 1175
integer height = 352
integer taborder = 10
boolean bringtotop = true
string title = ""
boolean border = false
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;wf_currentdw(this)
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow = 0 then return

//dw_child01 datawindow check
if dw_child01.rowcount() > 0 then	wf_retrieve_check(dw_child01)

wf_retrieve(dw_parent,currentrow,dw_child01)

end event

type st_child01 from statictext within w_common_mm
integer x = 46
integer y = 644
integer width = 1175
integer height = 360
boolean bringtotop = true
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

type dw_child01 from uo_dwlvin within w_common_mm
string tag = "settrans=true&trans=true&index=2"
integer x = 46
integer y = 648
integer width = 1175
integer height = 352
integer taborder = 10
boolean bringtotop = true
string title = ""
boolean border = false
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;wf_currentdw(this)
end event

