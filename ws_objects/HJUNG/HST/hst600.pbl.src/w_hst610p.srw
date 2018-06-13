$PBExportHeader$w_hst610p.srw
$PBExportComments$출력자료 (엑셀)
forward
global type w_hst610p from w_msheet
end type
type tab_1 from tab within w_hst610p
end type
type tabpage_1 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_1
end type
type rb_3 from radiobutton within tabpage_1
end type
type rb_2 from radiobutton within tabpage_1
end type
type rb_1 from radiobutton within tabpage_1
end type
type rb_gwa from radiobutton within tabpage_1
end type
type rb_id from radiobutton within tabpage_1
end type
type dw_head from datawindow within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_print dw_print
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
rb_gwa rb_gwa
rb_id rb_id
dw_head dw_head
gb_1 gb_1
gb_3 gb_3
end type
type tab_1 from tab within w_hst610p
tabpage_1 tabpage_1
end type
type uo_1 from u_tab within w_hst610p
end type
end forward

global type w_hst610p from w_msheet
tab_1 tab_1
uo_1 uo_1
end type
global w_hst610p w_hst610p

type variables
DataWindow			idw_sname
DataWindowChild	idw_child
end variables

on w_hst610p.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_hst610p.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_open
//	기 능 설 명: 초기화 처리
//	작성/수정자: 윤하영
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 버튼 초기화
//////////////////////////////////////////////////////////////////////////////////////
//wf_setmenu('R',TRUE)
//wf_setmenu('P',TRUE)
		
//////////////////////////////////////////////////////////////////////////////////////
// 2. 자산 조회조건(dw_head) dddw 초기화
//////////////////////////////////////////////////////////////////////////////////////
f_childretrieven(tab_1.tabpage_1.dw_head,"c_dept_code")							//부서
f_childretrieve(tab_1.tabpage_1.dw_head,"c_revenue_opt","asset_opt")			//구입재원
f_childretrieve(tab_1.tabpage_1.dw_head,"c_oper_opt","oper_opt")				//운용구분
f_childretrieven(tab_1.tabpage_1.dw_head,"c_cust_no")								//구입업체
f_childretrieve(tab_1.tabpage_1.dw_head,"c_acct_code","acct_code")	      //계정과목


tab_1.tabpage_1.dw_head.Reset()
tab_1.tabpage_1.dw_head.InsertRow(0)

tab_1.tabpage_1.dw_head.object.c_date_f[1] = Left(f_today(),6) + '01'
tab_1.tabpage_1.dw_head.object.c_date_t[1] = f_today()


//////////////////////////////////////////////////////////////////////////////////////
// 5. 출력용데이타윕도우 dddw 초기화
//////////////////////////////////////////////////////////////////////////////////////
idw_sname = tab_1.tabpage_1.dw_print
idw_print = tab_1.tabpage_1.dw_print

f_childretrieve(idw_sname,"revenue_opt","revenue_opt")	// 구입 재원

f_childretrieve(idw_sname,"oper_opt","oper_opt")			// 운용 구분 

f_childretrieve(idw_sname,"nation_code","kukjuk_code")	// 국가 코드

f_childretrieve(idw_sname,"tool_class","tool_class")			// 기자재설비구분

f_childretrieve(idw_sname,"depr_opt","depr_opt")			// 상각구분


idw_sname.getchild('acct_code',idw_child)
idw_child.SetTransObject(SQLCA)
idw_child.Retrieve('')
//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_init;call super::ue_init;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_init
////	기 능 설 명: 초기화 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////

//wf_setmenu('R',TRUE)
//wf_setmenu('P',TRUE)

////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
// 기    능 : 조회처리
// 작 성 자 : 
// 작 성 일 : 
// 함수원형 : 
// 인    수 : 
// 되 돌 림 : 
//	주의사항 : 
//////////////////////////////////////////////////////////////////////////////////////////
String 	ls_sql, ls_header, ls_gwa_name, ls_room_cd_name,ls_item_class_nm,ls_revenue_opt,ls_operopt_nm
String	ls_revenueopt_nm, ls_useful_nm, ls_purchaseopt_nm,ls_acct_code_nm
String	ls_datefr_nm, ls_dateto_nm
String	ls_roomnm, ls_IdNo_num, ls_manager_nm, ls_cust_nm


