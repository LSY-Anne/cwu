$PBExportHeader$w_hgm502i.srw
$PBExportComments$수리입고관리
forward
global type w_hgm502i from w_msheet
end type
type tab_1 from tab within w_hgm502i
end type
type tabpage_1 from userobject within tab_1
end type
type dw_update from uo_dwfree within tabpage_1
end type
type dw_list from uo_dwgrid within tabpage_1
end type
type dw_search1 from datawindow within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_update dw_update
dw_list dw_list
dw_search1 dw_search1
gb_1 gb_1
gb_2 gb_2
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type sle_ord_no_to from singlelineedit within tabpage_2
end type
type st_5 from statictext within tabpage_2
end type
type sle_ord_no_fr from singlelineedit within tabpage_2
end type
type st_4 from statictext within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type dw_gwa_code from datawindow within tabpage_2
end type
type em_to_date from editmask within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type em_fr_date from editmask within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
sle_ord_no_to sle_ord_no_to
st_5 st_5
sle_ord_no_fr sle_ord_no_fr
st_4 st_4
st_2 st_2
dw_gwa_code dw_gwa_code
em_to_date em_to_date
st_3 st_3
em_fr_date em_fr_date
st_1 st_1
gb_3 gb_3
end type
type tab_1 from tab within w_hgm502i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from u_tab within w_hgm502i
end type
end forward

global type w_hgm502i from w_msheet
integer width = 4507
tab_1 tab_1
uo_1 uo_1
end type
global w_hgm502i w_hgm502i

type variables

s_insa_com	istr_com

String	is_KName		//성명
String	is_MemberNo	//개인번호

string is_IdNo			// 등재번호
string is_applydate	//신청일자
int	 ii_apply_num	//신청번호
int 	 ii_Itemclss		// 품목구분
end variables

forward prototypes
public function boolean wf_apply_no ()
end prototypes

public function boolean wf_apply_no ();////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 기    능 : 조회조건체크
//// 2. 작 성 자 : 김지훈
//// 3. 작 성 일 : 2002.05.04
//// 4. 함수원형 : wf_apply_no RETURN BOOLEAN
//// 5. 인    수 : 
//// 6. 되 돌 림 : TRUE  - 정상
////			   	  FALSE - 오류
////////////////////////////////////////////////////////////////////////////////////////////
//Integer	li_Null
//SetNull(li_Null)
//
//Long		ll_GetRow
//ll_GetRow = dw_list.GetSelectedRow(0)
//IF ll_GetRow = 0 THEN RETURN FALSE
//////////////////////////////////////////////////////////////////////////////////
//// 1. 등재번호 체크
//////////////////////////////////////////////////////////////////////////////////
//String	ls_IdNo
//ls_IdNo = dw_list.Object.id_no[ll_GetRow]
//IF isNull(ls_IdNo) OR LEN(ls_IdNo) = 0 THEN
//	dw_list.SetFocus()
//	RETURN FALSE
//END IF
//////////////////////////////////////////////////////////////////////////////////
//// 2. 품목구분 체크
//////////////////////////////////////////////////////////////////////////////////
//Long		ll_ItemClss
//ll_ItemClss = dw_list.Object.item_class[ll_GetRow]
//IF isNull(String(ll_ItemClss)) OR ll_ItemClss = 0 THEN
//	dw_list.SetFocus()
//	RETURN FALSE
//END IF
//////////////////////////////////////////////////////////////////////////////////
//// 3. 신청일자 체크
//////////////////////////////////////////////////////////////////////////////////
//String	ls_Date
//em_apply_date.GetData(ls_Date)
//IF NOT f_chk_date(ls_Date,'YMD') THEN
//	em_apply_date.SetFocus()
//	RETURN FALSE
//END IF
//////////////////////////////////////////////////////////////////////////////////
//// 4. 전표번호 체크
//////////////////////////////////////////////////////////////////////////////////
//ddlb_apply_no.Reset()
//
//Long		ll_ApplyNo
//
//DECLARE	CUR_SOR	CURSOR FOR
//
//SELECT	NVL(A.APPLY_NO,0)
//FROM		STDB.HST030H	A
//WHERE		A.IN_NO      = '1'
//AND		A.ITEM_CLASS = :ll_ItemClss
//AND		A.APPLY_DATE = :ls_Date
//ORDER	BY	A.SEQ
//USING		SQLCA;
//
//OPEN CUR_SOR;
//
//FETCH	CUR_SOR	INTO :ll_ApplyNo;
//
//DO WHILE SQLCA.SQLCODE = 0
//	
//	ddlb_apply_no.AddItem(String(ll_ApplyNo,'0000'))
//	
//	FETCH	CUR_SOR	INTO :ll_ApplyNo;
//LOOP
//
//CLOSE CUR_SOR;
//
//Long	ll_i
//ll_i = ddlb_apply_no.TotalItems()
//ddlb_apply_no.SelectItem(ll_i)
//
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////
//// END OF GLOBAL FUNCITON
//////////////////////////////////////////////////////////////////////////////////
end function

