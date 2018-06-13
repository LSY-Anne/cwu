$PBExportHeader$w_hst201i_1.srw
$PBExportComments$자산등재
forward
global type w_hst201i_1 from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type dw_head2 from cuo_dwwindow within tabpage_sheet01
end type
type cb_1 from commandbutton within tabpage_sheet01
end type
type dw_list from cuo_dwwindow within tabpage_sheet01
end type
type rb_2 from radiobutton within tabpage_sheet01
end type
type rb_3 from radiobutton within tabpage_sheet01
end type
type cb_2 from commandbutton within tabpage_sheet01
end type
type st_1 from statictext within tabpage_sheet01
end type
type dw_update1 from cuo_dwwindow within tabpage_sheet01
end type
type tab_sheet_2 from userobject within tab_sheet
end type
type dw_print1 from cuo_dwprint within tab_sheet_2
end type
type gb_2 from groupbox within tab_sheet_2
end type
type rb_1 from radiobutton within tab_sheet_2
end type
type rb_purchase from radiobutton within tab_sheet_2
end type
type rb_class from radiobutton within tab_sheet_2
end type
type rb_item from radiobutton within tab_sheet_2
end type
type tab_sheet_2 from userobject within tab_sheet
dw_print1 dw_print1
gb_2 gb_2
rb_1 rb_1
rb_purchase rb_purchase
rb_class rb_class
rb_item rb_item
end type
type tab_sheet_3 from userobject within tab_sheet
end type
type dw_print2 from cuo_dwprint within tab_sheet_3
end type
type tab_sheet_3 from userobject within tab_sheet
dw_print2 dw_print2
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print3 from cuo_dwwindow_one_hin within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print3 dw_print3
end type
type tabpage_2 from userobject within tab_sheet
end type
type sle_id_num from singlelineedit within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type dw_print4 from cuo_dwwindow_one_hin within tabpage_2
end type
type gb_5 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_sheet
sle_id_num sle_id_num
st_2 st_2
dw_print4 dw_print4
gb_5 gb_5
end type
type dw_head1 from datawindow within w_hst201i_1
end type
type gb_6 from groupbox within w_hst201i_1
end type
type gb_3 from groupbox within w_hst201i_1
end type
end forward

global type w_hst201i_1 from w_tabsheet
string title = "자산등재"
dw_head1 dw_head1
gb_6 gb_6
gb_3 gb_3
end type
global w_hst201i_1 w_hst201i_1

type variables
Integer	ii_tab
Long		il_getrow = 1
DataWindowChild	idw_child
DataWindow			idw_sname

n_tty  u_tty
Long  li_row
end variables

forward prototypes
public function boolean wf_qty_chk ()
public subroutine wf_setmenubtn (string as_type)
public subroutine wf_ml_name (string wfs_item_no)
public subroutine wf_print_child ()
public subroutine wf_retrieve ()
public subroutine wf_save ()
public subroutine wf_insert ()
end prototypes

public function boolean wf_qty_chk ();//////////////////////////////////////////////////////////////////////////////////////////
// 기    능 : 등재수량,잔량 체크
// 작 성 자 : 
// 작 성 일 : 
// 함수원형 : wf_print_child() RETURN NONE
// 인    수 : 
// 되 돌 림 : 
//	주의사항 : 
//////////////////////////////////////////////////////////////////////////////////////////
Long		ll_jan

Long		ll_j_in_qty

IF tab_sheet.tabpage_sheet01.dw_head2.AcceptText() = -1 THEN RETURN FALSE
IF tab_sheet.tabpage_sheet01.dw_head2.Object.in_no[1] = 0 THEN RETURN FALSE

ll_jan = tab_sheet.tabpage_sheet01.dw_head2.object.jan_qty[1]			// 등재 잔량 
ll_j_in_qty = tab_sheet.tabpage_sheet01.dw_head2.object.j_in_qty[1]	// 등재 수량

IF ll_jan < ll_j_in_qty THEN 
	RETURN FALSE
ELSE	
	RETURN TRUE
END IF

//////////////////////////////////////////////////////////////////////////////////////////
// END OF WINDOW FUCTION
//////////////////////////////////////////////////////////////////////////////////////////
end function

public subroutine wf_setmenubtn (string as_type);//입력
////저장
////삭제
////조회
////검색
//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN lb_Value = TRUE
//	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
//	
//	CHOOSE CASE ls_Flag[li_idx]
//		CASE 'I' ;ib_insert   = lb_Value
//		CASE 'S' ;ib_update   = lb_Value
//		CASE 'D' ;ib_delete   = lb_Value
//		CASE 'R' ;ib_retrieve = lb_Value
//		CASE 'P' ;ib_print    = lb_Value
//		CASE 'P' ;ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

public subroutine wf_ml_name (string wfs_item_no);//////////////////////////////////////////////////////////////////////////////////////////
// 기    능 : 품목코드의 대분류,중분류명 셋팅
// 작 성 자 : 
// 작 성 일 : 
// 함수원형 : wf_ml_name( String wfs_item_no ) RETURN NONE
// 인    수 : wfs_item_no - 품목코드
// 되 돌 림 : 
//	주의사항 : 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_MiddNm
String	ls_LargeNm

gstru_uid_uname.s_parm[11] = ''
gstru_uid_uname.s_parm[12] = ''

IF isNull(wfs_item_no) OR wfs_item_no = '' THEN RETURN 

SELECT	B.MIDD_NAME,
			C.LARGE_NAME
INTO		:ls_MiddNm,
			:ls_LargeNm
FROM		STDB.HST004M	A,
			STDB.HST003M	B,
			STDB.HST002M	C
WHERE		A.ITEM_MIDDLE             = B.ITEM_MIDDLE(+)
AND		SUBSTR(A.ITEM_MIDDLE,1,2) = C.LARGE_CODE(+)
AND		A.ITEM_NO                 = :wfs_item_no;
		
gstru_uid_uname.s_parm[11] = ls_MiddNm
gstru_uid_uname.s_parm[12] = ls_LargeNm
//////////////////////////////////////////////////////////////////////////////////////////
// END OF WINDOW FUCTION
//////////////////////////////////////////////////////////////////////////////////////////
end subroutine

public subroutine wf_print_child ();//////////////////////////////////////////////////////////////////////////////////////////
// 기    능 : 출력용데이타윈도우 dddw초기화
// 작 성 자 : 
// 작 성 일 : 
// 함수원형 : wf_print_child() RETURN NONE
// 인    수 : 
// 되 돌 림 : 
//	주의사항 : 
//////////////////////////////////////////////////////////////////////////////////////////
idw_sname = tab_sheet.tab_sheet_2.dw_print1

f_childretrieve(idw_sname,"item_class","item_class")		// 물품구분				
f_childretrieve(idw_sname,"revenue_opt","revenue_opt")	// 구입 재원				
f_childretrieve(idw_sname,"oper_opt","oper_opt")			// 운용 구분 
f_childretrieve(idw_sname,"purchase_opt","purchase_opt")	// 구매방법	
f_childretrieve(idw_sname,"tool_class","tool_class")		// 기자재설비구분
f_childretrieve(idw_sname,"depr_opt","depr_opt")			// 상각구분

idw_sname.getchild('acct_code',idw_child)
idw_child.SetTransObject(SQLCA)
idw_child.Retrieve('')
//////////////////////////////////////////////////////////////////////////////////////////
// END OF WINDOW FUCTION
//////////////////////////////////////////////////////////////////////////////////////////
end subroutine

public subroutine wf_retrieve ();//////////////////////////////////////////////////////////////////////////////////////////
// 기    능 : 조회처리
// 작 성 자 : 
// 작 성 일 : 
// 함수원형 : wf_retrieve() RETURN NONE
// 인    수 : 
// 되 돌 림 : 
//	주의사항 : 
//////////////////////////////////////////////////////////////////////////////////////////
String 	ls_sql, ls_header, ls_gwa_name, ls_room_cd_name,ls_item_class_nm,ls_revenue_opt,ls_operopt_nm
String	ls_revenueopt_nm, ls_useful_nm, ls_purchaseopt_nm,ls_datefr_nm, ls_dateto_nm,ls_acct_datefr_nm, ls_acct_dateto_nm
String	ls_roomnm, ls_IdNo_num


IF dw_head1.AcceptText() = -1 THEN RETURN
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
ls_Gwa         = TRIM(dw_head1.object.c_dept_code[1]) + '%'			//부서
ls_DateFr      = dw_head1.object.c_date_f[1]								//구입일자(From)
ls_DateTo      = dw_head1.object.c_date_t[1]								//구입일자(To)
ls_acct_DateFr = dw_head1.object.c_acct_date_f[1]						//회계일자(From)
ls_acct_DateTo = dw_head1.object.c_acct_date_t[1]						//회계일자(To)
ls_RoomCd      = TRIM(dw_head1.object.c_room_code     [1]) + '%'	//사용장소
ls_Roomnm      = dw_head1.object.c_room_name     [1]		 + '%'	//사용장소
ls_ItemClss    = String(dw_head1.object.c_item_class  [1]) + '%'	//물품구분
ls_RevenueOpt  = String(dw_head1.object.c_revenue_opt [1]) + '%'	//구입재원
ls_OperOpt     = String(dw_head1.object.c_oper_opt    [1]) + '%'	//운용구분
ls_PurchaseOpt = String(dw_head1.object.c_purchase_opt[1]) + '%'	//구매방법
ls_Useful      = String(dw_head1.object.useful        [1]) + '%'	//구분


//ls_datefr 	 = string(ls_datefr,'yyyymmdd')
ls_datefr_nm = ls_datefr
//ls_dateto 	 = string(ls_dateto,'yyyymmdd')
ls_dateto_nm = ls_dateto

//ls_acct_datefr 	 = string(ls_acct_datefr,'yyyymmdd')
ls_acct_datefr_nm  = ls_acct_datefr
//ls_acct_dateto 	 = string(ls_acct_dateto,'yyyymmdd')
ls_acct_dateto_nm  = ls_acct_dateto

IF 	isNull(ls_datefr) or  isnull(ls_dateto)  THEN 
		 
ELSE
		ls_header += 	"구입일자 : "+ls_datefr_nm+"-"+ls_dateto_nm+"  "
END IF	

IF 	isNull(ls_acct_datefr) or  isnull(ls_acct_dateto)  THEN 
		 
ELSE
		ls_header += 	"회계일자 : "+ls_acct_datefr_nm+"-"+ls_acct_dateto_nm+"  "
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
IF 	isNull(ls_RoomCd) THEN 
		ls_RoomCd = '%'
END IF
IF		isNull(ls_RoomNM) OR ls_RoomNM = ""THEN 
		
ELSE	
		ls_room_cd_name = dw_head1.Describe("Evaluate('LookUpDisplay(c_room_name) ', 1)")
		ls_header +=	"사용장소 : "+ls_room_cd_name+"  "
		
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

ii_tab = tab_sheet.SelectedTab

