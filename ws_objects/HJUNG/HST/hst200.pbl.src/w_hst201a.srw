$PBExportHeader$w_hst201a.srw
$PBExportComments$자산대장(물품관리 카드)
forward
global type w_hst201a from w_msheet
end type
type tab_1 from tab within w_hst201a
end type
type tabpage_1 from userobject within tab_1
end type
type rb_purchase from radiobutton within tabpage_1
end type
type rb_1 from radiobutton within tabpage_1
end type
type rb_class from radiobutton within tabpage_1
end type
type rb_item from radiobutton within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type dw_print1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
rb_purchase rb_purchase
rb_1 rb_1
rb_class rb_class
rb_item rb_item
gb_2 gb_2
dw_print1 dw_print1
end type
type tabpage_2 from userobject within tab_1
end type
type st_2 from statictext within tabpage_2
end type
type sle_id_num from singlelineedit within tabpage_2
end type
type gb_5 from groupbox within tabpage_2
end type
type dw_print2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_2 st_2
sle_id_num sle_id_num
gb_5 gb_5
dw_print2 dw_print2
end type
type tab_1 from tab within w_hst201a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_head1 from datawindow within w_hst201a
end type
type uo_1 from u_tab within w_hst201a
end type
type gb_1 from groupbox within w_hst201a
end type
end forward

global type w_hst201a from w_msheet
tab_1 tab_1
dw_head1 dw_head1
uo_1 uo_1
gb_1 gb_1
end type
global w_hst201a w_hst201a

type variables
int  ii_tab
DataWindowChild	idw_child
DataWindow			idw_sname

end variables

forward prototypes
public subroutine wf_print_child ()
end prototypes

public subroutine wf_print_child ();//////////////////////////////////////////////////////////////////////////////////////////
// 기    능 : 출력용데이타윈도우 dddw초기화
// 작 성 자 : 
// 작 성 일 : 
// 함수원형 : wf_print_child() RETURN NONE
// 인    수 : 
// 되 돌 림 : 
//	주의사항 : 
//////////////////////////////////////////////////////////////////////////////////////////
idw_sname = tab_1.tabpage_1.dw_print1
idw_print = tab_1.tabpage_1.dw_print1

f_childretrieve(idw_sname,"item_class","item_class")		// 물품구분		
f_childretrieve(idw_sname,"revenue_opt","revenue_opt")	// 구입 재원		
f_childretrieve(idw_sname,"oper_opt","oper_opt")			// 운용 구분
f_childretrieve(idw_sname,"purchase_opt","purchase_opt")	// 구매방법
f_childretrieve(idw_sname,"tool_class","tool_class")		// 기자재설비구분
f_childretrieve(idw_sname,"depr_opt","depr_opt")			// 상각구분
f_childretrieve(idw_sname,"nation_code","kukjuk_code")	// 국가코드

idw_sname.getchild('acct_code',idw_child)
idw_child.SetTransObject(SQLCA)
idw_child.Retrieve('')
//////////////////////////////////////////////////////////////////////////////////////////
// END OF WINDOW FUCTION
//////////////////////////////////////////////////////////////////////////////////////////
end subroutine

on w_hst201a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_head1=create dw_head1
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_head1
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_hst201a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_head1)
destroy(this.uo_1)
destroy(this.gb_1)
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
//wf_setmenu('I',TRUE)
//wf_setmenu('R',TRUE)
//wf_setmenu('D',TRUE)
//wf_setmenu('U',TRUE)
		
		
if gstru_uid_uname.uid = 'F0008' then
   dw_head1.Object.c_dept_code.protect = 0
else
	dw_head1.Object.c_dept_code.protect = 1
end if