on w_hgm502i.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_hgm502i.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
end on

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_open
////	기 능 설 명: 초기화 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 등록용 - 품목구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////////

f_childretrieve(tab_1.tabpage_1.dw_update,"sign_yn","payment_class")         // 물품구분(조회조건) 
f_childretrieve(tab_1.tabpage_1.dw_update,"proof_gubun","proof_gubun")         // 증빙구분 
f_childretrieve(tab_1.tabpage_2.dw_print,"proof_gubun","proof_gubun")         // 증빙구분 
//wf_setMenu('I',FALSE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',FALSE)
//wf_setMenu('U',FALSE)


tab_1.tabpage_2.em_fr_date.text  = left(f_today(),6) + '01'
tab_1.tabpage_2.em_to_date.text  = f_today()

Long ll_InsRow
DataWindowChild	ldwc_Temp
tab_1.tabpage_2.dw_gwa_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa','0000')
	ldwc_Temp.SetItem(ll_InsRow,'fname','전체')
	ldwc_Temp.SetSort('gwa ASC')
	ldwc_Temp.Sort()
END IF   
tab_1.tabpage_2.dw_print.Object.DataWindow.print.preview = 'YES'
func.of_design_dw(tab_1.tabpage_1.dw_update)
tab_1.tabpage_1.dw_update.settransobject(sqlca)
tab_1.tabpage_1.dw_update.insertrow(0)

idw_print = tab_1.tabpage_2.dw_print
THIS.TRIGGER EVENT ue_init()
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_init;call super::ue_init;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_init
////	기 능 설 명: 초기화 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 변경사항체크
/////////////////////////////////////////////////////////////////////////////////////////
Integer	li_Rtn

IF tab_1.tabpage_1.dw_update.AcceptText() = -1 THEN RETURN
IF tab_1.tabpage_1.dw_update.DeletedCount() > 0 OR tab_1.tabpage_1.dw_update.ModifiedCount() > 0 THEN
	li_Rtn = MessageBox('확인','변경된 자료가 있지만 아직 저장하지 않았습니다.~r~n' + &
										'저장하지 않고 다른 작업을 하시려면 [예]를 누르십시오.',Question!,YesNo!,2)
	
	CHOOSE CASE	li_Rtn
		CASE 1
		CASE 2
       tab_1.tabpage_1.dw_update.SetFocus()
			RETURN
		CASE ELSE
			
	END CHOOSE
END IF

/////////////////////////////////////////////////////////////////////////////////////
// 2. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_list.Reset()
tab_1.tabpage_1.dw_update.Reset()
tab_1.tabpage_1.dw_update.InsertRow(0)


tab_1.tabpage_1.dw_search1.Reset()
tab_1.tabpage_1.dw_search1.InsertRow(0)

