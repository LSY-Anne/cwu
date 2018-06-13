$PBExportHeader$w_hfn803p.srw
$PBExportComments$세금계산서합계표
forward
global type w_hfn803p from w_hfn_print_form5
end type
end forward

global type w_hfn803p from w_hfn_print_form5
integer height = 2724
end type
global w_hfn803p w_hfn803p

type variables

end variables

forward prototypes
public subroutine wf_update (string as_frdate, string as_todate)
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_update (string as_frdate, string as_todate);String   Ls_Business_No, Ls_Tax_Class, ls_tax_cust_no
Long     Ll_Sum_Of_Tax, Ll_Blank, Ll_Seq = 1
Dec{0}   Ldc_Amt, Ldc_Tax_Amt
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IpAddr		//등록단말기
String	ls_jumin_gbn

ldt_WorkDate = f_sysdate()					//등록일자
ls_Worker    = gs_empcode		//등록자
ls_IpAddr    = gs_ip	//등록단말기

// 합계표 종류
If dw_con.object.item[1] = '1' Then
	Ls_Tax_Class = '1'
Else
	Ls_Tax_Class = '2'
End If

// 기 작성된 집계자료 삭제
DELETE FROM FNDB.HFN602H
WHERE	 ACCT_CLASS = :GI_ACCT_CLASS
AND	 RPT_FDATE  = :AS_FRDATE
AND    TAX_CLASS  = :LS_TAX_CLASS ;

// 집계자료 삽입
DECLARE CUR_SUM CURSOR FOR
SELECT 	B.BUSINESS_NO,
			A.TAX_CUST_NO,
			COUNT(A.TAX_CUST_NO),
			NVL(SUM(A.TAX_AMT),0),
			NVL(SUM(A.TAX_VAT),0),
			A.JUMIN_GBN
FROM   	FNDB.HFN007M A, 
			STDB.HST001M B
WHERE  	A.TAX_CUST_NO 	= B.CUST_NO (+)
AND	 	A.ACCT_CLASS 	= :GI_ACCT_CLASS
AND    	A.TAX_DATE 		BETWEEN :AS_FRDATE AND :AS_TODATE
AND    	A.TAX_TYPE  	= '2'
AND	 	A.TAX_GUBUN 	= :LS_TAX_CLASS
GROUP BY B.BUSINESS_NO, A.TAX_CUST_NO, A.JUMIN_GBN
ORDER BY B.BUSINESS_NO ;

OPEN CUR_SUM ;

FETCH CUR_SUM INTO :Ls_Business_No, :ls_tax_cust_no, :Ll_Sum_Of_Tax, :Ldc_Amt, :Ldc_Tax_Amt, :ls_jumin_gbn ;

DO WHILE SQLCA.SQLCODE = 0
	Ll_Blank = 14 - Len(String(Ldc_Amt))
	
	string	ls_business_opt
	
	if ls_jumin_gbn = 'Y' then	//개인
		ls_business_opt = '2'
	else
		ls_business_opt = '1'
	end if
	
	INSERT INTO FNDB.HFN602H
	     VALUES (:gi_acct_class,
		  			 :as_frdate,
		          '1',
					 :LS_TAX_CLASS,
					 :ls_business_opt,
					 :Ll_Seq,
					 :as_todate,
					 :Ls_Business_No,
					 :Ll_Sum_Of_Tax,
					 :Ll_Blank,
					 :Ldc_Amt,
					 :Ldc_Tax_Amt,
					 :Ls_Worker,
					 :Ls_Ipaddr,
					 :Ldt_WorkDate,
					 :Ls_Worker,
					 :Ls_Ipaddr,
					 :Ldt_WorkDate,
					 :ls_tax_cust_no ) ;
					 
	Ll_Seq ++

   FETCH CUR_SUM INTO :Ls_Business_No, :ls_tax_cust_no, :Ll_Sum_Of_Tax, :Ldc_Amt, :Ldc_Tax_Amt, :ls_jumin_gbn ;
LOOP

CLOSE CUR_SUM ;

COMMIT USING SQLCA;

end subroutine

public subroutine wf_retrieve ();string	ls_tax_class, ls_date, ls_str_date, ls_end_date
date		ld_date

dw_con.accepttext()
ls_date = string(dw_con.object.em_date[1], 'yyyymmdd')

dw_print.Reset()

// 합계표 종류
If dw_con.object.item[1] = '1' Then
	ls_tax_class = '1'
Else
	ls_tax_class = '2'
