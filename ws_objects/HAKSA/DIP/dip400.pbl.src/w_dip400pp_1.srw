$PBExportHeader$w_dip400pp_1.srw
$PBExportComments$[대학원입시] 장학생관리
forward
global type w_dip400pp_1 from w_popup
end type
type dw_1 from uo_dwfree within w_dip400pp_1
end type
end forward

global type w_dip400pp_1 from w_popup
integer width = 2254
integer height = 1348
string title = "공지사항 입력"
dw_1 dw_1
end type
global w_dip400pp_1 w_dip400pp_1

on w_dip400pp_1.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_dip400pp_1.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;string	ls_parm, ls_year, ls_hakgi
int	li_row

dw_1.SetTransObject(sqlca)

ls_parm = Message.StringParm

ls_year	=	mid(ls_parm, 1, 4)
ls_hakgi	=	mid(ls_parm, 5, 1)

li_row = dw_1.retrieve(ls_year, ls_hakgi)

if li_row <= 0 then
	dw_1.insertrow(0)
end if
end event

event ue_save;int	li_ans

dw_1.AcceptText()

//저장
li_ans = dw_1.update()
					
if li_ans = -1 then
	//저장 오류 메세지 출력
	messagebox("오류","저장중 오류가 발생되었습니다.")
	rollback using sqlca ;
else	
	commit using sqlca ;
	//저장확인 메세지 출력
	messagebox("확인","자료가 저장되었습니다.")
end if

Return 1
end event

event ue_ok;call super::ue_ok;Close(This)
end event

type p_msg from w_popup`p_msg within w_dip400pp_1
integer y = 1140
end type

type st_msg from w_popup`st_msg within w_dip400pp_1
integer y = 1140
integer width = 2039
end type

type uc_printpreview from w_popup`uc_printpreview within w_dip400pp_1
end type

type uc_cancel from w_popup`uc_cancel within w_dip400pp_1
end type

type uc_ok from w_popup`uc_ok within w_dip400pp_1
end type

type uc_excelroad from w_popup`uc_excelroad within w_dip400pp_1
end type

type uc_excel from w_popup`uc_excel within w_dip400pp_1
end type

type uc_save from w_popup`uc_save within w_dip400pp_1
end type

type uc_delete from w_popup`uc_delete within w_dip400pp_1
end type

type uc_insert from w_popup`uc_insert within w_dip400pp_1
end type

type uc_retrieve from w_popup`uc_retrieve within w_dip400pp_1
end type

type ln_temptop from w_popup`ln_temptop within w_dip400pp_1
integer endx = 2231
end type

type ln_1 from w_popup`ln_1 within w_dip400pp_1
integer beginy = 1200
integer endx = 2231
integer endy = 1200
end type

type ln_2 from w_popup`ln_2 within w_dip400pp_1
integer endy = 1244
end type

type ln_3 from w_popup`ln_3 within w_dip400pp_1
integer beginx = 2190
integer endx = 2190
integer endy = 1244
end type

type r_backline1 from w_popup`r_backline1 within w_dip400pp_1
end type

type r_backline2 from w_popup`r_backline2 within w_dip400pp_1
end type

type r_backline3 from w_popup`r_backline3 within w_dip400pp_1
end type

type uc_print from w_popup`uc_print within w_dip400pp_1
end type

type dw_1 from uo_dwfree within w_dip400pp_1
integer x = 64
integer y = 180
integer width = 2048
integer height = 896
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dip400pp_1"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
func.of_design_dw(dw_1)
end event

