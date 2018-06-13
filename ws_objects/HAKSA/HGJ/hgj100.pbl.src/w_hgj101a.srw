$PBExportHeader$w_hgj101a.srw
$PBExportComments$[청운대]교원자격코드관리
forward
global type w_hgj101a from w_no_condition_window
end type
type tab_1 from tab within w_hgj101a
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
type dw_c1 from uo_dwfree within tabpage_3
end type
type dw_3 from uo_input_dwc within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_c1 dw_c1
dw_3 dw_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_4 from uo_dwfree within tabpage_4
end type
type dw_c2 from uo_dwfree within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_4 dw_4
dw_c2 dw_c2
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
type dw_6 from uo_dwfree within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_6 dw_6
end type
type tab_1 from tab within w_hgj101a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
type uo_1 from u_tab within w_hgj101a
end type
end forward

global type w_hgj101a from w_no_condition_window
tab_1 tab_1
uo_1 uo_1
end type
global w_hgj101a w_hgj101a

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
		idw_update[1] = tab_1.tabpage_1.dw_1
		li_mod = tab_1.tabpage_1.dw_1.ModifiedCount()
		li_del = tab_1.tabpage_1.dw_1.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			This.Event ue_save()
		END IF
	
		
	CASE 2
		idw_update[1] = tab_1.tabpage_2.dw_2
		li_mod = tab_1.tabpage_2.dw_2.ModifiedCount()
		li_del = tab_1.tabpage_2.dw_2.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			This.Event ue_save()
		END IF
		
	CASE 3
		idw_update[1] = tab_1.tabpage_3.dw_3
		li_mod = tab_1.tabpage_3.dw_3.ModifiedCount()
		li_del = tab_1.tabpage_3.dw_3.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			This.Event ue_save()
		END IF
		
	CASE 4
		idw_update[1] = tab_1.tabpage_4.dw_4
		li_mod = tab_1.tabpage_4.dw_4.ModifiedCount()
		li_del = tab_1.tabpage_4.dw_4.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			This.Event ue_save()
		END IF		
		
	CASE 5
		idw_update[1] = tab_1.tabpage_5.dw_5
		li_mod = tab_1.tabpage_5.dw_5.ModifiedCount()
		li_del = tab_1.tabpage_5.dw_5.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			This.Event ue_save()
		END IF		
		
	CASE 6 
		idw_update[1] = tab_1.tabpage_6.dw_6
		li_mod = tab_1.tabpage_6.dw_6.ModifiedCount()
		li_del = tab_1.tabpage_6.dw_6.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			This.Event ue_save()
		END IF		
		
		
END CHOOSE

Return

end subroutine

on w_hgj101a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_hgj101a.destroy
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

Return

end event

event ue_insert;call super::ue_insert;long ll_line
int li_ans
string ls_jaguk, ls_pyosi, ls_hakgwa

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
		ls_jaguk    	= tab_1.tabpage_4.dw_c2.Object.jaguk_id[1]
		ls_pyosi	    = tab_1.tabpage_4.dw_c2.Object.pyosi_id[1]
		ls_hakgwa	= tab_1.tabpage_4.dw_c2.Object.gwa[1]
		
		if ls_jaguk = '' or ls_pyosi = '' or ls_hakgwa = '' then
			messagebox('확인!', '자격명, 표시과목명, 학과를 입력하세요!')
			return
		end if
				
		ll_line = tab_1.tabpage_4.dw_4.insertrow(0)
		if ll_line <> -1 then
			tab_1.tabpage_4.dw_4.object.jaguk_id[ll_line] = ls_jaguk
			tab_1.tabpage_4.dw_4.object.pyosi_id[ll_line] = ls_pyosi
			tab_1.tabpage_4.dw_4.object.gwa[ll_line] = ls_hakgwa
			
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
		
		tab_1.tabpage_6.dw_6.object.silsup_yn[ll_line]		=	'N'
		tab_1.tabpage_6.dw_6.object.silsup2_yn[ll_line]	=	'N'
		
		tab_1.tabpage_6.dw_6.object.worker[ll_line]		=	gstru_uid_uname.uid
		tab_1.tabpage_6.dw_6.object.ipaddr[ll_line]		=	gstru_uid_uname.address
		tab_1.tabpage_6.dw_6.object.work_date[ll_line]	=	f_sysdate()
		
		if ll_line <> -1 then
			tab_1.tabpage_6.dw_6.scrolltorow(ll_line)
			tab_1.tabpage_6.dw_6.setcolumn(1)
			tab_1.tabpage_6.dw_6.setfocus()
		end if