//////////////////////////////////////////////////////////////////////////////////////
// 2. 자산 조회조건(dw_head1) dddw 초기화
//////////////////////////////////////////////////////////////////////////////////////
f_childretrieven(dw_head1,"c_dept_code")							//부서
f_childretrieve(dw_head1,"c_item_class","item_class")			//물품구분
f_childretrieve(dw_head1,"c_revenue_opt","asset_opt")			//구입재원
f_childretrieve(dw_head1,"c_oper_opt","oper_opt")				//운용구분
f_childretrieve(dw_head1,"c_purchase_opt","purchase_opt")	//구매방법



dw_head1.Reset()
dw_head1.InsertRow(0)

dw_head1.object.c_dept_code[1]	=	gstru_uid_uname.dept_code     //로그인부서

dw_head1.object.c_date_f[1] = Left(f_today(),6) + '01'
dw_head1.object.c_date_t[1] = f_today()

//dw_head1.object.c_acct_date_f[1] = Left(f_today(),6) + '01'
//dw_head1.object.c_acct_date_t[1] = f_today()

//////////////////////////////////////////////////////////////////////////////////////
//3. 출력용데이타윕도우 dddw 초기화
//////////////////////////////////////////////////////////////////////////////////////
wf_print_child()

//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 윤하영
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 자산등재내역 초기화
//////////////////////////////////////////////////////////////////////////////////////////
dw_head1.Reset()
dw_head1.InsertRow(0)
tab_1.tabpage_1.dw_print1.Object.DataWindow.zoom = 100
tab_1.tabpage_1.dw_print1.Object.DataWindow.Print.Preview = 'YES'
tab_1.tabpage_2.dw_print2.Object.DataWindow.zoom = 100
tab_1.tabpage_2.dw_print2.Object.DataWindow.Print.Preview = 'YES'

//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력
////	작성/수정자: 윤하영
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//ii_tab = tab_1.SelectedTab
//
//CHOOSE CASE ii_tab
//	CASE 1
//		IF tab_1.tabpage_1.dw_print1.rowcount() <> 0 THEN
//			f_print(tab_1.tabpage_1.dw_print1)
//		END IF
//	CASE 2
//		IF tab_1.tabpage_2.dw_print2.rowcount() <> 0 THEN
//			f_print(tab_1.tabpage_2.dw_print2)
//		END IF
//END CHOOSE
//
////////////////////////////////////////////////////////////////////////////////////////////
//// END OF SCRIPT
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
String	ls_revenueopt_nm, ls_useful_nm, ls_purchaseopt_nm,ls_datefr_nm, ls_dateto_nm,ls_acct_datefr_nm, ls_acct_dateto_nm
String	ls_roomnm, ls_IdNo_num

//f_setpointer('START')
IF dw_head1.AcceptText() = -1 THEN RETURN -1
//////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
//////////////////////////////////////////////////////////////////////////////////////
String	ls_IdNo	,ls_IdNo_nm			//등재번호
String	ls_ItemNo,ls_ItemNo_nm		//품목코드
String	ls_ItemNm,ls_ItemNm_nm		//품목명
String	ls_Gwa							//부서
String	ls_DateFr						//구입일자(From)
String	ls_DateTo						//구입일자(To)
String	ls_acct_DateFr						//회계일자(From)
String	ls_acct_DateTo						//회계일자(To)
String	ls_RoomCd						//사용장소
String	ls_ItemClss						//물품구분
String	ls_RevenueOpt					//구입재원
String	ls_OperOpt						//운용구분
String	ls_PurchaseOpt					//구매방법
String	ls_Useful						//구분


