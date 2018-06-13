$PBExportHeader$w_hst605p.srw
$PBExportComments$물품총괄표
forward
global type w_hst605p from w_msheet
end type
type rb_2 from radiobutton within w_hst605p
end type
type rb_1 from radiobutton within w_hst605p
end type
type st_1 from statictext within w_hst605p
end type
type gb_1 from groupbox within w_hst605p
end type
type dw_head from datawindow within w_hst605p
end type
type gb_2 from groupbox within w_hst605p
end type
type dw_print1 from cuo_dwprint within w_hst605p
end type
type dw_print from cuo_dwprint within w_hst605p
end type
end forward

global type w_hst605p from w_msheet
string title = "기증 폐기 리스트"
rb_2 rb_2
rb_1 rb_1
st_1 st_1
gb_1 gb_1
dw_head dw_head
gb_2 gb_2
dw_print1 dw_print1
dw_print dw_print
end type
global w_hst605p w_hst605p

type variables
string is_sql, is_sql_front, is_sql_back
String is_sql_bus, is_sql_front_bus, is_sql_back_bus
end variables

on w_hst605p.create
int iCurrent
call super::create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_1=create st_1
this.gb_1=create gb_1
this.dw_head=create dw_head
this.gb_2=create gb_2
this.dw_print1=create dw_print1
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_2
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_head
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.dw_print1
this.Control[iCurrent+8]=this.dw_print
end on

on w_hst605p.destroy
call super::destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.dw_head)
destroy(this.gb_2)
destroy(this.dw_print1)
destroy(this.dw_print)
end on

event ue_print;call super::ue_print;
//IF 		dw_print.visible = true and 	dw_print.rowcount() = 0 THEN RETURN
//IF 		dw_print1.visible = true and 	dw_print1.rowcount() = 0 THEN RETURN
//
//IF 		dw_print.visible = true and 	dw_print.rowcount() > 0 THEN 
//			f_print(dw_print)
//elseif   dw_print1.visible = true and 	dw_print1.rowcount() > 0 THEN 
//			f_print(dw_print1)	
//end if	
//


//openwithparm(w_print, dw_retrieve)
end event

event ue_retrieve;call super::ue_retrieve;
////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked;;cb_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////

Long ll_RowCnt, ll_item_class_f, ll_item_class_t
String  ls_fr_date, ls_to_date, ls_fr_gwa, ls_to_gwa
long  ll_purchase_amt_f, ll_purchase_amt_t, ll_purchase_opt_f, ll_purchase_opt_t
Long  ll_grp_2_f, ll_grp_2_t, ll_grp_1_f, ll_grp_1_t, ll_edu_basis_f, ll_edu_basis_t 
  // 기간 
ls_fr_date = dw_head.object.c_eprbymd_f[1] 
IF isnull(ls_fr_date) OR ls_fr_date ='' THEN
	ls_fr_date = '00000000'
ELSE 
	ls_fr_date = dw_head.object.c_eprbymd_f[1] 
END IF
ls_to_date = dw_head.object.c_eprbymd_t[1] 
IF isnull(ls_to_date) OR ls_to_date ='' THEN
	ls_to_date = '99999999'
ELSE 
	ls_to_date = dw_head.object.c_eprbymd_t[1] 
END IF
  // 부서 
  ls_fr_gwa = dw_head.object.c_eprsbus_f[1]
IF isnull(ls_fr_gwa) OR  ls_fr_gwa = ''  THEN
   ls_fr_gwa = '0000'
ELSE 
   ls_fr_gwa = dw_head.object.c_eprsbus_f[1]
END IF
ls_to_gwa = dw_head.object.c_eprsbus_t[1]
IF isnull(ls_to_gwa) OR  ls_to_gwa = ''  THEN
   ls_to_gwa = 'zzzz'
ELSE 
   ls_to_gwa = dw_head.object.c_eprsbus_t[1]
END IF
  //물품구분
  ll_item_class_f = dw_head.object.c_eprjpgb_f[1]
IF isnull(ll_item_class_f) OR ll_item_class_f = 0 THEN
   ll_item_class_f = 0
ELSE 
   ll_item_class_f = dw_head.object.c_eprjpgb_f[1]
END IF
ll_item_class_t = dw_head.object.c_eprjpgb_t[1]
IF isnull(ll_item_class_t) OR ll_item_class_t = 0 THEN
   ll_item_class_t = 99
ELSE 
   ll_item_class_t = dw_head.object.c_eprjpgb_t[1]
END IF
  // 구입금액
   ll_purchase_amt_f = dw_head.object.c_eprbamt_f[1]
IF isnull(ll_purchase_amt_f) OR ll_purchase_amt_f = 0 THEN
   ll_purchase_amt_f = 0000000000