END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;long ll_ans
string	ls_year, ls_jaguk, ls_pyosi, ls_hakgwa

CHOOSE case ii_index
		case	1   // 
			ll_ans = tab_1.tabpage_1.dw_1.retrieve()   
		
		case	2   //
			ll_ans = tab_1.tabpage_2.dw_2.retrieve()   
		
		case	3   //
			ls_year	= tab_1.tabpage_3.dw_c1.Object.year[1]
			
			ll_ans = tab_1.tabpage_3.dw_3.retrieve(ls_year)   
		
		case	4   //
			ls_jaguk	    = tab_1.tabpage_4.dw_c2.Object.jaguk_id[1]
			ls_pyosi	    = func.of_nvl(tab_1.tabpage_4.dw_c2.Object.pyosi_id[1], '%') + '%'
			ls_hakgwa	= func.of_nvl(tab_1.tabpage_4.dw_c2.Object.gwa[1], '%') + '%'
			
			ll_ans = tab_1.tabpage_4.dw_4.retrieve(ls_jaguk, ls_pyosi, ls_hakgwa)   
			
		case	5   //
						
			ll_ans = tab_1.tabpage_5.dw_5.retrieve(ls_jaguk, ls_pyosi, ls_hakgwa)   
		
		case	6   // 
			ll_ans = tab_1.tabpage_6.dw_6.retrieve()   

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

type ln_templeft from w_no_condition_window`ln_templeft within w_hgj101a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hgj101a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hgj101a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hgj101a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hgj101a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hgj101a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hgj101a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hgj101a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hgj101a
end type

type uc_save from w_no_condition_window`uc_save within w_hgj101a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hgj101a
end type

type uc_print from w_no_condition_window`uc_print within w_hgj101a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hgj101a
end type

type st_line2 from w_no_condition_window`st_line2 within w_hgj101a
end type