tab_1.tabpage_2.dw_gwa_code.reset()
tab_1.tabpage_2.dw_gwa_code.insertrow(0)
/////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성화/비활성화처리, 포커스이동
/////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('I',FALSE)	//입력버튼
//wf_setMenu('R',TRUE)		//조회버튼
//wf_Setmenu('D',TRUE)	//삭제버튼
//wf_Setmenu('S',FALSE)	//저장버튼
//wf_Setmenu('P',FALSE)	//인쇄버튼

////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
///////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow, ll_row_cnt
Long		ll_RowCnt, ll_item_Seq
String	ls_IDNO			, ls_req_no//등재번호
Long		ll_ItemClss		//품목구분
String	ls_ApplyDate	//신청일자
Long		ll_ApplyNo		//신청번호
string 	ls_ord_no, ls_cust_nm, ls_item_nm, ls_item_class
Long     li_chk, ll_tab

ll_tab = tab_1.selectedtab

CHOOSE CASE ll_tab
		
	CASE 1
      //////////////////////////////////////////////////////////////////////////////////////////
      // 1. 조회조건 체크
      ///////////////////////////////////////////////////////////////////////////////////////

      tab_1.tabpage_1.dw_search1.accepttext()

	    //주문번호
      ls_ord_no = TRIM(tab_1.tabpage_1.dw_search1.object.jumun_no[1])
      IF isNull(ls_ord_no) OR LEN(ls_ord_no) = 0 THEN ls_ord_no = '%'

	    //품목코드
      ls_item_class = TRIM(tab_1.tabpage_1.dw_search1.object.item_code[1])
      IF isNull(ls_item_class) OR LEN(ls_item_class) = 0 THEN ls_item_class = '%'

	    //거래처명
      ls_cust_nm = TRIM(tab_1.tabpage_1.dw_search1.object.cust_name[1])
      IF isNull(ls_cust_nm) OR LEN(ls_cust_nm) = 0 THEN ls_cust_nm = '%'

       //입고여부
      li_chk = tab_1.tabpage_1.dw_search1.object.c_chk[1]

      //품목명
      ls_item_nm = TRIM(tab_1.tabpage_1.dw_search1.object.item_name[1])
      IF isNull(ls_item_nm) OR LEN(ls_item_nm) = 0 THEN ls_item_nm = '%'


      SetPointer(HourGlass!)
      ///////////////////////////////////////////////////////////////////////////////////////
      // 2. 자료조회
      ///////////////////////////////////////////////////////////////////////////////////////
      tab_1.tabpage_1.dw_list.Settransobject(sqlca)
      tab_1.tabpage_1.dw_list.SetReDraw(FALSE)
      tab_1.tabpage_1.dw_update.setredraw(false)
      ll_rowcnt = tab_1.tabpage_1.dw_list.retrieve(ls_ord_no, ls_item_class, li_chk, ls_cust_nm, ls_item_nm)
      tab_1.tabpage_1.dw_list.SetReDraw(true)

      ///////////////////////////////////////////////////////////////////////////////////////
      // 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
      ///////////////////////////////////////////////////////////////////////////////////////
      IF ll_RowCnt = 0 THEN 
//      	wf_SetMenu('I',FALSE)
//	      wf_SetMenu('D',TRUE)
//	      wf_SetMenu('S',FALSE)
//	      wf_SetMenu('R',TRUE)
	      wf_SetMsg('해당자료가 존재하지 않습니다.')
         tab_1.tabpage_1.dw_update.reset()
	      tab_1.tabpage_1.dw_update.Insertrow(0)
	      tab_1.tabpage_1.dw_update.Object.DataWindow.ReadOnly = 'YES'
      ELSE
//	      wf_SetMenu('I',FALSE)
//	      wf_SetMenu('D',TRUE)
//	      wf_SetMenu('S',TRUE)
//	      wf_SetMenu('R',TRUE)
	      tab_1.tabpage_1.dw_update.Object.DataWindow.ReadOnly = 'NO'		
	      wf_SetMsg('자료가 조회되었습니다.')
	      tab_1.tabpage_1.dw_list.trigger event rowfocuschanged(1)	
      END IF
         tab_1.tabpage_1.dw_update.SetReDraw(TRUE)
