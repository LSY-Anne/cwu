$PBExportHeader$w_dhwsu101a.srw
$PBExportComments$[대학원수업] 수업코드관리
forward
global type w_dhwsu101a from w_no_condition_window
end type
type tab_1 from tab within w_dhwsu101a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from uo_input_dwc within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type sle_1 from singlelineedit within tabpage_1
end type
type sle_2 from singlelineedit within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
gb_2 gb_2
sle_1 sle_1
sle_2 sle_2
st_1 st_1
st_2 st_2
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
type gb_3 from groupbox within tabpage_3
end type
type sle_3 from singlelineedit within tabpage_3
end type
type sle_4 from singlelineedit within tabpage_3
end type
type st_3 from statictext within tabpage_3
end type
type st_4 from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
gb_3 gb_3
sle_3 sle_3
sle_4 sle_4
st_3 st_3
st_4 st_4
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
type dw_5 from uo_grid within tabpage_5
end type
type dw_con5 from uo_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_5 dw_5
dw_con5 dw_con5
end type
type tab_1 from tab within w_dhwsu101a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
type uo_1 from u_tab within w_dhwsu101a
end type
end forward

global type w_dhwsu101a from w_no_condition_window
tab_1 tab_1
uo_1 uo_1
end type
global w_dhwsu101a w_dhwsu101a

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
		
	CASE 3
		li_mod = tab_1.tabpage_3.dw_3.ModifiedCount()
		li_del = tab_1.tabpage_3.dw_3.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			li_ans = tab_1.tabpage_3.dw_3.update()
		END IF
		
	CASE 4
		li_mod = tab_1.tabpage_4.dw_4.ModifiedCount()
		li_del = tab_1.tabpage_4.dw_4.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			li_ans = tab_1.tabpage_4.dw_4.update()
		END IF
		
	CASE 5
		li_mod = tab_1.tabpage_5.dw_5.ModifiedCount()
		li_del   = tab_1.tabpage_5.dw_5.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			li_ans = tab_1.tabpage_5.dw_5.update()
		END IF	
		
		
END CHOOSE

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback using sqlca;
elseif li_ans = 1 then
	commit using sqlca ;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if
end subroutine

on w_dhwsu101a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_dhwsu101a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
end on

event ue_delete;call super::ue_delete;int li_ans, ll_row

//삭제확인
if uf_messagebox(4) = 2 then return

CHOOSE CASE ii_index
	CASE 1
		ll_row = tab_1.tabpage_1.dw_1.GetRow()
		
		tab_1.tabpage_1.dw_1.deleterow(ll_row)
		li_ans = tab_1.tabpage_1.dw_1.update()
		
	CASE 2
		ll_row = tab_1.tabpage_2.dw_2.GetRow()
		
		tab_1.tabpage_2.dw_2.deleterow(ll_row)
		li_ans = tab_1.tabpage_2.dw_2.update()

	CASE 3
		MESSAGEBOX("확인","교수코드는 삭제할 수 없습니다.")
		RETURN
		
	CASE 4
		MESSAGEBOX("확인","강의실코드는 삭제할 수 없습니다.")
		RETURN
		
	Case 5
		ll_row = tab_1.tabpage_5.dw_5.GetRow()
		
		tab_1.tabpage_5.dw_5.deleterow(ll_row)
		li_ans = tab_1.tabpage_5.dw_5.update()

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
		MESSAGEBOX("확인","교수코드 입력은 행정부서에 문의하세요.")
		RETURN
		
	CASE 4
		MESSAGEBOX("확인","강의실코드 입력은 행정부서에 문의하세요.")
		RETURN
		
	CASE 5
		ll_line = tab_1.tabpage_5.dw_5.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_5.dw_5.scrolltorow(ll_line)
			tab_1.tabpage_5.dw_5.setcolumn(1)
			tab_1.tabpage_5.dw_5.setfocus()
		end if
END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;long     ll_ans
string	  ls_gwamok_id, ls_gwamok_name, ls_prof_id, ls_prof_name
String  ls_be_gwamok, ls_af_gwamok, ls_year, ls_hakgi

