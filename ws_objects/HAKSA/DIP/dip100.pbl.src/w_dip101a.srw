$PBExportHeader$w_dip101a.srw
$PBExportComments$[대학원입시] 코드관리
forward
global type w_dip101a from w_no_condition_window
end type
type tab_1 from tab within w_dip101a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from uo_input_dwc within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from uo_input_dwc within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_3 from uo_input_dwc within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_4 from uo_input_dwc within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_4 dw_4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_5 from uo_input_dwc within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_5 dw_5
end type
type tabpage_6 from userobject within tab_1
end type
type dw_6 from uo_input_dwc within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_6 dw_6
end type
type tabpage_7 from userobject within tab_1
end type
type dw_7 from uo_input_dwc within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_7 dw_7
end type
type tabpage_8 from userobject within tab_1
end type
type dw_8 from uo_input_dwc within tabpage_8
end type
type tabpage_8 from userobject within tab_1
dw_8 dw_8
end type
type tabpage_9 from userobject within tab_1
end type
type dw_9 from uo_input_dwc within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_9 dw_9
end type
type tabpage_10 from userobject within tab_1
end type
type dw_10 from uo_input_dwc within tabpage_10
end type
type tabpage_10 from userobject within tab_1
dw_10 dw_10
end type
type tab_1 from tab within w_dip101a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
end type
type uo_1 from u_tab within w_dip101a
end type
end forward

global type w_dip101a from w_no_condition_window
tab_1 tab_1
uo_1 uo_1
end type
global w_dip101a w_dip101a

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
		tab_1.tabpage_1.dw_1.Accepttext()
		li_mod = tab_1.tabpage_1.dw_1.ModifiedCount()
		li_del = tab_1.tabpage_1.dw_1.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN
			idw_update[1] = tab_1.tabpage_1.dw_1
//			This.PostEvent("ue_save")
             li_ans = tab_1.tabpage_1.dw_1.update()
		END IF
	
		
	CASE 2
		tab_1.tabpage_2.dw_2.Accepttext()
		li_mod = tab_1.tabpage_2.dw_2.ModifiedCount()
		li_del = tab_1.tabpage_2.dw_2.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			idw_update[1] = tab_1.tabpage_2.dw_2
//			This.PostEvent("ue_save")
             li_ans = tab_1.tabpage_2.dw_2.update()
		END IF
		
	CASE 3
		tab_1.tabpage_3.dw_3.Accepttext()
		li_mod = tab_1.tabpage_3.dw_3.ModifiedCount()
		li_del = tab_1.tabpage_3.dw_3.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			idw_update[1] = tab_1.tabpage_3.dw_3
//			This.PostEvent("ue_save")
			li_ans = tab_1.tabpage_3.dw_3.update()
		END IF
		
	CASE 4
		tab_1.tabpage_4.dw_4.Accepttext()
		li_mod = tab_1.tabpage_4.dw_4.ModifiedCount()
		li_del = tab_1.tabpage_4.dw_4.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			idw_update[1] = tab_1.tabpage_4.dw_4
//			This.PostEvent("ue_save")
			li_ans = tab_1.tabpage_4.dw_4.update()
		END IF		
		
	CASE 5
		tab_1.tabpage_5.dw_5.Accepttext()
		li_mod = tab_1.tabpage_5.dw_5.ModifiedCount()
		li_del = tab_1.tabpage_5.dw_5.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			idw_update[1] = tab_1.tabpage_5.dw_5
//			This.PostEvent("ue_save")
			li_ans = tab_1.tabpage_5.dw_5.update()
		END IF		
		
	CASE 6
		tab_1.tabpage_6.dw_6.Accepttext()
		li_mod = tab_1.tabpage_6.dw_6.ModifiedCount()
		li_del = tab_1.tabpage_6.dw_6.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			idw_update[1] = tab_1.tabpage_6.dw_6
//			This.PostEvent("ue_save")
			li_ans = tab_1.tabpage_6.dw_6.update()
		END IF		
		
	CASE 7
		tab_1.tabpage_7.dw_7.Accepttext()
		li_mod = tab_1.tabpage_7.dw_7.ModifiedCount()
		li_del = tab_1.tabpage_7.dw_7.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			idw_update[1] = tab_1.tabpage_7.dw_7
//			This.PostEvent("ue_save")
			li_ans = tab_1.tabpage_7.dw_7.update()
		END IF		
		
	CASE 8
		tab_1.tabpage_8.dw_8.Accepttext()
		li_mod = tab_1.tabpage_8.dw_8.ModifiedCount()
		li_del = tab_1.tabpage_8.dw_8.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			idw_update[1] = tab_1.tabpage_8.dw_8