CASE 2
	 string  ls_ord_numfr, ls_ord_numto
	 string	ls_gwa_code
	 string	ls_fr_date, ls_to_date
	
		 ls_gwa_code = trim(tab_1.tabpage_2.dw_gwa_code.Object.code[1]) 
		 ls_fr_date  = left(tab_1.tabpage_2.em_fr_date.text,4)+mid(tab_1.tabpage_2.em_fr_date.text,6,2)+ &
		               right(tab_1.tabpage_2.em_fr_date.text,2)
		 ls_to_date  = left(tab_1.tabpage_2.em_to_date.text,4)+mid(tab_1.tabpage_2.em_to_date.text,6,2)+ &
		               right(tab_1.tabpage_2.em_to_date.text,2)
		 
		 IF isnull(ls_gwa_code) OR ls_gwa_code = '' THEN
			 ls_gwa_code = '%'
		 ELSE
			 ls_gwa_code = trim(tab_1.tabpage_2.dw_gwa_code.Object.code[1]) 
		 END IF 
		 
		 ls_ord_numfr  = tab_1.tabpage_2.sle_ord_no_fr.text
		 ls_ord_numto	= tab_1.tabpage_2.sle_ord_no_to.text
		
		 IF isnull(ls_ord_numfr) OR ls_ord_numfr = '' THEN  ls_ord_numfr = '0000000000'
		 IF isnull(ls_ord_numto) OR ls_ord_numto = '' THEN  ls_ord_numto = '9999999999'
		 
		 ll_RowCnt = tab_1.tabpage_2.dw_print.retrieve( ls_fr_date, ls_to_Date, ls_gwa_code, ls_ord_numfr, ls_ord_numto)

//		 	 FOR idx = ll_RowCnt  TO 24
//				  tab_sheet.tabpage_1.dw_print.insertRow(0)
//			 NEXT
     
	  IF ll_RowCnt <> 0 THEN
      String ls_gwa, ls_member_no
		int    i
       for  i =1 to tab_1.tabpage_2.dw_print.rowcount()
       
		    	ls_member_no = tab_1.tabpage_2.dw_print.object.hst030h_audit_member_no[i]
            select gwa
		      into  :ls_gwa
		      from  indb.hin001m
		      where member_no = :ls_member_no;
	  
		    	tab_1.tabpage_2.dw_print.object.hst032h_dept_code[i] = ls_gwa 
	    next
	  END IF 
	  
		 IF ll_RowCnt = 0 THEN
			 wf_SetMsg('조회된 자료가없습니다..!')
//			 wf_Setmenu('R',TRUE)
		 ELSE
			 wf_SetMsg('자료가 조회되었습니다..!')
//			 wf_Setmenu('R',TRUE)
//			 wf_Setmenu('p',TRUE)
		 END IF
END CHOOSE
return 1
////////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;
int li_row, i, li_status
string ls_cust_no, ls_ord_no, ls_deli_dt
decimal ld_vat_dt, ld_ord_dt
string  ls_id_no,  ls_new_ord_no, ls_apply_date, ls_ord_class
STring  ls_audit_member_no,ls_audit_position 
long ll_item_class, ll_apply_no

	  tab_1.tabpage_1.dw_update.accepttext()	
	  
	   tab_1.tabpage_1.dw_list.accepttext()     

	  
 	  IF f_chk_modified(tab_1.tabpage_1.dw_update) = FALSE THEN RETURN -1
    

	  string ls_colarry[] = {'dept_code/부서,ord_amt/금액,vat_amt/부가세,audit_member_no/검수자'}
	   
		ls_ord_no = tab_1.tabpage_1.dw_update.object.ord_no[1]
		update  stdb.hst032h
		set     ord_class = 7
		where   ord_no  = :ls_ord_no;
		  
		update  stdb.hst030h
		set     stat_class = 7
		where   ord_no  = :ls_ord_no;
		
		  IF SQLCA.SQLCODE <> 0 	THEN
			     wf_SetMsg('저장중 오류가 발생하였습니다.')
			     ROLLBACK;
			    RETURN -1
	      END IF
			
		IF f_update( tab_1.tabpage_1.dw_update,'U') = TRUE THEN 
			wf_setmsg("저장되었습니다")			  
		END IF



