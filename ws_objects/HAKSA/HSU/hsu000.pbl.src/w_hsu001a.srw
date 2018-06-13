$PBExportHeader$w_hsu001a.srw
$PBExportComments$[청운대]수업코드관리
forward
global type w_hsu001a from w_no_condition_window
end type
type tab_1 from tab within w_hsu001a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_tab1 from uo_input_dwc within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_tab1 dw_tab1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from uo_dwfree within tabpage_2
end type
type dw_con2 from uo_dwfree within tabpage_2
end type
type dw_11 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
dw_con2 dw_con2
dw_11 dw_11
end type
type tabpage_3 from userobject within tab_1
end type
type dw_con3 from uo_dwfree within tabpage_3
end type
type dw_3 from uo_input_dwc within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_con3 dw_con3
dw_3 dw_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_con4 from uo_dwfree within tabpage_4
end type
type dw_7 from uo_input_dwc within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_con4 dw_con4
dw_7 dw_7
end type
type tabpage_5 from userobject within tab_1
end type
type dw_con5 from uo_dwfree within tabpage_5
end type
type dw_8 from uo_input_dwc within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_con5 dw_con5
dw_8 dw_8
end type
type tabpage_6 from userobject within tab_1
end type
type dw_9 from uo_input_dwc within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_9 dw_9
end type
type tabpage_7 from userobject within tab_1
end type
type dw_10 from uo_input_dwc within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_10 dw_10
end type
type tab_1 from tab within w_hsu001a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type
type uo_1 from u_tab within w_hsu001a
end type
end forward

global type w_hsu001a from w_no_condition_window
integer width = 4503
tab_1 tab_1
uo_1 uo_1
end type
global w_hsu001a w_hsu001a

type variables
int		ii_index			,&
			ii_save_flag
end variables

on w_hsu001a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_hsu001a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
end on

event ue_retrieve;/*
ii_index = 1  : 이수코드
ii_index = 2  : 교과목코드
ii_index = 3  : 대체과목코드
*/

integer 	li_ans
string	ls_gwamok, ls_gwamok_nm, ls_hakgwa, ls_be_gwamok, ls_af_gwamok, ls_year, ls_hakgi
string	ls_prof_id, ls_prof_name

CHOOSE CASE	ii_index
	CASE	1
		li_ans	= tab_1.tabpage_1.dw_tab1.retrieve()
	CASE	2
		tab_1.tabpage_2.dw_con2.AcceptText()
		
		ls_gwamok	     = func.of_nvl(tab_1.tabpage_2.dw_con2.Object.cd[1], '%')
     	ls_gwamok_nm = func.of_nvl(tab_1.tabpage_2.dw_con2.Object.cd_nm[1], '%')
		ls_hakgwa	     = func.of_nvl(tab_1.tabpage_2.dw_con2.Object.gwa[1], '%')
		
		li_ans	= tab_1.tabpage_2.dw_2.retrieve(ls_gwamok, ls_gwamok_nm, ls_hakgwa)
		
		if li_ans > 0 then
			tab_1.tabpage_2.dw_11.retrieve(ls_gwamok, ls_gwamok_nm, ls_hakgwa)
		end if
		
	CASE	3
		ls_be_gwamok	= func.of_nvl(tab_1.tabpage_3.dw_con3.Object.gwamok[1], '%')
		ls_af_gwamok	= func.of_nvl(tab_1.tabpage_3.dw_con3.Object.gwamok1[1], '%')
		ls_year			= func.of_nvl(tab_1.tabpage_3.dw_con3.Object.year[1], '%')
		ls_hakgi			= func.of_nvl(tab_1.tabpage_3.dw_con3.Object.hakgi[1], '%')
		
		li_ans	= tab_1.tabpage_3.dw_3.retrieve(ls_be_gwamok, ls_af_gwamok, ls_year, ls_hakgi)
	
	CASE	4
		ls_year			= func.of_nvl(tab_1.tabpage_4.dw_con4.Object.year[1], '%')
		ls_hakgi			= func.of_nvl(tab_1.tabpage_4.dw_con4.Object.hakgi[1], '%')
		
		li_ans	= tab_1.tabpage_4.dw_7.retrieve(ls_year, ls_hakgi)
		
	CASE	5
		ls_prof_id		= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.prof_no[1], '%')
		ls_prof_name	= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.prof_nm[1], '%')
		
		li_ans	= tab_1.tabpage_5.dw_8.retrieve(ls_prof_id, ls_prof_name)
	CASE	6
		
		li_ans	= tab_1.tabpage_6.dw_9.retrieve()
	CASE	7
		li_ans	= tab_1.tabpage_7.dw_10.retrieve()		
