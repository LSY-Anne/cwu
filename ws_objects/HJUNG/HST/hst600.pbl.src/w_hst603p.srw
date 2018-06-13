$PBExportHeader$w_hst603p.srw
$PBExportComments$경과년수별 종취득 금액별현황
forward
global type w_hst603p from w_msheet
end type
type dw_select from datawindow within w_hst603p
end type
type gb_1 from groupbox within w_hst603p
end type
type dw_print from datawindow within w_hst603p
end type
end forward

global type w_hst603p from w_msheet
dw_select dw_select
gb_1 gb_1
dw_print dw_print
end type
global w_hst603p w_hst603p

type variables
datawindowchild idw_child
String is_sql
end variables

forward prototypes
public function string wf_code_name (string wfs_sect, string wfs_code)
end prototypes

public function string wf_code_name (string wfs_sect, string wfs_code);string ls_code_name

IF ISNULL(wfs_code) OR wfs_code = '' THEN RETURN ''

// 구입 재원이면 'F12', 운용 상태이면 'F11', 비품(품목) 구분 'E01 '

IF len(wfs_sect) = 3 THEN             // 길이가 3 이면 구입재원, 운용 상태, 비품(품목) 구분

	SELECT comm.catcode.code_name1   
	INTO :ls_code_name
	FROM comm.catcode  
	WHERE comm.catcode.code_opt = :wfs_sect AND
			trim(comm.catcode.code) = :wfs_code  ; 
	
END IF

RETURN ls_code_name
end function

on w_hst603p.create
int iCurrent
call super::create
this.dw_select=create dw_select
this.gb_1=create gb_1
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_select
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_print
end on

on w_hst603p.destroy
call super::destroy
destroy(this.dw_select)
destroy(this.gb_1)
destroy(this.dw_print)
end on

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked;;cb_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long		ll_RowCnt, ll_cur_sel_row, ll_row
String 	 ls_statement, ls_gwa_f,ls_gwa_t, ls_new, ls_reve_f,ls_reve_t, ls_oper_f,ls_oper_t
string ls_f_date, ls_t_date, ll_amt_f, ll_amt_t, ls_text1,ls_pur_opt_f,ls_pur_opt_t
string li_item_class_f, li_item_class_t,li_reve_opt_f,li_reve_opt_t
string li_oper_opt_f,li_oper_opt_t,li_edu_opt_f,li_edu_opt_t
Long   ll_pur_opt_f,ll_pur_opt_t

ls_statement = ""
ls_new = ""
//dw_retrieve.reset()
dw_print.reset()

dw_select.accepttext()
ll_cur_sel_row = dw_select.getrow()

															/********* 	구입일자 조건	***********/

	ls_f_date	=	string(dw_select.object.c_eprbymd_f[dw_select.getrow()])
	ls_t_date	=	string(dw_select.object.c_eprbymd_t[dw_select.getrow()])	
if	not isnull(dw_select.object.c_eprbymd_f[dw_select.getrow()])	and	&
	not isnull(dw_select.object.c_eprbymd_t[dw_select.getrow()])  then
	ls_statement +=	" and  A.id_date >= '"+ls_f_date+"' and  A.id_date <= '"+ls_t_date+"'"
end if
															/********* 	사용부서 조건	***********/

	ls_gwa_f	=	string(dw_select.object.c_eprsbus_f[dw_select.getrow()])
	ls_gwa_t	=	string(dw_select.object.c_eprsbus_t[dw_select.getrow()])
if dw_select.object.c_eprsbus_f[dw_select.getrow()] <> "" and &
	dw_select.object.c_eprsbus_t[dw_select.getrow()] <> "" and	&
	not isnull(dw_select.object.c_eprsbus_f[dw_select.getrow()]) and	&
	not isnull(dw_select.object.c_eprsbus_t[dw_select.getrow()])  then
	ls_statement += " and A.gwa >= '"+ls_gwa_f +"'	 and  A.gwa <= '"+ls_gwa_t+"'"	
end if


															/********* 	비품구분 조건	***********/

	li_item_class_f	=	string(dw_select.object.c_eprjpgb_f[dw_select.getrow()])
	li_item_class_t	=	string(dw_select.object.c_eprjpgb_t[dw_select.getrow()])
if	not isnull(dw_select.object.c_eprjpgb_f[dw_select.getrow()]) and	&
	not isnull(dw_select.object.c_eprjpgb_t[dw_select.getrow()]) then
	ls_statement += " and A.item_class >= "+li_item_class_f +" and  A.item_class <= "+li_item_class_t 