//f_setpointer('END')

end event

event ue_delete;call super::ue_delete;
int li_tab, li_rowcount
long li_row, ll_in_no
string ls_ord_no
	      			
		dwItemStatus l_status 
		l_status = tab_1.tabpage_1.dw_update.getitemstatus(1, 0, Primary!)
	
		IF l_status = New! OR l_status = NewModified! THEN 

		ELSE
			
			IF messagebox("확인","입고를 취소하시겠습니까?", Question!, YesNo! ,2 ) = 1 THEN
				
					  
            ls_ord_no = tab_1.tabpage_1.dw_update.object.ord_no[1]
		  
			   UPDATE STDB.HST032H        // 발주 테이블에 발주 상태를 '발주'로 바꾼다(1:발주,2:입고) 
			   SET ORD_CLASS = 6           
			   WHERE ORD_NO = :ls_ord_no  ;
	
				UPDATE STDB.HST030H        // 발주 테이블에 발주 상태를 '발주'로 바꾼다(1:발주,2:입고) 
			   SET    stat_CLASS = 6,
				       audit_member_no = '',
						 audit_position  = '',
						 audit_date      = ''
			   WHERE ORD_NO = :ls_ord_no  ;
				
			  IF SQLCA.SQLCODE <> 0 	THEN
			     wf_SetMsg('저장중 오류가 발생하였습니다.')
			     ROLLBACK;
			    RETURN
	        END IF							  
//				IF f_update( dw_update,'D') = TRUE THEN 
					wf_setmsg("입고 취소되었습니다")
//				END IF
           THIS.TRIGGER EVENT UE_RETRIEVE()
			END IF		
		END IF
	

end event

event ue_print;call super::ue_print;//f_print(tab_1.tabpage_2.dw_print)
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "수리 검수 조서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hgm502i
end type

type ln_tempright from w_msheet`ln_tempright within w_hgm502i
end type

type ln_temptop from w_msheet`ln_temptop within w_hgm502i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hgm502i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hgm502i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hgm502i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hgm502i
end type

type uc_insert from w_msheet`uc_insert within w_hgm502i
end type

type uc_delete from w_msheet`uc_delete within w_hgm502i
end type

type uc_save from w_msheet`uc_save within w_hgm502i
end type

type uc_excel from w_msheet`uc_excel within w_hgm502i
end type

type uc_print from w_msheet`uc_print within w_hgm502i
end type

type st_line1 from w_msheet`st_line1 within w_hgm502i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hgm502i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hgm502i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hgm502i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hgm502i
end type

type tab_1 from tab within w_hgm502i
integer x = 55
integer y = 156
integer width = 4384
integer height = 2132
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

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2012
string text = "수리입고관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update dw_update
dw_list dw_list
dw_search1 dw_search1
gb_1 gb_1
gb_2 gb_2
end type

on tabpage_1.create
this.dw_update=create dw_update
this.dw_list=create dw_list
this.dw_search1=create dw_search1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_update,&
this.dw_list,&
this.dw_search1,&
this.gb_1,&
this.gb_2}
end on