ls_IdNo        = TRIM(dw_head1.object.c_id_no    [1]) + '%'			//등재번호
ls_IdNo_nm     = TRIM(dw_head1.object.c_id_no    [1]) 				//등재번호
ls_ItemNo      = TRIM(dw_head1.object.c_item_no  [1]) + '%'			//품목코드
ls_ItemNo_nm   = TRIM(dw_head1.object.c_item_no  [1]) 				//품목코드
ls_ItemNm      = TRIM(dw_head1.object.c_item_name[1]) + '%'			//품목명
ls_ItemNm_nm   = TRIM(dw_head1.object.c_item_name[1]) 				//품목명
ls_Gwa         = gstru_uid_uname.dept_code			               //부서
ls_DateFr      = dw_head1.object.c_date_f[1]								//구입일자(From)
ls_DateTo      = dw_head1.object.c_date_t[1]								//구입일자(To)
ls_RoomCd      = TRIM(dw_head1.object.c_room_code     [1]) + '%'	//사용장소
ls_Roomnm      = dw_head1.object.c_room_name     [1]		 + '%'	//사용장소
ls_ItemClss    = String(dw_head1.object.c_item_class  [1]) + '%'	//물품구분
ls_RevenueOpt  = String(dw_head1.object.c_revenue_opt [1]) + '%'	//구입재원
ls_OperOpt     = String(dw_head1.object.c_oper_opt    [1]) + '%'	//운용구분
ls_PurchaseOpt = String(dw_head1.object.c_purchase_opt[1]) + '%'	//구매방법
ls_Useful      = String(dw_head1.object.useful        [1]) + '%'	//구분

ls_datefr_nm = ls_datefr
ls_dateto_nm = ls_dateto

IF 	isNull(ls_datefr) or  isnull(ls_dateto)  THEN 
		 
ELSE
		ls_header += 	"구입일자 : "+ls_datefr_nm+"-"+ls_dateto_nm+"  "
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
		ls_gwa_name = dw_head1.Describe("Evaluate('LookUpDisplay(c_dept_code) ', 1)")
		ls_header	+=	"부서 : "+ls_Gwa_name+"  "
END IF	

string	ls_room
		
		SELECT A.ROOM_NAME_ETC
		INTO  :ls_room
		FROM 	STDB.HST242M A, STDB.HST240M B
		WHERE A.BUIL_NO = B.BUIL_NO
		AND   A.ROOM_NAME =  :ls_room_cd_name
		;
		
IF 	isNull(ls_RoomCd)OR ls_RoomNM = "" THEN 
		ls_RoomCd = '%'
ELSE	
		ls_room_cd_name = dw_head1.Describe("Evaluate('LookUpDisplay(c_room_name) ', 1)")
		ls_header +=	"사용장소 : "+ls_room_cd_name+" 호실명: "+ls_room+" "
		
END IF	
		
IF 	isNull(ls_ItemClss)   OR ls_ItemClss   = '0%' THEN 
		ls_ItemClss   = '%'
ELSE
		ls_item_class_nm = dw_head1.Describe("Evaluate('LookUpDisplay(c_item_class) ', 1)")
		ls_header +=	"물품구분 : "+ls_item_class_nm+"  "
END IF	
		
IF 	isNull(ls_RevenueOpt) OR ls_RevenueOpt = '0%' THEN 
		ls_RevenueOpt = '%'
ELSE
		ls_RevenueOpt_nm = dw_head1.Describe("Evaluate('LookUpDisplay(c_revenue_opt) ', 1)")
		ls_header +=	"구입재원 : "+ls_RevenueOpt_nm+"  "
END IF	
		
IF 	isNull(ls_OperOpt)    OR ls_OperOpt    = '0%' THEN 
		ls_OperOpt    = '%'
ELSE		
		ls_OperOpt_nm = dw_head1.Describe("Evaluate('LookUpDisplay(c_oper_opt) ', 1)")
		ls_header +=	"운용구분 : "+ls_OperOpt_nm+"  "		
END IF	
IF 	isNull(ls_PurchaseOpt) THEN 
		ls_PurchaseOpt = '%'
ELSE
		ls_PurchaseOpt_nm = dw_head1.Describe("Evaluate('LookUpDisplay(c_purchase_opt) ', 1)")
		ls_header +=	"구매방법 : "+ls_PurchaseOpt_nm+"  "			
