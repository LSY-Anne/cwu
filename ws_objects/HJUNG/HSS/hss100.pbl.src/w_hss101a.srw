$PBExportHeader$w_hss101a.srw
$PBExportComments$토지 관리
forward
global type w_hss101a from w_tabsheet
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type dw_update from uo_dwfree within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print dw_print
end type
end forward

global type w_hss101a from w_tabsheet
string title = "토지관리"
end type
global w_hss101a w_hss101a

type variables

int ii_tab
long il_getrow = 1
datawindowchild idw_child
datawindow idw_name1
end variables

forward prototypes
public subroutine wf_insert ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_insert ();
ii_tab  = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
		
		tab_sheet.tabpage_sheet01.dw_update.reset()		
		tab_sheet.tabpage_sheet01.dw_update.insertrow(0)
		
		tab_sheet.tabpage_sheet01.dw_update.setfocus()

END CHOOSE

end subroutine

public subroutine wf_retrieve ();


ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
		
		IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve() = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			wf_insert()
		ELSE	
			tab_sheet.tabpage_sheet01.dw_update_tab.setfocus()
         tab_sheet.tabpage_sheet01.dw_update_tab.trigger event rowfocuschanged(il_getrow)
		END IF	 
   CASE 2
		IF tab_sheet.tabpage_1.dw_print.retrieve() = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE	
			wf_setMsg("자료가 조회되었습니다..!")
		END IF 
END CHOOSE		



end subroutine

on w_hss101a.create
int iCurrent
call super::create
end on

on w_hss101a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;
wf_retrieve()

return 1




end event

event ue_insert;call super::ue_insert;
wf_insert()


end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 토지관리
//    적 성 인 : 윤하영
//		작성일자 : 2002.00.00
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

//wf_setMenu('I',TRUE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',TRUE)
//wf_setMenu('U',TRUE)

f_childretrieve(tab_sheet.tabpage_sheet01.dw_update_tab,"land_jimok","land_item_opt")	           // 지목 구분						
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update,"land_class","land_opt")	                 // 토지 구분						
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update,"land_jimok","land_item_opt")	           // 지목 구분						
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update,"use_yn","land_use_opt")	           // 사용 구분						

func.of_design_dw(tab_sheet.tabpage_sheet01.dw_update)
tab_sheet.tabpage_sheet01.dw_update.settransobject(sqlca)
tab_sheet.tabpage_sheet01.dw_update.insertrow(0)

f_childretrieve(tab_sheet.tabpage_1.dw_print,"land_jimok","land_item_opt")	      // 지목 구분	

tab_sheet.tabpage_1.dw_print.settransobject(sqlca)
tab_sheet.tabpage_1.dw_print.Object.DataWindow.print.preview = 'YES'

idw_print = tab_sheet.tabpage_1.dw_print

wf_retrieve()

//this.postevent("ue_insert")




end event

event ue_save;call super::ue_save;
long ll_land_seq

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

     idw_name1 = tab_sheet.tabpage_sheet01.dw_update
	   
	  idw_name1.accepttext()	
		
	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN -1
	  
	  SELECT NVL(MAX(LAND_SEQ),0)
	  INTO :ll_land_seq
	  FROM STDB.HST239M   ;
	  
	  idw_name1.object.land_seq[1] = ll_land_seq + 1		 
		 	  
	  string ls_colarry[] = {'land_class/토지구분','land_jimok/지목','land_jibun/지번','use_yn/사용구분','land_area/총면적'}

	  IF f_chk_null( idw_name1, ls_colarry ) = 1 THEN 
		  
		  IF f_update( idw_name1, 'U') = TRUE THEN 

			  wf_setmsg("저장되었습니다")

			  il_getrow = tab_sheet.tabpage_sheet01.dw_update_tab.getrow()
	
			  wf_retrieve()
		  END IF

	  END IF	
	
END CHOOSE		

//f_setpointer('END')

end event

event ue_delete;call super::ue_delete;
ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	   idw_name1 = tab_sheet.tabpage_sheet01.dw_update

	   dwItemStatus l_status 
		l_status = idw_name1.getitemstatus(1, 0, Primary!)
	
		IF l_status = New! OR l_status = NewModified! THEN 
				  
		ELSE
			
			IF f_messagebox( '2', 'DEL' ) = 1 THEN
	
				idw_name1.deleterow(0)
				
				IF f_update( idw_name1,'D') = TRUE THEN 
					wf_setmsg("삭제되었습니다")
					wf_retrieve()
				END IF	
       
	       END IF
		END IF
END CHOOSE		

end event

event ue_print;call super::ue_print;//f_print(tab_sheet.tabpage_1.dw_print)
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
if idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "토지대장")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hss101a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hss101a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hss101a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hss101a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hss101a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hss101a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hss101a
end type

type uc_insert from w_tabsheet`uc_insert within w_hss101a
end type

type uc_delete from w_tabsheet`uc_delete within w_hss101a
end type

type uc_save from w_tabsheet`uc_save within w_hss101a
end type

type uc_excel from w_tabsheet`uc_excel within w_hss101a
end type

type uc_print from w_tabsheet`uc_print within w_hss101a
end type

type st_line1 from w_tabsheet`st_line1 within w_hss101a
end type

type st_line2 from w_tabsheet`st_line2 within w_hss101a
end type

type st_line3 from w_tabsheet`st_line3 within w_hss101a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hss101a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hss101a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hss101a
integer y = 172
integer width = 4384
integer height = 2120
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_1 tabpage_1
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		f_setpointer('START')
//      wf_retrieve()
//		f_setpointer('END')		
//end choose
end event

on tab_sheet.create
this.tabpage_1=create tabpage_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_1)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 2000
long backcolor = 1073741824
string text = "토지 관리"
gb_2 gb_2
dw_update dw_update
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 882
integer y = 4
integer width = 238
integer height = 124
integer taborder = 50
boolean titlebar = true
string title = "조회 내용"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;
//wf_chrow()
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 23
integer y = 36
integer width = 1751
integer height = 1960
boolean titlebar = true
string title = "조회내용"
string dataobject = "d_hss101a_1"
end type

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )
//
long ll_land_seq

this.accepttext()

IF currentrow <> 0 THEN

	ll_land_seq = this.object.land_seq[currentrow]
	
   IF	tab_sheet.tabpage_sheet01.dw_update.retrieve( ll_land_seq ) = 0 THEN
		
		tab_sheet.tabpage_sheet01.dw_update.reset()
		tab_sheet.tabpage_sheet01.dw_update.insertrow(0)
				
   END IF
	
END IF

end event

type uo_tab from w_tabsheet`uo_tab within w_hss101a
integer x = 1134
integer y = 124
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hss101a
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hss101a
boolean visible = false
end type

type gb_2 from groupbox within tabpage_sheet01
integer x = 1787
integer y = 8
integer width = 2555
integer height = 1988
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "토지 내역"
end type

type dw_update from uo_dwfree within tabpage_sheet01
integer x = 1824
integer y = 76
integer width = 2501
integer height = 1896
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hss101a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2000
string text = "토지대장"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_1.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_1.destroy
destroy(this.dw_print)
end on

type dw_print from datawindow within tabpage_1
integer width = 4347
integer height = 2004
integer taborder = 20
string title = "none"
string dataobject = "d_hss101a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;//settransobject(sqlca)
end event