CHOOSE case ii_index
		case	1   // 
			ls_gwamok_id	     =	tab_1.tabpage_1.sle_1.text + '%'
			ls_gwamok_name	=	tab_1.tabpage_1.sle_2.text + '%'
			
			ll_ans = tab_1.tabpage_1.dw_1.retrieve(ls_gwamok_id, ls_gwamok_name)
		
		case	2   //
			ll_ans = tab_1.tabpage_2.dw_2.retrieve()   
		
		case	3   //
			ls_prof_id		=	tab_1.tabpage_3.sle_3.text + '%'
			ls_prof_name	=	tab_1.tabpage_3.sle_4.text + '%'
			
			ll_ans = tab_1.tabpage_3.dw_3.retrieve(ls_prof_id, ls_prof_name)   
		
		case	4   //
			ll_ans = tab_1.tabpage_4.dw_4.retrieve() 
			
		Case 5
			tab_1.tabpage_5.dw_con5.AcceptText()
			
			ls_be_gwamok	= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.gwamok[1], '%')
			ls_af_gwamok	= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.gwamok1[1], '%')
			ls_year			= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.year[1], '%')
			ls_hakgi			= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.hakgi[1], '%')
		
		    ll_ans	= tab_1.tabpage_5.dw_5.retrieve(ls_be_gwamok, ls_af_gwamok, ls_year, ls_hakgi)
			
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

type ln_templeft from w_no_condition_window`ln_templeft within w_dhwsu101a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_dhwsu101a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_dhwsu101a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_dhwsu101a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_dhwsu101a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_dhwsu101a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_dhwsu101a
end type

type uc_insert from w_no_condition_window`uc_insert within w_dhwsu101a
end type

type uc_delete from w_no_condition_window`uc_delete within w_dhwsu101a
end type

type uc_save from w_no_condition_window`uc_save within w_dhwsu101a
end type

type uc_excel from w_no_condition_window`uc_excel within w_dhwsu101a
end type

type uc_print from w_no_condition_window`uc_print within w_dhwsu101a
end type

type st_line1 from w_no_condition_window`st_line1 within w_dhwsu101a
end type

type st_line2 from w_no_condition_window`st_line2 within w_dhwsu101a
end type

type st_line3 from w_no_condition_window`st_line3 within w_dhwsu101a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_dhwsu101a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_dhwsu101a
end type

type gb_1 from w_no_condition_window`gb_1 within w_dhwsu101a
end type

type tab_1 from tab within w_dhwsu101a
integer x = 50
integer y = 224
integer width = 4379
integer height = 2040
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
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event selectionchanged;ii_index = newindex

long     ll_ans
String  ls_be_gwamok, ls_af_gwamok, ls_year, ls_hakgi

CHOOSE case ii_index
		case	1   // 
			idw_update[1] = tab_1.tabpage_1.dw_1
			ll_ans = tab_1.tabpage_1.dw_1.retrieve('%', '%')
			idw_print = tab_1.tabpage_1.dw_1
		
		case	2   //
			idw_update[1] = tab_1.tabpage_2.dw_2
			ll_ans = tab_1.tabpage_2.dw_2.retrieve()   
			idw_print = tab_1.tabpage_2.dw_2
		
		case	3   //
			ll_ans = tab_1.tabpage_3.dw_3.retrieve('%', '%') 
			idw_print = tab_1.tabpage_3.dw_3
		
		case	4   //
			ll_ans = tab_1.tabpage_4.dw_4.retrieve()   
			idw_print = tab_1.tabpage_4.dw_4
			
		case	5
			idw_update[1] = tab_1.tabpage_5.dw_5
			
			ls_be_gwamok	= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.gwamok[1], '%')
			ls_af_gwamok	= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.gwamok1[1], '%')
			ls_year			= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.year[1], '%')
			ls_hakgi			= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.hakgi[1], '%')
		
		    ll_ans	= tab_1.tabpage_5.dw_5.retrieve(ls_be_gwamok, ls_af_gwamok, ls_year, ls_hakgi)
						
END CHOOSE
end event

event selectionchanging;//DW의 내용이 바뀐게 있는지 check
wf_modify_chk(oldindex)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "과목코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_1 dw_1
gb_2 gb_2
sle_1 sle_1
sle_2 sle_2
st_1 st_1
st_2 st_2
end type