ELSE 
   ll_purchase_amt_f = dw_head.object.c_eprbamt_f[1]
END IF
ll_purchase_amt_t = dw_head.object.c_eprbamt_f[1]
IF isnull(ll_purchase_amt_t) OR ll_purchase_amt_t = 0 THEN
   ll_purchase_amt_t = 2000000000
ELSE 
   ll_purchase_amt_t = dw_head.object.c_eprbamt_f[1]
END IF
//   구입방법
  ll_purchase_opt_f = dw_head.object.c_eprgmae_f[1]
IF isnull(ll_purchase_opt_f) OR ll_purchase_opt_f = 0 THEN
   ll_purchase_opt_f = 0
ELSE 
   ll_purchase_opt_f = dw_head.object.c_eprgmae_f[1]
END IF
ll_purchase_opt_t = dw_head.object.c_eprgmae_t[1]
IF isnull(ll_purchase_opt_t) OR ll_purchase_opt_t = 0   THEN
   ll_purchase_opt_t = 99
ELSE 
   ll_purchase_opt_t = dw_head.object.c_eprgmae_t[1]
END IF
  // 구입재원
  ll_grp_2_f = dw_head.object.c_eprjwon_f[1]
IF isnull(ll_grp_2_f) OR ll_grp_2_f = 0  THEN
   ll_grp_2_f = 0
ELSE 
   ll_grp_2_f = dw_head.object.c_eprjwon_f[1]
END IF
ll_grp_2_t = dw_head.object.c_eprjwon_t[1]
IF isnull(ll_grp_2_t) OR ll_grp_2_t = 0 THEN
   ll_grp_2_t = 99
ELSE 
   ll_grp_2_t = dw_head.object.c_eprjwon_t[1]
END IF
  // 운용 상태
  ll_grp_1_f = dw_head.object.c_epryygb_f[1]
IF isnull(ll_grp_1_f) OR ll_grp_1_f = 0 THEN
   ll_grp_1_f = 0
ELSE 
   ll_grp_1_f = dw_head.object.c_epryygb_f[1]
END IF
ll_grp_1_t = dw_head.object.c_epryygb_t[1]
IF isnull(ll_grp_1_t) OR ll_grp_1_t = 0 THEN
   ll_grp_1_t = 99
ELSE 
   ll_grp_1_t = dw_head.object.c_epryygb_t[1]
END IF
  // 교육부 지준
//IF isnull(ls_edu_basis_f) OR ls_edu_basis_f = '' THEN
//   ls_edu_basis_f = '0'
//ELSE 
//   ls_edu_basis_f = dw_head.object.c_eprgjun_f[1]
//END IF
//IF isnull(ls_edu_basis_t) OR ls_edu_basis_t = '' THEN
//   ls_edu_basis_t = '9'
//ELSE 
//   ls_edu_basis_t = dw_head.object.c_eprgjun_t[1]
//END IF

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
IF dw_print.visible 	= True THEN
   dw_print.SetReDraw(false)
   dw_print.reset()
   ll_RowCnt = dw_print.Retrieve(ls_fr_date, ls_to_date, ls_fr_gwa, ls_to_gwa, ll_item_class_f, ll_item_class_t, &
                              ll_purchase_amt_f, ll_purchase_amt_t, ll_purchase_opt_f, ll_purchase_opt_t, &
										ll_grp_2_f, ll_grp_2_t, ll_grp_1_f, ll_grp_1_t )

   dw_print.SetReDraw(TRUE)
ELSE
	dw_print1.SetReDraw(false)
   dw_print1.reset()
   ll_RowCnt = dw_print1.Retrieve(ls_fr_date, ls_to_date, ls_fr_gwa, ls_to_gwa, ll_item_class_f, ll_item_class_t, &
                              ll_purchase_amt_f, ll_purchase_amt_t, ll_purchase_opt_f, ll_purchase_opt_t, &
										ll_grp_2_f, ll_grp_2_t, ll_grp_1_f, ll_grp_1_t )
   dw_print1.SetReDraw(TRUE)
END IF


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
	wf_SetMsg('자료가 조회되었습니다.')

END IF
return 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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
//wf_setmenu('I',FALSE)	//입력버튼
//wf_setmenu('R',TRUE)		//조회버튼
//wf_setmenu('D',FALSE)	//삭제버튼
//wf_setmenu('S',FALSE)	//저장버튼
//wf_setmenu('P',TRUE)		//인쇄버튼
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_open;call super::ue_open;
////////////////////////////////////////////////////////////////////////////////////////////
////	기 능 설 명: 오픈시 처리
////	작  성  자 : 이윤호
////	작  성  일 : 2000.05
////	수  정  자 : 
////	수  정  일 : 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
dw_head.settransobject(sqlca)


