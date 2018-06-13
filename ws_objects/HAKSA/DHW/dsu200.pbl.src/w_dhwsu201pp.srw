$PBExportHeader$w_dhwsu201pp.srw
$PBExportComments$[대학원수업] 개설과목관리(공통필수)
forward
global type w_dhwsu201pp from w_popup
end type
type dw_1 from uo_input_dwc within w_dhwsu201pp
end type
end forward

global type w_dhwsu201pp from w_popup
integer width = 2885
integer height = 1648
string title = "개설과목관리"
dw_1 dw_1
end type
global w_dhwsu201pp w_dhwsu201pp

on w_dhwsu201pp.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_dhwsu201pp.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;dw_1.retrieve()
end event

event ue_insert;call super::ue_insert;long ll_line


ll_line = dw_1.insertrow(0)
dw_1.scrolltorow(ll_line)

dw_1.object.gwajung_id[ll_line]		=	'1'
dw_1.object.isu_id[ll_line]			=	'1'
dw_1.object.hakjum[ll_line]			=	3
dw_1.object.sisu[ll_line]				=	3
dw_1.object.gaesul_gubun[ll_line]	=	'1'

dw_1.SetColumn('gwa_id')
dw_1.setfocus()



end event

event ue_delete;call super::ue_delete;int li_ans

//삭제확인
if messagebox("확인","자료를 삭제하시겠습니까?", Question!, YesNo!, 2) = 2 then return

dw_1.deleterow(0)
li_ans = dw_1.update()								

if li_ans = -1 then
	//저장 오류 메세지 출력
	rollback;
else	
	commit;
end if
end event

event ue_ok;call super::ue_ok;int li_mod, li_del, li_ans

li_mod = dw_1.ModifiedCount()
li_del = dw_1.deletedCount()

if li_mod + li_del > 0 then
	li_ans = messagebox("확인","변경된 자료가 존재합니다.~r~n저장하시겠습니까?", Question!, YesNo!, 2)
	
	if li_ans = 2 then
		close(This)
	else
		This.Event ue_save()
		close(This)
	end if
	
else
	close(This)
	
end if
end event

type p_msg from w_popup`p_msg within w_dhwsu201pp
end type

type st_msg from w_popup`st_msg within w_dhwsu201pp
integer width = 2688
end type

type uc_printpreview from w_popup`uc_printpreview within w_dhwsu201pp
end type

type uc_cancel from w_popup`uc_cancel within w_dhwsu201pp
end type

type uc_ok from w_popup`uc_ok within w_dhwsu201pp
end type

type uc_excelroad from w_popup`uc_excelroad within w_dhwsu201pp
end type

type uc_excel from w_popup`uc_excel within w_dhwsu201pp
end type

type uc_save from w_popup`uc_save within w_dhwsu201pp
end type

type uc_delete from w_popup`uc_delete within w_dhwsu201pp
end type

type uc_insert from w_popup`uc_insert within w_dhwsu201pp
end type

type uc_retrieve from w_popup`uc_retrieve within w_dhwsu201pp
end type

type ln_temptop from w_popup`ln_temptop within w_dhwsu201pp
integer endx = 2880
end type

type ln_1 from w_popup`ln_1 within w_dhwsu201pp
integer endx = 2880
end type

type ln_2 from w_popup`ln_2 within w_dhwsu201pp
end type

type ln_3 from w_popup`ln_3 within w_dhwsu201pp
integer beginx = 2834
integer endx = 2834
end type

type r_backline1 from w_popup`r_backline1 within w_dhwsu201pp
end type

type r_backline2 from w_popup`r_backline2 within w_dhwsu201pp
end type

type r_backline3 from w_popup`r_backline3 within w_dhwsu201pp
end type

type uc_print from w_popup`uc_print within w_dhwsu201pp
end type

type dw_1 from uo_input_dwc within w_dhwsu201pp
integer x = 55
integer y = 176
integer width = 2761
integer height = 1260
integer taborder = 20
string dataobject = "d_dhwsu201pp"
end type