//			This.PostEvent("ue_save")
			li_ans = tab_1.tabpage_8.dw_8.update()
		END IF

	CASE 9
		tab_1.tabpage_9.dw_9.Accepttext()
		li_mod = tab_1.tabpage_9.dw_9.ModifiedCount()
		li_del = tab_1.tabpage_9.dw_9.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			idw_update[1] = tab_1.tabpage_9.dw_9
//			This.PostEvent("ue_save")
			li_ans = tab_1.tabpage_9.dw_9.update()
		END IF

	CASE 10
		tab_1.tabpage_10.dw_10.Accepttext()
		li_mod = tab_1.tabpage_10.dw_10.ModifiedCount()
		li_del = tab_1.tabpage_10.dw_10.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			idw_update[1] = tab_1.tabpage_10.dw_10
//			This.PostEvent("ue_save")
			li_ans = tab_1.tabpage_10.dw_10.update()
		END IF		

END CHOOSE

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback USING SQLCA ;
elseif li_ans = 1 then
	commit  USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if
end subroutine

on w_dip101a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_dip101a.destroy
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

	CASE 3
		tab_1.tabpage_3.dw_3.deleterow(0)
		li_ans = tab_1.tabpage_3.dw_3.update()
		
	CASE 4
		tab_1.tabpage_4.dw_4.deleterow(0)
		li_ans = tab_1.tabpage_4.dw_4.update()

	CASE 5
		tab_1.tabpage_5.dw_5.deleterow(0)
		li_ans = tab_1.tabpage_5.dw_5.update()
		
	CASE 6
		tab_1.tabpage_6.dw_6.deleterow(0)
		li_ans = tab_1.tabpage_6.dw_6.update()
		
	CASE 7
		tab_1.tabpage_7.dw_7.deleterow(0)
		li_ans = tab_1.tabpage_7.dw_7.update()
		
	CASE 8
		tab_1.tabpage_8.dw_8.deleterow(0)
		li_ans = tab_1.tabpage_8.dw_8.update()

	CASE 9
		tab_1.tabpage_9.dw_9.deleterow(0)
		li_ans = tab_1.tabpage_9.dw_9.update()

	CASE 10
		tab_1.tabpage_10.dw_10.deleterow(0)
		li_ans = tab_1.tabpage_10.dw_10.update()

END CHOOSE

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback USING SQLCA ;
else	
	commit  USING SQLCA ;
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

	CASE 3
		ll_line = tab_1.tabpage_3.dw_3.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_3.dw_3.scrolltorow(ll_line)
			tab_1.tabpage_3.dw_3.setcolumn(1)
			tab_1.tabpage_3.dw_3.setfocus()
		end if
		
	CASE 4
		ll_line = tab_1.tabpage_4.dw_4.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_4.dw_4.scrolltorow(ll_line)
			tab_1.tabpage_4.dw_4.setcolumn(1)
			tab_1.tabpage_4.dw_4.setfocus()
		end if

	CASE 5
		ll_line = tab_1.tabpage_5.dw_5.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_5.dw_5.scrolltorow(ll_line)
			tab_1.tabpage_5.dw_5.setcolumn(1)
			tab_1.tabpage_5.dw_5.setfocus()
		end if
		
	CASE 6
		ll_line = tab_1.tabpage_6.dw_6.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_6.dw_6.scrolltorow(ll_line)
			tab_1.tabpage_6.dw_6.setcolumn(1)
			tab_1.tabpage_6.dw_6.setfocus()
		end if

	CASE 7
		ll_line = tab_1.tabpage_7.dw_7.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_7.dw_7.scrolltorow(ll_line)
			tab_1.tabpage_7.dw_7.setcolumn(1)
			tab_1.tabpage_7.dw_7.setfocus()
		end if
		
	CASE 8
		ll_line = tab_1.tabpage_8.dw_8.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_8.dw_8.scrolltorow(ll_line)
			tab_1.tabpage_8.dw_8.setcolumn(1)
			tab_1.tabpage_8.dw_8.setfocus()
		end if
		
	CASE 9
		ll_line = tab_1.tabpage_9.dw_9.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_9.dw_9.scrolltorow(ll_line)
			tab_1.tabpage_9.dw_9.setcolumn(1)
			tab_1.tabpage_9.dw_9.setfocus()
		end if

	CASE 10
		ll_line = tab_1.tabpage_10.dw_10.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_10.dw_10.scrolltorow(ll_line)
			tab_1.tabpage_10.dw_10.setcolumn(1)
			tab_1.tabpage_10.dw_10.setfocus()
		end if
				
