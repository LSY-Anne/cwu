$PBExportHeader$w_hst604p.srw
$PBExportComments$기증폐기리스트
forward
global type w_hst604p from w_msheet
end type
type dw_print from cuo_dwprint within w_hst604p
end type
type gb_2 from groupbox within w_hst604p
end type
type dw_head from datawindow within w_hst604p
end type
end forward

global type w_hst604p from w_msheet
string title = "기증 폐기 리스트"
dw_print dw_print
gb_2 gb_2
dw_head dw_head
end type
global w_hst604p w_hst604p

type variables
string is_sql
end variables

on w_hst604p.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.gb_2=create gb_2
this.dw_head=create dw_head
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.dw_head
end on

on w_hst604p.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.gb_2)
destroy(this.dw_head)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 자산 기증 및 폐기 리스트 출력
//    적 성 인 : 윤하영
//		작성일자 : 2002.04.11
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

long ll_row
//wf_setmenu('R',TRUE)

is_sql = dw_print.getsqlselect()
// 장소별 

dw_head.reset()
dw_head.insertrow(0)

f_childretrieve(dw_print,"item_class","item_class")           // 물품구분 
f_childretrieve(dw_print,"revenue_opt","asset_opt")         // 구입재원 


// 물품구분별1 

f_childretrieve(dw_head,"c_item_class_f","item_class")           // 물품구분 
f_childretrieve(dw_head,"c_item_class_t","item_class")           // 물품구분 

// 대 중분류
//datawindowchild dwc
//
//dw_head.Getchild("large_code",dwc)
//dwc.settransobject(sqlca)
//dwc.retrieve() 
//ll_row = dwc.insertrow(0)
//dwc.setitem(ll_row, 'large_code', '0')
//dwc.setitem(ll_row, 'large_name', '없음')
//dwc.setsort('large_code A')
//dwc.sort()
// 구입재원별 

f_childretrieve(dw_head,"c_revenue_opt_f","asset_opt")           // 구입재원
f_childretrieve(dw_head,"c_revenue_opt_t","asset_opt")           // 구입재원

dw_head.reset()
dw_head.insertrow(0)

// 구입일자별   

dw_head.setitem(1, "c_date_f", string(left(f_today(),6) + '01'))
dw_head.setitem(1, "c_date_t", string(f_sysdate(), "yyyymmdd"))

//출력구분
dw_head.setitem(1, "gubun", "1")   //기증

dw_head.setfocus()
dw_head.setcolumn("c_date_f")
dw_print.reset()
idw_print = dw_print
end event

event ue_print;call super::ue_print;//
//ii_tab = tab_sheet.selectedtab
//
//CHOOSE CASE ii_tab
//		
//	CASE 1
//
//     IF tab_sheet.tabpage_sheet01.dw_print_1.rowcount() <> 0 THEN f_print(tab_sheet.tabpage_sheet01.dw_print_1)
//	  
//	CASE 2
//
//     IF tab_sheet.tab_sheet_2.dw_print_2.rowcount() <> 0 THEN f_print(tab_sheet.tab_sheet_2.dw_print_2)  
//	  
//   CASE 3
//
//     IF tab_sheet.tab_sheet_3.dw_print_3.rowcount() <> 0 THEN f_print(tab_sheet.tab_sheet_3.dw_print_3)  
//	  
//	CASE 4
//
//     IF tab_sheet.tab_sheet_4.dw_print_4.rowcount() <> 0 THEN f_print(tab_sheet.tab_sheet_4.dw_print_4)    
//
//END CHOOSE
//
//IF dw_print.rowcount() <> 0 THEN f_print(dw_print)
end event

event ue_retrieve;call super::ue_retrieve;string ls_statement, ls_from, ls_to, ls_new, ls_header, rownumber, ls_text1, ls_text2, ls_text3
string ls_title,ls_from2, ls_to2
long ll_row

dw_head.accepttext()
// 등재일자
IF trim(dw_head.object.c_date_f[1]) <> '' and isnull(dw_head.object.c_date_f[1]) = false then
	ls_from = dw_head.object.c_date_f[1]
	ls_to = dw_head.object.c_date_t[1]
	ls_statement = "AND id_date >= '" + ls_from + "' AND id_date <= '" + ls_to + "'"
	ls_header = "구입일자: " + string(ls_from, "@@@@/@@/@@") + " ~~ " + string(ls_to, "@@@@/@@/@@") + "  "
END IF

// 장소
IF trim(dw_head.object.room_code_f[1]) <> '' and isnull(dw_head.object.room_code_f[1]) = false then
	ls_from = dw_head.object.room_code_f[1]
	ls_to = dw_head.object.room_code_t[1]
	ls_from2 = dw_head.object.c_room_name_f[1]
	ls_to2 = dw_head.object.c_room_name_t[1]
	ls_statement = ls_statement + "~r~n" + & 
	              "AND a.room_code    BETWEEN '" + ls_from + "' AND '" + ls_to + "'"
	ls_header = ls_header + "장소: " + ls_from2 + " ~~ " + ls_to2 + "  "