on tabpage_1.create
this.dw_1=create dw_1
this.gb_2=create gb_2
this.sle_1=create sle_1
this.sle_2=create sle_2
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.dw_1,&
this.gb_2,&
this.sle_1,&
this.sle_2,&
this.st_1,&
this.st_2}
end on

on tabpage_1.destroy
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.st_1)
destroy(this.st_2)
end on

type dw_1 from uo_input_dwc within tabpage_1
integer x = 18
integer y = 216
integer width = 4302
integer height = 1684
integer taborder = 20
string dataobject = "d_dhwsu101_1"
end type

type gb_2 from groupbox within tabpage_1
integer x = 32
integer y = 16
integer width = 4256
integer height = 172
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
end type

type sle_1 from singlelineedit within tabpage_1
integer x = 617
integer y = 80
integer width = 402
integer height = 64
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within tabpage_1
integer x = 1504
integer y = 80
integer width = 1303
integer height = 64
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
end type

type st_1 from statictext within tabpage_1
integer x = 343
integer y = 80
integer width = 265
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "과목코드"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_1
integer x = 1271
integer y = 80
integer width = 224
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "과목명"
alignment alignment = right!
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "이수구분코드"
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
integer x = 18
integer y = 28
integer width = 4297
integer height = 1864
integer taborder = 11
string dataobject = "d_dhwsu101_2"
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "교수코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_3 dw_3
gb_3 gb_3
sle_3 sle_3
sle_4 sle_4
st_3 st_3
st_4 st_4
end type

on tabpage_3.create
this.dw_3=create dw_3
this.gb_3=create gb_3
this.sle_3=create sle_3
this.sle_4=create sle_4
this.st_3=create st_3
this.st_4=create st_4
this.Control[]={this.dw_3,&
this.gb_3,&
this.sle_3,&
this.sle_4,&
this.st_3,&
this.st_4}
end on

on tabpage_3.destroy
destroy(this.dw_3)
destroy(this.gb_3)
destroy(this.sle_3)
destroy(this.sle_4)
destroy(this.st_3)
destroy(this.st_4)
end on

type dw_3 from uo_input_dwc within tabpage_3
integer x = 14
integer y = 220
integer width = 4302
integer height = 1672
integer taborder = 11
string dataobject = "d_dhwsu101_3"
end type

type gb_3 from groupbox within tabpage_3
integer x = 32
integer y = 16
integer width = 4274
integer height = 172
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
end type

type sle_3 from singlelineedit within tabpage_3
integer x = 695
integer y = 80
integer width = 457
integer height = 64
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
end type

type sle_4 from singlelineedit within tabpage_3
integer x = 1605
integer y = 80
integer width = 535
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_3
integer x = 425
integer y = 80
integer width = 261
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "교수번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_3
integer x = 1390
integer y = 80
integer width = 206
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "교수명"
alignment alignment = right!
boolean focusrectangle = false
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "강의실코드"
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
integer x = 27
integer y = 24
integer width = 4283
integer height = 1872
integer taborder = 11
string dataobject = "d_dhwsu101_4"
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "대체과목"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_5 dw_5
dw_con5 dw_con5
end type

on tabpage_5.create
this.dw_5=create dw_5
this.dw_con5=create dw_con5
this.Control[]={this.dw_5,&
this.dw_con5}
end on

on tabpage_5.destroy
destroy(this.dw_5)
destroy(this.dw_con5)
end on

type dw_5 from uo_grid within tabpage_5
integer x = 9
integer y = 184
integer width = 4315
integer height = 1720
integer taborder = 20
string dataobject = "d_dhwsu101_5"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_con5 from uo_dw within tabpage_5
integer x = 9
integer y = 28
integer width = 4315
integer height = 140
integer taborder = 60
string dataobject = "d_dhwsu101_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_constructor;call super::ue_constructor;This.SetTransObject(sqlca)
This.InsertRow(0)
end event

type uo_1 from u_tab within w_dhwsu101a
integer x = 270
integer y = 176
integer taborder = 50
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

