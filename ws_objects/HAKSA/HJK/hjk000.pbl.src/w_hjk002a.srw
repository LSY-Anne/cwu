$PBExportHeader$w_hjk002a.srw
$PBExportComments$[청운대]학적관련코드관리
forward
global type w_hjk002a from w_common_tab
end type
type dw_tab1 from uo_grid within tabpage_1
end type
type dw_search1 from uo_dwfree within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tab2 from uo_grid within tabpage_2
end type
type dw_search2 from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_tab2 dw_tab2
dw_search2 dw_search2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_tab3 from uo_grid within tabpage_3
end type
type dw_search3 from uo_dwfree within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_tab3 dw_tab3
dw_search3 dw_search3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_tab4 from uo_grid within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_tab4 dw_tab4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_tab5_1 from uo_grid within tabpage_5
end type
type dw_tab5 from uo_grid within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_tab5_1 dw_tab5_1
dw_tab5 dw_tab5
end type
type tabpage_6 from userobject within tab_1
end type
type dw_tab6 from uo_grid within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_tab6 dw_tab6
end type
type tabpage_7 from userobject within tab_1
end type
type dw_tab7 from uo_grid within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_tab7 dw_tab7
end type
type tabpage_8 from userobject within tab_1
end type
type dw_tab8 from uo_grid within tabpage_8
end type
type tabpage_8 from userobject within tab_1
dw_tab8 dw_tab8
end type
type tabpage_9 from userobject within tab_1
end type
type dw_tab9 from uo_grid within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_tab9 dw_tab9
end type
end forward

global type w_hjk002a from w_common_tab
end type
global w_hjk002a w_hjk002a

type variables
int		ii_index, 	ii_save_flag
datawindow idw_dwn
end variables

on w_hjk002a.create
int iCurrent
call super::create
end on

on w_hjk002a.destroy
call super::destroy
end on

event ue_delete;call super::ue_delete;int li_ans

CHOOSE case ii_index
		 case	1
			tab_1.tabpage_1.dw_tab1.deleterow(0)
			li_ans = tab_1.tabpage_1.dw_tab1.update()
		 case	2
			tab_1.tabpage_2.dw_tab2.deleterow(0)
			li_ans = tab_1.tabpage_2.dw_tab2.update()			
		 case	3
			tab_1.tabpage_3.dw_tab3.deleterow(0)
			li_ans = tab_1.tabpage_3.dw_tab3.update()
		 case	4
			tab_1.tabpage_4.dw_tab4.deleterow(0)
			li_ans = tab_1.tabpage_4.dw_tab4.update()			
    	  case	5
			idw_dwn.deleterow(0)	
			li_ans = idw_dwn.update()
    	 case	6
			tab_1.tabpage_6.dw_tab6.deleterow(0)		
			li_ans = tab_1.tabpage_6.dw_tab6.update()			
    	 case	7
			tab_1.tabpage_7.dw_tab7.deleterow(0)	
			li_ans = tab_1.tabpage_7.dw_tab7.update()	
    	 case	8
			tab_1.tabpage_8.dw_tab8.deleterow(0)	
			li_ans = tab_1.tabpage_8.dw_tab8.update()	
    	 case	9
			tab_1.tabpage_9.dw_tab9.deleterow(0)		
			li_ans = tab_1.tabpage_9.dw_tab9.update()			
END CHOOSE

if li_ans = -1 then
	//저장 오류 메세지 출력
	rollback Using Sqlca ;
	f_set_message("삭제시 오류가 발생하였습니다!", '', parentwin)
else	
	commit Using Sqlca ;
	//저장확인 메세지 출력
	f_set_message("삭제가 되었습니다!", '', parentwin)
end if
end event

event ue_retrieve;call super::ue_retrieve;integer li_ans
string  ls_code

