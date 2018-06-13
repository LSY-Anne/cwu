$PBExportHeader$w_hsg201a.srw
$PBExportComments$[청운대]동아리코드관리
forward
global type w_hsg201a from w_no_condition_window
end type
type tab_1 from tab within w_hsg201a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from uo_dwgrid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from uo_dwgrid within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tab_1 from tab within w_hsg201a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from u_tab within w_hsg201a
end type
end forward

global type w_hsg201a from w_no_condition_window
tab_1 tab_1
uo_1 uo_1
end type
global w_hsg201a w_hsg201a

type variables
integer ii_index
datawindow gdw_dwc
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
		li_mod = tab_1.tabpage_1.dw_1.ModifiedCount()
		li_del = tab_1.tabpage_1.dw_1.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			li_ans = tab_1.tabpage_1.dw_1.update()
		END IF
	
		
	CASE 2
		li_mod = tab_1.tabpage_2.dw_2.ModifiedCount()
		li_del = tab_1.tabpage_2.dw_2.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			li_ans = tab_1.tabpage_2.dw_2.update()
		END IF
		
END CHOOSE

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback;
elseif li_ans = 1 then
	commit;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if
end subroutine

on w_hsg201a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_hsg201a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
end on

event ue_delete;call super::ue_delete;int li_ans

//삭제확인
if uf_messagebox(4) = 2 then return

CHOOSE CASE ii_index
	CASE 1
		tab_1.tabpage_1.dw_1.deleterow(0)
		li_ans = tab_1.tabpage_1.dw_1.update()
		
	CASE 2
		tab_1.tabpage_2.dw_2.deleterow(0)
		li_ans = tab_1.tabpage_2.dw_2.update()

END CHOOSE

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback;
else	
	commit;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if

end event

event ue_insert;call super::ue_insert;long ll_line
int li_ans

CHOOSE CASE ii_index
	CASE 1
		ll_line = tab_1.tabpage_1.dw_1.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_1.dw_1.scrolltorow(ll_line)
			tab_1.tabpage_1.dw_1.setcolumn(1)
			tab_1.tabpage_1.dw_1.setfocus()
		end if
		
	CASE 2
		ll_line = tab_1.tabpage_2.dw_2.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_2.dw_2.scrolltorow(ll_line)
			tab_1.tabpage_2.dw_2.setcolumn(1)
			tab_1.tabpage_2.dw_2.setfocus()
		end if

	
END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;long ll_ans

CHOOSE case ii_index
		case	1   // 
			ll_ans = tab_1.tabpage_1.dw_1.retrieve()
		
		case	2   //
			ll_ans = tab_1.tabpage_2.dw_2.retrieve()   
					
END CHOOSE

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

return 1
end event

event open;call super::open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	TRUE)
//wf_setmenu('DELETE', 	TRUE)
//wf_setmenu('SAVE', 		TRUE)
//wf_setmenu('PRINT', 		TRUE)
end event

event close;call super::close;//if uf_messagebox(9) = 1 then
//	
//	wf_modify_chk(ii_index)
//	
//	close(this)
//	return 1
//else
//	return 1
//end if
end event

event ue_save;call super::ue_save;int li_ans
string ls_flag

CHOOSE CASE ii_index
		
	CASE 1
		li_ans = tab_1.tabpage_1.dw_1.update()
		
	CASE 2
		li_ans = tab_1.tabpage_2.dw_2.update()
		
END CHOOSE

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback;
	return -1
else	
	commit;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if
return 1
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_hsg201a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hsg201a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hsg201a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hsg201a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hsg201a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hsg201a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hsg201a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hsg201a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hsg201a
end type

type uc_save from w_no_condition_window`uc_save within w_hsg201a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hsg201a
end type

type uc_print from w_no_condition_window`uc_print within w_hsg201a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hsg201a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_no_condition_window`st_line2 within w_hsg201a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_no_condition_window`st_line3 within w_hsg201a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hsg201a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hsg201a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hsg201a
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type tab_1 from tab within w_hsg201a
integer x = 50
integer y = 208
integer width = 4384
integer height = 2052
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;ii_index = newindex

long ll_ans

CHOOSE case ii_index
		case	1   // 
			ll_ans = tab_1.tabpage_1.dw_1.retrieve()
			gdw_dwc = tab_1.tabpage_1.dw_1
		
		case	2   //
			ll_ans = tab_1.tabpage_2.dw_2.retrieve()   
			gdw_dwc = tab_1.tabpage_2.dw_2
								
END CHOOSE
end event

event selectionchanging;//DW의 내용이 바뀐게 있는지 check
wf_modify_chk(oldindex)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1932
string text = "동아리구분코드"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from uo_dwgrid within tabpage_1
integer width = 4343
integer height = 1932
integer taborder = 20
string dataobject = "d_hsg201a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1932
string text = "동아리코드"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from uo_dwgrid within tabpage_2
integer width = 4343
integer height = 1932
integer taborder = 30
string dataobject = "d_hsg201a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type uo_1 from u_tab within w_hsg201a
integer x = 2053
integer y = 372
integer height = 148
integer taborder = 30
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