END IF	
		
IF 	isNull(ls_Useful) OR ls_Useful = '0%' THEN 
		ls_Useful = '%'
ELSE		
		ls_Useful_nm = dw_head1.Describe("Evaluate('LookUpDisplay(useful) ', 1)")
		ls_header +=	"구분 : "+ls_Useful_nm+"  "					
END IF	

ii_tab = tab_1.SelectedTab

CHOOSE CASE ii_tab
	
	CASE 1
		IF tab_1.tabpage_1.dw_print1.Retrieve( ls_IdNo,        &	
		                                             ls_ItemNo,      &
					ls_ItemNm,      &
					ls_Gwa,         &
					ls_DateFr,      &
					ls_DateTo,      &
					ls_RoomCd,      &
					ls_ItemClss,    &
					ls_RevenueOpt,  &
					ls_OperOpt,     &
					ls_PurchaseOpt, &
					ls_Useful  ) = 0 THEN

			wf_setMsg("조회된 데이타가 없습니다")	
			tab_1.tabpage_1.dw_print1.object.t_53.text = ""			
		ELSE

			tab_1.tabpage_1.dw_print1.object.t_53.text = ls_header
			//wf_setmenu('P',TRUE)
		END IF

	
	CASE 2
		ls_IdNo_num = tab_1.tabpage_2.sle_id_num.text
		IF isnull(ls_IdNo_num) OR  ls_IdNo_num = '' THEN
			messagebox('확인','등재번호를 입력하여주시기 바랍니다..!')
		END IF
		
	   ls_gwa = gstru_uid_uname.dept_code			               //부서
		
		Long ll_count
		SELECT COUNT(A.ID_NO)
		INTO   :ll_count
		FROM  stdb.hst027m A
		WHERE A.ID_NO = :ls_IdNo_num
		AND   A.GWA = : ls_gwa ;
		
		IF ll_count = 0 THEN
			messagebox('확인','등재 자료가존재 하지 않습니다..!')
		ELSE
		   IF tab_1.tabpage_2.dw_print2.Retrieve(ls_IdNo_num, ls_gwa) = 0 THEN
			   wf_setMsg("조회된 데이타가 없습니다")	
			   //wf_setmenu('P',TRUE)
		   ELSE
			   //wf_setmenu('P',TRUE)
		   END IF
		  //////////////////////////////////////////////////////////////////////////////////////
//	     //  물품 이미지정보 조회처리
//	     ////////////////////////////////////////////////////////////////////////////////////
			datawindowchild   ldwc_temp

       tab_1.tabpage_2.dw_print2.GetChild('dw_main',ldwc_Temp)
       ldwc_Temp.SetTransObject(SQLCA)
       ldwc_Temp.retrieve(ls_IdNo_num)
		 
		 if ldwc_Temp.rowcount() < 1 then
			messagebox('확인','등재번호가 올바르지 않습니다..!')
			return -1
		 end if
		
		 string  ls_item_no, ls_item_stand_size
		 
		 ls_item_no = ldwc_Temp.getitemstring(1, 'hst027m_item_no')
		 ls_item_stand_size =  ldwc_Temp.getitemstring(1, 'item_stand_size')
		  
		  Int  Li_fileopen, i, j, loops 
		  Long filelen,  ii
	     Blob	lbo_Image, temp_blob
	     string	ls_InsPath, ls_work_date, ls_ext
		  
		  SELECTBLOB	A.ITEM_IMG
	     INTO			:lbo_Image
	     FROM			STDB.HST026h A
	     WHERE			A.item_no = :ls_item_no 
		  AND          A.item_stand_size = :ls_item_stand_size;


			SELECT	TO_CHAR(WORK_DATE,'YYYYMMDD')
			INTO		:ls_work_date
			FROM		STDB.HST026h
			WHERE		item_no = :ls_item_no 
		   AND      item_stand_size = :ls_item_stand_size;
			