CHOOSE CASE	ii_index
	CASE	1
		ls_code = func.of_nvl(tab_1.tabpage_1.dw_search1.Object.high_id[1], '%')
		li_ans	= tab_1.tabpage_1.dw_tab1.retrieve(ls_code)
	CASE	2
		ls_code =func.of_nvl( tab_1.tabpage_2.dw_search2.Object.college_id[1], '%')
		li_ans	= tab_1.tabpage_2.dw_tab2.retrieve(ls_code)
	CASE	3
		ls_code = func.of_nvl(tab_1.tabpage_3.dw_search3.Object.hakgwa_id[1], '%')
		li_ans	= tab_1.tabpage_3.dw_tab3.retrieve(ls_code)
	CASE	4
		li_ans	= tab_1.tabpage_4.dw_tab4.retrieve()
	CASE	5
		li_ans	= tab_1.tabpage_5.dw_tab5.retrieve()
	CASE	6
		li_ans	= tab_1.tabpage_6.dw_tab6.retrieve()	
	CASE	7
		li_ans	= tab_1.tabpage_7.dw_tab7.retrieve()	
	CASE	8
		li_ans	= tab_1.tabpage_8.dw_tab8.retrieve()	
	CASE	9
		li_ans	= tab_1.tabpage_9.dw_tab9.retrieve()			
END CHOOSE

if li_ans = 0 then
	f_set_message("조회 되었습니다!", '', parentwin)
elseif li_ans = -1 then
	f_set_message("조회시 오류가 발생하였습니다!", '', parentwin)
end if

Return 1
end event

event ue_insert;call super::ue_insert;long ll_line
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
			ll_line = tab_1.tabpage_2.dw_tab2.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_2.dw_tab2.scrolltorow(ll_line)
				tab_1.tabpage_2.dw_tab2.setcolumn(1)
				tab_1.tabpage_2.dw_tab2.setfocus()
			end if
      case	3
			ll_line = tab_1.tabpage_3.dw_tab3.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_3.dw_tab3.scrolltorow(ll_line)
				tab_1.tabpage_3.dw_tab3.setcolumn(1)
				tab_1.tabpage_3.dw_tab3.setfocus()
			end if
      case	4
			ll_line = tab_1.tabpage_4.dw_tab4.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_4.dw_tab4.scrolltorow(ll_line)
				tab_1.tabpage_4.dw_tab4.setcolumn(1)
				tab_1.tabpage_4.dw_tab4.setfocus()
			end if
		case 5
			ll_line = idw_dwn.insertrow(0)
			if ll_line <> -1 then
				idw_dwn.scrolltorow(ll_line)
				idw_dwn.setcolumn(1)
				idw_dwn.setfocus()
			End If
		case 6
			ll_line = tab_1.tabpage_6.dw_tab6.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_6.dw_tab6.scrolltorow(ll_line)
				tab_1.tabpage_6.dw_tab6.setcolumn(1)
				tab_1.tabpage_6.dw_tab6.setfocus()
			end if
		case 7
			ll_line = tab_1.tabpage_7.dw_tab7.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_7.dw_tab7.scrolltorow(ll_line)
				tab_1.tabpage_7.dw_tab7.setcolumn(1)
				tab_1.tabpage_7.dw_tab7.setfocus()
			end if
		case 8
			ll_line = tab_1.tabpage_8.dw_tab8.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_8.dw_tab8.scrolltorow(ll_line)
				tab_1.tabpage_8.dw_tab8.setcolumn(1)
				tab_1.tabpage_8.dw_tab8.setfocus()
			end if
		case 9
			ll_line = tab_1.tabpage_9.dw_tab9.insertrow(0)
			if ll_line <> -1 then
				tab_1.tabpage_9.dw_tab9.scrolltorow(ll_line)
				tab_1.tabpage_9.dw_tab9.setcolumn(1)
				tab_1.tabpage_9.dw_tab9.setfocus()
			end if
END CHOOSE


end event

type ln_templeft from w_common_tab`ln_templeft within w_hjk002a
end type

type ln_tempright from w_common_tab`ln_tempright within w_hjk002a
end type

type ln_temptop from w_common_tab`ln_temptop within w_hjk002a
end type

type ln_tempbuttom from w_common_tab`ln_tempbuttom within w_hjk002a
end type

type ln_tempbutton from w_common_tab`ln_tempbutton within w_hjk002a
end type

type ln_tempstart from w_common_tab`ln_tempstart within w_hjk002a
end type

type uc_retrieve from w_common_tab`uc_retrieve within w_hjk002a
end type

type uc_insert from w_common_tab`uc_insert within w_hjk002a
end type

type uc_delete from w_common_tab`uc_delete within w_hjk002a
end type

type uc_save from w_common_tab`uc_save within w_hjk002a
end type

