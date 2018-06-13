$PBExportHeader$w_system_error.srw
$PBExportComments$Popup 윈도우 ( response )
forward
global type w_system_error from w_response_ancestor_r
end type
type p_close from u_picture within w_system_error
end type
type p_print from u_picture within w_system_error
end type
type dw_main from uo_dw within w_system_error
end type
type p_1 from picture within w_system_error
end type
type st_1 from statictext within w_system_error
end type
end forward

global type w_system_error from w_response_ancestor_r
integer width = 2725
integer height = 1776
string title = "시스템 에러"
event uc_copy ( )
p_close p_close
p_print p_print
dw_main dw_main
p_1 p_1
st_1 st_1
end type
global w_system_error w_system_error

on w_system_error.create
int iCurrent
call super::create
this.p_close=create p_close
this.p_print=create p_print
this.dw_main=create dw_main
this.p_1=create p_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_close
this.Control[iCurrent+2]=this.p_print
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.st_1
end on

on w_system_error.destroy
call super::destroy
destroy(this.p_close)
destroy(this.p_print)
destroy(this.dw_main)
destroy(this.p_1)
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;//str_err		lstr_err

Vector	vc
vc = Create Vector

//gf_center_window(This)

func.of_design_dw(dw_main)

dw_main.InsertRow(0)

vc = Message.PowerObjectParm

dw_main.object.err_win[1]	= vc.getProperty("err_win")
dw_main.object.err_plce[1]	= vc.getProperty("err_plce")
dw_main.object.err_line[1]	= vc.getProperty("err_line")
dw_main.object.err_no[1]	= vc.getProperty("err_no")
dw_main.object.err_detl[1]	= vc.getProperty("err_detl")
dw_main.object.err_proc[1]	=	'전산장애가 발생되었습니다. ~r~n장애번호와 장애내역을 확인 하신 후~r~n시스템담당자에게 연락하십시요.'

Destroy vc

end event

event close;call super::close;If IsValid(w_wait) Then
	gf_closewait()
End If
Close(This)

end event

type uc_retrieve from w_response_ancestor_r`uc_retrieve within w_system_error
boolean visible = false
end type

type uc_ok from w_response_ancestor_r`uc_ok within w_system_error
boolean visible = false
end type

type uc_cancel from w_response_ancestor_r`uc_cancel within w_system_error
boolean visible = false
end type

type ln_temptop from w_response_ancestor_r`ln_temptop within w_system_error
end type

type ln_1 from w_response_ancestor_r`ln_1 within w_system_error
end type

type ln_2 from w_response_ancestor_r`ln_2 within w_system_error
end type

type ln_3 from w_response_ancestor_r`ln_3 within w_system_error
integer beginx = 2149
integer endx = 2149
end type

type p_close from u_picture within w_system_error
integer x = 2382
integer y = 1564
integer width = 306
integer height = 96
boolean bringtotop = true
string picturename = "..\img\topBtn_close.gif"
end type

event clicked;Close(Parent)

end event

type p_print from u_picture within w_system_error
boolean visible = false
integer x = 2057
integer y = 1564
integer width = 306
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_print.gif"
end type

event clicked;//Long		ll_i
//Long		ll_copy
//Long		ll_job_nbr
//
//Vector	vc
//vc = Create Vector
//
//Open(w_hardcopy_set)
//
//vc	= Message.PowerObjectParm
//
//ll_copy	= Long(vc.GetProperty("parm_str"))
//
//If ll_copy > 0 Then
//	
//	For ll_i = 1 To ll_copy
//		ll_job_nbr = PrintOpen()
//		Parent.Print(ll_job_nbr,1,1, 6000, 4000)
//		PrintClose(ll_job_nbr)
//	Next
//	
//End If
//
end event

type dw_main from uo_dw within w_system_error
integer x = 46
integer y = 132
integer width = 2638
integer height = 1380
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_system_error"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type p_1 from picture within w_system_error
integer x = 59
integer y = 80
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\front_title_img.gif"
boolean focusrectangle = false
end type

type st_1 from statictext within w_system_error
integer x = 119
integer y = 76
integer width = 457
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 20286463
long backcolor = 16777215
string text = "상세 장애내역"
boolean focusrectangle = false
end type

event clicked;//Parent.uc_retrieve.PictureName = "C:\SIM\IMG\topBtn_retrieve.gif"
//Parent.uc_retrieve.enabled = True
//
//
//func.of_pb_enable('retrieve', uc_retrieve, True)
//func.of_pb_enable('input', p_insert, True)
//
end event