IF tab_1.tabpage_1.dw_head.AcceptText() = -1 THEN RETURN -1
//////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
//////////////////////////////////////////////////////////////////////////////////////
String	ls_IdNo	,ls_IdNo_nm			//등재번호
String	ls_ItemNo,ls_ItemNo_nm		//품목코드
String	ls_ItemNm,ls_ItemNm_nm		//품목명
String	ls_Gwa							//부서
String	ls_DateFr						//등재일자(From)
String	ls_DateTo						//등재일자(To)
String	ls_RoomCd						//사용장소
string	ls_useful						//용도구분
String	ls_RevenueOpt					//구입재원
String	ls_OperOpt						//운용구분
String	ls_acct_code					//계정코드
String	ls_manager						//관리자
String	ls_cust_no						//구입업체


ls_IdNo        = TRIM(tab_1.tabpage_1.dw_head.object.c_id_no    [1]) + '%'			//등재번호
ls_IdNo_nm     = TRIM(tab_1.tabpage_1.dw_head.object.c_id_no    [1]) 				//등재번호
ls_ItemNo      = TRIM(tab_1.tabpage_1.dw_head.object.c_item_no  [1]) + '%'			//품목코드
ls_ItemNo_nm   = TRIM(tab_1.tabpage_1.dw_head.object.c_item_no  [1]) 				//품목코드
ls_ItemNm      = TRIM(tab_1.tabpage_1.dw_head.object.c_item_name[1]) + '%'			//품목명
ls_ItemNm_nm   = TRIM(tab_1.tabpage_1.dw_head.object.c_item_name[1]) 				//품목명
ls_Gwa         = TRIM(tab_1.tabpage_1.dw_head.object.c_dept_code[1]) + '%'			//부서
ls_DateFr      = tab_1.tabpage_1.dw_head.object.c_date_f[1]								//등재일자(From)
ls_DateTo      = tab_1.tabpage_1.dw_head.object.c_date_t[1]								//등재일자(To)
ls_RoomCd      = TRIM(tab_1.tabpage_1.dw_head.object.c_room_code     [1]) + '%'	//사용장소
ls_Roomnm      = tab_1.tabpage_1.dw_head.object.c_room_name     [1]					//사용장소
ls_RevenueOpt  = String(tab_1.tabpage_1.dw_head.object.c_revenue_opt [1]) + '%'	//구입재원
ls_OperOpt     = String(tab_1.tabpage_1.dw_head.object.c_oper_opt    [1]) + '%'	//운용구분
ls_acct_code	 	= TRIM(tab_1.tabpage_1.dw_head.object.c_acct_code[1]) + '%'	//계정코드
ls_manager        = TRIM(tab_1.tabpage_1.dw_head.object.c_manager[1]) + '%'		//관리자
ls_manager_nm     = TRIM(tab_1.tabpage_1.dw_head.object.c_manager[1]) 				//관리자
ls_cust_no			= TRIM(tab_1.tabpage_1.dw_head.object.c_cust_no[1]) + '%'		//구입업체
ls_useful	      = trim(tab_1.tabpage_1.dw_head.object.useful  [1]) 				//용도구분
ls_datefr_nm 		= ls_datefr
ls_dateto_nm 		= ls_dateto
ls_room_cd_name = tab_1.tabpage_1.dw_head.Describe("Evaluate('LookUpDisplay(c_room_name) ', 1)")


IF 	isNull(ls_datefr) or  isNull(ls_dateto) THEN 
		
ELSE
		ls_header += 	"등재일자 : "+ls_datefr_nm+"-"+ls_dateto_nm+"  "
END IF

IF 	isNull(ls_IdNo)   THEN 
		ls_IdNo   = '%' 
END IF
IF		isNull(ls_IdNo_NM)	OR ls_IdNo_NM = "" THEN
ELSE
		ls_header += 	"등재번호 : "+ls_IdNo_nm+"  "
END IF
IF 	isNull(ls_ItemNo) THEN 
		ls_ItemNo = '%'
END IF

IF		isnull(ls_ItemNo_nm)	or ls_ItemNo_nm = ""	THEN
ELSE
		ls_header +=	"품목코드 : "+ls_ItemNo_nm+"  "
END IF
IF 	isNull(ls_ItemNm) THEN 
		ls_ItemNm = '%'