end if	


															/********* 금액조건	***********/														
	ll_amt_f	=	string(dw_select.object.c_eprbamt_f[dw_select.getrow()]	)
	ll_amt_t	=	string(dw_select.object.c_eprbamt_t[dw_select.getrow()]		)
if	not isnull(dw_select.object.c_eprbamt_f[dw_select.getrow()]) and	&
	not isnull(dw_select.object.c_eprbamt_t[dw_select.getrow()]) then	
	ls_statement += " and A.purchase_amt >= "+ll_amt_f +"	 and  A.purchase_amt <= "+ll_amt_t
end if	


															

															/********* 구매방법조건	***********/																													

	ls_pur_opt_f	=	String(dw_select.object.c_eprgmae_f[dw_select.getrow()])	
	ls_pur_opt_t	=	String(dw_select.object.c_eprgmae_t[dw_select.getrow()])	
if	not isnull(dw_select.object.c_eprgmae_f[dw_select.getrow()]) and	&
	not isnull(dw_select.object.c_eprgmae_t[dw_select.getrow()]) then
	ls_statement += " and nvl(A.purchase_opt,1) >= " + ls_pur_opt_f + "	 and nvl(A.purchase_opt,1) <= " + ls_pur_opt_t
end if	

															/********* 구입재원조건	***********/														
															
	li_reve_opt_f	=	string(dw_select.object.c_eprjwon_f[dw_select.getrow()])	
	li_reve_opt_t	=	string(dw_select.object.c_eprjwon_t[dw_select.getrow()])		
if	not isnull(dw_select.object.c_eprjwon_f[dw_select.getrow()]) and	&
	not isnull(dw_select.object.c_eprjwon_t[dw_select.getrow()]) then
	ls_statement += " and A.revenue_opt >= "+li_reve_opt_f +"	 and  A.revenue_opt <= "+li_reve_opt_t
end if	

															/********* 운용상태조건  ***********/														
															
	li_oper_opt_f	=	string(dw_select.object.c_epryygb_f[dw_select.getrow()])	
	li_oper_opt_t	=	string(dw_select.object.c_epryygb_t[dw_select.getrow()])		
if	not isnull(dw_select.object.c_epryygb_f[dw_select.getrow()]) and	&
	not isnull(dw_select.object.c_epryygb_t[dw_select.getrow()]) then
	ls_statement += " and A.oper_opt >= "+li_oper_opt_f +"	 and  A.oper_opt <= "+li_oper_opt_t
end if	
															/********* 교육부 기준사항조건  ***********/														
//															
//	li_edu_opt_f	=	string(dw_select.object.c_eprgjun_f[dw_select.getrow()])	
//	li_edu_opt_t	=	string(dw_select.object.c_eprgjun_t[dw_select.getrow()])		
//if	not isnull(dw_select.object.c_eprgjun_f[dw_select.getrow()]) and	&
//	not isnull(dw_select.object.c_eprgjun_t[dw_select.getrow()]) then
//	ls_statement += " and A.edu_basis >= to_number('"+li_edu_opt_f +"')	 and  A.edu_basis <= to_number('"+li_edu_opt_t+"')"			
//end if	


	is_sql = dw_print.getsqlselect()
	
	is_sql = Mid(is_sql, 1, Len(is_sql) - (Len(is_sql) - Pos(is_sql, "group by",500) + 1))
   
	ls_new = is_sql + ls_statement + 'group by (to_char(sysdate,~'yyyy~'))- (substr(a.purchase_date,1,4)), a.revenue_opt'

	dw_print.SetSQLSelect(ls_new)
	dw_print.setredraw(false)
	ll_rowcnt = dw_print.retrieve()
	
	dw_print.SetSQLSelect(is_sql + 'group by  (to_char(sysdate,~'yyyy~'))- (substr(a.purchase_date,1,4)), a.revenue_opt')

	ls_reve_f = dw_select.Describe("Evaluate('LookUpDisplay(c_eprjwon_f) ',  1)")	 	
	ls_reve_t = dw_select.Describe("Evaluate('LookUpDisplay(c_eprjwon_t) ',  1)")	 			
	ls_oper_f = dw_select.Describe("Evaluate('LookUpDisplay(c_epryygb_f) ',  1)")	 	
	ls_oper_t = dw_select.Describe("Evaluate('LookUpDisplay(c_epryygb_t) ',  1)")	
	
	dw_print.object.t_eprbamt_f.text = ll_amt_f
	dw_print.object.t_eprbamt_t.text = ll_amt_t	
//	dw_print.object.t_eprjwon_f.text = li_reve_opt_f	
//	dw_print.object.t_eprjwon_t.text = li_reve_opt_t	
	dw_print.object.t_eprbymd_f.text = ls_f_date	
	dw_print.object.t_eprbymd_t.text = ls_t_date	