//		  messagebox('확인',ls_item_no+':'+ls_item_stand_size)
//		  messagebox('확인',long(lbo_Image))

//			IF SQLCA.SQLCODE <> 0 THEN
//				SetNull(lbo_Image)
//				ldwc_Temp.object.p_item_img.picturename = "../bmp/blank.bmp"
//				ldwc_Temp.Modify("p_item_img.FileName = '..\BMP\BLANK.BMP'")
//			END IF
//				tab_sheet.tabpage_2.p_1.SetPicture(lbo_Image)
//				ldwc_Temp.Modify("p_item_img.FileName = '..\BMP\ITEM.BMP'")
			
			if ls_work_date >= '20070501' then
				ls_ext = 'JPG'
			else
				ls_ext = 'BMP'
			end if
			
			   ls_InsPath = "c:\" //f_rtn_user_info('InstallPath')
			
		     IF SQLCA.SQLCODE = 0 THEN
				
				  FileDelete(ls_InsPath+"BMP\ITEM."+ls_ext)
					
				  filelen = Len(lbo_Image)
			
				  IF filelen > 32765 THEN
					  IF Mod(filelen,32765) = 0 THEN
						  loops = filelen/32765
					  ELSE
						  loops = int(filelen/32765) + 1
					  END IF
				  ELSE
					  loops = 1
				  END IF
			 
					Li_fileopen = FileOpen(ls_InsPath+"BMP\ITEM."+ls_ext, StreamMode!, Write!, LockWrite!, Replace!)
					ii = 1

					  FOR i = 1 TO loops
							IF i = loops THEN
								temp_blob = blobmid(lbo_Image,ii)
							ELSE
								temp_blob = blobmid(lbo_Image,ii,32765)
							END IF
							ii = ii + 32765
						   FileWrite(Li_fileopen, temp_blob)
					  NEXT
		
					 fileclose(Li_fileopen)
		
					  ldwc_Temp.Modify("p_item_img.FileName = '"+ls_InsPath+"BMP\ITEM."+ls_ext+"'")
        Else
	        ldwc_Temp.Modify("p_item_img.FileName = '"+ls_InsPath+"BMP\BLANK.BMP'")
		  END IF


		  //////////////////////////////////자료에 의한 빈로우 체우기////////////
		  int idx
		  long ll_rowcnt

        tab_1.tabpage_2.dw_print2.GetChild('dw_main2',ldwc_Temp)
        ldwc_Temp.SetTransObject(SQLCA)
		  ll_rowcnt = ldwc_Temp.Retrieve(ls_IdNo_num, ls_gwa)	
     
	      for idx = 1 to 4 - ll_rowcnt
	          ldwc_Temp.InsertRow(0)
		   next

        tab_1.tabpage_2.dw_print2.GetChild('dw_main3',ldwc_Temp)
        ldwc_Temp.SetTransObject(SQLCA)
		  ll_rowcnt = ldwc_Temp.Retrieve(ls_IdNo_num, ls_gwa)
		
			for idx = 1 to 3 - ll_rowcnt
	          ldwc_Temp.InsertRow(0)
		   nexT

        tab_1.tabpage_2.dw_print2.GetChild('dw_main4',ldwc_Temp)
        ldwc_Temp.SetTransObject(SQLCA)
		  ll_rowcnt = ldwc_Temp.Retrieve(ls_IdNo_num, ls_gwa)
  
			for idx = 1 to 3 - ll_rowcnt
	          ldwc_Temp.InsertRow(0)
		   next
		END IF
  END CHOOSE
	
ls_sql = tab_1.tabpage_1.dw_print1.getsqlselect()
return 1
//f_setpointer('END')
//////////////////////////////////////////////////////////////////////////////////////////
// END OF WINDOW FUNCTION
//////////////////////////////////////////////////////////////////////////////////////////
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