END IF
IF		ISNULL(ls_ItemNm_nm)	OR ls_ItemNm_nm=""	THEN
ELSE	
		ls_header +=	"품목명 : "+ls_ItemNm_nm+"  "
END IF

IF 	isNull(ls_Gwa)    THEN 
		ls_Gwa    = '%'
ELSE
		ls_gwa_name = tab_1.tabpage_1.dw_head.Describe("Evaluate('LookUpDisplay(c_dept_code) ', 1)")
		ls_header	+=	"부서 : "+ls_Gwa_name+"  "
END IF	

		string	ls_room
		
		SELECT A.ROOM_NAME_ETC
		INTO  :ls_room
		FROM 	STDB.HST242M A, STDB.HST240M B
		WHERE A.BUIL_NO = B.BUIL_NO
		AND   A.ROOM_NAME =  :ls_room_cd_name
		;
		
IF 	isNull(ls_RoomCd) THEN 
		ls_RoomCd = '%'
ELSE	
		ls_header +=	"사용장소 : "+ls_room_cd_name+"   호실명: "+ls_room+" "
END IF

IF 	isNull(ls_useful)   OR ls_useful   = '0%' THEN 
		ls_useful   = '%'
ELSE
		ls_useful_nm = tab_1.tabpage_1.dw_head.Describe("Evaluate('LookUpDisplay(useful) ', 1)")
		ls_header +=	"용도구분 : "+ls_useful_nm+"  "
END IF	
		
IF 	isNull(ls_RevenueOpt) OR ls_RevenueOpt = '0%' THEN 
		ls_RevenueOpt = '%'
ELSE
		ls_RevenueOpt_nm = tab_1.tabpage_1.dw_head.Describe("Evaluate('LookUpDisplay(c_revenue_opt) ', 1)")
		ls_header +=	"구입재원 : "+ls_RevenueOpt_nm+"  "
END IF	
		
IF 	isNull(ls_OperOpt)    OR ls_OperOpt    = "" THEN 
		ls_OperOpt    = '%'
ELSE		
		ls_OperOpt_nm = tab_1.tabpage_1.dw_head.Describe("Evaluate('LookUpDisplay(c_oper_opt) ', 1)")
		ls_header +=	"운용구분 : "+ls_OperOpt_nm+"  "		
END IF	

IF 	isNull(ls_acct_code) THEN 
		ls_acct_code = '%'
ELSE
		ls_acct_code_nm = tab_1.tabpage_1.dw_head.Describe("Evaluate('LookUpDisplay(c_acct_code) ', 1)")
		ls_header +=	"계정코드 : "+ls_acct_code_nm+"  "			
END IF

IF		isNull(ls_manager) OR ls_manager = "" THEN 
		ls_manager = '%'
END IF	

IF		isNull(ls_manager_nm) OR ls_manager_nm = "" THEN 
ELSE	
		ls_header +=	"관리자 : "+ls_manager_nm+"  "
END IF	

IF		isNull(ls_cust_no) OR ls_cust_no = "" THEN
		ls_cust_no ='%'
ELSE	
		ls_cust_nm = tab_1.tabpage_1.dw_head.Describe("Evaluate('LookUpDisplay(c_cust_no) ', 1)")
		ls_header +=	"구입업체 : "+ls_cust_nm+"  "
END IF	

IF tab_1.tabpage_1.dw_print.Retrieve( ls_IdNo,        & 
																	ls_ItemNo,      &
																	ls_ItemNm,      &
																	ls_Gwa,         &
																	ls_DateFr,      &
																	ls_DateTo,      &
																	ls_RoomCd,      &
																	ls_RevenueOpt,  &
																	ls_OperOpt,     &
																	ls_acct_code,	 &
																	ls_manager,     &	
																	ls_cust_no,		 &
																	ls_useful) = 0 THEN

			wf_setMsg("조회된 데이타가 없습니다")	
				
		ELSE
			//wf_setmenu('P',TRUE)
		END IF
	
//////////////////////////////////////////////////////////////////////////////////////////
// END OF WINDOW FUNCTION
//////////////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_print;call super::ue_print;//IF tab_1.tabpage_1.dw_print.rowcount() <> 0 THEN
//			f_print(tab_1.tabpage_1.dw_print)
//END IF
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hst610p
end type