END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;long ll_ans


CHOOSE case ii_index
		case	1   // 
			ll_ans = tab_1.tabpage_1.dw_1.retrieve()   
		
		case	2   //
			ll_ans = tab_1.tabpage_2.dw_2.retrieve()   
		
		case	3   //
			ll_ans = tab_1.tabpage_3.dw_3.retrieve()   
		
		case	4   //
			ll_ans = tab_1.tabpage_4.dw_4.retrieve()   
			
		case	5   //
			ll_ans = tab_1.tabpage_5.dw_5.retrieve()   
		
		case	6   // 
			ll_ans = tab_1.tabpage_6.dw_6.retrieve()   
			
		case	7   //
			ll_ans = tab_1.tabpage_7.dw_7.retrieve()   
			
		case	8   //
			ll_ans = tab_1.tabpage_8.dw_8.retrieve()   
			
		case	9   //
			ll_ans = tab_1.tabpage_9.dw_9.retrieve()   

		case	10   //
			ll_ans = tab_1.tabpage_10.dw_10.retrieve()   					
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

event open;call super::open;idw_update[1] = tab_1.tabpage_1.dw_1
end event

event ue_save;int li_ans
string ls_flag

CHOOSE CASE ii_index
		
	CASE 1
		li_ans = tab_1.tabpage_1.dw_1.update()
		
	CASE 2
		li_ans = tab_1.tabpage_2.dw_2.update()
		
	CASE 3
		li_ans = tab_1.tabpage_3.dw_3.update()
		
	CASE 4
		li_ans = tab_1.tabpage_4.dw_4.update()
		
	CASE 5
		li_ans = tab_1.tabpage_5.dw_5.update()
		
	CASE 6
		li_ans = tab_1.tabpage_6.dw_6.update()
		
	CASE 7
		li_ans = tab_1.tabpage_7.dw_7.update()

	CASE 8
		li_ans = tab_1.tabpage_8.dw_8.update()

	CASE 9
		li_ans = tab_1.tabpage_9.dw_9.update()		

	CASE 10
		li_ans = tab_1.tabpage_10.dw_10.update()	
		
END CHOOSE

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback USING SQLCA ;
else	
	commit  USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if

Return 1
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_dip101a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_dip101a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_dip101a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_dip101a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_dip101a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_dip101a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_dip101a
end type

type uc_insert from w_no_condition_window`uc_insert within w_dip101a
end type

type uc_delete from w_no_condition_window`uc_delete within w_dip101a
end type

type uc_save from w_no_condition_window`uc_save within w_dip101a
end type

type uc_excel from w_no_condition_window`uc_excel within w_dip101a
end type

type uc_print from w_no_condition_window`uc_print within w_dip101a
end type

type st_line1 from w_no_condition_window`st_line1 within w_dip101a
end type

type st_line2 from w_no_condition_window`st_line2 within w_dip101a
end type

type st_line3 from w_no_condition_window`st_line3 within w_dip101a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_dip101a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_dip101a
end type