type ln_templeft from w_msheet`ln_templeft within w_hst201a
end type

type ln_tempright from w_msheet`ln_tempright within w_hst201a
end type

type ln_temptop from w_msheet`ln_temptop within w_hst201a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst201a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst201a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst201a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst201a
end type

type uc_insert from w_msheet`uc_insert within w_hst201a
end type

type uc_delete from w_msheet`uc_delete within w_hst201a
end type

type uc_save from w_msheet`uc_save within w_hst201a
end type

type uc_excel from w_msheet`uc_excel within w_hst201a
end type

type uc_print from w_msheet`uc_print within w_hst201a
end type

type st_line1 from w_msheet`st_line1 within w_hst201a
end type

type st_line2 from w_msheet`st_line2 within w_hst201a
end type

type st_line3 from w_msheet`st_line3 within w_hst201a
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst201a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst201a
end type

type tab_1 from tab within w_hst201a
event create ( )
event destroy ( )
integer x = 50
integer y = 560
integer width = 4384
integer height = 1720
integer taborder = 30
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
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;
CHOOSE CASE newindex
	CASE 1
		idw_print =  tab_1.tabpage_1.dw_print1
	CASE 2
		idw_print =  tab_1.tabpage_2.dw_print2
END CHOOSE

end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1600
string text = "자산대장"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
rb_purchase rb_purchase
rb_1 rb_1
rb_class rb_class
rb_item rb_item
gb_2 gb_2
dw_print1 dw_print1
end type

on tabpage_1.create
this.rb_purchase=create rb_purchase
this.rb_1=create rb_1
this.rb_class=create rb_class
this.rb_item=create rb_item
this.gb_2=create gb_2
this.dw_print1=create dw_print1
this.Control[]={this.rb_purchase,&
this.rb_1,&
this.rb_class,&
this.rb_item,&
this.gb_2,&
this.dw_print1}
end on

on tabpage_1.destroy
destroy(this.rb_purchase)
destroy(this.rb_1)
destroy(this.rb_class)
destroy(this.rb_item)
destroy(this.gb_2)
destroy(this.dw_print1)
end on

type rb_purchase from radiobutton within tabpage_1
integer x = 1280
integer y = 120
integer width = 416
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "구입일자별"
end type

event clicked;
tab_1.tabpage_1.dw_print1.dataobject = 'd_hst201a_9'                 // 사용장소별 
tab_1.tabpage_1.dw_print1.settransobject(sqlca)
tab_1.tabpage_1.dw_print1.Object.DataWindow.Print.Preview = 'YES'
wf_print_child()


end event

type rb_1 from radiobutton within tabpage_1
integer x = 837
integer y = 120
integer width = 407
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "사용장소별"
end type

event clicked;
tab_1.tabpage_1.dw_print1.dataobject = 'd_hst201a_8'                 // 사용장소별 
tab_1.tabpage_1.dw_print1.settransobject(sqlca)
tab_1.tabpage_1.dw_print1.Object.DataWindow.Print.Preview = 'YES'
wf_print_child()


end event

type rb_class from radiobutton within tabpage_1
integer x = 384
integer y = 120
integer width = 416
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "용도구분별"
end type

event clicked;
tab_1.tabpage_1.dw_print1.dataobject = 'd_hst201a_7'                 // 물품 구분 
tab_1.tabpage_1.dw_print1.settransobject(sqlca)
tab_1.tabpage_1.dw_print1.Object.DataWindow.Print.Preview = 'YES'
wf_print_child()
end event

type rb_item from radiobutton within tabpage_1
integer x = 73
integer y = 120
integer width = 288
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "품목별"
boolean checked = true
end type

event clicked;
tab_1.tabpage_1.dw_print1.dataobject = 'd_hst201a_6'                 // 품목별 
tab_1.tabpage_1.dw_print1.settransobject(sqlca)
tab_1.tabpage_1.dw_print1.Object.DataWindow.Print.Preview = 'YES'
wf_print_child()
end event

type gb_2 from groupbox within tabpage_1
integer x = 37
integer y = 40
integer width = 4306
integer height = 176
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "선 택"
end type

type dw_print1 from datawindow within tabpage_1
integer x = 32
integer y = 232
integer width = 4306
integer height = 1368
integer taborder = 21
boolean titlebar = true
string title = "자산대장"
string dataobject = "d_hst201a_6"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1600
string text = "물품관리카드"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
st_2 st_2
sle_id_num sle_id_num
gb_5 gb_5
dw_print2 dw_print2
end type

on tabpage_2.create
this.st_2=create st_2
this.sle_id_num=create sle_id_num
this.gb_5=create gb_5
this.dw_print2=create dw_print2
this.Control[]={this.st_2,&
this.sle_id_num,&
this.gb_5,&
this.dw_print2}
end on

on tabpage_2.destroy
destroy(this.st_2)
destroy(this.sle_id_num)
destroy(this.gb_5)
destroy(this.dw_print2)
end on

type st_2 from statictext within tabpage_2
integer x = 293
integer y = 116
integer width = 261
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "등재번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_id_num from singlelineedit within tabpage_2
integer x = 567
integer y = 100
integer width = 558
integer height = 92
integer taborder = 31
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_5 from groupbox within tabpage_2
integer x = 23
integer y = 16
integer width = 4325
integer height = 224
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "조회조건"
end type

type dw_print2 from datawindow within tabpage_2
integer x = 18
integer y = 252
integer width = 4329
integer height = 1352
integer taborder = 21
boolean titlebar = true
string title = "물품관리카드"
string dataobject = "d_hst201a_34"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_head1 from datawindow within w_hst201a
event ue_keydown pbm_dwnkey
integer x = 87
integer y = 196
integer width = 4306
integer height = 284
integer taborder = 20
string title = "none"
string dataobject = "d_hst201a_50"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;String	ls_room_name
s_uid_uname	ls_middle


THIS.AcceptText()

IF key = KeyEnter! THEN 
	IF THIS.GetColumnName() = 'c_room_name' THEN				// 사용장소
		ls_room_name = THIS.object.c_room_name[1]
		OpenWithParm(w_hgm100h,ls_room_name)
		IF message.stringparm <> '' THEN
			THIS.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
			THIS.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
		END IF
   ELSEIF THIS.GetColumnName() = 'c_item_name' THEN		// 품목명
			ls_middle.uname = this.object.c_item_name[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE

	END IF
END IF
end event

event doubleclicked;String	ls_room_name
s_uid_uname	ls_middle


THIS.AcceptText()

	IF dwo.name = 'c_room_name' THEN				// 사용장소
		ls_room_name = THIS.object.c_room_name[1]
		OpenWithParm(w_hgm100h,ls_room_name)
		IF message.stringparm <> '' THEN
			THIS.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
			THIS.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
		END IF
   ELSEIF dwo.name = 'c_item_name' THEN		// 품목명
			ls_middle.uname = this.object.c_item_name[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
	END IF

end event

event dberror;return 1
end event

event itemchanged;IF dwo.name = 'c_room_name' THEN
	THIS.object.c_room_code[1] = ''
ELSEIF dwo.name = 'c_dept_code' THEN
	Long	li_cnt 
	SELECT	COUNT(*)
	INTO		:li_cnt
	FROM		CDDB.KCH003M
	WHERE		gwa = :data;
	IF li_cnt = 0 OR isnull(li_cnt) THEN
		RETURN -1
	END IF
END IF

end event

type uo_1 from u_tab within w_hst201a
integer x = 1262
integer y = 520
integer height = 148
integer taborder = 30
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type gb_1 from groupbox within w_hst201a
integer x = 50
integer y = 132
integer width = 4384
integer height = 384
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