type ln_tempright from w_msheet`ln_tempright within w_hst610p
end type

type ln_temptop from w_msheet`ln_temptop within w_hst610p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst610p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst610p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst610p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst610p
end type

type uc_insert from w_msheet`uc_insert within w_hst610p
end type

type uc_delete from w_msheet`uc_delete within w_hst610p
end type

type uc_save from w_msheet`uc_save within w_hst610p
end type

type uc_excel from w_msheet`uc_excel within w_hst610p
end type

type uc_print from w_msheet`uc_print within w_hst610p
end type

type st_line1 from w_msheet`st_line1 within w_hst610p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hst610p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hst610p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst610p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst610p
end type

type tab_1 from tab within w_hst610p
integer x = 50
integer y = 176
integer width = 4384
integer height = 2116
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1996
string text = "자산대장"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
rb_gwa rb_gwa
rb_id rb_id
dw_head dw_head
gb_1 gb_1
gb_3 gb_3
end type

on tabpage_1.create
this.dw_print=create dw_print
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.rb_gwa=create rb_gwa
this.rb_id=create rb_id
this.dw_head=create dw_head
this.gb_1=create gb_1
this.gb_3=create gb_3
this.Control[]={this.dw_print,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.rb_gwa,&
this.rb_id,&
this.dw_head,&
this.gb_1,&
this.gb_3}
end on

on tabpage_1.destroy
destroy(this.dw_print)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.rb_gwa)
destroy(this.rb_id)
destroy(this.dw_head)
destroy(this.gb_1)
destroy(this.gb_3)
end on

type dw_print from datawindow within tabpage_1
integer x = 46
integer y = 528
integer width = 4265
integer height = 1444
integer taborder = 40
string title = "none"
string dataobject = "d_hst201a_59_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

event dberror;IF sqldbcode = 1 THEN
	messagebox("확인",'중복된 값이 있습니다.')
	setcolumn(1)
	setfocus()
END IF

RETURN 1
end event

type rb_3 from radiobutton within tabpage_1
integer x = 2075
integer y = 452
integer width = 352
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "불용처분"
end type

event clicked;tab_1.tabpage_1.dw_print.dataobject = 'd_hst610p_6'                 
tab_1.tabpage_1.dw_print.settransobject(sqlca)
tab_1.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
end event

type rb_2 from radiobutton within tabpage_1
integer x = 1792
integer y = 452
integer width = 256
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "전체"
end type

event clicked;tab_1.tabpage_1.dw_print.dataobject = 'd_hst610p_5'                 
tab_1.tabpage_1.dw_print.settransobject(sqlca)
tab_1.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
end event

type rb_1 from radiobutton within tabpage_1
integer x = 1083
integer y = 452
integer width = 603
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "재물조사(사용중)"
end type

event clicked;tab_1.tabpage_1.dw_print.dataobject = 'd_hst610p_3'                 // 재물조사대장
tab_1.tabpage_1.dw_print.settransobject(sqlca)
tab_1.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
end event

type rb_gwa from radiobutton within tabpage_1
integer x = 576
integer y = 452
integer width = 384
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "집기비품"
end type

event clicked;tab_1.tabpage_1.dw_print.dataobject = 'd_hst610p_2'                 // 집기비품
tab_1.tabpage_1.dw_print.settransobject(sqlca)
tab_1.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
end event

type rb_id from radiobutton within tabpage_1
integer x = 155
integer y = 452
integer width = 352
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "기계기구"
end type

event clicked;tab_1.tabpage_1.dw_print.dataobject = 'd_hst610p_1'                 // 기계기구
tab_1.tabpage_1.dw_print.settransobject(sqlca)
tab_1.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
end event

type dw_head from datawindow within tabpage_1
integer x = 50
integer y = 80
integer width = 3721
integer height = 276
integer taborder = 20
string title = "none"
string dataobject = "d_hst609p_1"
boolean border = false
boolean livescroll = true
end type

event dberror;return 1
end event

type gb_1 from groupbox within tabpage_1
integer x = 18
integer y = 12
integer width = 4320
integer height = 380
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회조건"
end type

type gb_3 from groupbox within tabpage_1
integer x = 18
integer y = 400
integer width = 4320
integer height = 1596
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
end type

type uo_1 from u_tab within w_hst610p
event destroy ( )
integer x = 1285
integer y = 144
integer height = 148
integer taborder = 50
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