CHOOSE CASE ii_tab
	CASE 1
		IF tab_sheet.tabpage_sheet01.dw_update.Retrieve(ls_IdNo,        & 
																		ls_ItemNo,      &
																		ls_ItemNm,      &
																		ls_Gwa,         &
																		ls_RoomCd,      &																																		
																		ls_ItemClss,    &
																		ls_RevenueOpt,  &
																		ls_OperOpt,     &
																		ls_PurchaseOpt, &
																		ls_Useful	  , &
																		ls_DateFr,      &
																		ls_DateTo,      &	
																		ls_acct_DateFr, &
																		ls_acct_DateTo       ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")
		ELSE
			tab_sheet.tabpage_sheet01.dw_head2.reset()
			tab_sheet.tabpage_sheet01.dw_head2.insertrow(0)
			tab_sheet.tabpage_sheet01.dw_head2.object.in_date[1] = f_today()

		END IF
	CASE 2
		// 선택 추가 
		String	ls_sort
		ls_sort = tab_sheet.tabpage_sheet01.dw_update.Object.datawindow.table.sort
		
//		IF isNull(ls_sort) = FALSE AND ls_sort <> "" THEN
//			tab_sheet.tab_sheet_2.dw_print1.setsort(ls_sort)
//		END IF

		IF tab_sheet.tab_sheet_2.dw_print1.Retrieve( ls_IdNo,        &	
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
			tab_sheet.tab_sheet_2.dw_print1.object.t_53.text = ""			
		ELSE

			tab_sheet.tab_sheet_2.dw_print1.object.t_53.text = ls_header
			//wf_setmenu('P',TRUE)
		END IF

	CASE 3
		IF tab_sheet.tab_sheet_3.dw_print2.Retrieve(	ls_IdNo,        &
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
																	ls_Useful ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			tab_sheet.tab_sheet_2.dw_print1.object.t_5.text = ""
		ELSE
			//wf_setmenu('P',TRUE)
			tab_sheet.tab_sheet_2.dw_print1.object.t_5.text = ls_header		
long		ll_cnt, ll_amt

			
			SELECT	COUNT( DISTINCT A.ITEM_NO),SUM( DISTINCT A.PURCHASE_AMT)		
			INTO		:ll_cnt, :ll_amt
			FROM		STDB.HST027MV	A,
						STDB.HST028H	B,
						STDB.HST004M	C
			WHERE		A.ID_NO      = B.ID_NO
			AND		A.ITEM_CLASS = B.ITEM_CLASS
			AND		B.ITEM_NO    = C.ITEM_NO
			AND		A.ID_NO         LIKE :ls_idno
			AND  		A.ITEM_NO   LIKE :ls_itemno
			AND		A.ITEM_NAME     LIKE :ls_itemnm
			AND		A.GWA           LIKE :ls_gwa
			AND		B.ITEM_SUB_DATE >= :ls_datefr
			AND		B.ITEM_SUB_DATE <= :ls_dateto
			AND		A.ROOM_CODE                 LIKE :ls_roomcd
			AND		TO_CHAR(A.ITEM_CLASS)       LIKE :ls_itemclss
			AND		TO_CHAR(A.REVENUE_OPT)      LIKE :ls_revenueopt
			AND		TO_CHAR(A.OPER_OPT)         LIKE :ls_operopt
			AND		TO_CHAR(A.PURCHASE_OPT)     LIKE :ls_purchaseopt
			AND		NVL(TO_CHAR(A.USEFUL), ' ') LIKE :ls_useful	;			
//			tab_sheet.tab_sheet_3.dw_print2.object.t_14.text		=	string(ll_cnt,'#,###,##0'	)
//			tab_sheet.tab_sheet_3.dw_print2.object.t_15.text		=	string(ll_amt,'#,###,##0')		
//			tab_sheet.tab_sheet_3.dw_print2.object.t_16.text		=	string(ll_cnt + tab_sheet.tab_sheet_3.dw_print2.object.compute_2[1],'#,###,##0')		
//			tab_sheet.tab_sheet_3.dw_print2.object.t_17.text		=	string(ll_amt + tab_sheet.tab_sheet_3.dw_print2.object.compute_4[1],'#,###,##0')		
		END IF
		
	CASE 4
		IF tab_sheet.tabpage_1.dw_print3.Retrieve( ls_IdNo,        &	
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
//			tab_sheet.tabpage_1.dw_print3.object.t_53.text = ""			
		ELSE
			//wf_setmenu('P',TRUE)
		END IF
	
	CASE 5
//		datawindow  dw_name
//		dw_name = tab_sheet.tabpage_2.dw_print4
		ls_IdNo_num = tab_sheet.tabpage_2.sle_id_num.text
		IF isnull(ls_IdNo_num) OR  ls_IdNo_num = '' THEN
			messagebox('확인','등재번호를 입력하여주시기 바랍니다..!')
			return
		END IF
		IF tab_sheet.tabpage_2.dw_print4.Retrieve(ls_IdNo_num) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			//wf_setmenu('P',TRUE)
		ELSE
			//wf_setmenu('P',TRUE)
		END IF
		//////////////////////////////////////////////////////////////////////////////////////
//	     //  건물이미지정보 조회처리
//	     ////////////////////////////////////////////////////////////////////////////////////
		  datawindowchild   ldwc_temp
//
       tab_sheet.tabpage_2.dw_print4.GetChild('dw_main',ldwc_Temp)
       ldwc_Temp.SetTransObject(SQLCA)
       ldwc_Temp.retrieve(ls_IdNo_num)

		   Int  Li_fileopen
	     Blob	lbo_Image
	     SELECTBLOB	A.ITEM_IMG
	     INTO			:lbo_Image
	     FROM			STDB.HST026h A
	     WHERE			A.id_no = :ls_IdNo_num  ;

	     IF SQLCA.SQLCODE = 0 THEN
		     //SetNull(lbo_Image)
		     Li_fileopen = FileOpen("C:\CWU\BMP\ITEM.Bmp", StreamMode!, Write!, Shared!, Replace!)
	        FileWrite(Li_fileopen, lbo_Image)
	        fileclose(Li_fileopen)
//	        tab_sheet.tabpage_2.dw_print4.Modify("p_item_img.FileName = 'C:\CWU\BMP\ITEM.Bmp'")
	        ldwc_Temp.Modify("p_item_img.FileName = 'C:\CWU\BMP\ITEM.Bmp'")
        Else
	        ldwc_Temp.Modify("p_item_img.FileName = 'C:\CWU\BMP\BLANK.Bmp'")
		  END IF
		 //////////////////////////////////자료에 의한 빈로우 체우기////////////
		int idx
		long ll_rowcnt

      tab_sheet.tabpage_2.dw_print4.GetChild('dw_main2',ldwc_Temp)
      ldwc_Temp.SetTransObject(SQLCA)
		ll_rowcnt = ldwc_Temp.Retrieve(ls_IdNo_num)	
     
	      for idx = 1 to 4 - ll_rowcnt
	          ldwc_Temp.InsertRow(0)
		   next

      tab_sheet.tabpage_2.dw_print4.GetChild('dw_main3',ldwc_Temp)
      ldwc_Temp.SetTransObject(SQLCA)
		ll_rowcnt = ldwc_Temp.Retrieve(ls_IdNo_num)
		
			for idx = 1 to 2 - ll_rowcnt
	          ldwc_Temp.InsertRow(0)
		   nexT

      tab_sheet.tabpage_2.dw_print4.GetChild('dw_main4',ldwc_Temp)
      ldwc_Temp.SetTransObject(SQLCA)
		ll_rowcnt = ldwc_Temp.Retrieve(ls_IdNo_num)
  
			for idx = 1 to 2 - ll_rowcnt
	          ldwc_Temp.InsertRow(0)
		   next
	
END CHOOSE
ls_sql = tab_sheet.tab_sheet_2.dw_print1.getsqlselect()

//////////////////////////////////////////////////////////////////////////////////////////
// END OF WINDOW FUNCTION
//////////////////////////////////////////////////////////////////////////////////////////
end subroutine

public subroutine wf_save ();messagebox('gkgkgk',' 여기다')
Long  ll_rowcount, ll_i, idx, ll_item_class, ll_row, ll_maxnum,  ll_seq2, ll_maxnum2
String ls_num
String  ls_idno,ls_gwa,ls_room_code,ls_fac_code,ls_first_fac_code,ls_mgr_gwa,ls_acct_code,ls_worker
String  ls_ipaddr,ls_work_date,ls_job_uid,ls_job_add,ls_job_date
Long    ll_itemclass,ll_seq,ll_revenue_opt,ll_purchase_price,ll_purchase_amt,ll_nation_amt,ll_depr_rate
Long    ll_replace_amt,ll_school_amt,ll_prepare_amt,ll_oper_opt,ll_purchase_opt,ll_in_no,ll_depr_opt

datawindow   dw_sname
dw_sname = tab_sheet.tabpage_sheet01.dw_update1
idw_name = tab_sheet.tabpage_sheet01.dw_update

idw_name.AcceptText()	  	

String ls_sysdate
ls_sysdate = string(f_sysdate())
ll_rowcount = idw_name.rowcount()

select max(seq)
into   :ll_maxnum 
from   stdb.hst037m;
IF isnull(ll_maxnum) THEN
	ll_maxnum = 0
END IF 

ll_maxnum2 = ll_maxnum + 1
FOR idx = 1 TO ll_rowcount
    DwItemStatus	lds_Status01
    lds_Status01 = idw_name.getitemstatus(idx,0,Primary!)
    
	 IF  lds_Status01 <> NotModified! THEN 
        ll_row = dw_sname.insertrow(0)
			
  	   dw_sname.object.id_no         [ll_row]  = idw_name.object.id_no         [idx]    //등재번호  
   	dw_sname.object.item_class    [ll_row]  = idw_name.object.item_class    [idx]    //품목구분
   	dw_sname.object.seq           [ll_row]  = ll_maxnum2                      //이력번호           
   	dw_sname.object.revenue_opt   [ll_row]  = idw_name.object.revenue_opt   [idx]    //구입재원            
   	dw_sname.object.purchase_price[ll_row]  = idw_name.object.purchase_price[idx]    //구입단가            
   	dw_sname.object.purchase_amt  [ll_row]  = idw_name.object.purchase_amt  [idx]    //구입금액            
   	dw_sname.object.nation_amt    [ll_row]  = idw_name.object.nation_amt    [idx]    //국고사용금액        
   	dw_sname.object.replace_amt   [ll_row]  = idw_name.object.replace_amt   [idx]    //국고대응금액        
   	dw_sname.object.school_amt    [ll_row]  = idw_name.object.school_amt    [idx]    //교비사용금액        
   	dw_sname.object.prepare_amt   [ll_row]  = idw_name.object.prepare_amt   [idx]    //기성회비사용금액    
   	dw_sname.object.gwa           [ll_row]  = idw_name.object.gwa           [idx]    //사용부서            
   	dw_sname.object.room_code     [ll_row]  = idw_name.object.room_code     [idx]    //사용장소            
  // 	dw_sname.object.fac_code      [ll_row]  = idw_name.object.fac_code      [idx]    //시설변동내역        
  // 	dw_sname.object.first_fac_code[ll_row]  = idw_name.object.first_fac_code[idx]    //시설처음장소        
   	dw_sname.object.oper_opt      [ll_row]  = idw_name.object.oper_opt      [idx]    //운용구분            
   	dw_sname.object.purchase_opt  [ll_row]  = idw_name.object.purchase_opt  [idx]    //구매방법            
  // 	dw_sname.object.mgr_gwa       [ll_row]  = idw_name.object.mgr_gwa       [idx]    //관리부서            
  // 	dw_sname.object.acct_code     [ll_row]  = idw_name.object.acct_code     [idx]    //계정과목            
   	dw_sname.object.in_no         [ll_row]  = idw_name.object.in_no         [idx]    //입고번호            
  // 	dw_sname.object.depr_opt      [ll_row]  = idw_name.object.depr_opt      [idx]    //상각구분            
  // 	dw_sname.object.depr_rate     [ll_row]  = idw_name.object.depr_rate     [idx]    //감가율              
  
     IF  isnull(dw_sname.object.in_no[ll_row]) THEN
		   dw_sname.object.in_no[ll_row] = 0
	  END IF
      ///////////////////////////////////////////////////////////////////////////////////////
      // 3. 저장처리전 체크사항 기술
      ///////////////////////////////////////////////////////////////////////////////////////

		IF ll_row > 0 THEN
			ls_Worker     = gstru_uid_uname.uid				//등록자
			ls_IPAddr     = gstru_uid_uname.address		//등록단말기
  			ls_JOB_UID	  =gstru_uid_uname.uid	         //등록자
   		ls_JOB_ADD	  =gstru_uid_uname.address		   //등록단말기
		END IF
	
		////////////////////////////////////////////////////////////////////////////////////
		// 3.1 수정항목 처리
		////////////////////////////////////////////////////////////////////////////////////
		tab_sheet.tabpage_sheet01.dw_update1.Object.Worker   [ll_Row] =ls_Worker   //등록자                                                                                                                                     
		tab_sheet.tabpage_sheet01.dw_update1.Object.IpAddr   [ll_Row] =ls_IpAddr   //등록단말기                                                                                                                                 
//		tab_sheet.tabpage_sheet01.dw_update1.Object.Work_Date[ll_Row] =ldt_WorkDate//등록일자                                                                                                                                    
		tab_sheet.tabpage_sheet01.dw_update1.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
		tab_sheet.tabpage_sheet01.dw_update1.Object.job_add [ll_Row]  =ls_JOB_ADD//작업단말기
//		tab_sheet.tabpage_sheet01.dw_update1.Object.job_date[ll_Row]  =ldt_JOB_Date//작업일자
    
	 	///////////////////////////////////////////////////////////////////////////////////////
		// 5. 자료저장처리
		///////////////////////////////////////////////////////////////////////////////////////
		tab_sheet.tabpage_sheet01.dw_update1.update()
		commit;
		
	END IF
//   ll_seq2 = dw_sname.object.seq[ll_row]
//	ll_maxnum2 = ll_seq2 + 1
	NEXT
					  
//   messagebox('확인',string(sqlca.sqlcode) + SQLCA.SqlErrText)
	 			if sqlca.sqlcode <> 0 then
					wf_setmsg("저장실패")
					return
				end if
messagebox('gkgkgk',' 끝')
end subroutine

public subroutine wf_insert ();messagebox('gkgkgk',' 여기다2')
Long  ll_rowcount, ll_i, idx, ll_item_class, ll_row, ll_maxnum,  ll_seq2, ll_maxnum2
String ls_num
String  ls_idno,ls_gwa,ls_room_code,ls_fac_code,ls_first_fac_code,ls_mgr_gwa,ls_acct_code,ls_worker
String  ls_ipaddr,ls_work_date,ls_job_uid,ls_job_add,ls_job_date
Long    ll_itemclass,ll_seq,ll_revenue_opt,ll_purchase_price,ll_purchase_amt,ll_nation_amt,ll_depr_rate
Long    ll_replace_amt,ll_school_amt,ll_prepare_amt,ll_oper_opt,ll_purchase_opt,ll_in_no,ll_depr_opt

datawindow   dw_sname
dw_sname = tab_sheet.tabpage_sheet01.dw_update1
idw_name = tab_sheet.tabpage_sheet01.dw_update


String ls_sysdate
ls_sysdate = string(f_sysdate())
ll_rowcount = idw_name.rowcount()

select max(seq)
into   :ll_maxnum 
from   stdb.hst037m;
IF isnull(ll_maxnum) THEN
	ll_maxnum = 0
END IF 

ll_maxnum2 = ll_maxnum + 1
FOR idx = 1 TO ll_rowcount
    DwItemStatus	lds_Status01
	 lds_Status01 = idw_name.getitemstatus(idx,0,Primary!)
    
	 IF  lds_Status01 = NotModified! THEN 
//			 messagebox('11111111111', '11111111111')	
		 ll_row = dw_sname.insertrow(0)
		
  	   dw_sname.object.id_no         [ll_row]  = idw_name.object.id_no         [idx]    //등재번호            
   	dw_sname.object.item_class    [ll_row]  = idw_name.object.item_class    [idx]    //품목구분
   	dw_sname.object.seq           [ll_row]  = ll_maxnum2                      //이력번호           
   	dw_sname.object.revenue_opt   [ll_row]  = idw_name.object.revenue_opt   [idx]    //구입재원            
   	dw_sname.object.purchase_price[ll_row]  = idw_name.object.purchase_price[idx]    //구입단가            
   	dw_sname.object.purchase_amt  [ll_row]  = idw_name.object.purchase_amt  [idx]    //구입금액            
   	dw_sname.object.nation_amt    [ll_row]  = idw_name.object.nation_amt    [idx]    //국고사용금액        
   	dw_sname.object.replace_amt   [ll_row]  = idw_name.object.replace_amt   [idx]    //국고대응금액        
   	dw_sname.object.school_amt    [ll_row]  = idw_name.object.school_amt    [idx]    //교비사용금액        
   	dw_sname.object.prepare_amt   [ll_row]  = idw_name.object.prepare_amt   [idx]    //기성회비사용금액    
   	dw_sname.object.gwa           [ll_row]  = idw_name.object.gwa           [idx]    //사용부서            
   	dw_sname.object.room_code     [ll_row]  = idw_name.object.room_code     [idx]    //사용장소            
  // 	dw_sname.object.fac_code      [ll_row]  = idw_name.object.fac_code      [idx]    //시설변동내역        
  // 	dw_sname.object.first_fac_code[ll_row]  = idw_name.object.first_fac_code[idx]    //시설처음장소        
   	dw_sname.object.oper_opt      [ll_row]  = idw_name.object.oper_opt      [idx]    //운용구분            
   	dw_sname.object.purchase_opt  [ll_row]  = idw_name.object.purchase_opt  [idx]    //구매방법            
  // 	dw_sname.object.mgr_gwa       [ll_row]  = idw_name.object.mgr_gwa       [idx]    //관리부서            
  // 	dw_sname.object.acct_code     [ll_row]  = idw_name.object.acct_code     [idx]    //계정과목            
   	dw_sname.object.in_no         [ll_row]  = idw_name.object.in_no         [idx]    //입고번호            
  // 	dw_sname.object.depr_opt      [ll_row]  = idw_name.object.depr_opt      [idx]    //상각구분            
  // 	dw_sname.object.depr_rate     [ll_row]  = idw_name.object.depr_rate     [idx]    //감가율              
  
     IF  isnull(dw_sname.object.in_no[ll_row]) THEN
		   dw_sname.object.in_no[ll_row] = 0
	  END IF
      ///////////////////////////////////////////////////////////////////////////////////////
      // 3. 저장처리전 체크사항 기술
      ///////////////////////////////////////////////////////////////////////////////////////

		IF ll_row > 0 THEN
			ls_Worker     = gstru_uid_uname.uid				//등록자
			ls_IPAddr     = gstru_uid_uname.address		//등록단말기
  			ls_JOB_UID	  =gstru_uid_uname.uid	         //등록자
   		ls_JOB_ADD	  =gstru_uid_uname.address		   //등록단말기
		END IF
	
		////////////////////////////////////////////////////////////////////////////////////
		// 3.1 수정항목 처리
		////////////////////////////////////////////////////////////////////////////////////
		tab_sheet.tabpage_sheet01.dw_update1.Object.Worker   [ll_Row] =ls_Worker   //등록자                                                                                                                                     
		tab_sheet.tabpage_sheet01.dw_update1.Object.IpAddr   [ll_Row] =ls_IpAddr   //등록단말기                                                                                                                                 
//		tab_sheet.tabpage_sheet01.dw_update1.Object.Work_Date[ll_Row] =ldt_WorkDate//등록일자                                                                                                                                    
		tab_sheet.tabpage_sheet01.dw_update1.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
		tab_sheet.tabpage_sheet01.dw_update1.Object.job_add [ll_Row]  =ls_JOB_ADD//작업단말기
//		tab_sheet.tabpage_sheet01.dw_update1.Object.job_date[ll_Row]  =ldt_JOB_Date//작업일자
    
	 	///////////////////////////////////////////////////////////////////////////////////////
		// 5. 자료저장처리
		///////////////////////////////////////////////////////////////////////////////////////
		tab_sheet.tabpage_sheet01.dw_update1.update()
		commit;
		
	END IF
   ll_seq2 = dw_sname.object.seq[ll_row]
	ll_maxnum2 = ll_seq2 + 1
	NEXT
					  
//   messagebox('확인',string(sqlca.sqlcode) + SQLCA.SqlErrText)
	 			if sqlca.sqlcode <> 0 then
					wf_setmsg("저장실패")
					return
				end if
messagebox('gkgkgk',' 끝2')
end subroutine

on w_hst201i_1.create
int iCurrent
call super::create
this.dw_head1=create dw_head1
this.gb_6=create gb_6
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head1
this.Control[iCurrent+2]=this.gb_6
this.Control[iCurrent+3]=this.gb_3
end on

on w_hst201i_1.destroy
call super::destroy
destroy(this.dw_head1)
destroy(this.gb_6)
destroy(this.gb_3)
end on

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_retrieve
//	기 능 설 명: 자료조회
//	작성/수정자: 윤하영
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 자료조회
////////////////////////////////////////////////////////////////////////////////////
wf_retrieve()
return 1
//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가
//	작성/수정자: 윤하영
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long		ll_InsRow
String	ls_ItemNo
String	ls_ItemNm

ii_tab  = tab_sheet.SelectedTab
idw_sname.accepttext()
CHOOSE CASE ii_tab
	CASE 1
		tab_sheet.tabpage_sheet01.dw_head2.AcceptText()
		
		idw_name  = tab_sheet.tabpage_sheet01.dw_update
		idw_sname = tab_sheet.tabpage_sheet01.dw_head2

		IF idw_sname.Object.in_no[1] <> 0 THEN RETURN

	   ll_InsRow = idw_name.InsertRow(1)
		ls_ItemNo = tab_sheet.tabpage_sheet01.dw_head2.object.item_no[1]
		
		wf_ml_name(ls_ItemNo)			
      idw_name.object.midd_name    [ll_InsRow] = gstru_uid_uname.s_parm[11]
      idw_name.object.large_name   [ll_InsRow] = gstru_uid_uname.s_parm[12]			  
		idw_name.object.item_no      [ll_InsRow] = idw_sname.object.item_no  [1]
		idw_name.object.item_name    [ll_InsRow] = idw_sname.object.item_name[1]
		idw_name.object.gwa          [ll_InsRow] = idw_sname.object.gwa      [1]
//		idw_name.object.purchase_date[ll_InsRow] = Datetime(Date(String(idw_sname.object.in_date[1],'@@@@/@@/@@')),Time(00:00:00))
		
//		messagebox('',string(trim(idw_sname.object.purchase_dt[1]),'yyyymmdd'))
//		idw_name.object.purchase_date[ll_InsRow] = mid(idw_sname.object.purchase_dt[1]),1,4) + mid(idw_sname.object.purchase_dt[1]),6,2) + mid(idw_sname.object.purchase_dt[1]),9,2)
	   
		string ls_purchase_dt 
		
		
		ls_purchase_dt = idw_sname.getitemstring(1,'purchase_dt')
		messagebox('',ls_purchase_dt)
		if ls_purchase_dt = ''  then
			idw_name.setitem(ll_insrow,'purchase_date','')
		else 
			idw_name.setitem(ll_insrow,'purchase_date',TRIM(ls_purchase_dt))
		end if
	   idw_name.object.room_code    [ll_InsRow] = idw_sname.object.room_code   [1]
		idw_name.object.room_name    [ll_InsRow] = idw_sname.object.room_name   [1]
		idw_name.object.item_class   [ll_InsRow] = idw_sname.object.item_class  [1]
		idw_name.object.revenue_opt  [ll_InsRow] = idw_sname.object.revenue_opt [1]
		idw_name.object.purchase_opt [ll_InsRow] = idw_sname.object.purchase_opt[1]
		idw_name.object.oper_opt     [ll_InsRow] = idw_sname.object.oper_opt    [1]
		idw_name.object.useful       [ll_InsRow] = idw_sname.object.useful_opt  [1]
					
      idw_name.Object.worker   [ll_InsRow] = gstru_uid_uname.uid		//등록자
		idw_name.Object.work_date[ll_InsRow] = f_sysdate()					//등록일자
		idw_name.Object.ipaddr   [ll_InsRow] = gstru_uid_uname.address	//등록IP
	
	   idw_name.SetFocus()
		idw_name.SetRow(ll_InsRow)

END CHOOSE

//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

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

dw_head1.object.c_date_f[1] = Left(f_today(),6) + '01'
dw_head1.object.c_date_t[1] = f_today()

dw_head1.object.c_acct_date_f[1] = Left(f_today(),6) + '01'
dw_head1.object.c_acct_date_t[1] = f_today()

//////////////////////////////////////////////////////////////////////////////////////
// 3. 자산 등재할 입고내역(dw_head2) dddw 초기화
//////////////////////////////////////////////////////////////////////////////////////
idw_sname = tab_sheet.tabpage_sheet01.dw_head2

f_childretrieve(idw_sname,"item_class","item_class")		//물품구분
f_childretrieve(idw_sname,"revenue_opt","revenue_opt")	//구입재원
f_childretrieve(idw_sname,"purchase_opt","purchase_opt")	//구매방법
f_childretrieve(idw_sname,"oper_opt","oper_opt")			//운용구분

idw_sname.Reset()
idw_sname.InsertRow(0)

idw_sname.Object.in_date[1] = f_today()

//////////////////////////////////////////////////////////////////////////////////////
// 4. 자산 등재내역(저장)(dw_update) dddw 초기화
//////////////////////////////////////////////////////////////////////////////////////
idw_name = tab_sheet.tabpage_sheet01.dw_update

f_childretrieve(idw_name,"item_class","item_class")		//물품구분
f_childretrieve(idw_name,"revenue_opt","revenue_opt")		//구입재원
f_childretrieve(idw_name,"oper_opt","oper_opt")				//운용구분
f_childretrieve(idw_name,"purchase_opt","purchase_opt")	//구매방법

idw_name.Reset()

//////////////////////////////////////////////////////////////////////////////////////
// 4. 물품입고내역 조회
//////////////////////////////////////////////////////////////////////////////////////
tab_sheet.tabpage_sheet01.dw_list.Retrieve()

//////////////////////////////////////////////////////////////////////////////////////
// 5. 출력용데이타윕도우 dddw 초기화
//////////////////////////////////////////////////////////////////////////////////////
wf_print_child()
///////////////////////////////////////////////////////////////////////////////////
// 5.1 부대품내역 dddw 초기화
///////////////////////////////////////////////////////////////////////////////////
idw_sname = tab_sheet.tab_sheet_3.dw_print2

f_childretrieve(idw_sname,"item_class","item_class")		//물품구분
f_childretrieve(idw_sname,"revenue_opt","revenue_opt")	//구입재원


idw_sname = tab_sheet.tabpage_1.dw_print3
f_childretrieve(idw_sname,"hst027m_item_class","item_class")		//물품구분

tab_sheet.tabpage_1.dw_print3.Object.DataWindow.Print.Preview = 'YES'

u_tty = f_create_tty()//바코드출력을 위한부분

//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장
//	작성/수정자: 윤하영
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Integer	li_ItemClss			//물품구분
Integer	li_ItemClssOne
Long		ll_RowCnt, ll_item_Seq
Long		ll_i
Long		ll_InNo				//입고번호
Long		ll_RsvnQty, ll_in_qty
Long		ll_Nation
String	ls_IdNo				//등재번호
String	ls_PurchaseDate	//구입일자
String	ls_ItemNo			//품목코드
String	ls_ItemNoOne, ls_req_no

ii_tab = tab_sheet.selectedtab
idw_name.AcceptText()	  
idw_sname.AcceptText()	

wf_save()
CHOOSE CASE ii_tab
	CASE 1
		idw_name = tab_sheet.tabpage_sheet01.dw_update
		idw_sname = tab_sheet.tabpage_sheet01.dw_head2  
		
		ll_RowCnt = idw_name.RowCount()
		
		IF f_chk_modified(idw_name) = FALSE THEN RETURN -1
		
		ll_InNo = idw_sname.object.in_no[1]					// 입고 번호 
		
		IF ll_InNo <> 0 THEN										// 등재량이 등재 잔량보다 큰지 체크
		  IF wf_qty_chk() = FALSE THEN RETURN -1
		END IF	
		
		IF ll_RowCnt <> 0 THEN
			li_ItemClss     = idw_name.Object.item_class[1]
			ls_PurchaseDate = left(idw_name.Object.id_date[1],8)
		
			SELECT	NVL(MAX(SUBSTR(ID_NO,9,3)),'000') 
			INTO		:ls_IdNo
			FROM		STDB.HST027M  
			WHERE		ITEM_CLASS        = :li_ItemClss
			AND		SUBSTR(ID_NO,1,8) = :ls_PurchaseDate;
			
			ls_ItemNoOne   = idw_name.Object.item_no   [1]
			li_ItemClssOne = idw_name.Object.item_class[1]
         	
			  FOR ll_i = 1 TO ll_RowCnt             
				 DwItemStatus	lds_Status
				 lds_Status = idw_name.getitemstatus(ll_i,0,Primary!)

				 IF lds_Status = New! OR lds_Status = NewModified! THEN 
					

					 ls_ItemNo   = idw_name.Object.item_no   [ll_i]
					 li_ItemClss = idw_name.Object.item_class[ll_i]
					 IF ls_ItemNo <> ls_ItemNoOne OR li_ItemClss <> li_ItemClssOne  THEN
						Messagebox("확인","등재할수 없습니다, 품목과 물품구분을 확인하세요 ")
						RETURN -1
					 END IF
 
					SELECT	NVL(NATION_CODE, 118)
					INTO		:ll_Nation
					FROM		STDB.HST004M
					WHERE		ITEM_NO = :ls_ItemNo;
				  
					IF NOT isNull(ll_Nation) THEN
						idw_name.object.nation_code[ll_i] = ll_Nation
					END IF
               
					ls_IdNo = String(Long(ls_IdNo) + 1,'000') //자산등재번호부여 
			       
					idw_name.object.id_no[ll_i] = ls_PurchaseDate + ls_IdNo
					wf_save()
				END IF
				idw_name.Object.job_uid [ll_i] = gstru_uid_uname.uid
				idw_name.Object.job_add [ll_i] = gstru_uid_uname.address
				idw_name.Object.job_date[ll_i] = f_sysdate()

			NEXT 
		   
			ll_InNo = idw_sname.object.in_no[1]									//입고번호
			ls_req_no = idw_sname.object.req_no[1]								//접수번호
			ll_item_seq = idw_sname.object.item_seq[1]						//품목번호
			ll_in_qty = idw_sname.object.in_qty[1]                      //입고수량
			IF ll_in_qty <> 0 THEN
			   idw_name.object.PURCHASE_QTY[idw_name.getrow()] = ll_in_qty // 구입수량
			END IF
	
	
			IF ll_InNo <> 0 THEN
				//////////////////////////////////////////////////
				// 등재 합계량 = 현재 등재량 + 등재할 수량 
				//////////////////////////////////////////////////
				ll_RsvnQty = idw_sname.Object.rsvn_qty[1] + idw_sname.Object.j_in_qty[1]
				//////////////////////////////////////////////////
				// 물품입고 T 의 자산등재량에 UPDATE한다
				//////////////////////////////////////////////////
				UPDATE	STDB.HST109H
				SET		RSVN_QTY = :ll_RsvnQty
				WHERE		IN_NO    = :ll_InNo AND REQ_NO = :ls_req_no AND ITEM_SEQ = :ll_item_seq;
			END IF
		END IF
		String	ls_ColArry[] = {'item_no/품목코드','room_code/사용장소','dept_code/부서','id_date/등재일자'}	
 
		IF f_chk_null(idw_name,ls_ColArry) = 1 THEN
			IF f_update(idw_name,'U') = TRUE THEN
				wf_setmsg("저장되었습니다")
				COMMIT;
				tab_sheet.tabpage_sheet01.dw_list.Retrieve()
			END IF
		END IF
END CHOOSE
return 1
//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제
//	작성/수정자: 윤하영
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long		ll_Row

ii_tab = tab_sheet.SelectedTab

CHOOSE CASE ii_tab
	CASE 1
	   idw_name = tab_sheet.tabpage_sheet01.dw_update
		
	   ll_Row = idw_name.GetRow()
		IF ll_Row <> 0 THEN
			DwItemStatus	lds_status
			lds_status = idw_name.GetItemStatus(ll_Row, 0, Primary!)
			IF lds_status = New! OR lds_status = NewModified! THEN
				idw_name.DeleteRow(ll_Row)
			ELSE
			  IF f_messagebox('2','DEL') = 1 THEN
				  idw_name.DeleteRow(ll_Row)
				  IF f_update(idw_name,'D') = TRUE THEN wf_setmsg("삭제되었습니다")
			  END IF
		   END IF
	END IF
END CHOOSE

//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 자료출력
//	작성/수정자: 윤하영
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
ii_tab = tab_sheet.SelectedTab

CHOOSE CASE ii_tab
	CASE 2
		IF tab_sheet.tab_sheet_2.dw_print1.rowcount() <> 0 THEN
			f_print(tab_sheet.tab_sheet_2.dw_print1)
		END IF
	CASE 3
		IF tab_sheet.tab_sheet_3.dw_print2.rowcount() <> 0 THEN
			f_print(tab_sheet.tab_sheet_3.dw_print2)
		END IF
	CASE 4
		IF tab_sheet.tabpage_1.dw_print3.rowcount() <> 0 THEN
			f_print(tab_sheet.tabpage_1.dw_print3)
		END IF
	CASE 5
		IF tab_sheet.tabpage_2.dw_print4.rowcount() <> 0 THEN
			f_print(tab_sheet.tabpage_2.dw_print4)
		END IF
END CHOOSE

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
tab_sheet.tabpage_sheet01.dw_head2.Reset()
tab_sheet.tabpage_sheet01.dw_update.Reset()
dw_head1.InsertRow(0)
tab_sheet.tabpage_sheet01.dw_head2.InsertRow(0)
tab_sheet.tabpage_2.dw_print4.Object.DataWindow.zoom = 100
tab_sheet.tabpage_2.dw_print4.Object.DataWindow.Print.Preview = 'YES'
tab_sheet.tab_sheet_2.dw_print1.Object.DataWindow.Print.Preview = 'YES'
tab_sheet.tab_sheet_3.dw_print2.Object.DataWindow.Print.Preview = 'YES'
tab_sheet.tabpage_1.dw_print3.Object.DataWindow.Print.Preview = 'YES'

//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hst201i_1
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hst201i_1
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hst201i_1
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hst201i_1
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hst201i_1
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hst201i_1
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hst201i_1
end type

type uc_insert from w_tabsheet`uc_insert within w_hst201i_1
end type

type uc_delete from w_tabsheet`uc_delete within w_hst201i_1
end type

type uc_save from w_tabsheet`uc_save within w_hst201i_1
end type

type uc_excel from w_tabsheet`uc_excel within w_hst201i_1
end type

type uc_print from w_tabsheet`uc_print within w_hst201i_1
end type

type st_line1 from w_tabsheet`st_line1 within w_hst201i_1
end type

type st_line2 from w_tabsheet`st_line2 within w_hst201i_1
end type

type st_line3 from w_tabsheet`st_line3 within w_hst201i_1
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hst201i_1
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hst201i_1
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hst201i_1
integer y = 408
integer width = 3835
integer height = 2180
tab_sheet_2 tab_sheet_2
tab_sheet_3 tab_sheet_3
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 2		
//      wf_retrieve()		
//end choose
end event

on tab_sheet.create
this.tab_sheet_2=create tab_sheet_2
this.tab_sheet_3=create tab_sheet_3
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_sheet_2
this.Control[iCurrent+2]=this.tab_sheet_3
this.Control[iCurrent+3]=this.tabpage_1
this.Control[iCurrent+4]=this.tabpage_2
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tab_sheet_2)
destroy(this.tab_sheet_3)
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer width = 3799
integer height = 2064
string text = "자산등재"
gb_4 gb_4
gb_1 gb_1
dw_update dw_update
dw_head2 dw_head2
cb_1 cb_1
dw_list dw_list
rb_2 rb_2
rb_3 rb_3
cb_2 cb_2
st_1 st_1
dw_update1 dw_update1
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.gb_1=create gb_1
this.dw_update=create dw_update
this.dw_head2=create dw_head2
this.cb_1=create cb_1
this.dw_list=create dw_list
this.rb_2=create rb_2
this.rb_3=create rb_3
this.cb_2=create cb_2
this.st_1=create st_1
this.dw_update1=create dw_update1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_update
this.Control[iCurrent+4]=this.dw_head2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_list
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.rb_3
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_update1
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.dw_update)
destroy(this.dw_head2)
destroy(this.cb_1)
destroy(this.dw_list)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.dw_update1)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 3077
integer width = 498
integer height = 300
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
end type

type uo_tab from w_tabsheet`uo_tab within w_hst201i_1
end type

type dw_con from w_tabsheet`dw_con within w_hst201i_1
end type

type st_con from w_tabsheet`st_con within w_hst201i_1
end type

type gb_4 from groupbox within tabpage_sheet01
integer x = 27
integer y = 36
integer width = 3735
integer height = 464
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "자산 등재할 입고 내역"
end type

type gb_1 from groupbox within tabpage_sheet01
integer x = 27
integer y = 532
integer width = 3735
integer height = 772
integer taborder = 21
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 67108864
string text = "자산 등재 내역"
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
integer x = 69
integer y = 672
integer width = 3653
integer height = 612
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hst201a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

///////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_db_retrieve
////	기 능 설 명: 자료조회 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//Long		ll_GetRow
//Long		ll_RowCnt
//ll_GetRow = currentrow
//IF ll_GetRow = 0 THEN RETURN
//ll_RowCnt = THIS.RowCount()
//IF ll_RowCnt = 0 THEN
//	RETURN
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_id_No	//개인번호
//ls_id_No  = tab_sheet.tabpage_sheet01.dw_update.Object.id_no[ll_GetRow]
//
//SetPointer(HourGlass!)
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
//tab_sheet.tabpage_2.dw_print4.SetReDraw(FALSE)
//tab_sheet.tabpage_2.dw_print4.Reset()
//ll_RowCnt = tab_sheet.tabpage_2.dw_print4.Retrieve(ls_id_No)
//tab_sheet.tabpage_2.dw_print4.SetReDraw(TRUE)
//
//datawindowchild   ldwc_temp
//
//tab_sheet.tabpage_2.dw_print4.GetChild('dw_main2',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve(ls_id_No) < 1 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//tab_sheet.tabpage_2.dw_print4.GetChild('dw_main3',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve(ls_id_No) < 1 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//tab_sheet.tabpage_2.dw_print4.GetChild('dw_main4',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve(ls_id_No) < 1 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
/////////////////////////////////////////////////////////////////////////////////////////
////// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
/////////////////////////////////////////////////////////////////////////////////////////
////IF ll_RowCnt > 0 THEN
////	//wf_setmenuBtn('RP')
////	wf_SetMsg('자료가 조회되었습니다.')
////ELSE
////	//wf_setmenuBtn('R')
////	wf_SetMsg('해당자료가 존재하지 않습니다.')
////END IF
////tab_sheet.tabpage_2.dw_print4.SetReDraw(TRUE)
////////////////////////////////////////////////////////////////////////////////////////////
//////	END OF SCRIPT
/////////////////////////////////////////////////////////////////////////////////////
end event

event dberror;call super::dberror;IF sqldbcode = 1 THEN
	messagebox("확인",'중복된 값이 있습니다.')
	setcolumn(1)
	setfocus()
END IF

RETURN 1
end event

event doubleclicked;call super::doubleclicked;//
//string ls_middle_code, ls_midd_name, ls_large_name
//
//IF dwo.name = 'item_no' THEN
//	
//   open(w_kch102h)
//	   	
//	IF message.stringparm <> '' THEN
//	
//	   this.object.item_no[row] = gstru_uid_uname.s_parm[1]
//		this.object.item_name[row] = gstru_uid_uname.s_parm[2]	   
//		this.object.item_class[row] = integer(gstru_uid_uname.s_parm[3])	   
//		this.object.item_stand_size[row] = gstru_uid_uname.s_parm[4]	   
//		this.object.model[row] = gstru_uid_uname.s_parm[5]	   
//		
//		ls_middle_code = left(gstru_uid_uname.s_parm[1],7)
//		
//		SELECT A.MIDD_NAME, B.LARGE_NAME
//		INTO :ls_midd_name, :ls_large_name
//		FROM STDB.HST003M A, STDB.HST002M B
//		WHERE A.ITEM_MIDDLE = :ls_middle_code  AND
//		      A.LARGE_CODE =  B.LARGE_CODE(+)   ;
//				
//				
//		this.object.midd_name[row] = ls_midd_name
//		this.object.large_name[row] = ls_large_name
//	
//   END IF
//	
//END IF
end event

event itemchanged;
int li_revenue_opt
long ll_item_class, ll_purchase_qty, ll_purchase_price, ll_purchase_amt
string ls_room_name

this.accepttext()

 ll_purchase_qty   = this.object.purchase_qty[this.getrow()]
 ll_purchase_price = this.object.purchase_price[this.getrow()]
 ll_purchase_amt   = ll_purchase_qty * ll_purchase_price
 this.object.purchase_amt[this.getrow()] = ll_purchase_amt
IF dwo.name = 'room_code' THEN

   SELECT	ROOM_NAME
	INTO		:ls_room_name
	FROM		STDB.HST242M 
	WHERE		ROOM_CODE = :data   ;

   this.object.room_name[row] = ls_room_name

END IF

IF dwo.name = 'revenue_opt' OR dwo.name = 'purchase_amt' THEN          // 구입 재원 OR 구입금액  
  
    li_revenue_opt = this.object.revenue_opt[row]              // 구입 재원 
  
    this.object.school_amt[row] = 0                    // 교비 
    this.object.nation_amt[row] = 0                    // 국고 
	 this.object.replace_amt[row] = 0                   // 국고대응
	 this.object.self_amt[row] = 0                      // 자체구입
    this.object.prepare_amt[row] = 0                   // 기증 
	 
   IF li_revenue_opt = 1 THEN                         // 교비
		this.object.school_amt[row] = this.object.purchase_amt[row]		
	ELSEIF li_revenue_opt = 2 THEN                     // 일반국고
      this.object.nation_amt[row] = this.object.purchase_amt[row]		
   ELSEIF li_revenue_opt = 3 THEN                     // 일반국고대응
	   this.object.replace_amt[row] = this.object.purchase_amt[row]		
	ELSEIF li_revenue_opt = 4 THEN                     // 자체구입
	   this.object.self_amt[row] = this.object.purchase_amt[row]		
	ELSEIF li_revenue_opt = 5 THEN                     // 기증     
	   this.object.prepare_amt[row] = this.object.purchase_amt[row]	
	ELSEIF li_revenue_opt = 6 THEN                     // 특성화국고
      this.object.nation_amt[row] = this.object.purchase_amt[row]		
   ELSEIF li_revenue_opt = 7 THEN                     // 국고특성화
	   this.object.nation_amt[row] = this.object.purchase_amt[row]
	ELSEIF li_revenue_opt = 8 THEN                     // 특성화국고대응
	   this.object.replace_amt[row] = this.object.purchase_amt[row]	
   END IF
	
END IF


end event

event key_enter;call super::key_enter;
long ll_getrow
string ls_item_no, ls_room_code, ls_midd_name, ls_large_name

this.accepttext()
	
ll_getrow = this.getrow()

IF this.getcolumnname() = 'item_no' THEN                         // 물품 코드 

	ls_item_no = this.object.item_no[ll_getrow]
		
	openwithparm(w_hgm001h,ls_item_no)
			
	IF message.stringparm <> '' THEN
	
		this.object.item_no[ll_getrow]         = gstru_uid_uname.s_parm[1]
		this.object.item_name[ll_getrow]       = gstru_uid_uname.s_parm[2]	   
		this.object.item_class[ll_getrow]      = integer(gstru_uid_uname.s_parm[5])	   
		this.object.item_stand_size[ll_getrow] = gstru_uid_uname.s_parm[6]	   
		this.object.model[ll_getrow]           = gstru_uid_uname.s_parm[7]	   

//--- 중분류명, 소분류명 가져온다 ---//

//      SELECT B.MIDD_NAME, C.LARGE_NAME
//	   INTO :ls_midd_name, :ls_large_name
//	   FROM STDB.HST004M A, STDB.HST003M B, STDB.HST002M C
//	   WHERE A.ITEM_MIDDLE = B.ITEM_MIDDLE(+)  AND
//	         SUBSTR(A.ITEM_MIDDLE,1,4) = C.LARGE_CODE(+)  AND
//	         A.ITEM_NO = :gstru_uid_uname.s_parm[1]   ;
		
		wf_ml_name(gstru_uid_uname.s_parm[1])
		
		this.object.midd_name[ll_getrow] = gstru_uid_uname.s_parm[11]
		this.object.large_name[ll_getrow] = gstru_uid_uname.s_parm[12]
	
	END IF

END IF

IF this.getcolumnname() = 'room_code' THEN                       // 호실 코드 

	ls_room_code = this.object.room_code[ll_getrow]
	
	openwithparm(w_hgm100h,ls_room_code)
		
	IF message.stringparm <> '' THEN
	
		this.object.room_code[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.room_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
	
	END IF

END IF
	   

end event

type dw_head2 from cuo_dwwindow within tabpage_sheet01
integer x = 46
integer y = 112
integer width = 3707
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hst201a_3"
boolean border = false
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;
int li_item_class, li_purchase_opt, li_oper_opt, li_revenue_opt, ll_purchase_price 
long idx, ll_purchase_amt, ll_rowcount, ll_in_no, ll_purchase_qty 
string ls_item_no, ls_item_name, ls_item_stand_size, ls_model, ls_dept_code, ls_room_code, ls_middle_code, ls_midd_name
string ls_large_name, ls_room_name, ls_useful_opt
string ls_purchase_dt, ls_id_date, ls_large_code, ls_big_name

this.accepttext()

IF dwo.name = 'j_in_qty' THEN                        // 등재 수량 
	
 IF tab_sheet.tabpage_sheet01.rb_2.checked THEN      // 개별 등재
	IF wf_qty_chk() = TRUE THEN

      wf_ml_name(this.object.item_no[1])

      idw_name = tab_sheet.tabpage_sheet01.dw_update
      idw_name.reset()
		
		ll_in_no 				= this.object.in_no[1]
		ls_item_no 				= this.object.item_no[1]
		ls_item_name			= this.object.item_name[1]
		li_item_class 			= this.object.item_class[1]
		ls_item_stand_size	= this.object.item_stand_size[1]
		ls_model 				= this.object.model[1]
		ls_dept_code 			= this.object.apply_gwa[1]
		ll_purchase_price 	= this.object.in_price[1]
		ll_purchase_qty 		= this.object.j_in_qty[1]
		ll_purchase_amt 		= ll_purchase_price * ll_purchase_qty
		ls_purchase_dt 		= this.object.purchase_dt[1]
		li_revenue_opt 		= this.object.revenue_opt[1]
		li_purchase_opt 		= this.object.purchase_opt[1] 
		ls_room_code 			= this.object.room_code[1]
		ls_room_name 			= this.object.room_name[1]
		li_oper_opt 			= this.object.oper_opt[1]
		ls_useful_opt			= this.object.useful_opt[1]
	   ls_id_date				= this.object.id_date[1]
      ls_large_code        = left(ls_item_no,2)
	   select large_name
		into   :ls_big_name
		from   stdb.hst002m
		Where  large_code = :ls_large_code;
		
		
		idw_name.setredraw(false)
		
		FOR idx = 1 TO long(data)
		 		    				
		     idx = idw_name.insertrow(0)
          
			 idw_name.object.in_no[idx] 				= ll_in_no                           // 입고 번호 
			 idw_name.object.item_no[idx] 			= ls_item_no                         // 품목 코드 
			 idw_name.object.item_name[idx] 		   = ls_item_name                       // 품목명
			 idw_name.object.large_name[idx] 		= ls_big_name                      // 대분류명
			 idw_name.object.item_class[idx] 		= li_item_class                      // 품목구분
			 idw_name.object.item_stand_size[idx]  = ls_item_stand_size                 // 규 격
			 idw_name.object.model[idx] 				= ls_model                           // 모 델 
			 idw_name.object.purchase_qty[idx]  	= ll_purchase_qty                    // 등재수량
			 idw_name.object.gwa[idx] 				   = ls_dept_code                       // 부 서 
			 idw_name.object.purchase_price[idx] 	= ll_purchase_price                    // 단가 
			 idw_name.object.purchase_amt[idx] 	   = ll_purchase_amt                    // 금액 
		    idw_name.object.revenue_opt[idx] 		= li_revenue_opt                     // 재 원 
			 idw_name.object.purchase_opt[idx] 	   = li_purchase_opt                    // 구매방법 
			 idw_name.object.room_code[idx] 		   = ls_room_code                       // 사용장소코드
			 idw_name.object.room_name[idx] 		   = ls_room_name                       // 사용장소
			 idw_name.object.oper_opt[idx] 			= li_oper_opt                        // 운용구분 
			 idw_name.object.id_date[idx] 			= ls_id_date                         // 등재일자
	
		    idw_name.object.purchase_date[idx] 	= ls_purchase_dt		                // 구입일자(입고일자)			 
//		    idw_name.object.purchase_dt[idx] 		= datetime(date(string(this.object.in_date[1],'@@@@/@@/@@')),time(00:00:00))  // 구입일자(입고일자)			 
			 idw_name.object.work_date[idx] 		   = f_sysdate()                           // 작업일자	 	
			 idw_name.object.worker[idx] 			   = gstru_uid_uname.uid                   // 작업자  
			 idw_name.object.midd_name[idx] 		   = gstru_uid_uname.s_parm[11]
		    idw_name.object.large_name[idx] 		= gstru_uid_uname.s_parm[12]
			 idw_name.object.useful[idx] 			   = ls_useful_opt                         //구분
//			 idw_name.object.purchase_date[idx]	   = ls_purchase_dt                        //구입일자			 
		
			CHOOSE	CASE li_revenue_opt
					
						CASE 1			/** 교비**/
								idw_name.object.school_amt[idx]		=	ll_purchase_amt
								
						CASE 2			/** 국고**/
								idw_name.object.nation_amt[idx]		=	ll_purchase_amt							
						
						CASE 3			/** 국고대응**/
								idw_name.object.replace_amt[idx]	=	ll_purchase_amt							
							
						CASE 4, 6			/** 자체구입 **/
								idw_name.object.self_amt[idx]		=	ll_purchase_amt							
														
						CASE 5			/** 기증		**/
								idw_name.object.prepare_amt[idx]	=	ll_purchase_amt									
			
			END CHOOSE		
			
	   NEXT
   
	   idw_name. setredraw(true)
	
   ELSE
	
	   messagebox("확인","등재 수량이 등재 잔량보다 큽니다 조정하세요")	
	
	END IF	
	
END IF

IF 	dwo.name = 'purchase_dt'	THEN
		idw_name = tab_sheet.tabpage_sheet01.dw_update
		ls_purchase_dt 				= this.object.purchase_dt[1]		
	   ll_rowcount = dw_update.rowcount()
		
      FOR idx = 1 TO ll_rowcount
		idw_name.object.purchase_date[1]	=	ls_purchase_dt
		NEXT	
		

END IF

IF dwo.name = 'gwa' OR dwo.name = 'item_class' OR dwo.name = 'revenue_opt' OR dwo.name = 'purchase_opt' OR dwo.name = 'oper_opt' OR dwo.name = 'useful_opt' THEN 
   
	idw_name = tab_sheet.tabpage_sheet01.dw_update
	
   ll_rowcount = dw_update.rowcount()

   IF ll_rowcount <> 0 THEN

      ls_dept_code 		= this.object.gwa[1]		
		li_item_class 		= this.object.item_class[1]		
      li_revenue_opt 	= this.object.revenue_opt[1]		
      li_purchase_opt 	= this.object.purchase_opt[1]		
		li_oper_opt 		= this.object.oper_opt[1]		
		ls_useful_opt 		= this.object.useful_opt[1]		
		
      FOR idx = 1 TO ll_rowcount

         idw_name.object.gwa[idx] 				= ls_dept_code                            // 
         idw_name.object.item_class[idx] 	= li_item_class                           // 
			idw_name.object.revenue_opt[idx] 	= li_revenue_opt                          // 
			idw_name.object.purchase_opt[idx]	= li_purchase_opt                         // 
			idw_name.object.oper_opt[idx] 		= li_oper_opt                             // 
			idw_name.object.useful[idx] 			= ls_useful_opt                           // 구분 
			
		NEXT	
		
   END IF
	
END IF

IF  	dwo.name = 'revenue_opt'  THEN 
		idw_name = tab_sheet.tabpage_sheet01.dw_update
	
	   ll_rowcount = dw_update.rowcount()
		ll_purchase_amt 		= this.object.in_price[1]
   	IF ll_rowcount <> 0 THEN
      FOR idx = 1 TO ll_rowcount	
		CHOOSE	CASE li_revenue_opt
					
						CASE 1			/** 교비**/
								idw_name.object.school_amt	[idx]		=	ll_purchase_amt
								idw_name.object.nation_amt	[idx]		=	0
								idw_name.object.replace_amt[idx]		=	0
								idw_name.object.prepare_amt[idx]		=	0
						CASE 2			/** 국고**/
								idw_name.object.nation_amt	[idx]		=	ll_purchase_amt							
								idw_name.object.school_amt	[idx]		=	0
								idw_name.object.replace_amt[idx]		=	0
								idw_name.object.prepare_amt[idx]		=	0
						
						CASE 3			/** 국고대응**/
								idw_name.object.replace_amt[idx]		=	ll_purchase_amt							
								idw_name.object.school_amt	[idx]		=	0
								idw_name.object.nation_amt	[idx]		=	0
								idw_name.object.prepare_amt[idx]		=	0
								
						CASE 4, 6			/** 자체구입**/
								idw_name.object.self_amt[idx]			=	ll_purchase_amt							
								idw_name.object.school_amt	[idx]		=	0
								idw_name.object.nation_amt	[idx]		=	0
								idw_name.object.prepare_amt[idx]		=	0								
							
						CASE 5			/** 기증		**/
								idw_name.object.prepare_amt[idx]		=	ll_purchase_amt		
								idw_name.object.school_amt	[idx]		=	0
								idw_name.object.replace_amt[idx]		=	0
								idw_name.object.nation_amt	[idx]		=	0

			
			END CHOOSE
			NEXT
		END IF
	 END IF	
	  
	///////////////////////////////////////////////////////// 통합 등재 
	IF tab_sheet.tabpage_sheet01.rb_3.checked THEN        
		IF wf_qty_chk() = TRUE THEN

      wf_ml_name(this.object.item_no[1])

      idw_name = tab_sheet.tabpage_sheet01.dw_update

      idw_name.reset()
		
		ll_in_no 				= this.object.in_no[1]
		ls_item_no 				= this.object.item_no[1]
		ls_item_name			= this.object.item_name[1]
		li_item_class 			= this.object.item_class[1]
		ls_item_stand_size	= this.object.item_stand_size[1]
		ls_model 				= this.object.model[1]
		ls_dept_code 			= this.object.apply_gwa[1]
		ll_purchase_price 	= this.object.in_price[1]
		ll_purchase_qty 		= this.object.j_in_qty[1]
		ll_purchase_amt 		= ll_purchase_price * ll_purchase_qty
		ls_purchase_dt 		= this.object.purchase_dt[1]
		li_revenue_opt 		= this.object.revenue_opt[1]
		li_purchase_opt 		= this.object.purchase_opt[1] 
		ls_room_code 			= this.object.room_code[1]
		ls_room_name 			= this.object.room_name[1]
		li_oper_opt 			= this.object.oper_opt[1]
		ls_useful_opt			= this.object.useful_opt[1]
	   ls_id_date				= this.object.id_date[1]
		ls_large_code        = left(ls_item_no,2)
	   select large_name
		into   :ls_big_name
		from   stdb.hst002m
		Where  large_code = :ls_large_code;
		
		
		idw_name.setredraw(false)

		    idw_name.insertrow(0)
          
			 idw_name.object.in_no[idw_name.GetRow()] 				= ll_in_no                           // 입고 번호 
			 idw_name.object.item_no[idw_name.GetRow()] 			   = ls_item_no                         // 품목 코드 
			 idw_name.object.item_name[idw_name.GetRow()] 		   = ls_item_name                       // 품목명
			 idw_name.object.large_name[idw_name.GetRow()] 		   = ls_big_name                      // 대분류명
			 idw_name.object.item_class[idw_name.GetRow()] 		   = li_item_class                      // 품목구분
			 idw_name.object.item_stand_size[idw_name.GetRow()]   = ls_item_stand_size                 // 규 격
			 idw_name.object.model[idw_name.GetRow()] 				= ls_model  
			 idw_name.object.purchase_qty[idw_name.GetRow()]      = ll_purchase_qty                    // 등재수량// 모 델 
			 idw_name.object.gwa[idw_name.GetRow()] 				   = ls_dept_code                       // 부 서 
			 idw_name.object.purchase_price[idw_name.GetRow()] 	= ll_purchase_price                    // 단가 
			 idw_name.object.purchase_amt[idw_name.GetRow()] 	   = ll_purchase_amt                    // 금액 
		    idw_name.object.revenue_opt[idw_name.GetRow()] 		= li_revenue_opt                     // 재 원 
			 idw_name.object.purchase_opt[idw_name.GetRow()] 	   = li_purchase_opt                    // 구매방법 
			 idw_name.object.room_code[idw_name.GetRow()] 		   = ls_room_code                       // 사용장소코드
			 idw_name.object.room_name[idw_name.GetRow()] 		   = ls_room_name                       // 사용장소
			 idw_name.object.oper_opt[idw_name.GetRow()] 			= li_oper_opt                        // 운용구분 
			 idw_name.object.id_date[idw_name.GetRow()] 			   = ls_id_date                         // 등재일자
	
		    idw_name.object.purchase_date[idw_name.GetRow()] 	   = ls_purchase_dt		                // 구입일자(입고일자)			 
//		    idw_name.object.purchase_dt[idx] 		= datetime(date(string(this.object.in_date[1],'@@@@/@@/@@')),time(00:00:00))  // 구입일자(입고일자)			 
			 idw_name.object.work_date[idw_name.GetRow()] 		   = f_sysdate()                           // 작업일자	 	
			 idw_name.object.worker[idw_name.GetRow()] 			   = gstru_uid_uname.uid                   // 작업자  
			 idw_name.object.midd_name[idw_name.GetRow()] 		   = gstru_uid_uname.s_parm[11]
//		    idw_name.object.large_code[idx] 		= gstru_uid_uname.s_parm[12]
			 idw_name.object.useful[idw_name.GetRow()] 			   = ls_useful_opt                         //구분
//			 idw_name.object.purchase_date[idx]	   = ls_purchase_dt                        //구입일자			 
		
			CHOOSE	CASE li_revenue_opt
					
						CASE 1			/** 교비**/
								idw_name.object.school_amt[idw_name.GetRow()]		=	ll_purchase_amt
								
						CASE 2			/** 국고**/
								idw_name.object.nation_amt[idw_name.GetRow()]		=	ll_purchase_amt							
						
						CASE 3			/** 국고대응**/
								idw_name.object.replace_amt[idw_name.GetRow()]	   =	ll_purchase_amt							
							
						CASE 4, 6			/** 자체구입 **/
								idw_name.object.self_amt[idw_name.GetRow()]		   =	ll_purchase_amt							
														
						CASE 5			/** 기증		**/
								idw_name.object.prepare_amt[idw_name.GetRow()]	   =	ll_purchase_amt									
			
			END CHOOSE		
			
	   idw_name. setredraw(true)
	
   ELSE
	
	   messagebox("확인","등재 수량이 등재 잔량보다 큽니다 조정하세요")	
	
	END IF	
	
END IF

IF 	dwo.name = 'purchase_dt'	THEN
		idw_name = tab_sheet.tabpage_sheet01.dw_update
		ls_purchase_dt 				= this.object.purchase_dt[1]		
	   ll_rowcount = dw_update.rowcount()
		
      FOR idx = 1 TO ll_rowcount
		idw_name.object.purchase_date[1]	=	ls_purchase_dt
		NEXT	
		

END IF

IF dwo.name = 'gwa' OR dwo.name = 'item_class' OR dwo.name = 'revenue_opt' OR dwo.name = 'purchase_opt' OR dwo.name = 'oper_opt' OR dwo.name = 'useful_opt' THEN 
   
	idw_name = tab_sheet.tabpage_sheet01.dw_update
	
   ll_rowcount = dw_update.rowcount()

   IF ll_rowcount <> 0 THEN

      ls_dept_code 		= this.object.gwa[1]		
		li_item_class 		= this.object.item_class[1]		
      li_revenue_opt 	= this.object.revenue_opt[1]		
      li_purchase_opt 	= this.object.purchase_opt[1]		
		li_oper_opt 		= this.object.oper_opt[1]		
		ls_useful_opt 		= this.object.useful_opt[1]		
		
         idw_name.object.gwa[idw_name.GetRow()] 				= ls_dept_code                            // 
         idw_name.object.item_class[idw_name.GetRow()] 	   = li_item_class                           // 
			idw_name.object.revenue_opt[idw_name.GetRow()] 	   = li_revenue_opt                          // 
			idw_name.object.purchase_opt[idw_name.GetRow()]	   = li_purchase_opt                         // 
			idw_name.object.oper_opt[idw_name.GetRow()] 		   = li_oper_opt                             // 
			idw_name.object.useful[idw_name.GetRow()] 			= ls_useful_opt                           // 구분 
				
   END IF
	
END IF

IF  	dwo.name = 'revenue_opt'  THEN 
		idw_name = tab_sheet.tabpage_sheet01.dw_update
	
	   ll_rowcount = dw_update.rowcount()
		ll_purchase_amt 		= this.object.in_price[1]
   	IF ll_rowcount <> 0 THEN
		CHOOSE	CASE li_revenue_opt
					
						CASE 1			/** 교비**/
								idw_name.object.school_amt	[idx]		=	ll_purchase_amt
								idw_name.object.nation_amt	[idx]		=	0
								idw_name.object.replace_amt[idx]		=	0
								idw_name.object.prepare_amt[idx]		=	0
						CASE 2			/** 국고**/
								idw_name.object.nation_amt	[idx]		=	ll_purchase_amt							
								idw_name.object.school_amt	[idx]		=	0
								idw_name.object.replace_amt[idx]		=	0
								idw_name.object.prepare_amt[idx]		=	0
						
						CASE 3			/** 국고대응**/
								idw_name.object.replace_amt[idx]		=	ll_purchase_amt							
								idw_name.object.school_amt	[idx]		=	0
								idw_name.object.nation_amt	[idx]		=	0
								idw_name.object.prepare_amt[idx]		=	0
								
						CASE 4, 6			/** 자체구입**/
								idw_name.object.self_amt[idx]			=	ll_purchase_amt							
								idw_name.object.school_amt	[idx]		=	0
								idw_name.object.nation_amt	[idx]		=	0
								idw_name.object.prepare_amt[idx]		=	0								
							
						CASE 5			/** 기증		**/
								idw_name.object.prepare_amt[idx]		=	ll_purchase_amt		
								idw_name.object.school_amt	[idx]		=	0
								idw_name.object.replace_amt[idx]		=	0
								idw_name.object.nation_amt	[idx]		=	0

			
			END CHOOSE
	   END IF
	END IF	
	
END IF	

end event

event key_enter;call super::key_enter;
long ll_rowcount, i
string ls_room_name, ls_room_code, ls_item_no
	
this.accepttext()	
	
IF this.getcolumnname() = 'room_name' THEN                       // 사용장소명
 
	ls_room_name = this.object.room_name[1]

	openwithparm(w_hgm100h,ls_room_name)
		
	IF message.stringparm <> '' THEN

		this.object.room_code[1] = gstru_uid_uname.s_parm[1]
		this.object.room_name[1] = gstru_uid_uname.s_parm[2]	   
						
		idw_name = tab_sheet.tabpage_sheet01.dw_update
	
      ll_rowcount = dw_update.rowcount()

      IF ll_rowcount <> 0 THEN
				
         FOR i = 1 TO ll_rowcount
			
			  idw_name.object.room_code[i] = gstru_uid_uname.s_parm[1]                  // 사용장소코드
		     idw_name.object.room_name[i] = gstru_uid_uname.s_parm[2]                  // 사용장소
			
		   NEXT	
		
       END IF
		
	END IF
END IF	

IF this.getcolumnname() = 'item_no' THEN                         // 품목코드 

s_uid_uname	ls_middle

 
//	ls_item_no = this.object.item_no[1]
ls_middle.uname = this.object.item_no[1]
ls_middle.uid = "c_item_name"

//	openwithparm(w_kch102h,ls_item_no)
	openwithparm(w_hgm001h,ls_middle)
		
	IF message.stringparm <> '' THEN

		this.object.item_no[1] = gstru_uid_uname.s_parm[1]
		this.object.item_name[1] = gstru_uid_uname.s_parm[2]	   
						
		idw_name = tab_sheet.tabpage_sheet01.dw_update
	
	   wf_ml_name(gstru_uid_uname.s_parm[1])
	
      ll_rowcount = dw_update.rowcount()

      IF ll_rowcount <> 0 THEN
			
         FOR i = 1 TO ll_rowcount
			
			  idw_name.object.item_no[i] = gstru_uid_uname.s_parm[1]                  
		     idw_name.object.item_name[i] = gstru_uid_uname.s_parm[2]                
           idw_name.object.midd_name[i] = gstru_uid_uname.s_parm[11]
		     idw_name.object.large_name[i] = gstru_uid_uname.s_parm[12]			  
			  			
		   NEXT	
		
       END IF
		
	END IF
END IF	
end event

event itemerror;call super::itemerror;return 
end event

type cb_1 from commandbutton within tabpage_sheet01
integer x = 3241
integer y = 576
integer width = 457
integer height = 92
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "부대품등록"
end type

event clicked;s_insa_com	lstr_com
string rownumber

idw_name = tab_sheet.tabpage_sheet01.dw_update
rownumber = string(idw_name.getrow())
if tab_sheet.tabpage_sheet01.dw_update.rowcount() < 1 then return

lstr_com.ls_item[1] = idw_name.object.id_no[idw_name.getrow()]	//등재번호
lstr_com.ls_item[2] = idw_name.describe("Evaluate('LookUpDisPlay(item_class)'," + rownumber + ")")	//물품구분명

lstr_com.ll_item[1] = idw_name.object.item_class[idw_name.getrow()]	//물품구분		
lstr_com.ll_item[2] = idw_name.object.revenue_opt[idw_name.getrow()]	//구입재원

OpenWithParm(w_hst201pp,lstr_com)
end event

type dw_list from cuo_dwwindow within tabpage_sheet01
integer x = 18
integer y = 1332
integer width = 3753
integer height = 708
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "물품 입고 내역"
string dataobject = "d_hst201a_4"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;call super::doubleclicked;
long 		ll_in_no, ll_item_Seq
String	ls_req_no

IF row = 0 THEN RETURN

ll_in_no 	= this.object.in_no[row]
ls_req_no 	= this.object.req_no[row]
ll_item_Seq = this.object.item_seq[row]

IF tab_sheet.tabpage_sheet01.dw_head2.retrieve( ll_in_no, ls_req_no, ll_item_Seq ) = 0 THEN
	
	tab_sheet.tabpage_sheet01.dw_head2.reset()
	tab_sheet.tabpage_sheet01.dw_head2.insertrow(0)
ELSE
   tab_sheet.tabpage_sheet01.dw_head2.object.jan_qty[1] = tab_sheet.tabpage_sheet01.dw_head2.object.in_qty[1] - tab_sheet.tabpage_sheet01.dw_head2.object.rsvn_qty[1]
	tab_sheet.tabpage_sheet01.dw_head2.object.purchase_dt[1] = tab_sheet.tabpage_sheet01.dw_list.object.in_date[tab_sheet.tabpage_sheet01.dw_list.getrow()]
	tab_sheet.tabpage_sheet01.dw_head2.object.id_date[1] = f_today()
END IF

tab_sheet.tabpage_sheet01.dw_update.reset()
	
end event

event rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )
//

end event

type rb_2 from radiobutton within tabpage_sheet01
integer x = 1979
integer y = 592
integer width = 347
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 67108864
string text = "개별등재"
end type

type rb_3 from radiobutton within tabpage_sheet01
integer x = 2359
integer y = 592
integer width = 347
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 67108864
string text = "통합등재"
boolean checked = true
end type

type cb_2 from commandbutton within tabpage_sheet01
integer x = 2784
integer y = 576
integer width = 457
integer height = 92
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "바코드 출력"
end type

event clicked;String  ls_item_nm, ls_id_date, ls_ent_no_tot,  ls_dept_cd, ls_dept_nm
String  ls_item_no,  ls_ent_d_no,  ls_pri_dt,  ls_purchase_dt, ls_stand_size
Long    ll_purchase_qty, idx

DataWindow  dw_name
dw_name = tab_sheet.tabpage_sheet01.dw_update
IF dw_name.GetRow() = 0 then
   messagebox('확인','바코드화할 물품을 선택하시기 바랍니다..!')
	RETURN
END IF

ll_purchase_qty  = dw_name.Object.purchase_qty[dw_name.GetRow()]         //등재일자 

IF ll_purchase_qty > 1 THEN
   FOR idx = 1 TO ll_purchase_qty
       u_tty.of_OpenComm()

       ls_id_date     = dw_name.Object.id_date[dw_name.GetRow()]                //등재일자 
       ls_item_no     = dw_name.Object.item_no[dw_name.GetRow()]                //품목번호
       ls_item_nm     = dw_name.Object.item_name[dw_name.GetRow()]              //품명
       ls_stand_size  = dw_name.Object.item_stand_size[dw_name.GetRow()]        //규격
       ls_dept_cd     = dw_name.Object.gwa[dw_name.GetRow()]                    //사용부서
       ls_purchase_dt = dw_name.Object.purchase_date[dw_name.GetRow()]           //구입일자

      //부서명
      SELECT  fname
      INTO    :ls_dept_nm 
      FROM    cddb.kch003m
      WHERE   gwa = :ls_dept_cd ;   

      ls_ent_no_tot = ls_id_date + ls_item_no

		ls_pri_dt  = Left(ls_purchase_dt,4) + "/" + Mid(ls_purchase_dt,5,2) + "/" + Right(ls_purchase_dt,2)
		
		u_tty.of_writecomm(char(02) + 'LmD11H10P3S3' + char(13))
		
		u_tty.of_writecomm('D11' + char( 13 ))
		u_tty.of_writecomm('m' + char( 13 ))
		u_tty.of_writecomm('H10P3S3' + char(13 ))
		u_tty.of_writecomm('1' + char(27) + '1100001800030KD24' + "품명 : " + ls_item_nm + char(13) )
		u_tty.of_writecomm('1' + char(27) + '1100001600030KD24' + "규격 : " + ls_stand_size + char(13) )				
		u_tty.of_writecomm('1O' + '42' +      '07000600030' + ls_ent_no_tot  + char(13))	
		u_tty.of_writecomm('1' + char(27) + '1100000300030KD24' + "취 득 일 : " + ls_pri_dt + char(13) )		
		u_tty.of_writecomm('1' + char(27) + '1100000000030KD24' + "사용부서 : " + ls_dept_nm  + char(13) )		
		u_tty.of_writecomm('E')
	NEXT
ELSE
	    u_tty.of_OpenComm()

       ls_id_date     = dw_name.Object.id_date[dw_name.GetRow()]                //등재일자 
       ls_item_no     = dw_name.Object.item_no[dw_name.GetRow()]                //품목번호
       ls_item_nm     = dw_name.Object.item_name[dw_name.GetRow()]              //품명
       ls_stand_size  = dw_name.Object.item_stand_size[dw_name.GetRow()]        //규격
       ls_dept_cd     = dw_name.Object.gwa[dw_name.GetRow()]                    //사용부서
       ls_purchase_dt = dw_name.Object.purchase_date[dw_name.GetRow()]           //구입일자

      //부서명
      SELECT  fname
      INTO    :ls_dept_nm 
      FROM    cddb.kch003m
      WHERE   gwa = :ls_dept_cd ;   

      ls_ent_no_tot = ls_id_date + ls_item_no

		ls_pri_dt  = Left(ls_purchase_dt,4) + "/" + Mid(ls_purchase_dt,5,2) + "/" + Right(ls_purchase_dt,2)
		
		u_tty.of_writecomm(char(02) + 'LmD11H10P3S3' + char(13))
		
		u_tty.of_writecomm('D11' + char( 13 ))
		u_tty.of_writecomm('m' + char( 13 ))
		u_tty.of_writecomm('H10P3S3' + char(13 ))
		u_tty.of_writecomm('1' + char(27) + '1100001800030KD24' + "품명 : " + ls_item_nm + char(13) )
		u_tty.of_writecomm('1' + char(27) + '1100001600030KD24' + "규격 : " + ls_stand_size + char(13) )				
		u_tty.of_writecomm('1O' + '42' +      '07000600030' + ls_ent_no_tot  + char(13))	
		u_tty.of_writecomm('1' + char(27) + '1100000300030KD24' + "취 득 일 : " + ls_pri_dt + char(13) )		
		u_tty.of_writecomm('1' + char(27) + '1100000000030KD24' + "사용부서 : " + ls_dept_nm  + char(13) )		
		u_tty.of_writecomm('E')

END IF

end event

type st_1 from statictext within tabpage_sheet01
integer x = 352
integer y = 592
integer width = 1614
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "※등재유형을 먼저 선택하시고 사용하시기 바랍니다."
boolean focusrectangle = false
end type

type dw_update1 from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer x = 265
integer y = 852
integer width = 3419
integer taborder = 11
string dataobject = "d_hst201i_55"
borderstyle borderstyle = stylelowered!
end type

type tab_sheet_2 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 3799
integer height = 2064
long backcolor = 79741120
string text = "자산 대장"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print1 dw_print1
gb_2 gb_2
rb_1 rb_1
rb_purchase rb_purchase
rb_class rb_class
rb_item rb_item
end type

on tab_sheet_2.create
this.dw_print1=create dw_print1
this.gb_2=create gb_2
this.rb_1=create rb_1
this.rb_purchase=create rb_purchase
this.rb_class=create rb_class
this.rb_item=create rb_item
this.Control[]={this.dw_print1,&
this.gb_2,&
this.rb_1,&
this.rb_purchase,&
this.rb_class,&
this.rb_item}
end on

on tab_sheet_2.destroy
destroy(this.dw_print1)
destroy(this.gb_2)
destroy(this.rb_1)
destroy(this.rb_purchase)
destroy(this.rb_class)
destroy(this.rb_item)
end on

type dw_print1 from cuo_dwprint within tab_sheet_2
integer x = 37
integer y = 244
integer width = 3735
integer height = 1792
integer taborder = 11
boolean titlebar = true
string title = "자산대장내역"
string dataobject = "d_hst201a_6"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieveend;call super::retrieveend;
Long		ll_total_sum, ll_total_cnt


IF		ROWCOUNT < 1	THEN RETURN

IF dw_head1.AcceptText() = -1 THEN RETURN
//////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
//////////////////////////////////////////////////////////////////////////////////////
String	ls_IdNo				//등재번호
String	ls_ItemNo			//품목코드
String	ls_ItemNm			//품목명
String	ls_Gwa				//부서
String   lS_DateFr			//구입일자(From)
String	lS_DateTo			//구입일자(To)
String	ls_RoomCd			//사용장소
String	ls_ItemClss			//물품구분
String	ls_RevenueOpt		//구입재원
String	ls_OperOpt			//운용구분
String	ls_PurchaseOpt		//구매방법
String	ls_Useful			//구분


ls_IdNo        = TRIM(dw_head1.object.c_id_no    [1]) + '%'			//등재번호
ls_ItemNo      = TRIM(dw_head1.object.c_item_no  [1]) + '%'			//품목코드
ls_ItemNm      = TRIM(dw_head1.object.c_item_name[1]) + '%'			//품목명
ls_Gwa         = TRIM(dw_head1.object.c_dept_code[1]) + '%'			//부서
lS_DateFr      = dw_head1.object.c_date_f[1]								//구입일자(From)
lS_DateTo      = dw_head1.object.c_date_t[1]								//구입일자(To)
ls_RoomCd      = TRIM(dw_head1.object.c_room_code     [1]) + '%'	//사용장소
ls_ItemClss    = String(dw_head1.object.c_item_class  [1]) + '%'	//물품구분
ls_RevenueOpt  = String(dw_head1.object.c_revenue_opt [1]) + '%'	//구입재원
ls_OperOpt     = String(dw_head1.object.c_oper_opt    [1]) + '%'	//운용구분
ls_PurchaseOpt = String(dw_head1.object.c_purchase_opt[1]) + '%'	//구매방법
ls_Useful      = String(dw_head1.object.useful        [1]) + '%'  //구분


//ls_datefr = lS_datefr
//ls_dateto = lS_dateto
IF isNull(ls_IdNo)   THEN ls_IdNo   = '%' 
IF isNull(ls_ItemNo) THEN ls_ItemNo = '%'
IF isNull(ls_ItemNm) THEN ls_ItemNm = '%'
IF isNull(ls_Gwa)    THEN ls_Gwa    = '%'
IF isNull(ls_RoomCd) THEN ls_RoomCd = '%'
IF isNull(ls_ItemClss)   OR ls_ItemClss   = '0%' THEN ls_ItemClss   = '%'
IF isNull(ls_RevenueOpt) OR ls_RevenueOpt = '0%' THEN ls_RevenueOpt = '%'
IF isNull(ls_OperOpt)    OR ls_OperOpt    = '0%' THEN ls_OperOpt    = '%'
IF isNull(ls_PurchaseOpt) THEN ls_PurchaseOpt = '%'
IF isNull(ls_Useful) OR ls_Useful = '0%' THEN ls_Useful = '%'


SELECT 	SUM(TOTAL) TOTAL_SUM, COUNT(B.ITEM_SUB_NO) TOTAL_CNT
INTO		:ll_total_sum, :ll_total_cnt
FROM	(
		SELECT  		A.ID_NO, A.ITEM_CLASS,SUM(A.SCHOOL_AMT+A.NATION_AMT+ A.REPLACE_AMT+A.SELF_AMT) TOTAL, A.ITEM_SUB_NO
		FROM 	 		STDB.HST028H a
		WHERE			A.ITEM_SUB_DATE >= :ls_datefr						 AND
						A.ITEM_SUB_DATE <= :ls_dateto		       			 AND
						A.REVENUE_OPT	LIKE			:ls_RevenueOpt		 								
		GROUP BY 		A.ID_NO, A.ITEM_CLASS, A.ITEM_SUB_NO
		)B		;
	
THIS.OBJECT.T_49.TEXT	=	STRING(ll_total_cnt,'#,###,##0')
THIS.OBJECT.T_50.TEXT	=	STRING(ll_total_sum,'#,###,##0')
THIS.OBJECT.T_51.TEXT	=	String(Long(THIS.OBJECT.T_49.TEXT) + THIS.OBJECT.compute_4[1],'#,###,##0')
THIS.OBJECT.T_52.TEXT	=	String(Long(THIS.OBJECT.T_50.TEXT) + THIS.OBJECT.compute_5[1],'#,###,##0')

end event

type gb_2 from groupbox within tab_sheet_2
integer x = 37
integer y = 40
integer width = 1691
integer height = 176
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "선 택"
end type

type rb_1 from radiobutton within tab_sheet_2
integer x = 837
integer y = 120
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "사용장소별"
end type

event clicked;
tab_sheet.tab_sheet_2.dw_print1.dataobject = 'd_hst201a_8'                 // 사용장소별 
tab_sheet.tab_sheet_2.dw_print1.settransobject(sqlca)
tab_sheet.tab_sheet_2.dw_print1.Object.DataWindow.Print.Preview = 'YES'
wf_print_child()


end event

type rb_purchase from radiobutton within tab_sheet_2
integer x = 1280
integer y = 120
integer width = 416
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "구입일자별"
end type

event clicked;
tab_sheet.tab_sheet_2.dw_print1.dataobject = 'd_hst201a_9'                 // 사용장소별 
tab_sheet.tab_sheet_2.dw_print1.settransobject(sqlca)
tab_sheet.tab_sheet_2.dw_print1.Object.DataWindow.Print.Preview = 'YES'
wf_print_child()


end event

type rb_class from radiobutton within tab_sheet_2
integer x = 384
integer y = 120
integer width = 411
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "물품구분별"
end type

event clicked;
tab_sheet.tab_sheet_2.dw_print1.dataobject = 'd_hst201a_7'                 // 물품 구분 
tab_sheet.tab_sheet_2.dw_print1.settransobject(sqlca)
tab_sheet.tab_sheet_2.dw_print1.Object.DataWindow.Print.Preview = 'YES'
wf_print_child()
end event

type rb_item from radiobutton within tab_sheet_2
integer x = 73
integer y = 120
integer width = 288
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "품목별"
boolean checked = true
end type

event clicked;
tab_sheet.tab_sheet_2.dw_print1.dataobject = 'd_hst201a_6'                 // 품목별 
tab_sheet.tab_sheet_2.dw_print1.settransobject(sqlca)
tab_sheet.tab_sheet_2.dw_print1.Object.DataWindow.Print.Preview = 'YES'
wf_print_child()
end event

type tab_sheet_3 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 3799
integer height = 2064
long backcolor = 79741120
string text = "부대품 내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print2 dw_print2
end type

on tab_sheet_3.create
this.dw_print2=create dw_print2
this.Control[]={this.dw_print2}
end on

on tab_sheet_3.destroy
destroy(this.dw_print2)
end on

type dw_print2 from cuo_dwprint within tab_sheet_3
integer x = 37
integer y = 36
integer width = 3735
integer height = 2000
integer taborder = 21
boolean titlebar = true
string title = "부대품내역"
string dataobject = "d_hst201a_10"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 3799
integer height = 2064
long backcolor = 79741120
string text = "수리내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print3 dw_print3
end type

on tabpage_1.create
this.dw_print3=create dw_print3
this.Control[]={this.dw_print3}
end on

on tabpage_1.destroy
destroy(this.dw_print3)
end on

type dw_print3 from cuo_dwwindow_one_hin within tabpage_1
integer x = 14
integer y = 16
integer width = 3771
integer height = 2040
integer taborder = 11
boolean titlebar = true
string title = "수리내역"
string dataobject = "d_hst201a_20"
end type

type tabpage_2 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 3799
integer height = 2064
long backcolor = 79741120
string text = "물품관리카드"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
sle_id_num sle_id_num
st_2 st_2
dw_print4 dw_print4
gb_5 gb_5
end type

on tabpage_2.create
this.sle_id_num=create sle_id_num
this.st_2=create st_2
this.dw_print4=create dw_print4
this.gb_5=create gb_5
this.Control[]={this.sle_id_num,&
this.st_2,&
this.dw_print4,&
this.gb_5}
end on

on tabpage_2.destroy
destroy(this.sle_id_num)
destroy(this.st_2)
destroy(this.dw_print4)
destroy(this.gb_5)
end on

type sle_id_num from singlelineedit within tabpage_2
integer x = 567
integer y = 100
integer width = 558
integer height = 92
integer taborder = 21
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within tabpage_2
integer x = 293
integer y = 116
integer width = 261
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "등재번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_print4 from cuo_dwwindow_one_hin within tabpage_2
integer x = 14
integer y = 256
integer width = 3762
integer height = 1792
integer taborder = 11
boolean titlebar = true
string title = "물품관리카드"
string dataobject = "d_hst201a_34"
end type

type gb_5 from groupbox within tabpage_2
integer x = 23
integer y = 16
integer width = 3744
integer height = 224
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "조회조건"
end type

type dw_head1 from datawindow within w_hst201i_1
event ue_keydown pbm_dwnkey
integer x = 59
integer y = 88
integer width = 3758
integer height = 276
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst201a_1"
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
   ELSEIF THIS.GetColumnName() = 'c_item_name' THEN		// 사용장소
			ls_middle.uname = this.object.c_item_name[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
	   wf_retrieve()
	END IF
END IF
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

event dberror;return 1
end event

type gb_6 from groupbox within w_hst201i_1
integer x = 18
integer y = 1412
integer width = 3118
integer height = 184
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "자산 등재 조회 조건"
end type

type gb_3 from groupbox within w_hst201i_1
integer x = 32
integer y = 24
integer width = 3817
integer height = 356
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "조회 조건"
end type