END CHOOSE

if li_ans = 0 then
	uf_messagebox(7)

elseif li_ans = -1 then
	uf_messagebox(8)
end if

Return 1
end event

event ue_insert;call super::ue_insert;/*
ii_index = 1  : 이수코드
ii_index = 2  : 교과목코드
ii_index = 3  : 대체과목코드
*/

long ll_line
string ls_hakbun

CHOOSE case ii_index
		 case	1
			ll_line = tab_1.tabpage_1.dw_tab1.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_1.dw_tab1.scrolltorow(ll_line)
				tab_1.tabpage_1.dw_tab1.setcolumn(1)
				tab_1.tabpage_1.dw_tab1.setfocus()
			end if
		 case 2
			ll_line = tab_1.tabpage_2.dw_2.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_2.dw_2.scrolltorow(ll_line)
				tab_1.tabpage_2.dw_2.setcolumn(1)
				tab_1.tabpage_2.dw_2.setfocus()
			end if
      case	3
			ll_line = tab_1.tabpage_3.dw_3.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_3.dw_3.scrolltorow(ll_line)
				tab_1.tabpage_3.dw_3.setcolumn(1)
				tab_1.tabpage_3.dw_3.setfocus()
									
				tab_1.tabpage_3.dw_3.object.daeche_year[ll_line]	=	tab_1.tabpage_3.dw_con3.Object.year[1]
				tab_1.tabpage_3.dw_3.object.daeche_hakgi[ll_line]	=	tab_1.tabpage_3.dw_con3.Object.hakgi[1]
			end if
		case	4
			ll_line = tab_1.tabpage_4.dw_7.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_4.dw_7.scrolltorow(ll_line)
				tab_1.tabpage_4.dw_7.setcolumn(1)
				tab_1.tabpage_4.dw_7.setfocus()
			end if
		 case	7
			ll_line = tab_1.tabpage_7.dw_10.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_7.dw_10.scrolltorow(ll_line)
				tab_1.tabpage_7.dw_10.setcolumn(1)
				tab_1.tabpage_7.dw_10.setfocus()
			end if			
			
END CHOOSE


end event

event ue_delete;call super::ue_delete;/*
ii_index = 1  : 이수코드
ii_index = 2  : 교과목코드
ii_index = 3  : 대체과목코드
*/

int li_ans

if messagebox("확인","자료를 삭제하시겠습니까?", Question!, YesNo!, 2) = 2 then return

CHOOSE case ii_index
		 case	1
			tab_1.tabpage_1.dw_tab1.deleterow(0)
			li_ans = tab_1.tabpage_1.dw_tab1.update()
		 case	2
			tab_1.tabpage_2.dw_2.deleterow(0)
			li_ans = tab_1.tabpage_2.dw_2.update()			
		 case	3
			tab_1.tabpage_3.dw_3.deleterow(0)
			li_ans = tab_1.tabpage_3.dw_3.update()
		case	4
			tab_1.tabpage_4.dw_7.deleterow(0)
			li_ans = tab_1.tabpage_4.dw_7.update()
		case	7
			tab_1.tabpage_7.dw_10.deleterow(0)
			li_ans = tab_1.tabpage_7.dw_10.update()
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