on tabpage_1.destroy
destroy(this.dw_update)
destroy(this.dw_list)
destroy(this.dw_search1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type dw_update from uo_dwfree within tabpage_1
integer x = 69
integer y = 1344
integer width = 4229
integer height = 628
integer taborder = 50
string dataobject = "d_hgm502i_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;////////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: buttonclikced::dw_update
//	기 능 설 명: 데이타윈도우 버튼 클릭시 처리사항
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
IF row = 0 THEN RETURN
IF UPPER(THIS.Object.DataWindow.ReadOnly) = 'YES' THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
ls_ColName = STRING(dwo.name)

CHOOSE CASE ls_ColName
	CASE 'btn_audit_member'
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1 입력여부 체크
		/////////////////////////////////////////////////////////////////////////////////
		THIS.AcceptText()
		
		s_insa_com	lstr_com
		String	ls_Name
		
		ls_Name = TRIM(THIS.Object.member_name[row])
	
		lstr_com.ls_item[1] = ls_Name		//성명
		lstr_com.ls_item[2] = ''			//개인번호
		lstr_com.ls_item[3] = ''			//개인번호		
		/////////////////////////////////////////////////////////////////////////////////
		// 2.2 교직원 도움말 오픈
		/////////////////////////////////////////////////////////////////////////////////
		OpenWithParm(w_hIN000H,lstr_com)
		
		istr_com = Message.PowerObjectParm
		IF NOT isValid(istr_com) THEN
			THIS.SetFocus()
			RETURN
		END IF
		
		is_KName    = istr_com.ls_item[01]	//성명
		is_MemberNo = istr_com.ls_item[02]	//개인번호
		
	   THIS.Object.member_name [row] = is_KName		//성명
	   THIS.Object.audit_member_no[row] = is_MemberNo	//개인번호

		THIS.SetFocus()
	CASE ELSE
END CHOOSE

////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////
end event

event doubleclicked;call super::doubleclicked;
int li_getrow
string ls_audit_member_no

this.accepttext()	
	
IF dwo.name = 'audit_member_no' THEN                       // 검수자 
 
   li_getrow = this.getrow()
 
	ls_audit_member_no = this.object.audit_member_no[li_getrow]

	openwithparm(w_hgm200h,ls_audit_member_no)
		
	IF message.stringparm <> '' THEN
		
		this.object.audit_member_no[li_getrow] = gstru_uid_uname.s_parm[1]
//		this.object.name[li_getrow] = gstru_uid_uname.s_parm[2]
		
	END IF
	
END IF

end event

type dw_list from uo_dwgrid within tabpage_1
integer x = 14
integer y = 304
integer width = 4320
integer height = 956
integer taborder = 40
boolean titlebar = true
string title = "수리발주내역"
string dataobject = "d_hgm502i_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

string ls_ord_no, ls_req_no
long	ll_item_seq

this.accepttext()

IF currentrow <> 0 THEN

ls_ord_no   =  this.object.ord_no[currentrow] 
//ls_req_no	=	this.object.req_no[currentrow]
//ll_item_Seq	=	this.object.item_seq[currentrow]
	
	IF dw_update.retrieve(ls_ord_no) <> 0 THEN
	
//	   tab_sheet.tabpage_sheet01.dw_list2.setfocus()
//	   tab_sheet.tabpage_sheet01.dw_list2.trigger event rowfocuschanged(1)  
		
   END IF

END IF


end event

type dw_search1 from datawindow within tabpage_1
event dn_key pbm_dwnkey
integer x = 123
integer y = 76
integer width = 3520
integer height = 192
integer taborder = 20
string title = "none"
string dataobject = "d_hgm502i_4"
boolean border = false
boolean livescroll = true
end type

event dn_key;String	ls_room_name
s_uid_uname	ls_middle


THIS.AcceptText()

IF key = KeyEnter! THEN 
	IF THIS.GetColumnName() = 'room' THEN				// 사용장소
		ls_room_name = THIS.object.room[1]
		OpenWithParm(w_hgm100h,ls_room_name)
		IF message.stringparm <> '' THEN
//			THIS.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
//			THIS.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
			THIS.object.room[1] = gstru_uid_uname.s_parm[2]	   
		END IF
   ELSEIF THIS.GetColumnName() = 'item_name' THEN		// 품목명
			ls_middle.uname = this.object.item_name[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

//				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
//				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
				this.object.item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
//	   wf_retrieve()
	END IF
END IF

end event

event constructor;f_pro_toggle('k',handle(parent))
end event

event doubleclicked;String	ls_room_name
s_uid_uname	ls_middle


THIS.AcceptText()

	IF dwo.name = 'room' THEN				// 사용장소
		ls_room_name = THIS.object.room[1]
		OpenWithParm(w_hgm100h,ls_room_name)
		IF message.stringparm <> '' THEN
//			THIS.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
//			THIS.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
			THIS.object.room[1] = gstru_uid_uname.s_parm[2]	   
		END IF
   ELSEIF dwo.name = 'item_name' THEN		// 품목명
			ls_middle.uname = this.object.item_name[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

//				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
//				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
				this.object.item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
//	   wf_retrieve()
	END IF

end event

type gb_1 from groupbox within tabpage_1
integer x = 18
integer y = 12
integer width = 4320
integer height = 288
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type gb_2 from groupbox within tabpage_1
integer x = 18
integer y = 1272
integer width = 4320
integer height = 732
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "입고내역"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2012
string text = "수리입고 검수조서 출력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
sle_ord_no_to sle_ord_no_to
st_5 st_5
sle_ord_no_fr sle_ord_no_fr
st_4 st_4
st_2 st_2
dw_gwa_code dw_gwa_code
em_to_date em_to_date
st_3 st_3
em_fr_date em_fr_date
st_1 st_1
gb_3 gb_3
end type

on tabpage_2.create
this.dw_print=create dw_print
this.sle_ord_no_to=create sle_ord_no_to
this.st_5=create st_5
this.sle_ord_no_fr=create sle_ord_no_fr
this.st_4=create st_4
this.st_2=create st_2
this.dw_gwa_code=create dw_gwa_code
this.em_to_date=create em_to_date
this.st_3=create st_3
this.em_fr_date=create em_fr_date
this.st_1=create st_1
this.gb_3=create gb_3
this.Control[]={this.dw_print,&
this.sle_ord_no_to,&
this.st_5,&
this.sle_ord_no_fr,&
this.st_4,&
this.st_2,&
this.dw_gwa_code,&
this.em_to_date,&
this.st_3,&
this.em_fr_date,&
this.st_1,&
this.gb_3}
end on

on tabpage_2.destroy
destroy(this.dw_print)
destroy(this.sle_ord_no_to)
destroy(this.st_5)
destroy(this.sle_ord_no_fr)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.dw_gwa_code)
destroy(this.em_to_date)
destroy(this.st_3)
destroy(this.em_fr_date)
destroy(this.st_1)
destroy(this.gb_3)
end on

type dw_print from datawindow within tabpage_2
integer x = 23
integer y = 256
integer width = 4320
integer height = 1748
integer taborder = 40
string title = "none"
string dataobject = "d_hgm502i_6"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type sle_ord_no_to from singlelineedit within tabpage_2
integer x = 3250
integer y = 96
integer width = 498
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within tabpage_2
integer x = 3195
integer y = 120
integer width = 64
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "~~"
boolean focusrectangle = false
end type

type sle_ord_no_fr from singlelineedit within tabpage_2
integer x = 2674
integer y = 100
integer width = 503
integer height = 92
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within tabpage_2
integer x = 2386
integer y = 112
integer width = 261
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "발주번호"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_2
integer x = 1362
integer y = 120
integer width = 128
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "부서"
boolean focusrectangle = false
end type

type dw_gwa_code from datawindow within tabpage_2
integer x = 1486
integer y = 96
integer width = 777
integer height = 88
integer taborder = 30
string dataobject = "d_hgm201i_7"
boolean border = false
boolean livescroll = true
end type

type em_to_date from editmask within tabpage_2
integer x = 882
integer y = 100
integer width = 393
integer height = 92
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_3 from statictext within tabpage_2
integer x = 818
integer y = 96
integer width = 64
integer height = 84
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "~~"
boolean focusrectangle = false
end type

type em_fr_date from editmask within tabpage_2
integer x = 416
integer y = 100
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_1 from statictext within tabpage_2
integer x = 146
integer y = 124
integer width = 279
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "검수일자"
boolean focusrectangle = false
end type

type gb_3 from groupbox within tabpage_2
integer x = 23
integer width = 4320
integer height = 244
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type uo_1 from u_tab within w_hgm502i
integer x = 1358
integer y = 136
integer height = 148
integer taborder = 40
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