type uc_excel from w_common_tab`uc_excel within w_hjk002a
end type

type uc_print from w_common_tab`uc_print within w_hjk002a
end type

type st_line1 from w_common_tab`st_line1 within w_hjk002a
end type

type st_line2 from w_common_tab`st_line2 within w_hjk002a
end type

type st_line3 from w_common_tab`st_line3 within w_hjk002a
end type

type uc_excelroad from w_common_tab`uc_excelroad within w_hjk002a
end type

type ln_dwcon from w_common_tab`ln_dwcon within w_hjk002a
end type

type tab_1 from w_common_tab`tab_1 within w_hjk002a
integer y = 236
integer height = 2040
boolean boldselectedtext = true
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
this.Control[iCurrent+4]=this.tabpage_5
this.Control[iCurrent+5]=this.tabpage_6
this.Control[iCurrent+6]=this.tabpage_7
this.Control[iCurrent+7]=this.tabpage_8
this.Control[iCurrent+8]=this.tabpage_9
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
end on

event tab_1::selectionchanged;call super::selectionchanged;long	ll_newrow
integer li_ans

ii_index	= newindex

CHOOSE CASE	ii_index
	Case 1
		idw_update[1] = tab_1.tabpage_1.dw_tab1
	Case 2
		idw_update[1] = tab_1.tabpage_2.dw_tab2
	Case 3
		idw_update[1] = tab_1.tabpage_3.dw_tab3
	CASE	4
		li_ans	= tab_1.tabpage_4.dw_tab4.retrieve()
		idw_update[1] = tab_1.tabpage_4.dw_tab4
	CASE	5
		li_ans	= tab_1.tabpage_5.dw_tab5.retrieve()
		idw_update[1] = tab_1.tabpage_5.dw_tab5
		idw_update[2] = tab_1.tabpage_5.dw_tab5_1
	CASE	6
		li_ans	= tab_1.tabpage_6.dw_tab6.retrieve()
		idw_update[1] = tab_1.tabpage_6.dw_tab6
	CASE	7
		li_ans	= tab_1.tabpage_7.dw_tab7.retrieve()
		idw_update[1] = tab_1.tabpage_7.dw_tab7
	CASE	8
		li_ans	= tab_1.tabpage_8.dw_tab8.retrieve()
		idw_update[1] = tab_1.tabpage_8.dw_tab8
	CASE	9
		li_ans	= tab_1.tabpage_9.dw_tab9.retrieve()
		idw_update[1] = tab_1.tabpage_9.dw_tab9
END CHOOSE



end event

type tabpage_1 from w_common_tab`tabpage_1 within tab_1
integer height = 1920
string text = "학적고교코드"
dw_tab1 dw_tab1
dw_search1 dw_search1
end type

on tabpage_1.create
this.dw_tab1=create dw_tab1
this.dw_search1=create dw_search1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tab1
this.Control[iCurrent+2]=this.dw_search1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_tab1)
destroy(this.dw_search1)
end on

type uo_1 from w_common_tab`uo_1 within w_hjk002a
integer y = 176
end type