end if

//물품구분
if trim(dw_head.object.c_item_class_f[1]) <> '' and isnull(dw_head.object.c_item_class_f[1]) = false &
	and dw_head.object.c_item_class_f[1] <> '0' and dw_head.object.c_item_class_t[1] <> '0' then
	ls_from = dw_head.object.c_item_class_f[1]
	ls_to = dw_head.object.c_item_class_t[1]
	
	//DDDW의 display 값을 가져오기 위해...
	rownumber = string(dw_head.getrow())
	ls_text1 = dw_head.Describe("Evaluate('LookUpDisplay(c_item_class_f) ', " + rownumber + ")")
	ls_text2 = dw_head.Describe("Evaluate('LookUpDisplay(c_item_class_t) ', " + rownumber + ")")

	ls_statement = ls_statement + '~r~n' + & 
	              "AND a.ITEM_CLASS >= to_number('" + ls_from + "')  AND a,ITEM_CLASS <= to_number('" + ls_to + "')"
	ls_header = ls_header + "물품구분: " + ls_text1 + " ~~ " + ls_text2 + "  "
END IF

//구입재원
IF trim(dw_head.object.c_revenue_opt_f[1]) <> '' AND isnull(dw_head.object.c_revenue_opt_f[1]) = false &
	and dw_head.object.c_revenue_opt_f[1] <> '0' and dw_head.object.c_revenue_opt_t[1] <> '0' then
	ls_from = dw_head.object.c_revenue_opt_f[1]
	ls_to = dw_head.object.c_revenue_opt_t[1]
	
	//DDDW의 display 값을 가져오기 위해...
	rownumber = string(dw_head.getrow())
	ls_text1 = dw_head.Describe("Evaluate('LookUpDisplay(c_revenue_opt_f) ', " + rownumber + ")")
	ls_text2 = dw_head.Describe("Evaluate('LookUpDisplay(c_revenue_opt_t) ', " + rownumber + ")")
	
	ls_statement = ls_statement + '~r~n' + & 
	              "AND a.REVENUE_OPT >= to_number('" + ls_from + "')  AND a.REVENUE_OPT <= to_number('" + ls_to + "')"
	ls_header = ls_header + "구입재원: " + ls_text1 + " ~~ " + ls_text2 + "  "
END IF
//
////대 중분류
//if trim(dw_head.object.midd_code1[1]) <> '' and isnull(dw_head.object.midd_code1[1]) = false and trim(dw_head.object.midd_code1[1]) <> '0' then
//	ls_from = dw_head.object.large_code[1] + dw_head.object.midd_code1[1]
//	ls_to = dw_head.object.large_code[1] + dw_head.object.midd_code2[1]
//	
//	rownumber = string(dw_head.getrow())
//	ls_text1 = dw_head.Describe("Evaluate('LookUpDisplay(large_code) ', " + rownumber + ")")
//	ls_text2 = dw_head.Describe("Evaluate('LookUpDisplay(midd_code1) ', " + rownumber + ")")
//	ls_text3 = dw_head.Describe("Evaluate('LookUpDisplay(midd_code2) ', " + rownumber + ")")
//	
//	ls_statement = ls_statement + '~r~n' + & 
//	              "AND SUBSTR(ITEM_NO,1,7) >= '" + ls_from + "'  AND SUBSTR(ITEM_NO,1,7) <= '" + ls_to + "'"
//	ls_header = ls_header + "대분류: " + ls_text1 + " 중부류: " + ls_text2 + " ~~ " + ls_text3 + ""
//END IF

//출력구분
if dw_head.object.gubun[1] = "2" then 	//기증
	ls_statement = ls_statement + '~r~n' + & 
	              "AND a.OPER_OPT = 5 "
	ls_title = ' 기증 리스트 '
else													//폐기
	ls_statement = ls_statement + '~r~n' + & 
	              "AND a.OPER_OPT = 3 "
	ls_title = ' 폐기 리스트 '
end if

   is_sql = dw_print.getsqlselect()
   
	ls_new = is_sql + ls_statement
	dw_print.SetSQLSelect(ls_new)
	dw_print.setredraw(false)
	ll_row = dw_print.retrieve()
	
	dw_print.SetSQLSelect(is_sql )
	
IF ll_row > 0 then 
	dw_print.object.t_query.text = ls_header
	dw_print.object.t_1.text = ls_title
else
	dw_print.object.t_query.text = ""
	dw_print.object.t_1.text = '[ 리스트 ]'
end if
dw_print.setredraw(true)