type st_line3 from w_no_condition_window`st_line3 within w_hgj101a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hgj101a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hgj101a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hgj101a
end type

type tab_1 from tab within w_hgj101a
integer x = 50
integer y = 284
integer width = 4384
integer height = 1980
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
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event selectionchanged;ii_index = newindex

long ll_ans
string	ls_year, ls_jaguk, ls_pyosi, ls_hakgwa

CHOOSE case ii_index
		case	1   // 
			ll_ans = tab_1.tabpage_1.dw_1.retrieve()   
			idw_update[1] = tab_1.tabpage_1.dw_1
		
		case	2   //
			ll_ans = tab_1.tabpage_2.dw_2.retrieve() 
			idw_update[1] = tab_1.tabpage_2.dw_2
		
		case	3   //
			ls_year	= tab_1.tabpage_3.dw_c1.Object.year[1]
			
			ll_ans = tab_1.tabpage_3.dw_3.retrieve(ls_year)
			idw_update[1] = tab_1.tabpage_3.dw_3
		
		case	4   //
			ls_jaguk	    = tab_1.tabpage_4.dw_c2.Object.jaguk_id[1]
			ls_pyosi	    = func.of_nvl(tab_1.tabpage_4.dw_c2.Object.pyosi_id[1], '%') + '%'
			ls_hakgwa	= func.of_nvl(tab_1.tabpage_4.dw_c2.Object.gwa[1], '%') + '%'
			
			ll_ans = tab_1.tabpage_4.dw_4.retrieve(ls_jaguk, ls_pyosi, ls_hakgwa)
			idw_update[1] = tab_1.tabpage_4.dw_4
			
		case	5   //
			
			ll_ans = tab_1.tabpage_5.dw_5.retrieve()
			idw_update[1] = tab_1.tabpage_5.dw_5
		
		case	6   // 
			ll_ans = tab_1.tabpage_6.dw_6.retrieve() 
			idw_update[1] = tab_1.tabpage_6.dw_6

END CHOOSE

Return 1
end event

event selectionchanging;//DW의 내용이 바뀐게 있는지 check
wf_modify_chk(oldindex)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1860
string text = "교원자격코드"
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

type dw_1 from uo_input_dwc within tabpage_1
integer x = 18
integer y = 24
integer width = 4297
integer height = 1808
integer taborder = 20
string dataobject = "d_hgj101a_01"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1860
string text = "표시과목"
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

type dw_2 from uo_input_dwc within tabpage_2
integer x = 14
integer y = 16
integer width = 4302
integer height = 1828
integer taborder = 11
string dataobject = "d_hgj101a_02"
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1860
string text = "자격학과"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_c1 dw_c1
dw_3 dw_3
end type

on tabpage_3.create
this.dw_c1=create dw_c1
this.dw_3=create dw_3
this.Control[]={this.dw_c1,&
this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_c1)
destroy(this.dw_3)
end on

type dw_c1 from uo_dwfree within tabpage_3
integer x = 5
integer y = 16
integer width = 4325
integer height = 124
integer taborder = 41
string dataobject = "d_hgj101a_c01"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
This.InsertRow(0)

This.Object.year[1]   = f_haksa_iljung_year()
end event

type dw_3 from uo_input_dwc within tabpage_3
integer x = 9
integer y = 156
integer width = 4315
integer height = 1688
integer taborder = 11
string dataobject = "d_hgj101a_03"
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1860
string text = "기본이수과목"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_4 dw_4
dw_c2 dw_c2
end type

on tabpage_4.create
this.dw_4=create dw_4
this.dw_c2=create dw_c2
this.Control[]={this.dw_4,&
this.dw_c2}
end on

on tabpage_4.destroy
destroy(this.dw_4)
destroy(this.dw_c2)
end on

type dw_4 from uo_dwfree within tabpage_4
integer x = 9
integer y = 176
integer width = 4325
integer height = 1668
integer taborder = 20
string dataobject = "d_hgj101a_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;this.AcceptText()

CHOOSE CASE	DWO.NAME
	CASE	'gwamok'
		this.object.gwamok_id[row]		=	left(data, 7)
		this.object.gwamok_seq[row]	=	integer(mid(data, 8, 2))
		
END CHOOSE

end event

event constructor;call super::constructor;This.SetTransObject(sqlca)

end event

type dw_c2 from uo_dwfree within tabpage_4
integer x = 5
integer y = 16
integer width = 4325
integer height = 132
integer taborder = 21
string dataobject = "d_hgj101a_c02"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
This.InsertRow(0)
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1860
string text = "교직과목"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
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
integer x = 14
integer y = 12
integer width = 4311
integer height = 1836
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hgj101a_05"
end type

event itemchanged;call super::itemchanged;this.AcceptText()

CHOOSE CASE	DWO.NAME
	CASE	'gwamok'
		this.object.gwamok_id[row]		=	left(data, 7)
		this.object.gwamok_seq[row]	=	integer(mid(data, 8, 2))
		
END CHOOSE

end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1860
string text = "사정기준"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
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

type dw_6 from uo_dwfree within tabpage_6
integer x = 27
integer y = 20
integer width = 4293
integer height = 1816
integer taborder = 20
string dataobject = "d_hgj101a_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)

end event

type uo_1 from u_tab within w_hgj101a
integer x = 462
integer y = 200
integer taborder = 30
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