End If

if dw_con.object.bungi[1] = '1' then
	ls_str_date = String(dw_con.object.year[1], 'yyyy') + '0101'
	ls_end_date = String(dw_con.object.year[1], 'yyyy') + '0331'
elseif dw_con.object.bungi[1] = '2' then
	ls_str_date = String(dw_con.object.year[1], 'yyyy') + '0401'
	ls_end_date = String(dw_con.object.year[1], 'yyyy') + '0630'
elseif dw_con.object.bungi[1] = '3' then
	ls_str_date = String(dw_con.object.year[1], 'yyyy') + '0701'
	ls_end_date = String(dw_con.object.year[1], 'yyyy') + '0930'
else
	ls_str_date = String(dw_con.object.year[1], 'yyyy') + '1001'
	ls_end_date = String(dw_con.object.year[1], 'yyyy') + '1231'
end if

wf_setMsg('조회중')

// 집계처리
wf_Update(ls_str_date, ls_end_date)

dw_print.SetRedraw(False)

 dw_print.retrieve(gi_acct_class, ls_str_date, ls_tax_class, ls_date) 

dw_print.SetRedraw(True)
wf_setMsg('')

end subroutine

on w_hfn803p.create
int iCurrent
call super::create
end on

on w_hfn803p.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//string  ls_sys_date
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//
//ls_sys_date = f_today()
//
//em_year.text = mid(ls_sys_date,1,4)
//
//choose case mid(ls_sys_date,5,2)
//	case '01', '02', '03'
//		ddlb_bungi.selectitem(1)
//	case '04', '05', '06'
//		ddlb_bungi.selectitem(2)
//	case '07', '08', '09'
//		ddlb_bungi.selectitem(3)
//	case '10', '11', '12'
//		ddlb_bungi.selectitem(4)
//	case else
//		ddlb_bungi.selectitem(1)
//end choose
//
//em_date.text = string(ls_sys_date, '@@@@/@@/@@')
//
//ddlb_item.SelectItem(1)
//ddlb_gubun.SelectItem(1)
//
end event

event ue_postopen;call super::ue_postopen;string  ls_sys_date

ls_sys_date = f_today()

dw_con.object.year[1] = date(String(ls_sys_date, '@@@@/@@/@@'))

choose case mid(ls_sys_date,5,2)
	case '01', '02', '03'
		dw_con.object.bungi[1] = '1'
	case '04', '05', '06'
		dw_con.object.bungi[1] = '2'
	case '07', '08', '09'
		dw_con.object.bungi[1] = '3'
	case '10', '11', '12'
		dw_con.object.bungi[1] = '4'
	case else
		dw_con.object.bungi[1] = '1'
end choose

dw_con.object.em_date[1] = date(String(ls_sys_date, '@@@@/@@/@@'))
dw_con.object.item[1] = '1'
dw_con.object.gubun[1] = '1'
idw_print = dw_print

end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "세금계산서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn803p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn803p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn803p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn803p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn803p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn803p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn803p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn803p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn803p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn803p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn803p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn803p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn803p
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn803p
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn803p
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn803p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn803p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn803p
boolean visible = false
integer x = 2085
integer y = 840
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn803p
boolean visible = false
integer x = 1198
integer y = 16
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn803p
integer height = 1984
integer taborder = 50
string dataobject = "d_hfn803p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn803p
string dataobject = "d_hfn803p_con"
end type

event dw_con::itemchanged;call super::itemchanged;accepttext()
Choose Case dwo.name
	Case 'gubun'
		If dw_con.object.item[1] = '1' Then
		   If data = '1' Then
			dw_print.DataObject = 'd_hfn803p_1'
		   Else
			   dw_print.DataObject = 'd_hfn803p_2'
		   End If
		Else
		   If data = '1' Then
			   dw_print.DataObject = 'd_hfn803p_3'
		   Else
			   dw_print.DataObject = 'd_hfn803p_4'
		   End If
		End If
		
		dw_print.SetTransObject(SQLCA)
		dw_print.Modify("datawindow.print.preview = 'yes'")
	Case 'item'
		dw_con.object.gubun[1] = '1'
		
		If data = '1' Then
		  	dw_print.DataObject = 'd_hfn803p_1'		  
		Else
		     dw_print.DataObject = 'd_hfn803p_3'
		   
		End If
		
		dw_print.SetTransObject(SQLCA)
		dw_print.Modify("datawindow.print.preview = 'yes'")
End Choose


end event