type ln_templeft from w_no_condition_window`ln_templeft within w_hsu001a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hsu001a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hsu001a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hsu001a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hsu001a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hsu001a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hsu001a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hsu001a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hsu001a
end type

type uc_save from w_no_condition_window`uc_save within w_hsu001a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hsu001a
end type

type uc_print from w_no_condition_window`uc_print within w_hsu001a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hsu001a
end type

type st_line2 from w_no_condition_window`st_line2 within w_hsu001a
end type

type st_line3 from w_no_condition_window`st_line3 within w_hsu001a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hsu001a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hsu001a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hsu001a
end type

type tab_1 from tab within w_hsu001a
integer x = 55
integer y = 256
integer width = 4379
integer height = 2008
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
boolean showpicture = false
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

event selectionchanged;
ii_index	= newindex

integer 	li_ans
string	ls_gwamok, ls_gwamok_nm, ls_hakgwa, ls_be_gwamok, ls_af_gwamok, ls_year, ls_hakgi, ls_prof_id, ls_prof_name

//과목코드와 대체과목은 데이타 양이 많아서 조회 생략.
CHOOSE CASE	ii_index
	CASE	1
		idw_update[1] = tab_1.tabpage_1.dw_tab1
		li_ans	= tab_1.tabpage_1.dw_tab1.retrieve()
	CASE	2
		idw_update[1] = tab_1.tabpage_2.dw_2
	CASE	3
		idw_update[1] = tab_1.tabpage_3.dw_3
	CASE	4
		idw_update[1] = tab_1.tabpage_4.dw_7
		ls_year			= tab_1.tabpage_4.dw_con4.Object.year[1]
		ls_hakgi			= tab_1.tabpage_4.dw_con4.Object.hakgi[1]
		
		li_ans	= tab_1.tabpage_4.dw_7.retrieve(ls_year, ls_hakgi)
	CASE	5
		ls_prof_id		= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.prof_no[1], '%')
		ls_prof_name	= func.of_nvl(tab_1.tabpage_5.dw_con5.Object.prof_nm[1], '%')
		
		li_ans	= tab_1.tabpage_5.dw_8.retrieve(ls_prof_id, ls_prof_name)
	CASE	6
		li_ans	= tab_1.tabpage_6.dw_9.retrieve()
	CASE	7
		idw_update[1] = tab_1.tabpage_7.dw_10
		li_ans	= tab_1.tabpage_7.dw_10.retrieve()		
END CHOOSE



end event

event selectionchanging;/*************************************************************************************************************************************
	 NAME :	wf_modify_chk() return none
	 DESCRIPTION : 변경사항이 있을때 저장하는 함수.

*************************************************************************************************************************************/

int li_mod, li_del, li_msg, li_ans

CHOOSE CASE oldindex
	CASE 1
		
		li_mod = tab_1.tabpage_1.dw_tab1.ModifiedCount()
		li_del = tab_1.tabpage_1.dw_tab1.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			idw_update[1] = tab_1.tabpage_1.dw_tab1
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
//			li_ans = tab_1.tabpage_1.dw_1.update()
			Parent.Event ue_save()
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
		li_mod = tab_1.tabpage_4.dw_7.ModifiedCount()
		li_del = tab_1.tabpage_4.dw_7.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			li_ans = tab_1.tabpage_4.dw_7.update()
		END IF		
		
	CASE 7
		li_mod = tab_1.tabpage_7.dw_10.ModifiedCount()
		li_del = tab_1.tabpage_7.dw_10.DeletedCount()
		
		IF li_mod + li_del > 0 THEN
			IF MessageBox("확인","변경된 사항이 있습니다.~r~n" + "저장하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN 
			li_ans = tab_1.tabpage_7.dw_10.update()
		END IF
		
END CHOOSE

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback USING SQLCA;
elseif li_ans = 1 then
	commit USING SQLCA;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1888
long backcolor = 16777215
string text = "이수코드"
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
integer width = 4334
integer height = 2192
integer taborder = 20
string dataobject = "d_hsu001a_1"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1888
long backcolor = 16777215
string text = "교과목코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_2 dw_2
dw_con2 dw_con2
dw_11 dw_11
end type

on tabpage_2.create
this.dw_2=create dw_2
this.dw_con2=create dw_con2
this.dw_11=create dw_11
this.Control[]={this.dw_2,&
this.dw_con2,&
this.dw_11}
end on

on tabpage_2.destroy
destroy(this.dw_2)
destroy(this.dw_con2)
destroy(this.dw_11)
end on

type dw_2 from uo_dwfree within tabpage_2
integer y = 168
integer width = 4334
integer height = 1720
integer taborder = 20
string dataobject = "d_hsu001a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

type dw_con2 from uo_dwfree within tabpage_2
integer x = 9
integer y = 24
integer width = 4320
integer height = 128
integer taborder = 30
string dataobject = "d_hsu001a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
This.InsertRow(0)
end event

type dw_11 from datawindow within tabpage_2
boolean visible = false
integer x = 517
integer y = 740
integer width = 2277
integer height = 1168
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_hsu001a_2_print"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1888
long backcolor = 16777215
string text = "대체과목코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_con3 dw_con3
dw_3 dw_3
end type

on tabpage_3.create
this.dw_con3=create dw_con3
this.dw_3=create dw_3
this.Control[]={this.dw_con3,&
this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_con3)
destroy(this.dw_3)
end on

event constructor;tab_1.tabpage_3.dw_con3.Object.year[1] = func.of_get_sdate('YYYY')
end event

type dw_con3 from uo_dwfree within tabpage_3
integer y = 20
integer width = 4334
integer height = 160
integer taborder = 40
string dataobject = "d_hsu001a_c2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
This.InsertRow(0)
end event

type dw_3 from uo_input_dwc within tabpage_3
integer y = 200
integer width = 4329
integer height = 2000
integer taborder = 10
string dataobject = "d_hsu001a_3"
end type

event itemchanged;call super::itemchanged;string	ls_gwamok, ls_gwmaok_before, ls_gwamok_after
integer	li_gwamok_seq, li_gwmaok_seq_before, li_gwamok_seq_after
integer	li_newrow

CHOOSE CASE	DWO.NAME
	//대체전 과목을 입력하게 되면
	//이전에 대체된 내력을 읽어와서 전부 대체과목으로 생성한다,
	CASE	'gwamok_before'
		
		//대체후 과목을 미리 가져온다.(입력을 편하게 하려고)
		ls_gwamok_after		=	this.object.gwamok_id_after[row]
		li_gwamok_seq_after	=	integer(this.object.gwamok_seq_after[row])
		
		if ls_gwamok_after = '' then
			messagebox("확인","대체후 과목을 먼저 입력하세요.")
			return
		end if
		
		//현재입력하는 대체전 과목을 가져온다.
		ls_gwamok		=	left(data, 7)
		li_gwamok_seq	=	integer(mid(data, 8, 2))
		
		this.object.gwamok_id_before[row]	=	ls_gwamok
		this.object.gwamok_seq_before[row]	=	li_gwamok_seq
				
		if messagebox("확인","해당과목의 대체전과목을 모두 입력하시겠습니까?", Question!, YesNo!, 1) = 2 then return
		
		DECLARE CUR_DAECHE CURSOR FOR
		SELECT	GWAMOK_ID_BEFORE,
					GWAMOK_SEQ_BEFORE
		FROM	HAKSA.DAECHE_GWAMOK
		WHERE	GWAMOK_ID_AFTER	=	:ls_gwamok
		AND	GWAMOK_SEQ_AFTER	=	:li_gwamok_seq
		 USING SQLCA ;
		
		OPEN CUR_DAECHE	;
		DO
			FETCH CUR_DAECHE	INTO	:ls_gwmaok_before, :li_gwmaok_seq_before	;
			
			IF SQLCA.SQLCODE <> 0 THEN EXIT
			
			row = row + 1
			
			li_newrow = this.insertrow(row)
			
			this.object.gwamok_id_before[li_newrow]	=	ls_gwmaok_before
			this.object.gwamok_seq_before[li_newrow]	=	li_gwmaok_seq_before
			this.object.gwamok_before[li_newrow]		=	ls_gwmaok_before + string(li_gwmaok_seq_before)
			
			this.object.gwamok_id_after[li_newrow]		=	ls_gwamok_after
			this.object.gwamok_seq_after[li_newrow]	=	li_gwamok_seq_after
			this.object.gwamok_after[li_newrow]			=	ls_gwamok_after + string(li_gwamok_seq_after)
			
			this.object.daeche_year[li_newrow]	=	tab_1.tabpage_3.dw_con3.Object.year[1]
			this.object.daeche_hakgi[li_newrow]	=	tab_1.tabpage_3.dw_con3.Object.hakgi[1]
		LOOP WHILE TRUE
		CLOSE CUR_DAECHE	;
	
	//대체후 과목 입력시...
	CASE	'gwamok_after'
		
		ls_gwamok		=	left(data, 7)
		li_gwamok_seq	=	integer(mid(data, 8, 2))

		this.object.gwamok_id_after[row]		=	ls_gwamok
		this.object.gwamok_seq_after[row]	=	li_gwamok_seq	
				
END CHOOSE
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1888
long backcolor = 16777215
string text = "강의평가코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_con4 dw_con4
dw_7 dw_7
end type

on tabpage_4.create
this.dw_con4=create dw_con4
this.dw_7=create dw_7
this.Control[]={this.dw_con4,&
this.dw_7}
end on

on tabpage_4.destroy
destroy(this.dw_con4)
destroy(this.dw_7)
end on

type dw_con4 from uo_dwfree within tabpage_4
integer y = 16
integer width = 4338
integer height = 148
integer taborder = 40
string dataobject = "d_hsu001a_c3"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
This.InsertRow(0)
end event

type dw_7 from uo_input_dwc within tabpage_4
integer y = 184
integer width = 4334
integer height = 1976
integer taborder = 11
string dataobject = "d_hsu001a_4"
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1888
long backcolor = 16777215
string text = "교수코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_con5 dw_con5
dw_8 dw_8
end type

on tabpage_5.create
this.dw_con5=create dw_con5
this.dw_8=create dw_8
this.Control[]={this.dw_con5,&
this.dw_8}
end on

on tabpage_5.destroy
destroy(this.dw_con5)
destroy(this.dw_8)
end on

type dw_con5 from uo_dwfree within tabpage_5
integer x = 5
integer y = 12
integer width = 4329
integer height = 148
integer taborder = 40
string dataobject = "d_hsu001a_c4"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
This.InsertRow(0)
end event

type dw_8 from uo_input_dwc within tabpage_5
integer y = 176
integer width = 4325
integer height = 2000
integer taborder = 11
string dataobject = "d_hsu001a_5"
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1888
long backcolor = 16777215
string text = "강의실코드"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_9 dw_9
end type

on tabpage_6.create
this.dw_9=create dw_9
this.Control[]={this.dw_9}
end on

on tabpage_6.destroy
destroy(this.dw_9)
end on

type dw_9 from uo_input_dwc within tabpage_6
integer y = 12
integer width = 4329
integer height = 2156
integer taborder = 11
string dataobject = "d_hsu001a_6"
end type

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1888
long backcolor = 16777215
string text = "학습구분가능학과"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_10 dw_10
end type

on tabpage_7.create
this.dw_10=create dw_10
this.Control[]={this.dw_10}
end on

on tabpage_7.destroy
destroy(this.dw_10)
end on

type dw_10 from uo_input_dwc within tabpage_7
integer x = 5
integer y = 8
integer width = 4325
integer height = 2184
integer taborder = 30
string dataobject = "d_hsu001a_7"
end type

type uo_1 from u_tab within w_hsu001a
integer x = 462
integer y = 200
integer taborder = 20
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

