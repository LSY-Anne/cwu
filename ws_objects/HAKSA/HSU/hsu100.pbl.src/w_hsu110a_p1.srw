$PBExportHeader$w_hsu110a_p1.srw
$PBExportComments$[청운대]강의계획서 -  주별세부사항
forward
global type w_hsu110a_p1 from w_popup
end type
type dw_1 from uo_dwfree within w_hsu110a_p1
end type
end forward

global type w_hsu110a_p1 from w_popup
integer width = 3438
integer height = 1884
string title = "강의계획서 -  주별세부사항"
dw_1 dw_1
end type
global w_hsu110a_p1 w_hsu110a_p1

type variables
string 	is_year, is_hakgi, is_gwa, is_hakyun, is_ban, is_gwamok, is_bunban
integer	ii_gwamok_seq
end variables

on w_hsu110a_p1.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_hsu110a_p1.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_saveend;call super::ue_saveend;Int li_return

li_return	=	uf_gangplan_save(is_year, is_hakgi, is_gwa, is_hakyun, is_ban, is_gwamok, ii_gwamok_seq, is_bunban)
	
if li_return = 1 or li_return = 2 or li_return = 3 or li_return = 4 or li_return = 5 then
	rollback USING SQLCA ;
	return -1
end if

Return 1
end event

event ue_ok;call super::ue_ok;Close(This)
end event

event ue_postopen;call super::ue_postopen;Vector	vc

dw_1.SetTransObject(sqlca )
//func.of_design_dw(dw_1)

vc = Create Vector

idw_update[1] = dw_1

vc = Message.powerobjectparm

If IsValid(vc) Then
	If Long(vc.GetProperty("parm_cnt")) > 0 Then
		is_year	        = vc.GetProperty("string1")
		is_hakgi	        = vc.GetProperty("string2")
		is_gwa            = vc.GetProperty("string3")
		is_hakyun	    = vc.GetProperty("string4")
		is_ban	         = vc.GetProperty("string5")
		is_gwamok	    = vc.GetProperty("string6")
		is_bunban	    = vc.GetProperty("string7")
		ii_gwamok_seq	= Long(vc.GetProperty("string8"))
	End If
End If

dw_1.retrieve(is_year, is_hakgi, is_gwa, is_hakyun, is_ban, is_gwamok, ii_gwamok_seq, is_bunban)
end event

type p_msg from w_popup`p_msg within w_hsu110a_p1
integer y = 1688
end type

type st_msg from w_popup`st_msg within w_hsu110a_p1
integer y = 1688
integer width = 3227
end type

type uc_printpreview from w_popup`uc_printpreview within w_hsu110a_p1
end type

type uc_cancel from w_popup`uc_cancel within w_hsu110a_p1
end type

type uc_ok from w_popup`uc_ok within w_hsu110a_p1
end type

type uc_excelroad from w_popup`uc_excelroad within w_hsu110a_p1
end type

type uc_excel from w_popup`uc_excel within w_hsu110a_p1
end type

type uc_save from w_popup`uc_save within w_hsu110a_p1
end type

type uc_delete from w_popup`uc_delete within w_hsu110a_p1
end type

type uc_insert from w_popup`uc_insert within w_hsu110a_p1
end type

type uc_retrieve from w_popup`uc_retrieve within w_hsu110a_p1
end type

type ln_temptop from w_popup`ln_temptop within w_hsu110a_p1
integer endx = 3419
end type

type ln_1 from w_popup`ln_1 within w_hsu110a_p1
integer beginy = 1748
integer endx = 3419
integer endy = 1748
end type

type ln_2 from w_popup`ln_2 within w_hsu110a_p1
integer endy = 1792
end type

type ln_3 from w_popup`ln_3 within w_hsu110a_p1
integer beginx = 3378
integer endx = 3378
integer endy = 1792
end type

type r_backline1 from w_popup`r_backline1 within w_hsu110a_p1
end type

type r_backline2 from w_popup`r_backline2 within w_hsu110a_p1
end type

type r_backline3 from w_popup`r_backline3 within w_hsu110a_p1
end type

type uc_print from w_popup`uc_print within w_hsu110a_p1
end type

type dw_1 from uo_dwfree within w_hsu110a_p1
integer x = 59
integer y = 180
integer width = 3319
integer height = 1484
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hsu110a_p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