f_childretrieve(dw_head,"c_eprjpgb_f","item_class")       //물품구분(조회조건) 
f_childretrieve(dw_head,"c_eprjpgb_t","item_class")       //물품구분(조회조건) 
f_childretrieve(dw_head,"c_eprjwon_f","asset_opt")			//구입재원
f_childretrieve(dw_head,"c_eprjwon_t","asset_opt")			//구입재원
f_childretrieve(dw_head,"c_epryygb_f","oper_opt")			//운용구분
f_childretrieve(dw_head,"c_epryygb_t","oper_opt")			//운용구분
f_childretrieve(dw_head,"c_eprgmae_f","purchase_opt")		//구매방법
f_childretrieve(dw_head,"c_eprgmae_t","purchase_opt")		//구매방법

f_childretrieve(dw_print,"grp_2","asset_opt")				//구입재원
f_childretrieve(dw_print,"grp_1","oper_opt")					//운용구분

f_childretrieve(dw_print1,"grp_2","asset_opt")				//구입재원
f_childretrieve(dw_print1,"grp_1","oper_opt")					//운용구분

dw_head.reset()
dw_head.insertrow(0)


dw_head.object.c_eprbymd_f[1] =  left(f_today(),6)+'01'
dw_head.object.c_eprbymd_t[1] =  f_today()
this.postevent("ue_init")

idw_print = dw_print
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', idw_print.title)
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hst605p
end type

type ln_tempright from w_msheet`ln_tempright within w_hst605p
end type

type ln_temptop from w_msheet`ln_temptop within w_hst605p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst605p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst605p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst605p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst605p
end type

type uc_insert from w_msheet`uc_insert within w_hst605p
end type

type uc_delete from w_msheet`uc_delete within w_hst605p
end type

type uc_save from w_msheet`uc_save within w_hst605p
end type

type uc_excel from w_msheet`uc_excel within w_hst605p
end type

type uc_print from w_msheet`uc_print within w_hst605p
end type

type st_line1 from w_msheet`st_line1 within w_hst605p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hst605p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hst605p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst605p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst605p
end type

type rb_2 from radiobutton within w_hst605p
integer x = 3319
integer y = 200
integer width = 389
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "업무용"
end type

event clicked;dw_print1.visible 	= True
dw_print.visible 		= False
idw_print = dw_print1
end event

type rb_1 from radiobutton within w_hst605p
integer x = 2821
integer y = 200
integer width = 352
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "교육용"
boolean checked = true
boolean lefttext = true
end type

event clicked;dw_print.visible 	= True
dw_print1.visible = False
idw_print = dw_print
end event

type st_1 from statictext within w_hst605p
integer x = 2665
integer y = 196
integer width = 146
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "용도"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hst605p
integer x = 2811
integer y = 160
integer width = 969
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
end type

type dw_head from datawindow within w_hst605p
event ue_keydown pbm_dwnkey
integer x = 64
integer y = 184
integer width = 3744
integer height = 176
integer taborder = 20
string title = "none"
string dataobject = "d_hst601p_1"
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
	
		
			this.object.c_room_name_f[1] = gstru_uid_uname.s_parm[2]	   
			this.object.c_room_name_t[1] = gstru_uid_uname.s_parm[2]
	
		END IF
	
	END IF			
	
	IF ls_column = 'c_room_name_t' THEN                       // 사용장소
	 
		ls_room_name_t = this.object.c_room_name_t[1]
	
		openwithparm(w_hgm100h,ls_room_name_t)
			
		IF message.stringparm <> '' THEN
	
			this.object.c_room_name_t[1] = gstru_uid_uname.s_parm[2]	   
	
		END IF
	
	END IF			
	
END IF
end event

event itemchanged;
//Choose case dwo.name
//	case 'c_item_class_f'
//		this.object.c_item_class_t[1] = data
//	case 'large_code'
//		this.object.midd_code1[1] = ""
//		this.object.midd_code2[1] = "" 
//		
//		f_childretrieve(this,"midd_code1",data)           // 물품구분 
//		f_childretrieve(this,"midd_code2",data)
//	case 'midd_code1'
//		this.object.midd_code2[1] = data 
//	case 'c_revenue_opt_f'
//		this.object.c_revenue_opt_t[1] = data
//end choose
//
		
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

type gb_2 from groupbox within w_hst605p
integer x = 46
integer y = 124
integer width = 4393
integer height = 272
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

type dw_print1 from cuo_dwprint within w_hst605p
boolean visible = false
integer x = 50
integer y = 400
integer width = 4384
integer height = 1876
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "총괄표(업무용)"
string dataobject = "d_hst605p_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type dw_print from cuo_dwprint within w_hst605p
integer x = 50
integer y = 400
integer width = 4384
integer height = 1876
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "총괄표(교육용)"
string dataobject = "d_hst605p_111"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