type dw_con from w_common_tab`dw_con within w_hjk002a
boolean visible = false
end type

type dw_tab1 from uo_grid within tabpage_1
integer x = 14
integer y = 172
integer width = 4306
integer height = 1732
integer taborder = 30
string dataobject = "d_hjk002a_1"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type dw_search1 from uo_dwfree within tabpage_1
integer x = 229
integer y = 24
integer width = 1504
integer height = 124
integer taborder = 50
string dataobject = "d_list_highcode"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
This.InsertRow(0)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "학적대학코드"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab2 dw_tab2
dw_search2 dw_search2
end type

on tabpage_2.create
this.dw_tab2=create dw_tab2
this.dw_search2=create dw_search2
this.Control[]={this.dw_tab2,&
this.dw_search2}
end on

on tabpage_2.destroy
destroy(this.dw_tab2)
destroy(this.dw_search2)
end on

type dw_tab2 from uo_grid within tabpage_2
integer x = 9
integer y = 200
integer width = 4315
integer height = 1692
integer taborder = 30
string dataobject = "d_hjk002a_2"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type dw_search2 from uo_dwfree within tabpage_2
integer x = 270
integer y = 20
integer width = 1531
integer height = 140
integer taborder = 60
string dataobject = "d_list_college"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
This.InsertRow(0)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "대학학과코드"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab3 dw_tab3
dw_search3 dw_search3
end type

on tabpage_3.create
this.dw_tab3=create dw_tab3
this.dw_search3=create dw_search3
this.Control[]={this.dw_tab3,&
this.dw_search3}
end on

on tabpage_3.destroy
destroy(this.dw_tab3)
destroy(this.dw_search3)
end on

type dw_tab3 from uo_grid within tabpage_3
integer x = 5
integer y = 192
integer width = 4325
integer height = 1704
integer taborder = 30
string dataobject = "d_hjk002a_3"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type dw_search3 from uo_dwfree within tabpage_3
integer x = 256
integer y = 24
integer width = 1618
integer height = 140
integer taborder = 60
string dataobject = "d_list_collegehakgwa"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
This.InsertRow(0)
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "학적상태코드"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab4 dw_tab4
end type

on tabpage_4.create
this.dw_tab4=create dw_tab4
this.Control[]={this.dw_tab4}
end on

on tabpage_4.destroy
destroy(this.dw_tab4)
end on

type dw_tab4 from uo_grid within tabpage_4
integer y = 24
integer width = 4320
integer height = 1876
integer taborder = 60
string dataobject = "d_hjk002a_4"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "학적변동코드"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab5_1 dw_tab5_1
dw_tab5 dw_tab5
end type

on tabpage_5.create
this.dw_tab5_1=create dw_tab5_1
this.dw_tab5=create dw_tab5
this.Control[]={this.dw_tab5_1,&
this.dw_tab5}
end on

on tabpage_5.destroy
destroy(this.dw_tab5_1)
destroy(this.dw_tab5)
end on

type dw_tab5_1 from uo_grid within tabpage_5
integer x = 1243
integer y = 12
integer width = 3077
integer height = 1892
integer taborder = 30
string dataobject = "d_hjk002a_8"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type dw_tab5 from uo_grid within tabpage_5
integer x = 5
integer y = 12
integer width = 1225
integer height = 1892
integer taborder = 70
string dataobject = "d_hjk002a_5"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

event ue_clicked;call super::ue_clicked;//override
string 	ls_hjmod_id
Long		ll_SelectRow

if dwo.name = 'hjmod_id' or dwo.name = 'hjmod_name' then
	ls_hjmod_id = This.object.hjmod_id[row] 
	dw_tab5_1.retrieve(ls_hjmod_id + '%')
end if

end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "증명서코드"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab6 dw_tab6
end type

on tabpage_6.create
this.dw_tab6=create dw_tab6
this.Control[]={this.dw_tab6}
end on

on tabpage_6.destroy
destroy(this.dw_tab6)
end on

type dw_tab6 from uo_grid within tabpage_6
integer x = 5
integer y = 24
integer width = 4320
integer height = 1876
integer taborder = 40
string dataobject = "d_hjk002a_6"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "상벌코드"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab7 dw_tab7
end type

on tabpage_7.create
this.dw_tab7=create dw_tab7
this.Control[]={this.dw_tab7}
end on

on tabpage_7.destroy
destroy(this.dw_tab7)
end on

type dw_tab7 from uo_grid within tabpage_7
integer x = 9
integer y = 20
integer width = 4311
integer height = 1868
integer taborder = 60
string dataobject = "d_hjk002a_9"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "입학구분코드"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab8 dw_tab8
end type

on tabpage_8.create
this.dw_tab8=create dw_tab8
this.Control[]={this.dw_tab8}
end on

on tabpage_8.destroy
destroy(this.dw_tab8)
end on

type dw_tab8 from uo_grid within tabpage_8
integer x = 9
integer y = 20
integer width = 4315
integer height = 1772
integer taborder = 30
string dataobject = "d_hjk002a_10"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type tabpage_9 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1920
long backcolor = 16777215
string text = "입학전형코드"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab9 dw_tab9
end type

on tabpage_9.create
this.dw_tab9=create dw_tab9
this.Control[]={this.dw_tab9}
end on

on tabpage_9.destroy
destroy(this.dw_tab9)
end on

type dw_tab9 from uo_grid within tabpage_9
integer x = 18
integer y = 24
integer width = 4306
integer height = 1864
integer taborder = 30
string dataobject = "d_hjk002a_11"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