IF ll_row = 0 THEN
	wf_setMsg("조회된 데이타가 없습니다")	
ELSE
	//wf_setmenu('P',TRUE)
END IF	  

return 1
end event

event ue_init;call super::ue_init;dw_head.setredraw(false)
dw_head.reset()
dw_head.insertrow(0)
dw_print.object.t_query.text = ""
dw_head.setitem(1, "c_date_f", string(left(f_today(),6) + '01'))
dw_head.setitem(1, "c_date_t", string(f_sysdate(), "yyyymmdd"))
dw_head.setredraw(true)
dw_head.setcolumn("c_date_f")
dw_head.setitem(1, "gubun", "1")   //폐기
dw_print.reset()
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "기증 폐기 리스트")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hst604p
end type

type ln_tempright from w_msheet`ln_tempright within w_hst604p
end type

type ln_temptop from w_msheet`ln_temptop within w_hst604p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst604p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst604p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst604p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst604p
end type

type uc_insert from w_msheet`uc_insert within w_hst604p
end type

type uc_delete from w_msheet`uc_delete within w_hst604p
end type

type uc_save from w_msheet`uc_save within w_hst604p
end type

type uc_excel from w_msheet`uc_excel within w_hst604p
end type

type uc_print from w_msheet`uc_print within w_hst604p
end type

type st_line1 from w_msheet`st_line1 within w_hst604p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hst604p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hst604p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst604p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst604p
end type

type dw_print from cuo_dwprint within w_hst604p
integer x = 50
integer y = 452
integer width = 4389
integer height = 1844
integer taborder = 30
boolean titlebar = true
string title = "기증 폐기 리스트"
string dataobject = "d_hst604p_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type gb_2 from groupbox within w_hst604p
integer x = 50
integer y = 124
integer width = 4389
integer height = 320
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회 조건"
end type

type dw_head from datawindow within w_hst604p
event ue_keydown pbm_dwnkey
integer x = 87
integer y = 196
integer width = 3200
integer height = 232
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst604p_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
string ls_room_name_f, ls_room_name_t, ls_column

this.accepttext()

IF key = keyenter! THEN 
   
	ls_column = this.getcolumnname()
	
	IF ls_column = 'c_room_name_f' THEN                       // 사용장소
	 
		ls_room_name_f = this.object.c_room_name_f[1]
	
		openwithparm(w_hgm100h,ls_room_name_f)
			
		IF message.stringparm <> '' THEN
	
		   this.object.room_code_f[1] = gstru_uid_uname.s_parm[1]	   
			this.object.room_code_t[1] = gstru_uid_uname.s_parm[1]
			this.object.c_room_name_f[1] = gstru_uid_uname.s_parm[2]	   
			this.object.c_room_name_t[1] = gstru_uid_uname.s_parm[2]
	
		END IF
	
	END IF			
	
	IF ls_column = 'c_room_name_t' THEN                       // 사용장소
	 
		ls_room_name_t = this.object.c_room_name_t[1]
	
		openwithparm(w_hgm100h,ls_room_name_t)
			
		IF message.stringparm <> '' THEN
	
	      this.object.room_code_t[1] = gstru_uid_uname.s_parm[1]	 
			this.object.c_room_name_t[1] = gstru_uid_uname.s_parm[2]	   
	
		END IF
	
	END IF			
	
END IF
end event

event itemchanged;Choose case dwo.name
	case 'c_item_class_f'
		this.object.c_item_class_t[1] = data
	case 'large_code'
		this.object.midd_code1[1] = ""
		this.object.midd_code2[1] = ""
		
		f_childretrieve(this,"midd_code1",data)           // 물품구분 
		f_childretrieve(this,"midd_code2",data)
	case 'midd_code1'
		this.object.midd_code2[1] = data 
	case 'c_revenue_opt_f'
		this.object.c_revenue_opt_t[1] = data
end choose

		
//IF dwo.name = 'c_item_class_f' THEN
//	
//	this.object.c_item_class_t[1] = integer(data)
//	
//END IF	
//
//IF dwo.name = 'large_code' THEN
//	tab_sheet.tab_sheet_5.dw_head_5.object.midd_code1[1] = ""
//	tab_sheet.tab_sheet_5.dw_head_5.object.midd_code2[1] = ""
//	
//	f_childretrieve(tab_sheet.tab_sheet_5.dw_head_5,"midd_code1",data)           // 물품구분 
//	f_childretrieve(tab_sheet.tab_sheet_5.dw_head_5,"midd_code2",data)
//END IF	
//
//IF dwo.name = 'midd_code1' THEN
//	
//	this.object.midd_code1[1] = data
//	
//END IF	
//
//IF dwo.name = 'c_revenue_opt_f' THEN
//	
//	this.object.c_revenue_opt_t[1] = integer(data)
//	
//END IF
end event

event dberror;return 1
end event

