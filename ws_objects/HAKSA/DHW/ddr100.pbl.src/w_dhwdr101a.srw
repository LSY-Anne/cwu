$PBExportHeader$w_dhwdr101a.srw
$PBExportComments$[대학원장학] 코드관리
forward
global type w_dhwdr101a from w_no_condition_window
end type
type tab_1 from tab within w_dhwdr101a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_tab1 from uo_input_dwc within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_tab1 dw_tab1
end type
type tab_1 from tab within w_dhwdr101a
tabpage_1 tabpage_1
end type
type uo_1 from u_tab within w_dhwdr101a
end type
end forward

global type w_dhwdr101a from w_no_condition_window
tab_1 tab_1
uo_1 uo_1
end type
global w_dhwdr101a w_dhwdr101a

type variables
integer ii_index
end variables

forward prototypes
public subroutine wf_modify_chk (integer ai_index)
end prototypes

public subroutine wf_modify_chk (integer ai_index);/*************************************************************************************************************************************
	 NAME :	wf_modify_chk() return none
	 DESCRIPTION : 변경사항이 있을때 저장하는 함수.

*************************************************************************************************************************************/

int li_mod, li_del, li_msg, li_ans

CHOOSE CASE ai_index
	CASE 1
		li_mod = tab_1.tabpage_1.dw_tab1.ModifiedCount()
		li_del = tab_1.tabpage_1.dw_tab1.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			This.Event ue_save()
		END IF
	
END CHOOSE

end subroutine

on w_dhwdr101a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_dhwdr101a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
end on

event ue_delete;call super::ue_delete;int li_ans

//삭제확인
if uf_messagebox(4) = 2 then return

CHOOSE CASE ii_index
	CASE 1
		tab_1.tabpage_1.dw_tab1.deleterow(0)
		li_ans = tab_1.tabpage_1.dw_tab1.update()
		
END CHOOSE

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback USING SQLCA ;
else	
	commit USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if

end event

event ue_insert;call super::ue_insert;long ll_line
int li_ans

CHOOSE CASE ii_index
	CASE 1
		ll_line = tab_1.tabpage_1.dw_tab1.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_1.dw_tab1.scrolltorow(ll_line)
			tab_1.tabpage_1.dw_tab1.setcolumn(1)
			tab_1.tabpage_1.dw_tab1.setfocus()
		end if
		
END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;long ll_ans
string	ls_gwamok_id, ls_gwamok_name, ls_prof_id, ls_prof_name

CHOOSE case ii_index
		case	1
			
			ll_ans = tab_1.tabpage_1.dw_tab1.retrieve()
		
END CHOOSE

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;idw_update[1] = tab_1.tabpage_1.dw_tab1
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_dhwdr101a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_dhwdr101a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_dhwdr101a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_dhwdr101a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_dhwdr101a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_dhwdr101a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_dhwdr101a
end type

type uc_insert from w_no_condition_window`uc_insert within w_dhwdr101a
end type

type uc_delete from w_no_condition_window`uc_delete within w_dhwdr101a
end type

type uc_save from w_no_condition_window`uc_save within w_dhwdr101a
end type

type uc_excel from w_no_condition_window`uc_excel within w_dhwdr101a
end type

type uc_print from w_no_condition_window`uc_print within w_dhwdr101a
end type

type st_line1 from w_no_condition_window`st_line1 within w_dhwdr101a
end type

type st_line2 from w_no_condition_window`st_line2 within w_dhwdr101a
end type

type st_line3 from w_no_condition_window`st_line3 within w_dhwdr101a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_dhwdr101a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_dhwdr101a
end type

type gb_1 from w_no_condition_window`gb_1 within w_dhwdr101a
end type

type tab_1 from tab within w_dhwdr101a
integer x = 55
integer y = 292
integer width = 4379
integer height = 1972
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

event selectionchanged;ii_index = newindex

long ll_ans

CHOOSE case ii_index
		case	1
			ll_ans = tab_1.tabpage_1.dw_tab1.retrieve()   
		
END CHOOSE
end event

event selectionchanging;//DW의 내용이 바뀐게 있는지 check
wf_modify_chk(oldindex)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1852
long backcolor = 16777215
string text = "장학코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_tab1 dw_tab1
end type

on tabpage_1.create
this.dw_tab1=create dw_tab1
this.Control[]={this.dw_tab1}
end on

on tabpage_1.destroy
destroy(this.dw_tab1)
end on

type dw_tab1 from uo_input_dwc within tabpage_1
integer x = 18
integer y = 16
integer width = 4306
integer height = 1808
integer taborder = 20
string dataobject = "d_dhwdr101_1"
end type

type uo_1 from u_tab within w_dhwdr101a
integer x = 462
integer y = 200
integer taborder = 50
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