//	dw_print.object.t_eprjwon_f.text = ls_reve_f	
//	dw_print.object.t_eprjwon_t.text = ls_reve_t		
//	dw_print.object.t_epryygb_f.text = ls_oper_f
//	dw_print.object.t_epryygb_t.text = ls_oper_t	
	 	
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
	//wf_setmenu('I',FALSE)
	//wf_setmenu('D',FALSE)
	//wf_setmenu('S',FALSE)
	//wf_setmenu('R',TRUE)
	messagebox('알림','자산등재 자료가 존재하지 않습니다.~r~n' + &
					'자산등재 후 사용하시기 바랍니다.')
ELSE
	//wf_setmenu('I',FALSE)
	//wf_setmenu('D',FALSE)
	//wf_setmenu('S',FALSE)
	//wf_setmenu('R',TRUE)
	//wf_setmenu('p',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
END IF
return 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;//f_print(dw_print)
end event

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	기 능 설 명: 화면 open
////	작  성  자 : 이윤호
////	작  성  일 : 2000.05
////	수  정  자 : 
////	수  정  일 : 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
dw_select.settransobject(sqlca)

f_childretrieve(dw_select,"c_eprjpgb_f","item_class")       //물품구분(조회조건) 
f_childretrieve(dw_select,"c_eprjpgb_t","item_class")       //물품구분(조회조건) 
f_childretrieve(dw_select,"c_eprjwon_f","asset_opt")			//구입재원
f_childretrieve(dw_select,"c_eprjwon_t","asset_opt")			//구입재원
f_childretrieve(dw_select,"c_epryygb_f","oper_opt")			//운용구분
f_childretrieve(dw_select,"c_epryygb_t","oper_opt")			//운용구분
f_childretrieve(dw_print, "revenue_opt","revenue_opt")			//물품구분
f_childretrieve(dw_select,"c_eprgmae_f","purchase_opt")		//구매방법
f_childretrieve(dw_select,"c_eprgmae_t","purchase_opt")		//구매방법
		
dw_select.reset()
dw_select.insertrow(0)
dw_select.setitem(1, "c_eprbymd_f", (left(f_today(),4) +mid(f_today(),5,2)+ '01'))
dw_select.setitem(1, "c_eprbymd_t", f_sysdate())

//dw_select.object.c_eprbymd_f[1] = ('19000101')
dw_select.object.c_eprbymd_t[1] = (f_today())
dw_print.Object.DataWindow.zoom = 100
dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = dw_print
this.postevent("ue_init")

end event

event ue_init;call super::ue_init;////////////////////////////////////////////////////////////////////////////////////////////
////	기 능 설 명: 초기화
////	작  성  자 : 이윤호
////	작  성  일 : 2000.05
////	수  정  자 : 
////	수  정  일 : 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
dw_print.reset()
///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성화/비활성화처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setmenu('I',FALSE)		//입력버튼
//wf_setmenu('R',TRUE)			//조회버튼
//wf_setmenu('D',FALSE)		//삭제버튼
//wf_setmenu('S',FALSE)		//저장버튼
//wf_setmenu('P',FALSE)			//인쇄버튼
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "경과연수별 종(점수) 취득금액별 현황")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hst603p
end type

type ln_tempright from w_msheet`ln_tempright within w_hst603p
end type

type ln_temptop from w_msheet`ln_temptop within w_hst603p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst603p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst603p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst603p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst603p
end type

type uc_insert from w_msheet`uc_insert within w_hst603p
end type

type uc_delete from w_msheet`uc_delete within w_hst603p
end type

type uc_save from w_msheet`uc_save within w_hst603p
end type

type uc_excel from w_msheet`uc_excel within w_hst603p
end type

type uc_print from w_msheet`uc_print within w_hst603p
end type

type st_line1 from w_msheet`st_line1 within w_hst603p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hst603p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hst603p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst603p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst603p
end type

type dw_select from datawindow within w_hst603p
integer x = 101
integer y = 200
integer width = 4279
integer height = 184
integer taborder = 20
string title = "none"
string dataobject = "d_hst601p_1"
boolean border = false
boolean livescroll = true
end type

event dberror;return 1
end event

type gb_1 from groupbox within w_hst603p
integer x = 50
integer y = 132
integer width = 4389
integer height = 276
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type dw_print from datawindow within w_hst603p
integer x = 50
integer y = 408
integer width = 4389
integer height = 1876
integer taborder = 60
string title = "none"
string dataobject = "d_hst603p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