type gb_1 from w_no_condition_window`gb_1 within w_dip101a
end type

type tab_1 from tab within w_dip101a
integer x = 50
integer y = 272
integer width = 4384
integer height = 1992
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
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
this.tabpage_10=create tabpage_10
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9,&
this.tabpage_10}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
destroy(this.tabpage_10)
end on

event selectionchanged;ii_index = newindex

long ll_ans

CHOOSE case ii_index
		case	1   // 
			ll_ans = tab_1.tabpage_1.dw_1.retrieve()   
			idw_update[1] = tab_1.tabpage_1.dw_1
		
		case	2   //
			ll_ans = tab_1.tabpage_2.dw_2.retrieve()
			idw_update[1] = tab_1.tabpage_2.dw_2
		
		case	3   //
			ll_ans = tab_1.tabpage_3.dw_3.retrieve() 
			idw_update[1] = tab_1.tabpage_3.dw_3
		
		case	4   //
			ll_ans = tab_1.tabpage_4.dw_4.retrieve() 
			idw_update[1] = tab_1.tabpage_4.dw_4
			
		case	5   //
			ll_ans = tab_1.tabpage_5.dw_5.retrieve()
			idw_update[1] = tab_1.tabpage_5.dw_5
		
		case	6   // 
			ll_ans = tab_1.tabpage_6.dw_6.retrieve()
			idw_update[1] = tab_1.tabpage_6.dw_6
			
		case	7   //
			ll_ans = tab_1.tabpage_7.dw_7.retrieve()
			idw_update[1] = tab_1.tabpage_7.dw_7
			
		case	8   //
			ll_ans = tab_1.tabpage_8.dw_8.retrieve()
			idw_update[1] = tab_1.tabpage_8.dw_8

		case	9   //
			ll_ans = tab_1.tabpage_9.dw_9.retrieve() 
			idw_update[1] = tab_1.tabpage_9.dw_9

		case	10   //
			ll_ans = tab_1.tabpage_10.dw_10.retrieve()
			idw_update[1] = tab_1.tabpage_10.dw_10
END CHOOSE
end event

event selectionchanging;//DW의 내용이 바뀐게 있는지 check
wf_modify_chk(oldindex)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
long backcolor = 16777215
string text = "모집구분"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
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

type dw_1 from uo_input_dwc within tabpage_1
integer x = 23
integer y = 24
integer width = 4283
integer height = 1808
integer taborder = 20
string dataobject = "d_dip101a_01"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
long backcolor = 16777215
string text = "종별"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
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

type dw_2 from uo_input_dwc within tabpage_2
integer x = 27
integer y = 24
integer width = 4274
integer height = 1816
integer taborder = 11
string dataobject = "d_dip101a_02"
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
long backcolor = 16777215
string text = "과정코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from uo_input_dwc within tabpage_3
integer x = 23
integer y = 24
integer width = 4279
integer height = 1812
integer taborder = 11
string dataobject = "d_dip101a_03"
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
long backcolor = 16777215
string text = "학과코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_4.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_4)
end on

type dw_4 from uo_input_dwc within tabpage_4
integer x = 32
integer y = 28
integer width = 4270
integer height = 1812
integer taborder = 11
string dataobject = "d_dip101a_04"
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
long backcolor = 16777215
string text = "전공코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_5.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_5)
end on

type dw_5 from uo_input_dwc within tabpage_5
integer x = 23
integer y = 28
integer width = 4279
integer height = 1812
integer taborder = 11
string dataobject = "d_dip101a_05"
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
long backcolor = 16777215
string text = "직위코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tabpage_6.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tabpage_6.destroy
destroy(this.dw_6)
end on

type dw_6 from uo_input_dwc within tabpage_6
integer x = 18
integer y = 24
integer width = 4288
integer height = 1812
integer taborder = 11
string dataobject = "d_dip101a_06"
end type

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
long backcolor = 16777215
string text = "합격구분코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_7 dw_7
end type

on tabpage_7.create
this.dw_7=create dw_7
this.Control[]={this.dw_7}
end on

on tabpage_7.destroy
destroy(this.dw_7)
end on

type dw_7 from uo_input_dwc within tabpage_7
integer x = 32
integer y = 24
integer width = 4274
integer height = 1816
integer taborder = 11
string dataobject = "d_dip101a_07"
end type

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
long backcolor = 16777215
string text = "장학코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_8 dw_8
end type

on tabpage_8.create
this.dw_8=create dw_8
this.Control[]={this.dw_8}
end on

on tabpage_8.destroy
destroy(this.dw_8)
end on

type dw_8 from uo_input_dwc within tabpage_8
integer x = 27
integer y = 24
integer width = 4279
integer height = 1824
integer taborder = 11
string dataobject = "d_dip101a_08"
end type

type tabpage_9 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
long backcolor = 16777215
string text = "졸업구분"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_9 dw_9
end type

on tabpage_9.create
this.dw_9=create dw_9
this.Control[]={this.dw_9}
end on

on tabpage_9.destroy
destroy(this.dw_9)
end on

type dw_9 from uo_input_dwc within tabpage_9
integer x = 23
integer y = 24
integer width = 4283
integer height = 1820
integer taborder = 11
string dataobject = "d_dip101a_09"
end type

type tabpage_10 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
long backcolor = 16777215
string text = "계열구분"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_10 dw_10
end type

on tabpage_10.create
this.dw_10=create dw_10
this.Control[]={this.dw_10}
end on

on tabpage_10.destroy
destroy(this.dw_10)
end on

type dw_10 from uo_input_dwc within tabpage_10
integer x = 27
integer y = 20
integer width = 4279
integer height = 1820
integer taborder = 21
string dataobject = "d_dip101a_10"
end type

type uo_1 from u_tab within w_dip101a
integer x = 462
integer y = 200
integer taborder = 40
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

