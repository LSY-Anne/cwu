$PBExportHeader$w_print_reason1.srw
$PBExportComments$인쇄사유 등록용 Window
forward
global type w_print_reason1 from w_response_ancestor
end type
type sle_1 from singlelineedit within w_print_reason1
end type
type st_1 from statictext within w_print_reason1
end type
type mle_1 from multilineedit within w_print_reason1
end type
type gb_3 from groupbox within w_print_reason1
end type
end forward

global type w_print_reason1 from w_response_ancestor
integer width = 2624
integer height = 860
string title = "출력사유등록(테스트)"
sle_1 sle_1
st_1 st_1
mle_1 mle_1
gb_3 gb_3
end type
global w_print_reason1 w_print_reason1

type variables
String is_className
vector ivc
end variables

on w_print_reason1.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.mle_1=create mle_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.mle_1
this.Control[iCurrent+4]=this.gb_3
end on

on w_print_reason1.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.mle_1)
destroy(this.gb_3)
end on

event open;call super::open;/**************************************************************************
  Name          : w_print_reason
  설명            : 인쇄시 사유 입력. 해당 화면에서 사유를 입력해야만 인쇄를 할 수 있다.
  매개변수      : 
  RETURN       : 1 성공, 0 취소, -1 오류
**************************************************************************/
Int          li_row
Vector	vc

ivc	=Create Vector
ivc.Removeall()
ivc.setProperty("parm_cnt", "0")

vc = Create Vector

vc = Message.powerobjectparm

sle_1.Text = gs_empcode

If IsValid(vc) Then
	If Long(vc.GetProperty("parm_cnt")) > 0 Then
		is_className	= vc.GetProperty("pgmid")
	End If
End If

Destroy vc





end event

type uc_cancel from w_response_ancestor`uc_cancel within w_print_reason1
integer x = 2309
end type

event uc_cancel::clicked;call super::clicked;ivc.Removeall()

ivc.setproperty("parm_cnt" , '0')

CloseWithReturn(Parent, ivc)


end event

type uc_ok from w_response_ancestor`uc_ok within w_print_reason1
integer x = 2030
end type

event uc_ok::clicked;call super::clicked;String ls_classname
String ls_remark
Long   ll_rtn

ls_remark = mle_1.Text
If Trim(ls_remark) = "" Then
	MessageBox("확인", "인쇄 사유를 입력하십시오.")
	mle_1.SetFocus()
	Return
End If

If Len(ls_remark) < 5 Then
	MessageBox("확인","인쇄 사유는 최소한 5자이상 입력하셔야 합니다.")
	mle_1.SetFocus()
	Return
End If

ls_classname = Message.StringParm

INSERT INTO CDDB.PF_PRT_REASON
			(PGM_ID,        JOB_UID,      	JOB_DATE,   PRT_REMARK)
VALUES(:is_classname, :gs_empcode, SysDate, 		:ls_remark);

If Sqlca.SqlCode = -1 Then
	RollBack Using Sqlca;
	MessageBox("오류", "인쇄 사유 저장 중 오류가 발생하였습니다.~r~n~r~n해당 자료를 인쇄할 수 없습니다.~r~n" + Sqlca.SqlerrText)
	ll_rtn = -1
Else
	Commit Using Sqlca;
	ll_rtn = 1
End If

//CloseWithReturn(Parent, ll_rtn)

ivc.Removeall()

ivc.setproperty("parm_cnt" , '1')

CloseWithReturn(Parent, ivc)
end event

type uc_save from w_response_ancestor`uc_save within w_print_reason1
integer x = 1751
end type

type uc_delete from w_response_ancestor`uc_delete within w_print_reason1
integer x = 1472
end type

type uc_insert from w_response_ancestor`uc_insert within w_print_reason1
integer x = 1193
end type

type uc_retrieve from w_response_ancestor`uc_retrieve within w_print_reason1
integer x = 914
end type

type ln_temptop from w_response_ancestor`ln_temptop within w_print_reason1
end type

type ln_tempbuttom from w_response_ancestor`ln_tempbuttom within w_print_reason1
integer beginy = 740
integer endy = 740
end type

type ln_temleft from w_response_ancestor`ln_temleft within w_print_reason1
end type

type ln_tempright from w_response_ancestor`ln_tempright within w_print_reason1
integer beginx = 2574
integer endx = 2574
end type

type r_backline1 from w_response_ancestor`r_backline1 within w_print_reason1
end type

type r_backline2 from w_response_ancestor`r_backline2 within w_print_reason1
end type

type r_backline3 from w_response_ancestor`r_backline3 within w_print_reason1
end type

type sle_1 from singlelineedit within w_print_reason1
integer x = 256
integer y = 208
integer width = 562
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_print_reason1
integer x = 101
integer y = 220
integer width = 146
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "사번"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_print_reason1
integer x = 119
integer y = 384
integer width = 2391
integer height = 296
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type gb_3 from groupbox within w_print_reason1
integer x = 87
integer y = 320
integer width = 2455
integer height = 388
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "출력 사유"
end type

