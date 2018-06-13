$PBExportHeader$w_hpa412a.srw
$PBExportComments$new연말정산소득공제등록
forward
global type w_hpa412a from w_msheet
end type
type ln_temp1 from line within w_hpa412a
end type
type ln_temp2 from line within w_hpa412a
end type
type ln_1 from line within w_hpa412a
end type
type dw_main from uo_dwfree within w_hpa412a
end type
type tab_1 from tab within w_hpa412a
end type
type tabpage_1 from userobject within tab_1
end type
type r_tab1 from rectangle within tabpage_1
end type
type dw_tab1 from uo_dwlv within tabpage_1
end type
type dw_tab1_1 from uo_dwfree within tabpage_1
end type
type tabpage_1 from userobject within tab_1
r_tab1 r_tab1
dw_tab1 dw_tab1
dw_tab1_1 dw_tab1_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tab2 from uo_dwlv within tabpage_2
end type
type r_tab2 from rectangle within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_tab2 dw_tab2
r_tab2 r_tab2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_tab3_1 from uo_dwlv within tabpage_3
end type
type dw_tab3 from uo_dwlv within tabpage_3
end type
type r_tab3 from rectangle within tabpage_3
end type
type r_tab3_1 from rectangle within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_tab3_1 dw_tab3_1
dw_tab3 dw_tab3
r_tab3 r_tab3
r_tab3_1 r_tab3_1
end type
type tabpage_4 from userobject within tab_1
end type
type dw_tab4_1 from uo_dwlv within tabpage_4
end type
type dw_tab4 from uo_dwlv within tabpage_4
end type
type r_tab4 from rectangle within tabpage_4
end type
type r_tab4_1 from rectangle within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_tab4_1 dw_tab4_1
dw_tab4 dw_tab4
r_tab4 r_tab4
r_tab4_1 r_tab4_1
end type
type tabpage_5 from userobject within tab_1
end type
type r_tab5 from rectangle within tabpage_5
end type
type dw_tab5 from uo_dwfree within tabpage_5
end type
type dw_tab5_temp from uo_dwlv within tabpage_5
end type
type tabpage_5 from userobject within tab_1
r_tab5 r_tab5
dw_tab5 dw_tab5
dw_tab5_temp dw_tab5_temp
end type
type tabpage_6 from userobject within tab_1
end type
type r_tab6 from rectangle within tabpage_6
end type
type dw_tab6 from uo_dwlv within tabpage_6
end type
type tabpage_6 from userobject within tab_1
r_tab6 r_tab6
dw_tab6 dw_tab6
end type
type tab_1 from tab within w_hpa412a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
type uo_1 from u_tab within w_hpa412a
end type
type uo_family from uo_imgbtn within w_hpa412a
end type
type uo_create from uo_imgbtn within w_hpa412a
end type
type uo_singo from uo_imgbtn within w_hpa412a
end type
type uo_report from uo_imgbtn within w_hpa412a
end type
type uo_medi from uo_imgbtn within w_hpa412a
end type
type uo_gibu from uo_imgbtn within w_hpa412a
end type
type uc_row_insert from u_picture within w_hpa412a
end type
type uc_row_delete from u_picture within w_hpa412a
end type
type uc_row_save from u_picture within w_hpa412a
end type
type uo_gicreate from uo_imgbtn within w_hpa412a
end type
type dw_con from uo_dwfree within w_hpa412a
end type
type dw_print from datawindow within w_hpa412a
end type
type uo_close from picture within w_hpa412a
end type
end forward

global type w_hpa412a from w_msheet
integer width = 4489
integer height = 2384
boolean resizable = false
boolean center = false
ln_temp1 ln_temp1
ln_temp2 ln_temp2
ln_1 ln_1
dw_main dw_main
tab_1 tab_1
uo_1 uo_1
uo_family uo_family
uo_create uo_create
uo_singo uo_singo
uo_report uo_report
uo_medi uo_medi
uo_gibu uo_gibu
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
uc_row_save uc_row_save
uo_gicreate uo_gicreate
dw_con dw_con
dw_print dw_print
uo_close uo_close
end type
global w_hpa412a w_hpa412a

type variables
DataWindow idw_tab[]
Boolean ibTabPageSelected = TRUE
String is_magam = 'N'
end variables

forward prototypes
public function integer wf_etc_deduc (string as_cd, long as_amt, long al_row, string as_year)
public function string wf_return_incom (string as_rel_cd)
public function integer wf_upd_date_set (datawindow adw)
public function integer wf_update_chk ()
end prototypes

public function integer wf_etc_deduc (string as_cd, long as_amt, long al_row, string as_year);// as_cd - 공제구분
// as_amt - 대상금액
// al_row - row
// as_year - 정산년도
Long ll_limit_amt, ll_P40DAM
Dec  ld_rate, ld_limit_rate
Long ll_find, ll_amt_tmp1 = 0 , ll_amt_tmp2 = 0 , ll_amt_tmp3 = 0, ll_amt_tmp4 = 0, ll_amt_tmp5 = 0
Long ll_limit_tmp1 = 0, ll_limit_tmp2 = 0
String	ls_emp_no, ls_retire_dt, ls_gubun
Datawindow ldw_tab5
String ls_p45dec
Long ll_p45dem , ll_p45pcn
ldw_tab5 = tab_1.tabpage_5.dw_tab5

ls_emp_no = dw_con.getitemstring(dw_con.Getrow(), 'member_no')
ls_retire_dt = trim(dw_main.getitemString(dw_main.getrow(), 'h01rtd'))

If  left(ls_retire_dt, 4) = as_year Then
	ls_gubun = 'T'
Else
	ls_gubun = 'J'
End If

  SELECT     P40DAM,	
                  P40DRT,   
         		P40LIM,   
         		P40LRT
	INTO     :ll_P40DAM,
			   :ld_rate,
	            :ll_limit_amt,
			   :ld_limit_rate
    FROM  PADB.HPAP40M
WHERE     P40YAR = :as_year
    AND     P40DGB = :as_cd
USING SQLCA;	 
 
If left(as_cd, 2) = '34' Then //주택자금  - 전체한도금액
//3401 + 3402 한도액
		  SELECT    	P40LIM
		INTO     :ll_limit_tmp1
		 FROM  PADB.HPAP40M
	WHERE     P40YAR = :as_year
		 AND     P40DGB = '3403'
	USING SQLCA;	 
	
//주택자금 전체한도액	
	  SELECT    	P40LIM
		INTO     :ll_limit_tmp2
		 FROM  PADB.HPAP40M
	WHERE     P40YAR = :as_year
		 AND     P40DGB = '3406'
	USING SQLCA;	 
	
End If

If left(as_cd, 2) = '35'  Then  //기부금공제일 경우 근로소득금액
	
ll_limit_tmp1  = dw_main.GetitemNumber(dw_main.Getrow(), 'p02tam_tot') + &
			  dw_main.GetitemNumber(dw_main.Getrow() , 'p02p20_tot') + &
					dw_main.GetitemNumber(dw_main.Getrow() , 'p42atl_tot')	
					
//외국인인 경우 과세대상급여의 30%를 차감한 금액이  근로소득금액이다.
If dw_main.object.H01FOR[1] = '9' Then 
	ll_limit_tmp1 = ll_limit_tmp1 - (ll_limit_tmp1 * 0.3)
End If

SELECT  					
 (CASE WHEN :ll_limit_tmp1 <= 5000000 THEN 0 ELSE :ll_limit_tmp1 -  ROUND(A.P48AM1 + (:ll_limit_tmp1 - A.P48AM2) * A.P48RTE * 0.01, 0) END  ) 
  INTO :ll_limit_tmp1
  FROM PADB.HPAP48M A
       WHERE P48YAR = :as_year
       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE  P48YAR = :as_year and  P48ATU >= :ll_limit_tmp1    ) 
USING SQLCA;       


// SELECT CASE WHEN A.P46ICW <= 5000000 THEN 0 ELSE A.P46ICW -  ROUND(A.P48AM1 + (A.P46ICW - A.P48AM2) * A.P48RTE * 0.01, 0) END   
//    INTO :ll_limit_tmp1
//FROM (
//SELECT A.P46YAR, A.P46GBN, A.P46NNO,
//       A.P46ICW,
//       NVL((SELECT P48AM1 
//       FROM PADB.HPAP48M
//       WHERE P48YAR = :as_year
//       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE  P48YAR = :as_year and  P48ATU >= A.P46ICW    ) 
//		   ), 0) AS P48AM1,
//     NVL((SELECT P48AM2
//       FROM PADB.HPAP48M
//       WHERE  P48YAR = :as_year
//       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE  P48YAR = :as_year AND P48ATU >= A.P46ICW )
//		 ),0) AS P48AM2,
//     NVL((SELECT P48RTE 
//       FROM PADB.HPAP48M
//       WHERE  P48YAR = :as_year
//       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE  P48YAR = :as_year AND  P48ATU >= A.P46ICW  )
//		 ),0)     AS P48RTE
//FROM PADB.HPAP46T A
//WHERE  A.P46YAR = :as_year
//AND A.P46GBN =  'J'
//AND A.P46NNO LIKE :ls_emp_no) A
//USING SQLCA;
//


					
					

Elseif  left(as_cd, 2) = '36'  Or left(as_cd,2) = '42' Then  //과세대상근로소득금액

ll_limit_tmp1  = dw_main.GetitemNumber(dw_main.Getrow(), 'p02tam_tot') + &
                      dw_main.GetitemNumber(dw_main.Getrow() , 'p02p20_tot') + &
					dw_main.GetitemNumber(dw_main.Getrow() , 'p42atl_tot')		

//외국인인 경우 과세대상급여의 30%를 차감한 금액이  근로소득금액이다.
If dw_main.object.H01FOR[1] = '9' Then 
	ll_limit_tmp1 = ll_limit_tmp1 - (ll_limit_tmp1 * 0.3)
End If
					
					
End If


Choose Case as_cd
	Case '3401'  //주택마련저축공제  
		    ll_P40DAM = truncate(as_amt * ld_rate, 0)   //0.4 
		    
		   	ll_amt_tmp1 = ldw_tab5.getitemnumber(al_row, 'd_3402_amt')  //주택임차차입금원리금상환공dl제
			
			If ll_P40DAM + ll_amt_tmp1 >= ll_limit_tmp1 Then  //1+2 한도 300만원 이상일 경우
				ll_P40DAM = ll_limit_tmp1 - ll_amt_tmp1          //잔액공제
			End If	
			
			 ll_amt_tmp2 =  ldw_tab5.getitemNumber(al_row, 'd_3404_amt')  //2003이전 장기주택저당차입금 이자상환액공제
			
			ll_amt_tmp3 = ldw_tab5.getitemNumber(al_row, 'd_3405_amt')  //2003이후 장기주택저당차입금 이자상환액공제
			
			ll_amt_tmp4 = ldw_tab5.getitemNumber(al_row, 'd_3407_amt')  //1500
			If ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 >= ll_limit_tmp2  Then  //전체한도금액 초과했으면
				ll_P40DAM = 0
			Else
				If ll_P40DAM + ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 >= ll_limit_tmp2  Then  //전체한도금액 초과했으면
			        ll_P40DAM = ll_limit_tmp2 - (ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 )  //한도금액까지 잔액 공제
				End If
			End If	
	Case '3402'  //주택임차차입금원리금상환공제
		    ll_P40DAM = truncate(as_amt * ld_rate, 0)   //0.4 
		    
		 
			ll_amt_tmp1 = ldw_tab5.GetitemNumber(al_row, 'd_3401_amt')  //주택마련저축공제
		
			If ll_P40DAM + ll_amt_tmp1 >= ll_limit_tmp1 Then  //1+2 한도 300만원 이상일 경우
				ll_P40DAM = ll_limit_tmp1 - ll_amt_tmp1          //잔액공제
			End If	
			
			
		         ll_amt_tmp2 =  ldw_tab5.getitemNumber(al_row, 'd_3404_amt')  //2003이전 장기주택저당차입금 이자상환액공제
	
				ll_amt_tmp3 = ldw_tab5.Getitemnumber(al_row, 'd_3405_amt')  //2003이후 장기주택저당차입금 이자상환액공제
		
			ll_amt_tmp4 = ldw_tab5.getitemNumber(al_row, 'd_3407_amt')  //1500 
			If ll_amt_tmp4 <> 0  Then ll_limit_tmp2 = 15000000 
			
			If ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 >= ll_limit_tmp2  Then  //전체한도금액 초과했으면
				ll_P40DAM = 0
			Else
				If ll_P40DAM + ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 >= ll_limit_tmp2  Then  //전체한도금액 초과했으면
			        ll_P40DAM = ll_limit_tmp2 - (ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 )  //한도금액까지 잔액 공제
				End If
			End If		
	
	Case '3404'  //2003이전 장기주택저당차입금 이자상환액공제
		    ll_P40DAM =  as_amt
		    
		    	If ll_P40DAM >= ll_limit_amt Then 
				ll_P40DAM = ll_limit_amt
			End If
			
			ll_amt_tmp1 = ldw_tab5.Getitemnumber(al_row, 'd_3401_amt')  //주택마련저축공제

			ll_amt_tmp2 = ldw_tab5.Getitemnumber(al_row, 'd_3402_amt')  //주택임차차입금원리금상환공제
			ll_amt_tmp3 =  ldw_tab5.getitemNumber(al_row, 'd_3405_amt')  //2003이후 장기주택저당차입금 이자상환액공제
			ll_amt_tmp4 = ldw_tab5.getitemNumber(al_row, 'd_3407_amt')  //1500
			If ll_amt_tmp4 <> 0  Then ll_limit_tmp2 = 15000000 
			
			If ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 >= ll_limit_tmp2  Then  //전체한도금액 초과했으면
				ll_P40DAM = 0
			Else
				If ll_P40DAM + ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 >= ll_limit_tmp2  Then  //전체한도금액 초과했으면
			        ll_P40DAM = ll_limit_tmp2 - (ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 )  //한도금액까지 잔액 공제
				End If
			End If		
	
			
	Case '3405'  //2003이후 장기주택저당차입금 이자상환액공제
		    ll_P40DAM =  as_amt
		    
			ll_amt_tmp1 = ldw_tab5.Getitemnumber(al_row, 'd_3401_amt')  //주택마련저축공제

			ll_amt_tmp2 = ldw_tab5.Getitemnumber(al_row, 'd_3402_amt')  //주택임차차입금원리금상환공제
			ll_amt_tmp3 =  ldw_tab5.getitemNumber(al_row, 'd_3404_amt')  //2003이전 장기주택저당차입금 이자상환액공제
			ll_amt_tmp4 = ldw_tab5.getitemNumber(al_row, 'd_3407_amt')  //1500
			If ll_amt_tmp4 <> 0  Then ll_limit_tmp2 = 15000000 
			If ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 >= ll_limit_tmp2  Then  //전체한도금액 초과했으면
				ll_P40DAM = 0
			Else
				If ll_P40DAM + ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 >= ll_limit_tmp2  Then  //전체한도금액 초과했으면
			        ll_P40DAM = ll_limit_tmp2 - (ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 )  //한도금액까지 잔액 공제
				End If
			End If	
	Case '3407'  //2003이후 장기주택저당차입금 이자상환액공제
		    ll_P40DAM =  as_amt
		    
			ll_amt_tmp1 = ldw_tab5.Getitemnumber(al_row, 'd_3401_amt')  //주택마련저축공제

			ll_amt_tmp2 = ldw_tab5.Getitemnumber(al_row, 'd_3402_amt')  //주택임차차입금원리금상환공제
			ll_amt_tmp3 =  ldw_tab5.getitemNumber(al_row, 'd_3404_amt')  //2003이전 장기주택저당차입금 이자상환액공제
			ll_amt_tmp4 = ldw_tab5.getitemNumber(al_row, 'd_3405_amt')  //
			
			If ll_P40DAM <> 0  Then ll_limit_tmp2 = 15000000 
			
			If ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 >= ll_limit_tmp2  Then  //전체한도금액 초과했으면
				ll_P40DAM = 0
			Else
				If ll_P40DAM + ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 >= ll_limit_tmp2  Then  //전체한도금액 초과했으면
			        ll_P40DAM = ll_limit_tmp2 - (ll_amt_tmp1 + ll_amt_tmp2 + ll_amt_tmp3 + ll_amt_tmp4 )  //한도금액까지 잔액 공제
				End If
			End If			
//######################################################################
//기부금
  
Case '3500' //기부금
	
		tab_1.tabpage_5.dw_tab5_temp.retrieve(as_year, ls_emp_no, 'N', ls_gubun)
	
	  ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3501'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
	If ll_find > 0 Then
		tab_1.tabpage_5.dw_tab5_temp.deleterow(ll_find)
	End If
	 ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3502'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
	If ll_find > 0 Then
		tab_1.tabpage_5.dw_tab5_temp.deleterow(ll_find)
	End If
	 ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3503'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
	If ll_find > 0 Then
		tab_1.tabpage_5.dw_tab5_temp.deleterow(ll_find)
	End If
	 ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3504'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
	If ll_find > 0 Then
		tab_1.tabpage_5.dw_tab5_temp.deleterow(ll_find)
	End If
	 ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3505'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
	If ll_find > 0 Then
		tab_1.tabpage_5.dw_tab5_temp.deleterow(ll_find)
	End If
	 ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3506'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
	If ll_find > 0 Then
		tab_1.tabpage_5.dw_tab5_temp.deleterow(ll_find)
	End If
	
	DECLARE HPAP45T CURSOR FOR 
			SELECT P45DEC, SUM(P45PTL), COUNT(DISTINCT P45RNO) FROM PADB.HPAP45T
		WHERE P45YAR = :as_year
		AND P45NNO LIKE :ls_emp_no
		GROUP BY P45DEC
		ORDER BY P45DEC
		USING SQLCA;

	OPEN HPAP45T ;
 	FETCH HPAP45T INTO  :ls_p45dec, :as_amt, :ll_p45pcn ;
	 DO WHILE SQLCA.SQLCODE = 0
		al_row = tab_1.tabpage_5.dw_tab5_temp.insertrow(0)
		
	  SELECT     P40DAM,	
							P40DRT,   
						P40LIM,   
						P40LRT
		INTO     :ll_P40DAM,
					:ld_rate,
						:ll_limit_amt,
					:ld_limit_rate
		 FROM  PADB.HPAP40M
	WHERE     P40YAR = :as_year
		 AND     P40DGB = :ls_p45dec
	USING SQLCA;	 
		
		
	Choose Case ls_p45dec
		Case '3501'  //전액공제기부금
				If as_amt >= ll_limit_tmp1 Then //근로소득금액
					ll_P40DAM = ll_limit_tmp1
				Else
					ll_P40DAM = as_amt
				End If		
		Case '3502' //50%한도기부금
			  ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3501'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp1 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //전액공제기부금
				End If
				
				If as_amt >= truncate((ll_limit_tmp1 - ll_amt_tmp1) * ld_limit_rate, 0) Then
					ll_P40DAM = truncate((ll_limit_tmp1 - ll_amt_tmp1) * ld_limit_rate, 0)
				Else
					ll_P40DAM = as_amt
				End If
		Case '3503' //30%한도기부금
			  ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3501'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp1 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //전액공제기부금
				End If
			
				ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3502'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp2 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //50%한도기부금
				End If
				
				If as_amt >= truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2) * ld_limit_rate, 0) Then
					ll_P40DAM = truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2) * ld_limit_rate, 0)
				Else
					ll_P40DAM = as_amt
				End If		
				
		Case '3504' //15%한도기부금
			  ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3501'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp1 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //전액공제기부금
				End If
			
				ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3502'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp2 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //50%한도기부금
				End If
			
				 ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3503'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp3 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //30%한도기부금
				End If
				
				long ll_3505  //10%한도 - 종교단체기부금
				
					SELECT  SUM(P45PTL) 
					INTO :ll_3505
					FROM PADB.HPAP45T					
					WHERE P45YAR = :as_year
					AND P45NNO = :ls_emp_no
					AND P45DEC = '3505'
					USING SQLCA;
			
				If ll_3505 > 0 Then //종교단체기부금이 있는 경우
					//한도금액 * 10% + Min( 한도금액*5%, 기타의 지정기부금액)
						If as_amt >= truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2 - ll_amt_tmp3) * 0.1, 0) + Min( truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2 - ll_amt_tmp3) * 0.1, 0), as_amt)  Then
							ll_P40DAM = truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2 - ll_amt_tmp3) * 0.1, 0) + Min( truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2 - ll_amt_tmp3) * 0.1, 0), as_amt)
						Else
							ll_P40DAM = as_amt
						End If		
				
				Else
						If as_amt >= truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2 - ll_amt_tmp3) * ld_limit_rate, 0) Then
							ll_P40DAM = truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2 - ll_amt_tmp3) * ld_limit_rate, 0)
						Else
							ll_P40DAM = as_amt
						End If		
				End If
		Case '3505' //10%한도기부금
			  ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3501'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp1 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //전액공제기부금
				End If
			
				ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3502'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp2 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //50%한도기부금
				End If
			
				 ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3503'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp3 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //30%한도기부금
				End If
				
//지정기부금끼리는 한도체크 금액에 속하지 않는다.				
//				ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3504'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
//				If ll_find <> 0 Then
//					ll_amt_tmp4 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //15%한도기부금
//				End If
					ll_amt_tmp4 = 0
				
				If as_amt >= truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2 - ll_amt_tmp3 - ll_amt_tmp4) * ld_limit_rate, 0) Then
					ll_P40DAM = truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2 - ll_amt_tmp3 - ll_amt_tmp4) * ld_limit_rate, 0)
				Else
					ll_P40DAM = as_amt
				End If		
			Case '3506' //기타의 기부금
			  ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3501'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp1 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //전액공제기부금
				End If
			
				ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3502'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp2 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //50%한도기부금
				End If
			
				 ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3503'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp3 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //30%한도기부금
				End If
				
				ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3504'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp4 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //15%한도기부금
				End If
				
				ll_find = tab_1.tabpage_5.dw_tab5_temp.find("P41DGB = '3505'" , 1, tab_1.tabpage_5.dw_tab5_temp.Rowcount())
				If ll_find <> 0 Then
					ll_amt_tmp5 = tab_1.tabpage_5.dw_tab5_temp.getitemnumber(ll_find, 'P41DEM')  //10%한도기부금
				End If
				
				If as_amt >= truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2 - ll_amt_tmp3 - ll_amt_tmp4 - ll_amt_tmp5) * ld_limit_rate, 0) Then
					ll_P40DAM = truncate((ll_limit_tmp1 - ll_amt_tmp1 - ll_amt_tmp2 - ll_amt_tmp3 - ll_amt_tmp4 - ll_amt_tmp5) * ld_limit_rate, 0)
				Else
					ll_P40DAM = as_amt
				End If			
		End Choose
			tab_1.tabpage_5.dw_tab5_temp.Setitem(al_row, 'P41DEM', ll_P40DAM)
			tab_1.tabpage_5.dw_tab5_temp.Setitem(al_row, 'P41SAM', as_amt)
			tab_1.tabpage_5.dw_tab5_temp.Setitem(al_row, 'P41YAR', as_year)
			tab_1.tabpage_5.dw_tab5_temp.Setitem(al_row, 'P41NNO', ls_emp_no)
			tab_1.tabpage_5.dw_tab5_temp.Setitem(al_row, 'P41DCD', '3500')
			tab_1.tabpage_5.dw_tab5_temp.Setitem(al_row, 'P41DGB', ls_p45dec)
			tab_1.tabpage_5.dw_tab5_temp.Setitem(al_row, 'P41AJG', ls_gubun)
			tab_1.tabpage_5.dw_tab5_temp.Setitem(al_row, 'P41PCN', ll_p45pcn)

	FETCH HPAP45T INTO  :ls_p45dec, :as_amt,  :ll_p45pcn ;
	Loop
     CLOSE HPAP45T;




	
//##############################################################################			
	Case 	'3601'  //혼인이사장례
		If as_amt = 0 Or ll_limit_tmp1 > ll_limit_amt Then //근로소득이 2500만원 이상이면
		   ll_P40DAM = 0
		End If
			//위에서 받아온 공제금액을 사용
			//지출금액과 상관없이 공제금액 공제
		//as_amt 를 횟수로 받아옴	
		ll_P40DAM = ll_P40DAM * as_amt
			
	Case '4101' //개인연금저축 소득공제
		ll_P40DAM = truncate(as_amt * ld_rate, 0) //40%
		
		If ll_P40DAM >= ll_limit_amt Then
			ll_P40DAM = ll_limit_amt
		End If
	Case '4102' //연금저축 소득공제
		ll_P40DAM = as_amt
		
			ll_amt_tmp1 =  ldw_tab5.getitemNumber(al_row, 'd_4103_amt')  
		
		
		If ll_amt_tmp1 >= ll_limit_amt  Then  //전체한도금액 초과했으면
				ll_P40DAM = 0
			Else
				If ll_P40DAM + ll_amt_tmp1 >= ll_limit_amt  Then  //전체한도금액 초과했으면
			        ll_P40DAM = ll_limit_amt - ll_amt_tmp1  //한도금액까지 잔액 공제
				End If
			End If	
	Case '4103' //퇴직연금 소득공제
		ll_P40DAM = as_amt
		
			ll_amt_tmp1 =  ldw_tab5.getitemNumber(al_row, 'd_4102_amt')  
		
		
		If ll_amt_tmp1 >= ll_limit_amt  Then  //전체한도금액 초과했으면
				ll_P40DAM = 0
			Else
				If ll_P40DAM + ll_amt_tmp1 >= ll_limit_amt  Then  //전체한도금액 초과했으면
			        ll_P40DAM = ll_limit_amt - ll_amt_tmp1  //한도금액까지 잔액 공제
				End If
			End If			
		
		
	Case '4201' , '4202' //투자조합출자 
		ll_P40DAM = truncate(as_amt * ld_rate, 0) //10%
		
		If ll_P40DAM >= truncate(ll_limit_tmp1 * ld_limit_rate, 0) Then
			ll_P40DAM = truncate(ll_limit_tmp1 * ld_limit_rate, 0) 
		End If
		
		//4201 : 2006년도분을 먼저 공제 (50%한도체크)
		Long ll_4201
			ldw_tab5.Accepttext()
			ll_4201 = ldw_tab5.GetitemNumber(al_row, 'd_4201_amt') 
		If as_cd = '4202'  Then
			If ll_4201 + ll_P40DAM >   truncate(ll_limit_tmp1 * ld_limit_rate, 0)  Then //한도금액보다 크면
				If wf_etc_deduc('4201', ldw_tab5.GetitemNumber(al_row, 'p_4201_amt'), al_row, as_year) = 1 Then
					ll_P40DAM = truncate(ll_limit_tmp1 * ld_limit_rate, 0) -  ldw_tab5.GetitemNumber(al_row, 'd_4201_amt')
				End If
			End If
		End If
		
	Case '4401' //우리사주
		If as_amt >= ll_limit_amt Then
			ll_P40DAM = ll_limit_amt
		Else
			ll_P40DAM = as_amt
		End If
		
	Case '4501' //정치기부자금
		
		If as_amt >= ll_limit_amt Then
			ll_P40DAM = ll_limit_amt
		Else
			ll_P40DAM = as_amt
		End If
	Case '4502' //주택자금 차입금이자세액공제
		ll_P40DAM = truncate(as_amt * ld_rate, 0)
	Case '4601' //소기업·소상공인 공제부금
		If as_amt >= ll_limit_amt Then
			ll_P40DAM = ll_limit_amt
		Else
			ll_P40DAM = as_amt
		End If	
	Case '4701', '4702', '4703' //펀드소득공제
			ll_P40DAM = truncate(as_amt * ld_rate, 0)
End Choose

If as_cd <> '3500' Then
	//tab_1.tabpage_5.dw_tab5_temp.Setitem(al_row, 'P41DEM', ll_P40DAM)
//Else
	ldw_tab5.Setitem(al_row, 'd_' + as_cd + '_amt' , ll_P40DAM)
End If


RETURN 1
end function

public function string wf_return_incom (string as_rel_cd);String ls_incom_cd

//기부금 상세코드에 대한 소득공제코드를 가져옴

SELECT ETC_CD1 
INTO :ls_incom_cd
FROM CDDB.KCH102D  
WHERE UPPER(CODE_GB) = 'GIBO_OPT'
AND CODE = :as_rel_cd
USING SQLCA;



RETURN ls_incom_cd
end function

public function integer wf_upd_date_set (datawindow adw);Long ll_row
DateTime ldt_cur

ldt_cur = func.of_get_datetime()


//Choose Case adw	
//	Case tab_1.tabpage_1.dw_tab1
		ll_row = adw.GetNextModified(0, Primary!)
		Do While ll_row > 0			
			adw.SetItem(ll_row, "JOB_UID", gs_empcode)	//최종수정자
				adw.SetItem(ll_row, "JOB_DATE", ldt_cur)		//최종수정일시
				adw.Setitem(ll_row, "JOB_ADD" , gs_ip)
			
			
			If adw.GetItemStatus(ll_row, 0, Primary!) = NewModified! Then
				
				adw.SetItem(ll_row, "WORKER", gs_empcode)	//최초등록자
				adw.SetItem(ll_row, "WORK_DATE", ldt_cur)		//최초등록일
				adw.Setitem(ll_row, "IPADD" , gs_ip)
			End If			
			ll_row = adw.GetNextModified(ll_row, Primary!)
		Loop

//	Case tab_1.tabpage_2.dw_tab2
//		ll_row = adw.GetNextModified(0, Primary!)
//		Do While ll_row > 0			
//			adw.SetItem(ll_row, "upduid", gs_empcode)	//최종수정자
//			adw.SetItem(ll_row, "upddte", ldt_cur)		//최종수정일시
//			
//			If adw.GetItemStatus(ll_row, 0, Primary!) = NewModified! Then
//				adw.SetItem(ll_row, "creuid", gs_empcode)	//최초등록자
//				adw.SetItem(ll_row, "credte", ldt_cur)		//최초등록일자
//			End If			
//			ll_row = adw.GetNextModified(ll_row, Primary!)
//		Loop
//
//	Case tab_1.tabpage_3.dw_tab3
//		ll_row = adw.GetNextModified(0, Primary!)
//		Do While ll_row > 0			
//			adw.SetItem(ll_row, "upduid", gs_empcode)	//최종수정자
//			adw.SetItem(ll_row, "upddte", ldt_cur)		//최종수정일시
//			
//			If adw.GetItemStatus(ll_row, 0, Primary!) = NewModified! Then
//				adw.SetItem(ll_row, "creuid", gs_empcode)	//최초등록자
//				adw.SetItem(ll_row, "credte", ldt_cur)		//최초등록일자
//			End If			
//			ll_row = adw.GetNextModified(ll_row, Primary!)
//		Loop
//
//	Case tab_1.tabpage_4.dw_tab4
//		ll_row = adw.GetNextModified(0, Primary!)
//		Do While ll_row > 0			
//			adw.SetItem(ll_row, "upduid", gs_empcode)	//최종수정자
//			adw.SetItem(ll_row, "upddte", ldt_cur)		//최종수정일시
//			
//			If adw.GetItemStatus(ll_row, 0, Primary!) = NewModified! Then
//				adw.SetItem(ll_row, "creuid", gs_empcode)	//최초등록자
//				adw.SetItem(ll_row, "credte", ldt_cur)		//최초등록일자
//			End If			
//			ll_row = adw.GetNextModified(ll_row, Primary!)
//		Loop
//
//	Case tab_1.tabpage_5.dw_tab5
//		ll_row = adw.GetNextModified(0, Primary!)
//		Do While ll_row > 0			
//			adw.SetItem(ll_row, "upduid", gs_empcode)	//최종수정자
//			adw.SetItem(ll_row, "upddte", ldt_cur)		//최종수정일시
//			
//			If adw.GetItemStatus(ll_row, 0, Primary!) = NewModified! Then
//				adw.SetItem(ll_row, "creuid", gs_empcode)	//최초등록자
//				adw.SetItem(ll_row, "credte", ldt_cur)		//최초등록일자
//			End If			
//			ll_row = adw.GetNextModified(ll_row, Primary!)
//		Loop
//End Choose

Return 0
end function

public function integer wf_update_chk ();Long				ll_rv = 0
Long				ll_cnt = 0
Long				ll_i
Long				ll_dw_cnt

If  uc_save.Enabled = False And uc_row_save.Enabled = false Then RETURN 1

For ll_i = 1 To UpperBound(idw_update)
	idw_update[ll_i].AcceptText()

	ll_cnt += (idw_update[ll_i].ModifiedCount() + idw_update[ll_i].DeletedCount())
Next

	If ll_cnt > 0 Then

	//	If ll_rv = 0 Then 
			ll_rv = Messagebox("알림", "변경된 내역을 저장하시겠습니까?",  Exclamation!, YesNoCancel!, 1) //gf_message(parentwin, 2, '0007', '', '')

		For ll_i = 1 To UpperBound(idw_update)
			Choose Case ll_rv
				Case 1
					If (idw_update[ll_i].ModifiedCount() + idw_update[ll_i].DeletedCount()) > 0 Then
//						If func.of_checknull(idw_update[ll_i]) = -1 Then
//							RETURN -1
//						End If
						
						If idw_update[ll_i].Dynamic Event ue_update() = 1 Then
							ll_rv = 1
						Else
							RETURN -1
						End IF
					End If
				Case 2
					If (idw_update[ll_i].ModifiedCount() + idw_update[ll_i].DeletedCount()) > 0 then
						If ib_updatequery_resetupdate Then
							
							idw_update[ll_i].Dynamic Event ue_retrieve() 
							idw_update[ll_i].resetUpdate()
						End If
						ll_rv = 2
					End If					
				Case 3
					ll_rv = 3
			End Choose
		Next
	End If
	//End If



If ll_rv = 0 Then ll_rv = 1

RETURN ll_rv

end function

on w_hpa412a.create
int iCurrent
call super::create
this.ln_temp1=create ln_temp1
this.ln_temp2=create ln_temp2
this.ln_1=create ln_1
this.dw_main=create dw_main
this.tab_1=create tab_1
this.uo_1=create uo_1
this.uo_family=create uo_family
this.uo_create=create uo_create
this.uo_singo=create uo_singo
this.uo_report=create uo_report
this.uo_medi=create uo_medi
this.uo_gibu=create uo_gibu
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.uc_row_save=create uc_row_save
this.uo_gicreate=create uo_gicreate
this.dw_con=create dw_con
this.dw_print=create dw_print
this.uo_close=create uo_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_temp1
this.Control[iCurrent+2]=this.ln_temp2
this.Control[iCurrent+3]=this.ln_1
this.Control[iCurrent+4]=this.dw_main
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_family
this.Control[iCurrent+8]=this.uo_create
this.Control[iCurrent+9]=this.uo_singo
this.Control[iCurrent+10]=this.uo_report
this.Control[iCurrent+11]=this.uo_medi
this.Control[iCurrent+12]=this.uo_gibu
this.Control[iCurrent+13]=this.uc_row_insert
this.Control[iCurrent+14]=this.uc_row_delete
this.Control[iCurrent+15]=this.uc_row_save
this.Control[iCurrent+16]=this.uo_gicreate
this.Control[iCurrent+17]=this.dw_con
this.Control[iCurrent+18]=this.dw_print
this.Control[iCurrent+19]=this.uo_close
end on

on w_hpa412a.destroy
call super::destroy
destroy(this.ln_temp1)
destroy(this.ln_temp2)
destroy(this.ln_1)
destroy(this.dw_main)
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.uo_family)
destroy(this.uo_create)
destroy(this.uo_singo)
destroy(this.uo_report)
destroy(this.uo_medi)
destroy(this.uo_gibu)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.uc_row_save)
destroy(this.uo_gicreate)
destroy(this.dw_con)
destroy(this.dw_print)
destroy(this.uo_close)
end on

event ue_postopen;call super::ue_postopen;
//

String ls_emp

SELECT CODE
INTO :ls_emp
FROM CDDB.KCH102D
WHERE CODE_GB = 'HPA04'
AND CODE = :gs_empcode
USING SQLCA;

If SQLCA.SQLCODE <> 0 Or ls_emp = '' Or isnull(ls_emp) Then 
	is_magam = 'Y'
//	is_magam = 'N'
	
	dw_con.Setitem(dw_con.Getrow(), 'member_no', gs_empcode)
	dw_con.Setitem(dw_con.Getrow(), 'kor_name', gs_empname)
	dw_con.object.member_no.protect = 1
	dw_con.object.kor_name.protect = 1
Else
//If gs_empcode = 'F0016' Or gs_empcode = 'admin'  Then
	is_magam = 'N'

	
End If
//
func.of_design_dw( dw_main )

dw_main.insertrow(0)
//
//// DataWindow가 Grid일때 사용
//This.Event ue_resize_dw( Tab_1.TabPage_1.r_tab1, Tab_1.TabPage_1.dw_tab1 )
//This.Event ue_resize_dw( Tab_1.TabPage_2.r_tab2, Tab_1.TabPage_2.dw_tab2 )
//This.Event ue_resize_dw( Tab_1.TabPage_3.r_tab3, Tab_1.TabPage_3.dw_tab3 )
//This.Event ue_resize_dw( Tab_1.TabPage_3.r_tab3_1, Tab_1.TabPage_3.dw_tab3_1 )
//This.Event ue_resize_dw( Tab_1.TabPage_4.r_tab4, Tab_1.TabPage_4.dw_tab4 )
//This.Event ue_resize_dw( Tab_1.TabPage_4.r_tab4_1, Tab_1.TabPage_4.dw_tab4_1 )
//This.Event ue_resize_dw( Tab_1.TabPage_6.r_tab6, Tab_1.TabPage_6.dw_tab6 )
// DataWindow가 master일 경우 사용
func.of_design_dw( Tab_1.TabPage_1.dw_tab1_1 )
Tab_1.TabPage_1.dw_tab1_1.insertrow(0)

//func.of_design_dw( Tab_1.TabPage_3.dw_tab3 )
//func.of_design_dw( Tab_1.TabPage_5.dw_tab5 )
Tab_1.TabPage_5.dw_tab5.insertrow(0)
////
idw_tab[1] = Tab_1.TabPage_1.dw_tab1
idw_tab[2] = Tab_1.TabPage_2.dw_tab2
idw_tab[3] = Tab_1.TabPage_3.dw_tab3_1
idw_tab[4] = Tab_1.TabPage_4.dw_tab4_1
idw_tab[5] = Tab_1.TabPage_5.dw_tab5
idw_tab[6] = Tab_1.TabPage_6.dw_tab6
//
//Tab_1.Tabpage_1.dw_tab1.iw_parent = This
//Tab_1.Tabpage_2.dw_tab2.iw_parent = This
//Tab_1.Tabpage_3.dw_tab3.iw_parent = This
//Tab_1.Tabpage_4.dw_tab4.iw_parent = This
//Tab_1.Tabpage_5.dw_tab5.iw_parent = This
//
////저장 버튼 클릭 시 저장할 dw
////dw_main.idw_updatedw[1] = dw_main
//Tab_1.TabPage_1.dw_tab1.idw_updatedw[1] = Tab_1.TabPage_1.dw_tab1
//Tab_1.TabPage_2.dw_tab2.idw_updatedw[1] = Tab_1.TabPage_2.dw_tab2
//Tab_1.TabPage_3.dw_tab3.idw_updatedw[1] = Tab_1.TabPage_3.dw_tab3
//Tab_1.TabPage_4.dw_tab4.idw_updatedw[1] = Tab_1.TabPage_4.dw_tab4
//Tab_1.TabPage_5.dw_tab5_temp.idw_updatedw[1] = Tab_1.TabPage_5.dw_tab5_temp
////
//종료 시 검사할 dw
//idw_update[1] = dw_main
idw_update[1] = Tab_1.TabPage_1.dw_tab1
idw_update[2] = Tab_1.TabPage_2.dw_tab2
idw_update[3] = Tab_1.TabPage_3.dw_tab3
idw_update[4] = Tab_1.TabPage_4.dw_tab4
idw_update[5] = Tab_1.TabPage_5.dw_tab5_temp
idw_update[6] = Tab_1.TabPage_3.dw_tab3_1
idw_update[7] = Tab_1.TabPage_4.dw_tab4_1
idw_print = dw_print
ibTabPageSelected = False
//
//
//
//
//
//Datawindowchild ldw_child
//Long rtncode, ll_i
//String ls_year
//
//rtncode =Tab_1.TabPage_3.dw_tab3.GetChild('p45dec', ldw_child)
//
//IF rtncode = -1 THEN MessageBox( &
//        "Error", "Not a DataWindowChild")
//
//ldw_child.SetTransObject(SQLCA)
//
//ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4)
//
//// Populate with values for eastern states
//
//ldw_child.Retrieve(ls_year, '3500' )
//
//// Set transaction object for main DW and retrieve
//
//Tab_1.TabPage_3.dw_tab3.SetTransObject(SQLCA)
//
//vector lvc_data
//
//lvc_data = Create vector
////DDDW Setting
//
//lvc_data.setProperty('column1', 'p45cod')		//직능
//lvc_data.setProperty('system1', 'MIS')
//lvc_data.setProperty('group1', 'EC5')
//lvc_data.setProperty('column2', 'p45cod_1')		//직능
//lvc_data.setProperty('system2', 'MIS')
//lvc_data.setProperty('group2', 'EC5')
////gvc_val.setProperty('column2', 'h01grd')		//직급
////gvc_val.setProperty('system2', 'MIS')
////gvc_val.setProperty('group2', 'E08')
//
//If func.of_dddw(Tab_1.TabPage_3.dw_tab3, lvc_data) < 0 Then
//	MessageBox("오류", "dddw 조회 시 오류가 발생하였습니다.")
//End If
//
//
//
//Destroy lvc_data
//
//idw_print = dw_print
//idw_excel[1] = dw_print
//
////gvc_val.removeall()
////gvc_val.setProperty('column1', 'p43')
////gvc_val.setProperty('system1', 'MIS')
////gvc_val.setProperty('group1', 'E16')			//가족관계
////If func.of_dddw(Tab_1.TabPage_1.dw_tab1_1, gvc_val) < 0 Then
////	MessageBox("오류", "dddw 조회 시 오류가 발생하였습니다.")
////End If
////
////func.of_design_dwlv( Tab_1.TabPage_1.dw_tab1 )
////func.of_design_dwlv( Tab_1.TabPage_2.dw_tab2 )
////func.of_design_dwlv( Tab_1.TabPage_3.dw_tab3_1 )
////func.of_design_dwlv( Tab_1.TabPage_4.dw_tab4_1 )
////func.of_design_dwlv( Tab_1.TabPage_3.dw_tab3 )
////func.of_design_dwlv( Tab_1.TabPage_4.dw_tab4 )
////func.of_design_dwlv( Tab_1.TabPage_6.dw_tab6 )
//
//If is_magam = 'Y' Then
//	For ll_i = 1 To 7
//		idw_update[ll_i].object.datawindow.readonly = 'Yes'
//	NEXT
//	tab_1.tabpage_5.dw_tab5.object.datawindow.readonly = 'Yes'
//	tab_1.tabpage_1.dw_tab1_1.object.datawindow.readonly = 'Yes'
//
//	This.post event ue_inquiry()
//End If

end event

event ue_delete;call super::ue_delete;Long			ll_rv
String			ls_txt

//ls_txt = "[삭제] "
//
//ll_rv = dw_main.Event ue_DeleteRow()
//
//If ll_rv > 0 Then
//	If Trigger Event ue_save() = -1 Then
//		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
//	Else
//		dw_main.Reset()
//		dw_main.InsertRow(0)
//		f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
//	End If
//ElseIf ll_rv = 0 Then
//	
//Else
//	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
//End If
end event

event ue_insert;call super::ue_insert;Long		ll_rv
String		ls_txt

//ll_rv = This.Event ue_updatequery() 
//If ll_rv <> 1 And ll_rv <> 2 Then RETURN
//
//ll_rv = dw_main.Event ue_InsertRow()
//
//ls_txt = "[신규] "
//If ll_rv = 1 Then
//	f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
//ElseIf ll_rv = 0 Then
//	
//Else
//	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
//End If

end event

event ue_save;call super::ue_save;Long ll_rv

//ll_rv = dw_main.Event ue_Update()

Return ll_rv



end event

event ue_updatequery;call super::ue_updatequery;Long				ll_rv = 0
Long				ll_cnt = 0
Long				ll_i
Long				ll_dw_cnt

If  uc_save.Enabled = False And uc_row_save.Enabled = false Then RETURN 1

For ll_i = 1 To UpperBound(idw_update)
	idw_update[ll_i].AcceptText()

	ll_cnt = (idw_update[ll_i].ModifiedCount() + idw_update[ll_i].DeletedCount())

	If ll_cnt > 0 Then

		If ll_rv = 0 Then ll_rv = gf_message(parentwin, 2, '0007', '', '')

		Choose Case ll_rv
			Case 1
				If idw_update[ll_i].Dynamic Event ue_update() = 1 Then
					//RETURN 1
				Else
					RETURN -1
				End IF
			Case 2
				If ib_updatequery_resetupdate Then
					idw_update[ll_i].resetUpdate()
				End If
				//RETURN 2
			Case 3
				RETURN 3
		End Choose
	End If
Next

If ll_rv = 0 Then ll_rv = 1

RETURN ll_rv

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_tempright.beginx

If uc_row_save.Enabled Then
	uc_row_save.X	= ll_stnd_pos - uc_row_save.Width
	ll_stnd_pos		= ll_stnd_pos - uc_row_save.Width - 16
	uc_row_save.Visible = True
Else
	uc_row_save.Visible = FALSE
End If

If uc_row_delete.Enabled Then
	uc_row_delete.X	= ll_stnd_pos - uc_row_delete.Width
	ll_stnd_pos			= ll_stnd_pos - uc_row_delete.Width - 16
	uc_row_delete.Visible	= True
Else
	uc_row_delete.Visible	= FALSE
End If

If uc_row_insert.Enabled Then
	uc_row_insert.X			= ll_stnd_pos - uc_row_insert.Width
	ll_stnd_pos					= ll_stnd_pos - uc_row_insert.Width - 16
	uc_row_insert.Visible	= True
Else
	uc_row_insert.Visible	= FALSE
End If

If uo_gicreate.Enabled Then
	uo_gicreate.X			= ll_stnd_pos - uo_gicreate.Width
	ll_stnd_pos					= ll_stnd_pos - uo_gicreate.Width - 16
	uo_gicreate.Visible	= True
Else
	uo_gicreate.Visible	= FALSE
End If

If uo_family.Enabled Then
	uo_family.X			= ll_stnd_pos - uo_family.Width
	ll_stnd_pos					= ll_stnd_pos - uo_family.Width - 16
	uo_family.Visible	= True
Else
	uo_family.Visible	= FALSE
End If

If uo_report.Enabled Then  //가정산
	uo_report.X			= uc_retrieve.X - uo_report.Width - 16
//	ll_stnd_pos					= uc_retrieve.X - uo_create.Width - 16
	uo_report.Visible	= True
Else
	uo_report.Visible	= FALSE
End If

If uo_create.Enabled Then  //가정산
	uo_create.X			= uo_report.X - uo_create.Width - 16
//	ll_stnd_pos					= uc_retrieve.X - uo_create.Width - 16
	uo_create.Visible	= True
Else
	uo_create.Visible	= FALSE
End If

If uo_singo.Enabled Then  //소득공제신고서
	uo_singo.X			= uo_create.X - uo_singo.Width - 16
//	ll_stnd_pos					= uc_retrieve.X - uo_create.Width - 16
	uo_singo.Visible	= True
Else
	uo_singo.Visible	= FALSE
End If

If uo_medi.Enabled Then  //의료비지급명세서
	uo_medi.X			= uo_singo.X - uo_medi.Width - 16
//	ll_stnd_pos					= uc_retrieve.X - uo_create.Width - 16
	uo_medi.Visible	= True
Else
	uo_medi.Visible	= FALSE
End If

If uo_gibu.Enabled Then  //기부금명세서
	uo_gibu.X			= uo_medi.X - uo_gibu.Width - 16
//	ll_stnd_pos					= uc_retrieve.X - uo_create.Width - 16
	uo_gibu.Visible	= True
Else
	uo_gibu.Visible	= FALSE
End If


uo_gicreate.of_enable(false)
uo_gibu.of_enable(false)
uo_medi.of_enable(false)
uo_report.of_enable(false)
uo_singo.of_enable(false)
uo_create.of_enable(false)
uo_family.of_enable(false)
uc_row_insert.of_enable(false)
uc_row_delete.of_enable(false)
uc_row_save.of_enable(false)
end event

event ue_retrieve;call super::ue_retrieve;Long  ll_rv
Integer li_selectedtab

ll_rv = This.Event ue_updatequery() 
If ll_rv <> 1 And ll_rv <> 2 Then RETURN -1

SetPointer(HourGlass!)

If ib_retrieve_wait Then
 gf_openwait()
End If

ll_rv = dw_main.Event ue_retrieve()

If ll_rv > 0 Then
 li_SelectedTab = tab_1.SelectedTab
  idw_tab[li_SelectedTab].Dynamic Event ue_retrieve()
End If

If ll_rv > 0 Then
 f_set_message("[조회] " + '자료가 조회되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
 f_set_message("[조회] " + '자료가 없습니다.', '', parentwin)
Else
 f_set_message("[조회] " + '오류가 발생했습니다.', '', parentwin)
End If

If ib_retrieve_wait Then
 gf_closewait()
End If

SetPointer(Arrow!)
ib_excl_yn = FALSE

RETURN ll_rv





end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', dw_print.title)
avc_data.SetProperty('dataobject', dw_print.dataobject)
avc_data.SetProperty('datawindow', dw_print)

//label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])

Return 1
end event

type ln_templeft from w_msheet`ln_templeft within w_hpa412a
end type

type ln_tempright from w_msheet`ln_tempright within w_hpa412a
end type

type ln_temptop from w_msheet`ln_temptop within w_hpa412a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hpa412a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hpa412a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hpa412a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hpa412a
integer x = 2382
end type

type uc_insert from w_msheet`uc_insert within w_hpa412a
integer x = 2665
end type

type uc_delete from w_msheet`uc_delete within w_hpa412a
integer x = 2949
end type

type uc_save from w_msheet`uc_save within w_hpa412a
integer x = 3232
end type

type uc_excel from w_msheet`uc_excel within w_hpa412a
integer x = 3515
end type

type uc_print from w_msheet`uc_print within w_hpa412a
boolean originalsize = false
boolean callevent = false
end type

event uc_print::clicked;call super::clicked;If idw_print.rowcount() > 0 Then
	If idw_print.dataobject = 'd_hpa412a_2_2009' Then
		

		Vector			lvc_print

		lvc_print = Create Vector
	
		If parent.Event ue_printStart(lvc_print) = -1 Then
			Return -1
		Else
			// 인쇄를 하기전에 해당 인쇄를 하고자 하는 사유를 확인한다.
			OpenWithParm(w_print_reason, gs_pgmid)
			If Message.Longparm <= 0 Then
				Return -1
			Else
					 OpenWithParm(w_print_preview, lvc_print)
			End If
		End If



		
		
		//parent.triggerevent('ue_print')
	Else
		idw_print.print()
	End If
End If
	
end event

type st_line1 from w_msheet`st_line1 within w_hpa412a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_msheet`st_line2 within w_hpa412a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_msheet`st_line3 within w_hpa412a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hpa412a
integer x = 3799
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hpa412a
end type

type ln_temp1 from line within w_hpa412a
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 160
integer endx = 4471
integer endy = 160
end type

type ln_temp2 from line within w_hpa412a
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 280
integer endx = 4471
integer endy = 280
end type

type ln_1 from line within w_hpa412a
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 784
integer endx = 4471
integer endy = 784
end type

type dw_main from uo_dwfree within w_hpa412a
event type long ue_retrieve ( )
integer x = 50
integer y = 292
integer width = 4384
integer height = 500
integer taborder = 40
string dataobject = "d_hpa412a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
String 	ls_member, ls_year, ls_fr_mm, ls_to_mm, ls_dt, ls_today, ls_insert_fr, ls_insert_to

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_today =  String(func.of_get_datetime(), 'yyyymmdd')

ls_member = trim(dw_con.GetitemString(dw_con.Getrow(), 'member_no')) //사원번호
ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4) //정산년도

SELECT	SUBSTR(A.FDATE,1,6),	SUBSTR(A.TDATE,1,6),  A.FROM_DATE, A.TO_DATE
	INTO	:ls_fr_mm,		:ls_to_mm, :ls_insert_fr, :ls_insert_to
	FROM	PADB.HPA022M A   /*연말정산기간관리 */
	WHERE	A.YEAR	=	:ls_year;

If isnull(ls_fr_mm) or ls_fr_mm = '' Then 
	messagebox("알림", "연말정산 기간 설정을 확인하세요!")
	RETURN -1
End If
If isnull(ls_member) Or ls_member = '' Then RETURN -1


ll_rv = dw_main.retrieve(ls_year, ls_member, ls_fr_mm, ls_to_mm)

If ll_rv > 0 Then 
	
	If (ls_today < ls_insert_fr or ls_today > ls_insert_to) and is_magam = 'Y' Then
		uo_gicreate.of_enable(False)
		uo_gibu.of_enable(true)
		uo_medi.of_enable(true)
		uo_report.of_enable(true)
		uo_singo.of_enable(true)
		uo_family.of_enable(False)
		uc_row_insert.of_enable(False)
		uc_row_delete.of_enable(False)
		uc_row_save.of_enable(False)
		
		tab_1.tabpage_1.dw_tab1_1.object.datawindow.readonly = 'Yes'
		tab_1.tabpage_2.dw_tab2.object.datawindow.readonly = 'Yes'
		tab_1.tabpage_3.dw_tab3.object.datawindow.readonly = 'Yes'
		tab_1.tabpage_4.dw_tab4.object.datawindow.readonly = 'Yes'
		tab_1.tabpage_5.dw_tab5.object.datawindow.readonly = 'Yes'
	Else
		uo_gicreate.event clicked()
		uo_gicreate.of_enable(False)
		uo_gibu.of_enable(true)
		uo_medi.of_enable(true)
		uo_report.of_enable(true)
		uo_singo.of_enable(true)
		uo_family.of_enable(true)
		uc_row_insert.of_enable(true)
		uc_row_delete.of_enable(true)
		uc_row_save.of_enable(true)
		tab_1.tabpage_1.dw_tab1_1.object.datawindow.readonly = 'No'
		tab_1.tabpage_2.dw_tab2.object.datawindow.readonly = 'No'
		tab_1.tabpage_3.dw_tab3.object.datawindow.readonly = 'No'
		tab_1.tabpage_4.dw_tab4.object.datawindow.readonly = 'No'
		tab_1.tabpage_5.dw_tab5.object.datawindow.readonly = 'No'
	End If
	
	If is_magam = 'Y' Then	
		
		

		SELECT TRIM(ETC_CD3) 
		INTO :ls_DT
		FROM CDDB.KCH102D
		WHERE CODE_GB = 'HPA06'
		AND CODE = :ls_year
		USING SQLCA;

		If SQLCA.SQLCODE <> 0 or isnull(ls_dt) or ls_dt = '' Then
			//Messagebox("알림", "공통코드 HPA06 해당년도 원천징수영수증 출력기간을 확인하세요!")
			//RETURN 
			uo_create.of_enable(True)
		Else
			If ls_today >= ls_dt  Then 
				uo_create.of_enable(false)
			Else
				uo_create.of_enable(True)
			End If
		End If
				
		
		
		//uo_create.of_enable(False)
	Else
		uo_create.of_enable(True)
	End If
	
//	If dw_main.GetitemString(dw_main.Getrow(), 'h01for') = '9' Then
//		tab_1.tabpage_3.visible = false
//		tab_1.tabpage_4.visible = false
//		tab_1.tabpage_5.visible = false
//	Else
		tab_1.tabpage_3.visible = true
		tab_1.tabpage_4.visible = true
		tab_1.tabpage_5.visible = true
//	End If
	
End If

tab_1.tabpage_1.dw_tab1.Post Event ue_Retrieve()

return ll_rv


end event

event rowfocuschanged;call super::rowfocuschanged;//If currentrow > 0 Then
//	dw_detail.PostEvent("ue_retrieve")
//Else
//	dw_detail.Reset()
//End If
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type tab_1 from tab within w_hpa412a
integer x = 50
integer y = 848
integer width = 4384
integer height = 1424
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean raggedright = true
boolean showpicture = false
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event selectionchanged;Long		ll_rv
String ls_insert_fr, ls_insert_to, ls_year, ls_today
//
If Oldindex = -1 Then RETURN

ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4) //정산년도
ls_today =  String(func.of_get_datetime(), 'yyyymmdd')
SELECT	  A.FROM_DATE, A.TO_DATE
	INTO	 :ls_insert_fr, :ls_insert_to
	FROM	PADB.HPA022M A   /*연말정산기간관리 */
	WHERE	A.YEAR	=	:ls_year;


If  newindex = 5 Or newindex = 6 Then  //기타공제, 공제내역
	uc_row_insert.of_enable(false)
	uc_row_delete.of_enable(false)
Else
	
	If (ls_today < ls_insert_fr or ls_today > ls_insert_to) and is_magam = 'Y' Then
		uc_row_insert.of_enable(false)
		uc_row_delete.of_enable(false)
	Else
		uc_row_insert.of_enable(True)
		uc_row_delete.of_enable(True)
	End If
End If

If newindex = 1 Then 
	If (ls_today < ls_insert_fr or ls_today > ls_insert_to) and is_magam = 'Y' Then
		uo_family.of_enable(false)
	Else
		uo_family.of_enable(True)
	End If
	
Else
	uo_family.of_enable(false)
End If

If newindex = 3 Then //기부금
	If (ls_today < ls_insert_fr or ls_today > ls_insert_to) and is_magam = 'Y' Then
		uo_gicreate.of_enable(false)
	Else
		uo_gicreate.of_enable(True)  //기부금이월 버튼 
	End If
Else
	uo_gicreate.of_enable(False)
End If
	
If newindex = 6 Then
	uc_row_save.of_enable(false) 	
Else
	If (ls_today < ls_insert_fr or ls_today > ls_insert_to) and is_magam = 'Y' Then
		uc_row_save.of_enable(false) 	
	Else
		uc_row_save.of_enable(true) 	
	End If
End If


If ibTabPageSelected = TRUE Then
	Return 0
Else
	
    If wf_update_chk() <> 1 Then RETURN -1
    
    ll_rv = idw_tab[newindex].TriggerEvent("ue_Retrieve")
	
	RETURN ll_rv
End If

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1304
long backcolor = 16777215
string text = "부양가족"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
r_tab1 r_tab1
dw_tab1 dw_tab1
dw_tab1_1 dw_tab1_1
end type

on tabpage_1.create
this.r_tab1=create r_tab1
this.dw_tab1=create dw_tab1
this.dw_tab1_1=create dw_tab1_1
this.Control[]={this.r_tab1,&
this.dw_tab1,&
this.dw_tab1_1}
end on

on tabpage_1.destroy
destroy(this.r_tab1)
destroy(this.dw_tab1)
destroy(this.dw_tab1_1)
end on

type r_tab1 from rectangle within tabpage_1
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 119
integer y = 48
integer width = 64
integer height = 60
end type

type dw_tab1 from uo_dwlv within tabpage_1
event type long ue_retrieve ( )
event type long ue_insertrow ( )
event type long ue_deleterow ( )
event type long ue_update ( )
integer x = 5
integer y = 28
integer width = 4334
integer height = 940
integer taborder = 20
string dataobject = "d_hpa412a_3"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
String 	ls_member, ls_year

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_member = dw_con.GetitemString(dw_con.Getrow(), 'member_no') //사원번호
ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4) //정산년도

ll_rv = This.retrieve(ls_year, ls_member)
If ll_Rv > 0 Then

	dw_tab1_1.event ue_retrieve()
Else
	This.event ue_insertrow()
End If
RETURN ll_rv
end event

event type long ue_insertrow();String ls_year, ls_h01nno
Long ll_Rv

dw_con.Accepttext()

ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4)
ls_h01nno = trim(dw_con.GetitemString(dw_con.Getrow(), 'member_no'))

//dw_tab1.event ue_retrieve()

ll_rv = This.insertrow(0)

dw_tab1.setitem(ll_rv, 'p43yar', ls_year)
dw_tab1.setitem(ll_rv, 'p43nno', ls_h01nno)
This.SetItemStatus(ll_rv, 0, Primary!,  New!)
This.setrow(ll_rv)
This.scrolltorow(ll_Rv)

dw_tab1_1.reset()
ll_rv = dw_tab1_1.Insertrow(0)
dw_tab1_1.setitem(ll_rv, 'p43yar', ls_year)
dw_tab1_1.setitem(ll_rv, 'p43nno', ls_h01nno)


RETURN 1

end event

event type long ue_deleterow();If This.Getrow() > 0 Then 
	If Messagebox("알림", "의료비 및 기부금 입력 내역이 삭제됩니다! 삭제하시겠습니까? ",  Exclamation!, Yesno!, 2) = 2 Then RETURN -1
	String ls_nno, ls_yar, ls_rno
	long ll_row
	ll_row = This.Getrow()
	ls_nno = func.of_nvl(This.GetitemSTring(ll_row, 'p43nno'), '')
	ls_yar = func.of_nvl(This.GetitemSTring(ll_row, 'p43yar'), '')
	ls_rno = func.of_nvl(This.GetitemSTring(ll_row, 'p43rno'), '')
	
	DELETE FROM PADB.HPAP44T 
	WHERE P44YAR = :ls_yar
	    AND P44NNO = :ls_nno
		AND P44RNO = :ls_rno;
	If SQLCA.SQLCODE <> 0 Then
		ROLLBACK USING SQLCA;
		Messagebox("알림", "의료비 내역 삭제 중 에러!")
		RETURN -1
	End If
    
	DELETE FROM PADB.HPAP45T 
	WHERE P45YAR = :ls_yar
	    AND P45NNO = :ls_nno
		AND P45RNO = :ls_rno;
	If SQLCA.SQLCODE <> 0 Then
		ROLLBACK USING SQLCA;
		Messagebox("알림", "기부금 내역 삭제 중 에러!")
		RETURN -1
	End If
    
		
	This.deleterow(This.Getrow())
	This.update()
	
	dw_tab1_1.reset()
	dw_tab1_1.insertrow(0)
	RETURN 1
End If
end event

event type long ue_update();Long					ll_dw_cnt
Long					ll_i
Long					ll_totmodcont
String					ls_dw_id

ll_totmodcont = 0	


If  This.AcceptText() <> 1 Then
	this.SetFocus()
	RETURN -1
End If


ll_totmodcont = (this.ModifiedCount() + this.DeletedCount())
	
If ll_totmodcont <= 0 Then
	f_set_message("[저장] " + '변경된 내용이 없습니다.', '', parentwin)
	RETURN 0
End If
	
SetPointer(HourGlass!)
	

//입력 데이터에 대한 각종 Validation Check를 기술하십시요.


	If wf_upd_date_set(this) = -1 Then
		RETURN -1
	End If


// Update Property check

	If this.Describe("DataWindow.Table.UpdateTable") = "?" Then
		ls_dw_id = this.DataObject
		
		
		SetPointer(Arrow!)
		gf_message(parentwin, 2, '9999', 'ERROR', 'DataWindow = ' + ls_dw_id + '의 Update속성이 지정되지 않았습니다.')
		RETURN -1
	End If

	If func.of_checknull(dw_tab1) = -1 Then
		RETURN -1
	End If
	
//	For ll_i = 1 To dw_tab1.rowcount() 
//		If dw_tab1.object.p4303[ll_i]  <> 0 and dw_tab1.object.p43rel[ll_i]  <> '0' Then //본인 Then 
//			If dw_tab1.object.p43edg[ll_i] = '' or isnull(dw_tab1.object.p43edg[ll_i]) Then
//				Messagebox("알림", "교육비 구분을 입력하세요!")
//				RETURN -1
//			End If
//		End If	
//	Next
	


	If this.Update(TRUE, TRUE) <> 1 Then
		ROLLBACK USING SQLCA;	
		
		SetPointer(Arrow!)
		f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
		RETURN -1
	End If

	

COMMIT USING SQLCA;

ib_excl_yn = FALSE

f_set_message("[저장] " + '성공적으로 저장되었습니다.', '', parentwin)


SetPointer(Arrow!)

RETURN 1
end event

event constructor;call super::constructor;settransobject(sqlca)
This.object.datawindow.readonly = 'Yes'
end event

event rowfocuschanged;call super::rowfocuschanged;If currentrow > 0 and  currentrow <= This.rowcount()   Then
		If This.GetItemStatus(currentrow, 0, Primary!) <> NewModified! And This.GetItemStatus(currentrow, 0, Primary!) <> New! Then// And This.GetItemStatus(currentrow, 0, Primary!) <>  NotModified! Then
	    		//This.update()
			If  wf_update_chk()  > 0 then
				dw_tab1_1.post Event ue_Retrieve()
			Else
				RETURN 0
			end If
		End If
End If
return 0

end event

type dw_tab1_1 from uo_dwfree within tabpage_1
event type long ue_retrieve ( )
event type long ue_insertrow ( )
event type long ue_deleterow ( )
event type long ue_update ( )
integer x = 9
integer y = 972
integer width = 4334
integer height = 340
integer taborder = 20
string dataobject = "d_hpa412a_4"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
String 	ls_member, ls_year, ls_p43rno

dw_tab1.Accepttext()

ls_member = dw_tab1.GetitemString(dw_tab1.Getrow(), 'p43nno') //사원번호
ls_year = trim(dw_tab1.GetitemString(dw_tab1.Getrow(), 'p43yar')) //정산년도
ls_p43rno = dw_tab1.GetitemSTring(dw_tab1.Getrow(), 'p43rno') //주민등록번호

ll_rv = This.retrieve(ls_year, ls_member, ls_p43rno)

If ll_rv = 0 Then
	This.Insertrow(0)
End If
RETURN ll_rv

end event

event itemchanged;call super::itemchanged;Long ll_row , ll_amt, ll_age, ll_amt1
String ls_coltype, ls_col,  ls_year, ls_birth_year, ls_rel, ls_egd, ls_col1


dw_tab1.accepttext()
ll_row = dw_tab1.Getrow()
//

ls_coltype = left(This.Describe(dwo.name + ".ColType"), 4)
ls_col = dwo.name

If UPPER(ls_coltype) = 'CHAR' Then
	dw_tab1.Setitem(ll_row, ls_col , data)
ElseIf UPPER(ls_coltype) = 'DECI' Then
	ll_amt =  Long(data)
	dw_tab1.Setitem(ll_row, ls_col, ll_amt)
	If ll_amt > 0 Then
		If ls_col = 'p43g08' Then 
			dw_tab1.Setitem(ll_row, left(ls_col,  3) + 'C01', 'Y')
		Else
			dw_tab1.Setitem(ll_row, left(ls_col,  3) + 'C' + right(ls_col,  2), 'Y')
		End If
	Else
		If ls_col = 'p43g08' Then 
			If This.GetitemNumber(row, 'p43g01') + This.GetitemNumber(row, 'p43f01') = 0 Then 
				dw_tab1.Setitem(ll_row, left(ls_col,  3) + 'C01', 'N')
			End If
		Else
			If mid(ls_col, 4, 1) = 'g' then 
				ls_col1 = left(ls_col,  3) + 'f' + right(ls_col,  2) 
			Else
				ls_col1 = left(ls_col,  3) + 'g' + right(ls_col,  2) 
			End If
			ll_amt1 = This.GetitemNumber(row,  ls_col1)
			If  ll_Amt + ll_amt1 = 0 Then 
				dw_tab1.Setitem(ll_row, left(ls_col,  3) + 'C' + right(ls_col,  2), 'N')
			End If
		End If
	End If
End If
//	
If dwo.name = 'p43rel' Then
	If data = '0' Then 
		This.setitem(row, 'p43ko1' , 'Y')
		This.event itemChanged(row, This.object.p43ko1, 'Y')
		This.setitem(row, 'p43knm', dw_main.GetitemString(dw_main.Getrow(), 'h01knm'))
		This.event itemChanged(row, This.object.p43knm, dw_main.GetitemString(dw_main.Getrow(), 'h01knm'))
		This.setitem(row, 'p43rno', dw_main.GetitemString(dw_main.Getrow(), 'h01rno'))
		This.event itemChanged(row, This.object.p43rno, dw_main.GetitemString(dw_main.Getrow(), 'h01rno'))	
	End If
	
	dw_tab1.Setitem(ll_row, 'p43rel' , data)
End If

If dwo.name = 'p43ko2' Then
	If data = 'N'  Then
		This.setitem(row, 'p43g08', 0)
		This.event itemChanged(row, This.object.p43g08, '0')	
	End If
		
End If


If dwo.name = 'p43rno' Then //주민등록번호
	//나이를 구한다.
	If func.of_reg_no_check(data) = FALSE Then
				If messagebox("알림", "사용하시겠습니까?",  Exclamation!, YesNo!, 2) = 2 Then
					This.SetItem(row, "p43rno", "")
					dw_tab1.Setitem(ll_row,  "p43rno", "")
					RETURN 1
				End If
	End If		
	
	ls_year = dw_con.GetitemString(dw_con.Getrow(), 'year')
	If mid(data, 7, 1) = '1' Or mid(data, 7, 1) = '2' Or mid(data, 7, 1) = '5' Or mid(data, 7, 1) = '6' Then
		ls_birth_year = '19' + mid(data, 1, 2)
	Else
		ls_birth_year = '20' + mid(data, 1, 2)
	End If
	ll_age = Long(ls_year) - Long(ls_birth_year)
	This.Setitem(row, 'p43age', ll_age)
	dw_tab1.Setitem(ll_row, 'p43age', ll_age)	

	//관계코드(기본공제)
	ls_rel = Trim(This.GetitemString(row, 'p43rel'))
	If ls_rel = '' Or isnull(ls_rel) Then RETURN -1
	If ls_rel = '3' Then //배우자
		This.Setitem(row, 'p43ko1', 'Y')
		dw_tab1.Setitem(ll_Row, 'p43ko1', 'Y')
	End If

	If ls_rel = '4' OR ls_rel = '5'  Then  //직계비속 - 다자녀
		If ll_age <= 20 Then  //20세 이하 기본공제  
			This.Setitem(row, 'p43ko1', 'Y')
			This.setitem(row, 'p43con', 'Y')
			dw_tab1.Setitem(ll_Row, 'p43ko1', 'Y')
			dw_tab1.Setitem(ll_Row, 'p43con', 'Y')
		Else
			This.Setitem(row, 'p43ko1', 'N')
			This.setitem(row, 'p43con', 'N')
			dw_tab1.Setitem(ll_Row, 'p43ko1', 'N')
			dw_tab1.Setitem(ll_Row, 'p43con', 'N')
		End If
		
//		If ll_age <= 6 Then  //6세 이하는 자녀양육공제
//			This.setitem(row, 'p43ko3', 'Y')
//			This.setitem(row, 'p43con', 'Y')
//			dw_tab1.Setitem(ll_Row, 'p43ko3', 'Y')
//			dw_tab1.Setitem(ll_Row, 'p43con', 'Y')
//		End If
	End If

	If ls_rel = '6'	Then //형제자매
		If ll_age <= 20 Then  //20세 이하
			This.Setitem(row, 'p43ko1', 'Y')
			dw_tab1.Setitem(ll_Row, 'p43ko1', 'Y')
		Else
			This.Setitem(row, 'p43ko1', 'N')
			dw_tab1.Setitem(ll_Row, 'p43ko1', 'N')
		End If
		
		If ll_age >= 60 Then  //60세 이상
			This.Setitem(row, 'p43ko1', 'Y')
			dw_tab1.Setitem(ll_Row, 'p43ko1', 'Y')
		Else
			This.Setitem(row, 'p43ko1', 'N')
			dw_tab1.Setitem(ll_Row, 'p43ko1', 'N')
		End If
//		If mid(data, 7, 1) = '1' Or mid(data, 7, 1) = '3' Then  //남자
//			If ll_age >= 60 Then  //60세 이상
//				This.Setitem(row, 'p43ko1', 'Y')
//				dw_tab1.Setitem(ll_Row, 'p43ko1', 'Y')
//			End If
//		Else  //여자
//			If ll_age >= 55 Then  //55세 이상
//				This.Setitem(row, 'p43ko1', 'Y')
//				dw_tab1.Setitem(ll_Row, 'p43ko1', 'Y')
//			End If
//		End If
	End If
	
	If ls_rel = '1' Or ls_rel = '2'	Then //직계존속
				
		If ll_age >= 60 Then  //60세 이상
			This.Setitem(row, 'p43ko1', 'Y')
			dw_tab1.Setitem(ll_Row, 'p43ko1', 'Y')
		Else
			This.Setitem(row, 'p43ko1', 'N')
			dw_tab1.Setitem(ll_Row, 'p43ko1', 'N')
		End If
		
//		If mid(data, 7, 1) = '1' Or mid(data, 7, 1) = '3' Then  //남자
//			If ll_age >= 60 Then  //60세 이상
//				This.Setitem(row, 'p43ko1', 'Y')
//				dw_tab1.Setitem(ll_Row, 'p43ko1', 'Y')
//			End If
//		Else  //여자
//			If ll_age >= 55 Then  //55세 이상
//				This.Setitem(row, 'p43ko1', 'Y')
//				dw_tab1.Setitem(ll_Row, 'p43ko1', 'Y')
//			End If
//		End If
	
		//경로우대
		If ll_age >= 70 then 
			This.Setitem(row, 'p43ogb', 'Y')
			dw_tab1.Setitem(ll_Row, 'p43ogb', 'Y')
		Else
			This.Setitem(row, 'p43ogb', 'N')
			dw_tab1.Setitem(ll_Row, 'p43ogb', 'N')
		End If
	Elseif ls_rel = '0' Then
		//경로우대
		If ll_age >= 70 then 
			This.Setitem(row, 'p43ogb', 'Y')
			dw_tab1.Setitem(ll_Row, 'p43ogb', 'Y')
		Else
			This.Setitem(row, 'p43ogb', 'N')
			dw_tab1.Setitem(ll_Row, 'p43ogb', 'N')
		End If
		
	End If

End If
	

If dwo.name = 'p43g03' Or dwo.name =	'p43f03'  Then
	ls_rel = This.GetitemString(row, 'p43rel')
	If ls_rel <> '0' Then //본인
		ls_egd = func.of_nvl(This.GetitemSTring(row, 'p43edg'), '')
		If long(data) > 0 Then
			If ls_egd = '' Or isnull(ls_egd) Then
				Messagebox("알림", "교육비구분을 입력하세요!")
				setcolumn('p43edg')
				RETURN 1
			End If
		End If
	End If
End If

	
	
end event

event editchanged;call super::editchanged;Long ll_row , ll_amt, ll_age, ll_amt1
String ls_coltype, ls_col,  ls_year, ls_birth_year, ls_rel, ls_col1


dw_tab1.accepttext()
ll_row = dw_tab1.Getrow()


ls_coltype = left(This.Describe(dwo.name + ".ColType"), 4)
ls_col = dwo.name

If UPPER(ls_coltype) = 'CHAR' Then
	dw_tab1.Setitem(ll_row, ls_col , data)
ElseIf UPPER(ls_coltype) = 'DECI' Then
	ll_amt =  Long(data)
	dw_tab1.Setitem(ll_row, ls_col, ll_amt)
	If ll_amt > 0 Then
		If ls_col = 'p43g08' Then 
			dw_tab1.Setitem(ll_row, left(ls_col,  3) + 'C01', 'Y')
		Else
			dw_tab1.Setitem(ll_row, left(ls_col,  3) + 'C' + right(ls_col,  2), 'Y')
		End If
	Else
		If ls_col = 'p43g08' Then 
			If This.GetitemNumber(row, 'p43g01') + This.GetitemNumber(row, 'p43f01') = 0 Then 
				dw_tab1.Setitem(ll_row, left(ls_col,  3) + 'C01', 'N')
			End If
		Else
			If mid(ls_col, 4, 1) = 'g' then 
				ls_col1 = left(ls_col,  3) + 'f' + right(ls_col,  2) 
			Else
				ls_col1 = left(ls_col,  3) + 'g' + right(ls_col,  2) 
			End If
			
			ll_amt1 = This.GetitemNumber(row,  ls_col1)
			If  ll_Amt + ll_amt1 = 0 Then 
				dw_tab1.Setitem(ll_row, left(ls_col,  3) + 'C' + right(ls_col,  2), 'N')
			End If
		End If
	End If
End If
	
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemerror;call super::itemerror;return 1
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1304
long backcolor = 16777215
string text = "전근무지"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab2 dw_tab2
r_tab2 r_tab2
end type

on tabpage_2.create
this.dw_tab2=create dw_tab2
this.r_tab2=create r_tab2
this.Control[]={this.dw_tab2,&
this.r_tab2}
end on

on tabpage_2.destroy
destroy(this.dw_tab2)
destroy(this.r_tab2)
end on

type dw_tab2 from uo_dwlv within tabpage_2
event type long ue_retrieve ( )
event type long ue_insertrow ( )
event type long ue_deleterow ( )
event type long ue_update ( )
integer x = 9
integer y = 28
integer width = 4334
integer height = 1272
integer taborder = 20
string dataobject = "d_hpa412a_5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
String 	ls_member, ls_year

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_member = dw_con.GetitemString(dw_con.Getrow(), 'member_no') //사원번호
ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4) //정산년도

ll_rv = This.retrieve(ls_year, ls_member)

RETURN ll_rv
end event

event type long ue_insertrow();String ls_year, ls_h01nno
Long ll_Rv

dw_con.Accepttext()

ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4)
ls_h01nno = trim(dw_con.GetitemString(dw_con.Getrow(), 'member_no'))

//dw_tab1.event ue_retrieve()

ll_rv = This.insertrow(0)

This.setitem(ll_rv, 'p42yar', ls_year)
This.setitem(ll_rv, 'p42nno', ls_h01nno)

This.setrow(ll_rv)
This.scrolltorow(ll_Rv)

RETURN 1

end event

event type long ue_deleterow();If This.Getrow() > 0 Then 
	If Messagebox("알림", "삭제하시겠습니까?",  Exclamation!, Yesno!, 2) = 2 Then RETURN -1
	This.deleterow(This.Getrow())
	RETURN 1
End If
end event

event type long ue_update();Long					ll_dw_cnt
Long					ll_i
Long					ll_totmodcont
String					ls_dw_id

ll_totmodcont = 0	


If  This.AcceptText() <> 1 Then
	this.SetFocus()
	RETURN -1
End If


ll_totmodcont = (this.ModifiedCount() + this.DeletedCount())
	
If ll_totmodcont <= 0 Then
	f_set_message("[저장] " + '변경된 내용이 없습니다.', '', parentwin)
	RETURN 0
End If
	
SetPointer(HourGlass!)
	

//입력 데이터에 대한 각종 Validation Check를 기술하십시요.


	If wf_upd_date_set(this) = -1 Then
		RETURN -1
	End If


// Update Property check

	If this.Describe("DataWindow.Table.UpdateTable") = "?" Then
		ls_dw_id = this.DataObject
		
		
		SetPointer(Arrow!)
		gf_message(parentwin, 2, '9999', 'ERROR', 'DataWindow = ' + ls_dw_id + '의 Update속성이 지정되지 않았습니다.')
		RETURN -1
	End If

	If func.of_checknull(dw_tab2) = -1 Then
		RETURN -1
	End If

	If this.Update(TRUE, TRUE) <> 1 Then
		ROLLBACK USING SQLCA;	
		
		SetPointer(Arrow!)
		f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
		RETURN -1
	End If

	

COMMIT USING SQLCA;

ib_excl_yn = FALSE

f_set_message("[저장] " + '성공적으로 저장되었습니다.', '', parentwin)


SetPointer(Arrow!)

RETURN 1
end event

event itemchanged;call super::itemchanged;String 		ls_null, ls_emp_no, ls_per_jumin_num
//Vector      lvc_data

//lvc_data = Create Vector

SetNull(ls_null)

Choose Case dwo.name
	Case 'p42bnb'
		If func.of_reg_no_check(TRIM(data)) = FALSE Then		
			If messagebox("알림", "사용하시겠습니까?",  Exclamation!, YesNo!, 2) = 2 Then
				This.Setitem(row, 'p42bnb', ls_null)
				RETURN 1
			End If
		End If
ENd Choose

//Destroy lvc_data


end event

event rowfocuschanged;call super::rowfocuschanged; wf_update_chk() 
		
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemerror;call super::itemerror;return 1
end event

type r_tab2 from rectangle within tabpage_2
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 119
integer y = 48
integer width = 64
integer height = 60
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1304
long backcolor = 16777215
string text = "기부금"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab3_1 dw_tab3_1
dw_tab3 dw_tab3
r_tab3 r_tab3
r_tab3_1 r_tab3_1
end type

on tabpage_3.create
this.dw_tab3_1=create dw_tab3_1
this.dw_tab3=create dw_tab3
this.r_tab3=create r_tab3
this.r_tab3_1=create r_tab3_1
this.Control[]={this.dw_tab3_1,&
this.dw_tab3,&
this.r_tab3,&
this.r_tab3_1}
end on

on tabpage_3.destroy
destroy(this.dw_tab3_1)
destroy(this.dw_tab3)
destroy(this.r_tab3)
destroy(this.r_tab3_1)
end on

type dw_tab3_1 from uo_dwlv within tabpage_3
event type long ue_retrieve ( )
event type long ue_insertrow ( )
event type long ue_deleterow ( )
event type long ue_update ( )
integer x = 5
integer y = 28
integer width = 4334
integer height = 624
integer taborder = 10
string dataobject = "d_hpa412a_3"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
String 	ls_member, ls_year

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_member = dw_con.GetitemString(dw_con.Getrow(), 'member_no') //사원번호
ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4) //정산년도
This.setfilter('')
This.filter()
ll_rv = This.retrieve(ls_year, ls_member)

If ll_rv > 0 Then  //기부금은 본인/배우자/직계비속/입양자만 입력가
	This.setfilter("p43rel = '0'  Or p43rel = '3' Or p43rel = '4' Or p43rel = '5'")
	This.filter()
	dw_tab3.event ue_retrieve()
	uo_gibu.of_enable(true)
Else
	dw_tab3.reset()
	uo_gibu.of_enable(false)
End If
end event

event type long ue_insertrow();If This.Rowcount() = 0 Then RETURN -1

dw_tab3.event ue_insertrow()
end event

event type long ue_deleterow();If This.Rowcount() = 0 Then RETURN -1

dw_tab3.event ue_deleterow()

end event

event type long ue_update();Long					ll_dw_cnt
Long					ll_i
Long					ll_totmodcont
String					ls_dw_id

ll_totmodcont = 0	


If  This.AcceptText() <> 1 Then
	this.SetFocus()
	RETURN -1
End If


ll_totmodcont = (this.ModifiedCount() + this.DeletedCount())
	
If ll_totmodcont <= 0 Then
	f_set_message("[저장] " + '변경된 내용이 없습니다.', '', parentwin)
	RETURN 0
End If
	
SetPointer(HourGlass!)
	

//입력 데이터에 대한 각종 Validation Check를 기술하십시요.


	If wf_upd_date_set(this) = -1 Then
		RETURN -1
	End If


// Update Property check

	If this.Describe("DataWindow.Table.UpdateTable") = "?" Then
		ls_dw_id = this.DataObject
		
		
		SetPointer(Arrow!)
		gf_message(parentwin, 2, '9999', 'ERROR', 'DataWindow = ' + ls_dw_id + '의 Update속성이 지정되지 않았습니다.')
		RETURN -1
	End If

	If func.of_checknull(dw_tab3_1) = -1 Then
		RETURN -1
	End If

	If this.Update(TRUE, TRUE) <> 1 Then
		ROLLBACK USING SQLCA;	
		
		SetPointer(Arrow!)
		f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
		RETURN -1
	End If

	

COMMIT USING SQLCA;

ib_excl_yn = FALSE

f_set_message("[저장] " + '성공적으로 저장되었습니다.', '', parentwin)


SetPointer(Arrow!)

RETURN 1
end event

event constructor;call super::constructor;settransobject(sqlca)
This.object.datawindow.readonly = 'Yes'
end event

event rowfocuschanged;call super::rowfocuschanged;If currentrow > 0 and  currentrow <= This.rowcount()   Then
		If This.GetItemStatus(currentrow, 0, Primary!) <> NewModified! And This.GetItemStatus(currentrow, 0, Primary!) <> New!  Then //And This.GetItemStatus(currentrow, 0, Primary!) <>  NotModified! Then
	    		//This.update()
			If wf_update_chk() = 1 then
				dw_tab3.Event ue_Retrieve()
			Else
				This.event ue_retrieve()
			End If
			
		End If
End If

end event

type dw_tab3 from uo_dwlv within tabpage_3
event type long ue_retrieve ( )
event type long ue_insertrow ( )
event type long ue_deleterow ( )
event type long ue_update ( )
integer x = 9
integer y = 680
integer width = 4334
integer height = 620
integer taborder = 20
string dataobject = "d_hpa412a_6"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
String 	ls_member, ls_year, ls_p43rno

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_member = dw_con.GetitemString(dw_con.Getrow(), 'member_no') //사원번호
ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4) //정산년도
ls_p43rno = dw_tab3_1.GetitemString(dw_tab3_1.Getrow(), 'p43rno') //주민번호

ll_rv = This.retrieve(ls_year, ls_member, ls_p43rno)

RETURN ll_rv
end event

event type long ue_insertrow();String ls_year, ls_h01nno, ls_p43rno, ls_p43knm, ls_p43rel
Long ll_Rv

dw_con.Accepttext()


ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4)
ls_h01nno = trim(dw_con.GetitemString(dw_con.Getrow(), 'member_no'))
ls_p43rno = trim(dw_tab3_1.GetitemString(dw_tab3_1.Getrow(), 'p43rno'))
ls_p43knm = trim(dw_tab3_1.GetitemString(dw_tab3_1.Getrow(), 'p43knm'))
ls_p43rel = trim(dw_tab3_1.GetitemSTring(Dw_tab3_1.Getrow(), 'p43rel'))



ll_rv = This.insertrow(0)

This.setitem(ll_rv, 'p45yar', ls_year)
This.setitem(ll_rv, 'p45nno', ls_h01nno)
This.setitem(ll_rv, 'p45rno', ls_p43rno)
This.SEtitem(ll_Rv, 'p45chm', ls_p43knm)

If ls_p43rel = '3' Then 
	ls_p43rel = '2'  //배우자
Elseif ls_p43rel = '4' OR ls_p43rel = '5' Then //직계비속 외
	ls_p43rel = '3'
Else
	ls_p43rel = '1' //거주자
End If

This.setitem(ll_rv, 'p45rls' , ls_p43rel)
This.setitem(ll_rv, 'p45gbn', '0')  //입력

This.setrow(ll_rv)
This.scrolltorow(ll_Rv)

RETURN 1

end event

event type long ue_deleterow();If This.Getrow() > 0 Then 
	If Messagebox("알림", "삭제하시겠습니까?",  Exclamation!, Yesno!, 2) = 2 Then RETURN -1
		
		String ls_rel_cd
		ls_rel_cd = This.GetitemString(this.getrow(), 'p45cod')
		Long ll_jungchi
		If ls_rel_cd = '20' Then //정치자금			
			ll_jungchi = 0
				
			tab_1.tabpage_5.dw_tab5.POST event itemchanged(	1, tab_1.tabpage_5.dw_tab5.object.p_4501_amt, String(ll_jungchi))
			tab_1.tabpage_5.dw_tab5_temp.POST event ue_update()
		End If
	
	This.deleterow(This.Getrow())
	dw_tab3_1.setitem(dw_tab3_1.Getrow(), 'p43f06', this.GetitemNumber(1, 'p45ptl_sum'))
	If this.GetitemNumber(1, 'p45ptl_sum')  > 0 Then
		dw_tab3_1.setitem(dw_tab3_1.Getrow(), 'P43C06' , 'Y')
	Else
		dw_tab3_1.setitem(dw_tab3_1.Getrow(), 'P43C06' , 'N')
	End If
	RETURN 1
End If
end event

event type long ue_update();Long					ll_dw_cnt
Long					ll_i
Long					ll_totmodcont
String					ls_dw_id

ll_totmodcont = 0	


If  This.AcceptText() <> 1 Then
	this.SetFocus()
	RETURN -1
End If


ll_totmodcont = (this.ModifiedCount() + this.DeletedCount())
	
If ll_totmodcont <= 0 Then
	f_set_message("[저장] " + '변경된 내용이 없습니다.', '', parentwin)
	RETURN 0
End If
	
SetPointer(HourGlass!)
	

//입력 데이터에 대한 각종 Validation Check를 기술하십시요.

Long    ll_seq, ll_row
String  ls_year, ls_h01nno


ls_year  = left(trim(dw_con.GetitemSTring(dw_con.Getrow(), 'year')), 4)
ls_h01nno = dw_con.GetitemString(dw_con.Getrow(), 'member_no')


SELECT MAX(P45SEQ) + 1
   INTO :ll_seq
  FROM PADB.HPAP45T
WHERE P45YAR = :ls_year
AND P45NNO = :ls_h01nno
USING SQLCA;

If sqlca.sqlcode = 100 Or ll_Seq = 0 Or isnull(ll_Seq) Then 	ll_seq = 1 

	ll_row = dw_tab3.GetNextModified(0, Primary!)
		Do While ll_row > 0			
			
			If dw_tab3.GetItemStatus(ll_row, 0, Primary!) = NewModified! Then
				dw_tab3.SetItem(ll_row, "p45seq", ll_seq)	//순번
				If dw_tab3.GetitemString(ll_row, 'p45cod') = '20' Then
					dw_tab3.Setitem(ll_row, 'p45bno', String(ll_seq,  '0000000000'))
				End If
			
			End If			
			ll_row = dw_tab3.GetNextModified(ll_row, Primary!)
			ll_seq ++
		Loop


	If  wf_upd_date_set(this) = -1 Then
		RETURN -1
	End If	




// Update Property check

	If this.Describe("DataWindow.Table.UpdateTable") = "?" Then
		ls_dw_id = this.DataObject
		
		
		SetPointer(Arrow!)
		gf_message(parentwin, 2, '9999', 'ERROR', 'DataWindow = ' + ls_dw_id + '의 Update속성이 지정되지 않았습니다.')
		RETURN -1
	End If

	
	If func.of_checknull(dw_tab3) = -1 Then
		RETURN -1
	End If

	If this.Update(TRUE, TRUE) <> 1 Then
		ROLLBACK USING SQLCA;	
		
		SetPointer(Arrow!)
		f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
		RETURN -1
	End If

	

COMMIT USING SQLCA;

ib_excl_yn = FALSE

dw_tab3_1.update() 

f_set_message("[저장] " + '성공적으로 저장되었습니다.', '', parentwin)


SetPointer(Arrow!)

RETURN 1
end event

event itemchanged;call super::itemchanged;String 		ls_incom_cd, ls_null, ls_incom, ls_year, ls_rel_cd
Vector      lvc_data
datawindow ldw_tab5
Long 		ll_tab5, ll_tab5_cnt, ll_tab3, ll_tab3_cnt
Long		ll_amt, ll_tab3_amt, ll_find
String		ls_dec
String		ls_rel


lvc_data = Create Vector

SetNull(ls_null)

This.accepttext()

String ls_rno
		
ls_rno = This.GetitemString(row, 'p45rno')
ll_find = dw_tab3_1.Find("p43rno = '" + ls_rno + "'", 1, dw_tab3_1.Rowcount())

Choose Case dwo.name
	Case 'p45bno'
		If func.of_reg_no_check(TRIM(data)) = FALSE Then
			If messagebox("알림", "사용하시겠습니까?",  Exclamation!, YesNo!, 2) = 2 Then
				This.Setitem(row, 'p45bno', ls_null)
				Return 1
			End If
		End If
	Case 'p45yrm'
		If len(trim(data)) <> 6 Then
			Messagebox("알림", "기부년월을 확인하세요!")
			This.Setitem(row, 'p45yrm', ls_null)
			Return 1
		End If
		

//	Case 'p45dec' //기부유형	
//		
//		This.Setitem(row, 'p45cod', '')
//		Datawindowchild ldw_child
//		Long rtncode
//		String ls_filter
//		
//		rtncode = This.GetChild('p45cod', ldw_child)
//		
//		IF rtncode = -1 THEN MessageBox( &
//				  "Error", "Not a DataWindowChild")
//		
//		ldw_child.SetTransObject(SQLCA)
//		
//		If data = '' Or isnull(data) Then
//			ls_filter = "zccsyscd = 'MIS'  and zccgrpcd = 'EC5'"
//		Else
//			ls_filter = "zccsyscd = 'MIS'  and zccgrpcd = 'EC5' and  ZCCVAL01 = '" + data + "'"
//		End If
//		
//		ldw_child.setfilter(ls_filter)
//		ldw_child.filter()
		
	Case 'p45cod' //기부코드
		ls_rel = dw_tab3_1.GetitemSTring(dw_tab3_1.Getrow(), 'p43rel')  //관계
		
		If ls_rel <> '0' And (data = '20' Or data = '42')  Then 
			Messagebox("알림", "정치자금 및 우리사주기부금은 본인만 입력할 수 있습니다!")
			This.SetItem(row, "p45cod", '')
			This.setcolumn(6)
			Return 1
		End If
		
		   SELECT ETC_CD1
			 INTO :ls_dec
				 FROM CDDB.KCH102D 
			WHERE UPPER(CODE_GB) = 'GIBO_OPT'   
			AND  CODE = :data
			USING SQLCA;
			
			This.Setitem(row, 'p45dec', ls_dec)		
		
//		ll_amt = This.GetitemNumber(row, 'p45ptl')
//
//		ls_incom_cd = wf_return_incom(data)	
//		ll_tab3_cnt = This.rowcount()
//		
//		If ll_amt > 0 Then
//			For ll_tab3 = 1 To ll_tab3_cnt
//				If ll_tab3 <> row Then
//					If ls_incom_cd = wf_return_incom(This.GetitemString(ll_tab3, 'p45cod')) Then 
//						ll_tab3_amt = This.GetitemNumber(ll_tab3, 'p45ptl')
//						ll_amt = ll_amt + ll_tab3_amt
//					End If
//				End If
//			Next
//			
//			ldw_tab5 = tab_1.tabpage_5.dw_tab5_temp
//			
//
//			ll_tab5_cnt = ldw_tab5.Rowcount()
//			
//			
//			ll_Find = ldw_tab5.find("P41DGB = '" + ls_incom_cd + "'", 1, ll_tab5_cnt)
//			
//			//정산년도
//			ls_year =  left(trim(dw_con.object.p43yar[dw_con.getrow()]), 4)
//			
//			If ll_find = 0 Then
//				ll_find =	ldw_tab5.Insertrow(0)		
//			End If
//			
//				SELECT HZ8DCD
//					INTO :ls_incom
//					FROM HRPDTALB.THZ8CMA0
//				WHERE HZ8YAR = :ls_year
//					  AND HZ8DGB = :ls_incom_cd
//				USING SQLCA;
//
//				ldw_tab5.Setitem(ll_find, 'P41YAR', ls_year)		
//				ldw_tab5.Setitem(ll_find, 'P41DCD', ls_incom)		
//				ldw_tab5.Setitem(ll_find, 'P41DGB', ls_incom_cd)		
//				ldw_tab5.Setitem(ll_find, 'P41NNO', dw_main.object.H01NNO[dw_main.getrow()])		
//				ldw_tab5.Setitem(ll_find, 'P41AJG',  'J')		 //연말정산
//				ldw_tab5.Setitem(ll_find, 'P41SAM', ll_amt)		
//				ldw_tab5.Setitem(ll_find, 'P41PCN', 1)	
//				
//				wf_etc_deduc(ls_incom_cd, ll_amt, ll_find, ls_year)				
//			
//		End If
		
	Case 'p45ptl'  //기부금액	
		
		ll_amt = long(data)
		ls_rel_cd = This.GetitemString(row, 'p45cod')
		Long ll_jungchi
		If ls_rel_cd = '20' Then //정치자금
		
			If ll_amt - 100000 > 0 Then
				ll_jungchi = 100000
				ll_amt = ll_amt - ll_jungchi
			Else
				ll_jungchi = ll_amt
				ll_amt = 0
			End If
			
		tab_1.tabpage_5.dw_tab5.POST event itemchanged(	1, tab_1.tabpage_5.dw_tab5.object.p_4501_amt, String(ll_jungchi))
		tab_1.tabpage_5.dw_tab5_temp.POST event ue_update()
//		This.post event itemchanged(	row,this.object.p45ptl, String(ll_amt))
		data = String(ll_amt)
		
		This.setitem(row, 'p45ptl', ll_amt)
		
		
		dw_tab3_1.setitem(ll_find, 'p43f06', This.GetitemNumber(1, 'p45ptl_sum'))
				 If This.GetitemNumber(1, 'p45ptl_sum') > 0 Then
					 dw_tab3_1.setitem(ll_find, 'P43C06', 'Y') 
				Else
					dw_tab3_1.setitem(ll_find, 'P43C06' , 'N')
				End If		
			Return 	2
	
		End If
//		ls_incom_cd = wf_return_incom(ls_rel_cd)
//
//		ll_tab3_cnt = This.rowcount()
//		
//		If ll_amt > 0 Then
//			For ll_tab3 = 1 To ll_tab3_cnt
//				
//				If ll_tab3 <> row Then
//					If  ls_incom_cd = wf_return_incom( This.GetitemString(ll_tab3, 'p45cod')) Then 
//						ll_tab3_amt = This.GetitemNumber(ll_tab3, 'p45ptl')
//						ll_amt = ll_amt + ll_tab3_amt
//					End If
//				End If
//			Next
//			
//			ldw_tab5 = tab_1.tabpage_5.dw_tab5_temp
//			
//			ll_tab5_cnt = ldw_tab5.Rowcount()
//				
//			ll_Find = ldw_tab5.find("P41DGB = '" + ls_incom_cd + "'", 1, ll_tab5_cnt)
//			
//				//정산년도
//			ls_year =  left(trim(dw_con.object.p43yar[dw_con.getrow()]), 4)
//			
//			If ll_find = 0 Then
//				ll_find =	ldw_tab5.Insertrow(0)
//			
//			End If
//
//				SELECT HZ8DCD
//					INTO :ls_incom
//					FROM HRPDTALB.THZ8CMA0
//				WHERE HZ8YAR = :ls_year
//					  AND HZ8DGB = :ls_incom_cd
//				USING SQLCA;
//
//
//				ldw_tab5.Setitem(ll_find, 'P41YAR', ls_year)		
//				ldw_tab5.Setitem(ll_find, 'P41DCD', ls_incom)		
//				ldw_tab5.Setitem(ll_find, 'P41DGB', ls_incom_cd)		
//				ldw_tab5.Setitem(ll_find, 'P41NNO', dw_main.object.H01NNO[dw_main.getrow()])		
//				ldw_tab5.Setitem(ll_find, 'P41AJG',  'J')		 //연말정산
//				ldw_tab5.Setitem(ll_find, 'P41SAM', ll_amt)		
//				ldw_tab5.Setitem(ll_find, 'P41PCN', 1)						
//				
//				
//				wf_etc_deduc(ls_incom_cd, ll_amt, ll_find, ls_year)
				
			    dw_tab3_1.setitem(ll_find, 'p43f06', This.GetitemNumber(1, 'p45ptl_sum'))
				 If This.GetitemNumber(1, 'p45ptl_sum') > 0 Then
					 dw_tab3_1.setitem(ll_find, 'P43C06', 'Y') 
				Else
					dw_tab3_1.setitem(ll_find, 'P43C06' , 'N')
				End If
			
		
	
ENd Choose

Destroy lvc_data


//RETURN 1
end event

event rowfocuschanged;call super::rowfocuschanged;If currentrow > 0 and  currentrow <= This.rowcount()   Then
		If This.GetItemStatus(currentrow, 0, Primary!) <> NewModified! And This.GetItemStatus(currentrow, 0, Primary!) <> New! And This.GetItemStatus(currentrow, 0, Primary!) <>  NotModified! Then
//	    		//This.update()
			If wf_update_chk() <> 1 then
				//dw_tab3_1.Event ue_Retrieve()
			Else
				//This.event ue_retrieve()
			End If
			
		End If
End If

end event

event editchanged;call super::editchanged;//String 		ls_incom_cd, ls_null, ls_incom, ls_year, ls_rel_cd
//Vector      lvc_data
//datawindow ldw_tab5
//Long 		ll_tab5, ll_tab5_cnt, ll_tab3, ll_tab3_cnt
//Long		ll_amt, ll_tab3_amt, ll_find
//String		ls_dec
//String		ls_rel
//
//
//lvc_data = Create Vector
//
//
//Choose Case dwo.name
//
//		
//	Case 'p45ptl'  //기부금액	
//		
//		ll_amt = long(data)
//		ls_rel_cd = This.GetitemString(row, 'p45cod')
//		Long ll_jungchi
//		If ls_rel_cd = '20' Then //정치자금
//		
//			If ll_amt - 100000 > 0 Then
//				ll_jungchi = 100000
//				ll_amt = ll_amt - ll_jungchi
//			Else
//				ll_jungchi = ll_amt
//				ll_amt = 0
//			End If
//			
//		tab_1.tabpage_5.dw_tab5.post event itemchanged(	1, tab_1.tabpage_5.dw_tab5.object.p_4501_amt, String(ll_jungchi))
//		tab_1.tabpage_5.dw_tab5_temp.post event ue_update()
////		This.post event itemchanged(	row,this.object.p45ptl, String(ll_amt))
//		data = String(ll_amt)
//		
//		This.setitem(row, 'p45ptl', ll_amt)
//		String ls_rno
//		
//		ls_rno = This.GetitemString(row, 'p45rno')
//		ll_find = dw_tab3_1.Find("p43rno = '" + ls_rno + "'", 1, dw_tab3_1.Rowcount())
//		
//		dw_tab3_1.setitem(ll_find, 'p43f06', This.GetitemNumber(1, 'p45ptl_sum'))
//				 If This.GetitemNumber(1, 'p45ptl_sum') > 0 Then
//					 dw_tab3_1.setitem(ll_find, 'P43C06', 'Y') 
//				Else
//					dw_tab3_1.setitem(ll_find, 'P43C06' , 'N')
//				End If		
//		RETURN 1		
//	
//		End If
////		ls_incom_cd = wf_return_incom(ls_rel_cd)
////
////		ll_tab3_cnt = This.rowcount()
////		
////		If ll_amt > 0 Then
////			For ll_tab3 = 1 To ll_tab3_cnt
////				
////				If ll_tab3 <> row Then
////					If  ls_incom_cd = wf_return_incom( This.GetitemString(ll_tab3, 'p45cod')) Then 
////						ll_tab3_amt = This.GetitemNumber(ll_tab3, 'p45ptl')
////						ll_amt = ll_amt + ll_tab3_amt
////					End If
////				End If
////			Next
////			
////			ldw_tab5 = tab_1.tabpage_5.dw_tab5_temp
////			
////			ll_tab5_cnt = ldw_tab5.Rowcount()
////				
////			ll_Find = ldw_tab5.find("P41DGB = '" + ls_incom_cd + "'", 1, ll_tab5_cnt)
////			
////				//정산년도
////			ls_year =  left(trim(dw_con.object.p43yar[dw_con.getrow()]), 4)
////			
////			If ll_find = 0 Then
////				ll_find =	ldw_tab5.Insertrow(0)
////			
////			End If
////
////				SELECT HZ8DCD
////					INTO :ls_incom
////					FROM HRPDTALB.THZ8CMA0
////				WHERE HZ8YAR = :ls_year
////					  AND HZ8DGB = :ls_incom_cd
////				USING SQLCA;
////
////
////				ldw_tab5.Setitem(ll_find, 'P41YAR', ls_year)		
////				ldw_tab5.Setitem(ll_find, 'P41DCD', ls_incom)		
////				ldw_tab5.Setitem(ll_find, 'P41DGB', ls_incom_cd)		
////				ldw_tab5.Setitem(ll_find, 'P41NNO', dw_main.object.H01NNO[dw_main.getrow()])		
////				ldw_tab5.Setitem(ll_find, 'P41AJG',  'J')		 //연말정산
////				ldw_tab5.Setitem(ll_find, 'P41SAM', ll_amt)		
////				ldw_tab5.Setitem(ll_find, 'P41PCN', 1)						
////				
////				
////				wf_etc_deduc(ls_incom_cd, ll_amt, ll_find, ls_year)
//				
//			    dw_tab3_1.setitem(dw_tab3_1.getrow(), 'p43f06', This.GetitemNumber(1, 'p45ptl_sum'))
//				 If This.GetitemNumber(1, 'p45ptl_sum') > 0 Then
//					 dw_tab3_1.setitem(dw_tab3_1.getrow(), 'P43C06', 'Y') 
//				Else
//					dw_tab3_1.setitem(dw_tab3_1.Getrow(), 'P43C06' , 'N')
//				End If
//			
////		End If
//		
//	Case Else
//ENd Choose
//
//Destroy lvc_data
//
//
////RETURN 1
end event

event constructor;call super::constructor;settransobject(sqlca)


DataWindowChild	ldwc_Temp
This.GetChild('p45cod',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('gibo_opt',0) = 0 THEN
	wf_setmsg('공통코드[기부금코드]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
Else
	This.GetChild('p45cod_1',ldwc_Temp)
	ldwc_Temp.SetTransObject(SQLCA)
	ldwc_Temp.Retrieve('gibo_opt',0) 
END IF


end event

event itemerror;call super::itemerror;return 1
end event

type r_tab3 from rectangle within tabpage_3
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 119
integer y = 48
integer width = 64
integer height = 60
end type

type r_tab3_1 from rectangle within tabpage_3
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 119
integer y = 124
integer width = 64
integer height = 60
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1304
long backcolor = 16777215
string text = "의료비"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab4_1 dw_tab4_1
dw_tab4 dw_tab4
r_tab4 r_tab4
r_tab4_1 r_tab4_1
end type

on tabpage_4.create
this.dw_tab4_1=create dw_tab4_1
this.dw_tab4=create dw_tab4
this.r_tab4=create r_tab4
this.r_tab4_1=create r_tab4_1
this.Control[]={this.dw_tab4_1,&
this.dw_tab4,&
this.r_tab4,&
this.r_tab4_1}
end on

on tabpage_4.destroy
destroy(this.dw_tab4_1)
destroy(this.dw_tab4)
destroy(this.r_tab4)
destroy(this.r_tab4_1)
end on

type dw_tab4_1 from uo_dwlv within tabpage_4
event type long ue_retrieve ( )
event type long ue_insertrow ( )
event type long ue_deleterow ( )
event type long ue_update ( )
integer x = 5
integer y = 28
integer width = 4334
integer height = 628
integer taborder = 20
string dataobject = "d_hpa412a_3"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
String 	ls_member, ls_year

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_member = dw_con.GetitemString(dw_con.Getrow(), 'member_no') //사원번호
ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4) //정산년도

ll_rv = This.retrieve(ls_year, ls_member)
If ll_rv > 0 Then
	dw_tab4.event ue_retrieve()
	uo_medi.of_enable(true)
Else
	dw_tab4.reset()
	uo_medi.of_enable(false)

End If

RETURN ll_rv
end event

event type long ue_insertrow();If This.Rowcount() = 0 Then RETURN -1

dw_tab4.event ue_insertrow()
end event

event type long ue_deleterow();If This.Rowcount() = 0 Then RETURN -1

dw_tab4.event ue_deleterow()

end event

event type long ue_update();Long					ll_dw_cnt
Long					ll_i
Long					ll_totmodcont
String					ls_dw_id

ll_totmodcont = 0	


If  This.AcceptText() <> 1 Then
	this.SetFocus()
	RETURN -1
End If


ll_totmodcont = (this.ModifiedCount() + this.DeletedCount())
	
If ll_totmodcont <= 0 Then
	f_set_message("[저장] " + '변경된 내용이 없습니다.', '', parentwin)
	RETURN 0
End If
	
SetPointer(HourGlass!)
	

//입력 데이터에 대한 각종 Validation Check를 기술하십시요.


	If wf_upd_date_set(this) = -1 Then
		RETURN -1
	End If


// Update Property check

	If this.Describe("DataWindow.Table.UpdateTable") = "?" Then
		ls_dw_id = this.DataObject
		
		
		SetPointer(Arrow!)
		gf_message(parentwin, 2, '9999', 'ERROR', 'DataWindow = ' + ls_dw_id + '의 Update속성이 지정되지 않았습니다.')
		RETURN -1
	End If

	
	If func.of_checknull(dw_tab4_1) = -1 Then
		RETURN -1
	End If

	If this.Update(TRUE, TRUE) <> 1 Then
		ROLLBACK USING SQLCA;	
		
		SetPointer(Arrow!)
		f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
		RETURN -1
	End If

	

COMMIT USING SQLCA;

ib_excl_yn = FALSE

f_set_message("[저장] " + '성공적으로 저장되었습니다.', '', parentwin)


SetPointer(Arrow!)

RETURN 1
end event

event constructor;call super::constructor;settransobject(sqlca)
This.object.datawindow.readonly = 'Yes'
end event

event rowfocuschanged;call super::rowfocuschanged;
If currentrow > 0 and  currentrow <= This.rowcount()   Then
		If This.GetItemStatus(currentrow, 0, Primary!) <> NewModified! And This.GetItemStatus(currentrow, 0, Primary!) <> New!  Then //And This.GetItemStatus(currentrow, 0, Primary!) <>  NotModified! Then
//	    		This.update()
			If  wf_update_chk()  = 1 then
				dw_tab4.Event ue_Retrieve()
			Else 
				This.event ue_retrieve()
			End If
		End If
End If

end event

type dw_tab4 from uo_dwlv within tabpage_4
event type long ue_retrieve ( )
event type long ue_insertrow ( )
event type long ue_deleterow ( )
event type long ue_update ( )
integer x = 18
integer y = 684
integer width = 4329
integer height = 620
integer taborder = 20
string dataobject = "d_hpa412a_7"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
String 	ls_member, ls_year, ls_p43rno

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_member = dw_con.GetitemString(dw_con.Getrow(), 'member_no') //사원번호
ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4) //정산년도
ls_p43rno = dw_tab4_1.GetitemString(dw_tab4_1.Getrow(), 'p43rno')

ll_rv = This.retrieve(ls_year, ls_member, ls_p43rno)

RETURN ll_rv
end event

event type long ue_insertrow();String ls_year, ls_h01nno, ls_p43rno, ls_p43knm, ls_p43rel, ls_p43frg, ls_P43KO2, ls_P44GBN
Long ll_Rv, ll_age

dw_con.Accepttext()


ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4)
ls_h01nno = trim(dw_con.GetitemString(dw_con.Getrow(), 'member_no'))
ls_p43rno = trim(dw_tab4_1.GetitemString(dw_tab4_1.Getrow(), 'p43rno'))
ls_p43knm = trim(dw_tab4_1.GetitemString(dw_tab4_1.Getrow(), 'p43knm'))
ls_p43rel = trim(dw_tab4_1.GetitemSTring(dw_tab4_1.Getrow(), 'p43rel'))
ls_p43frg = trim(dw_tab4_1.GetitemSTring(dw_tab4_1.Getrow(), 'p43gbn'))  //내외국인a
ll_age   = dw_tab4_1.GetitemNumber(dw_tab4_1.Getrow(), 'P43AGE')  //나이
ls_P43KO2   = trim(dw_tab4_1.GetitemSTring(dw_tab4_1.Getrow(), 'P43KO2'))  //장애여부
//dw_tab1.event ue_retrieve()

ll_rv = This.insertrow(0)

This.setitem(ll_rv, 'p44yar', ls_year)
This.setitem(ll_rv, 'p44nno', ls_h01nno)
This.setitem(ll_rv, 'p44rno', ls_p43rno)
This.SEtitem(ll_Rv, 'p44hnm', ls_p43knm)
This.SEtitem(ll_Rv, 'p44frg', ls_p43frg)
This.setitem(ll_rv, 'p44rls' , ls_p43rel)

If ls_p43rel = '0' Then   //본인
	ls_P44GBN = 'Y'
Else
	If ls_P43KO2 = 'Y' then  //장애
		ls_P44GBN = 'Y'
	Else
		If ll_age >= 70 then  //경로 
			ls_P44GBN = 'Y'
		Else
			ls_P44GBN = 'N'
		End If
	end If
End If

This.setitem(ll_rv, 'P44GBN' , ls_P44GBN)  //본인/장애/경로


This.setrow(ll_rv)
This.scrolltorow(ll_Rv)

RETURN 1
end event

event type long ue_deleterow();If This.Getrow() > 0 Then 
	If Messagebox("알림", "삭제하시겠습니까?",  Exclamation!, Yesno!, 2) = 2 Then RETURN -1
	This.deleterow(This.Getrow())
	dw_tab4_1.setitem(dw_tab4_1.getrow(), 'P43F02', This.GetitemNumber(1, 'p44hgs_sum'))  //국세청 제외
	dw_tab4_1.setitem(dw_tab4_1.getrow(), 'P43G02', This.GetitemNumber(1, 'p44hgs1_sum'))  //국세청
	If This.GetitemNumber(1, 'p44hgs_sum') > 0 Or This.GetitemNumber(1, 'p44hgs1_sum') > 0 Then
		dw_tab4_1.setitem(dw_tab4_1.getrow(), 'P43C02', 'Y')
	Elseif  This.GetitemNumber(1, 'p44hgs_sum') = 0 And This.GetitemNumber(1, 'p44hgs1_sum') = 0 Then
		dw_tab4_1.setitem(dw_tab4_1.getrow(), 'P43C02', 'N')
	End If
	RETURN 1
End If
end event

event type long ue_update();Long					ll_dw_cnt
Long					ll_i
Long					ll_totmodcont
String					ls_dw_id

ll_totmodcont = 0	


If  This.AcceptText() <> 1 Then
	this.SetFocus()
	RETURN -1
End If


ll_totmodcont = (this.ModifiedCount() + this.DeletedCount())
	
If ll_totmodcont <= 0 Then
	f_set_message("[저장] " + '변경된 내용이 없습니다.', '', parentwin)
	RETURN 0
End If
	
SetPointer(HourGlass!)
	

//입력 데이터에 대한 각종 Validation Check를 기술하십시요.
Long ll_seq, ll_row
String 	ls_year, ls_h01nno


ls_year  = left(trim(dw_con.GetitemSTring(dw_con.Getrow(), 'year')), 4)
ls_h01nno = dw_con.GetitemString(dw_con.Getrow(), 'member_no')

SELECT MAX(P44SEQ) + 1
   INTO :ll_seq
  FROM PADB.HPAP44T
WHERE P44YAR = :ls_year
AND P44NNO = :ls_h01nno
USING SQLCA;

If sqlca.sqlcode = 100 Or ll_Seq = 0 Or isnull(ll_Seq) Then 	ll_seq = 1 

	ll_row = dw_tab4.GetNextModified(0, Primary!)
		Do While ll_row > 0			
			
			If dw_tab4.GetItemStatus(ll_row, 0, Primary!) = NewModified! Then
				dw_tab4.SetItem(ll_row, "p44seq", ll_seq)	//순번
				If dw_tab4.GetitemString(ll_row, 'p44hsg') = '1' Then
					dw_tab4.Setitem(ll_row, 'p44bno', String(ll_seq,  '0000000000'))
				End If
			
			End If			
			ll_row = dw_tab4.GetNextModified(ll_row, Primary!)
			ll_seq ++
		Loop


	If wf_upd_date_set(this) = -1 Then
		RETURN -1
	End If


// Update Property check

	If this.Describe("DataWindow.Table.UpdateTable") = "?" Then
		ls_dw_id = this.DataObject
		
		
		SetPointer(Arrow!)
		gf_message(parentwin, 2, '9999', 'ERROR', 'DataWindow = ' + ls_dw_id + '의 Update속성이 지정되지 않았습니다.')
		RETURN -1
	End If

	
	If func.of_checknull(dw_tab4) = -1 Then
		RETURN -1
	End If


	If this.Update(TRUE, TRUE) <> 1 Then
		ROLLBACK USING SQLCA;	
		
		SetPointer(Arrow!)
		f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
		RETURN -1
	End If

	

COMMIT USING SQLCA;

ib_excl_yn = FALSE

String ls_nno , ls_yar, ls_rno
Long  ll_cnt
DEC ld_hsg, ld_hsg1
ll_cnt = dw_tab4_1.Rowcount()
For ll_i = 1 To ll_cnt 
	ls_nno = dw_tab4_1.GetitemSTring(ll_i, 'p43nno')
	ls_yar = dw_tab4_1.GetitemSTring(ll_i, 'p43yar')
	ls_rno = dw_tab4_1.GetitemSTring(ll_i, 'p43rno')
	
SELECT SUM(CASE WHEN P44HSG = '1' THEN NVL(P44PTL , 0) ELSE 0 END),
SUM(CASE WHEN P44HSG <> '1' THEN NVL(P44PTL , 0) ELSE 0 END)
INTO :ld_hsg, :ld_hsg1
FROM  PADB.HPAP44T A
WHERE P44YAR = :ls_yar
 AND P44NNO = :ls_nno
 AND P44RNO =  :ls_rno;

dw_tab4_1.setitem(ll_i, 'P43F02', ld_hsg1) //국세청 제외
dw_tab4_1.setitem(ll_i, 'P43G02', ld_hsg)  //국세청
If ld_hsg1 > 0 Or ld_hsg > 0 Then
	dw_tab4_1.setitem(ll_i, 'P43C02', 'Y')
Elseif  ld_hsg1 = 0 And ld_hsg = 0 Then
	dw_tab4_1.setitem(ll_i, 'P43C02', 'N')
End If
Next

If func.of_checknull(dw_tab4_1) = -1 Then
		RETURN -1
End If

dw_tab4_1.update() //의료비 업데이트
f_set_message("[저장] " + '성공적으로 저장되었습니다.', '', parentwin)


SetPointer(Arrow!)

RETURN 1
end event

event itemchanged;call super::itemchanged;String 		ls_null, ls_emp_no, ls_per_jumin_num
Long			ll_row, ll_rowcnt, ll_amt, ll_med_amt, ll_find
Vector      lvc_data

lvc_data = Create Vector

SetNull(ls_null)
This.accepttext()
Choose Case dwo.name
	Case 'p44bno'
		If func.of_reg_no_check(data) = FALSE Then
			If messagebox("알림", "사용하시겠습니까?",  Exclamation!, YesNo!, 2) = 2 Then
				This.setitem(row, 'p44bno',  ls_null)
				Return 1
			End If
		End If
//	Case 'p44rno'
//		If func.of_reg_no_check(data) = FALSE Then
//			If messagebox("알림", "사용하시겠습니까?",  Exclamation!, YesNo!, 2) = 2 Then
//				This.setitem(row, 'p44rno', ls_null)
//				RETURN 1
//			End If
//		End If
//	Case 'p44rls'
//		If data = '0' Then			// 본인
//			ls_emp_no = dw_main.getitemstring(dw_main.GetRow(), 'h01nno')
//		
//			ls_per_jumin_num = dw_main.GetitemString(dw_main.Getrow(), 'h01rno')
//		
//			This.Setitem(row, 'p44rno', ls_per_jumin_num)
//			This.setitem(row, 'p44hnm', dw_main.GetitemSTring(dw_main.Getrow(), 'h01knm'))
//			This.Setitem(row, 'p44gbn', 'Y') //본인,장애,경로여부
//
//		Else
//			This.Setitem(row, 'p44rno', '')
//			This.setitem(row, 'p44hnm', '')
//			This.Setitem(row, 'p44gbn', 'N') //본인,장애,경로여부
//
//		End If
//		Return 0
	Case 'p44ptl'	
		String ls_rno
		
		ls_rno = This.GetitemString(row, 'p44rno')
		ll_find = dw_tab4_1.Find("p43rno = '" + ls_rno + "'", 1, dw_tab4_1.Rowcount())
		
		dw_tab4_1.setitem(ll_find, 'P43F02', This.GetitemNumber(1, 'p44hgs_sum'))  //국세청 제외
		dw_tab4_1.setitem(ll_find, 'P43G02', This.GetitemNumber(1, 'p44hgs1_sum'))  //국세청
		If This.GetitemNumber(1, 'p44hgs_sum') > 0 Or This.GetitemNumber(1, 'p44hgs1_sum') > 0 Then
			dw_tab4_1.setitem(ll_find, 'P43C02', 'Y')
		Elseif  This.GetitemNumber(1, 'p44hgs_sum') = 0 And This.GetitemNumber(1, 'p44hgs1_sum') = 0 Then
			dw_tab4_1.setitem(ll_find, 'P43C02', 'N')
		End If
			
//		ls_per_jumin_num =This.GetitemSTring(row, 'p44rno')
//		ll_rowcnt = This.Rowcount()
//		ll_amt = 0
//		For ll_row = 1 To ll_rowcnt
//			If ll_row <> row Then
//				If  This.GetitemString(ll_row, 'p44rno') = ls_per_jumin_num Then
//					ll_med_amt = This.GetitemNumber(ll_row, 'p44ptl')
//					ll_amt = ll_amt + ll_med_amt
//				End If
//			End If
//		Next
//		
//		ll_med_amt =  long(data)
//		ll_amt = ll_amt +ll_med_amt
//		
//		ll_find = tab_1.tabpage_1.dw_tab1.find("p43rno = '" + ls_per_jumin_num + "'" , 1, tab_1.tabpage_1.dw_tab1.rowcount())
//		If ll_find = 0 Then
//			Messagebox("알림", "부양가족정보가 존재하지 않습니다!")
//			RETURN -1
//		Else
//			
//			tab_1.tabpage_1.dw_tab1.setitem(ll_find, 'p43g02', ll_amt)
//		End If
//			


			
		
ENd Choose

Destroy lvc_data


//RETURN 1
end event

event rowfocuschanged;call super::rowfocuschanged;If currentrow > 0 and  currentrow <= This.rowcount()   Then
		If This.GetItemStatus(currentrow, 0, Primary!) <> NewModified! And This.GetItemStatus(currentrow, 0, Primary!) <> New! And This.GetItemStatus(currentrow, 0, Primary!) <>  NotModified! Then
//	    		//This.update()
			If wf_update_chk() <> 1 then
				//dw_tab4_1.post Event ue_Retrieve()
			Else
				//This.event ue_retrieve()
			End If
			
		End If
End If

end event

event editchanged;call super::editchanged;//Long ll_row
//
//dw_tab4_1.accepttext()
//ll_row = dw_tab4_1.Getrow()
////This.Accepttext()
//		If dwo.name = 'p44ptl'	Then
////		String ls_rno
//		
////		ls_rno = This.GetitemString(row, 'p44rno')
////		ll_find = dw_tab4_1.Find("p43rno = '" + ls_rno + "'", 1, dw_tab4_1.Rowcount())
////		
//	//	This.event itemchanged(row, dwo, data)
//		dw_tab4_1.setitem(ll_row, 'P43F02', This.GetitemNumber(1, 'p44hgs_sum'))  //국세청 제외
//		dw_tab4_1.setitem(ll_row, 'P43G02', This.GetitemNumber(1, 'p44hgs1_sum'))  //국세청
//		
//		If This.GetitemNumber(1, 'p44hgs_sum') > 0 Or This.GetitemNumber(1, 'p44hgs1_sum') > 0 Then
//			dw_tab4_1.setitem(ll_row, 'P43C02', 'Y')
//		Elseif  This.GetitemNumber(1, 'p44hgs_sum') = 0 And This.GetitemNumber(1, 'p44hgs1_sum') = 0 Then
//			dw_tab4_1.setitem(ll_row, 'P43C02', 'N')
//		End If
//			
//		End If


//RETURN 1
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemerror;call super::itemerror;return 1
end event

type r_tab4 from rectangle within tabpage_4
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 119
integer y = 48
integer width = 64
integer height = 60
end type

type r_tab4_1 from rectangle within tabpage_4
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 119
integer y = 124
integer width = 64
integer height = 60
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1304
long backcolor = 16777215
string text = "기타공제"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
r_tab5 r_tab5
dw_tab5 dw_tab5
dw_tab5_temp dw_tab5_temp
end type

on tabpage_5.create
this.r_tab5=create r_tab5
this.dw_tab5=create dw_tab5
this.dw_tab5_temp=create dw_tab5_temp
this.Control[]={this.r_tab5,&
this.dw_tab5,&
this.dw_tab5_temp}
end on

on tabpage_5.destroy
destroy(this.r_tab5)
destroy(this.dw_tab5)
destroy(this.dw_tab5_temp)
end on

type r_tab5 from rectangle within tabpage_5
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 119
integer y = 48
integer width = 64
integer height = 60
end type

type dw_tab5 from uo_dwfree within tabpage_5
event type long ue_retrieve ( )
event type long ue_insertrow ( )
event type long ue_deleterow ( )
event type long ue_update ( )
integer y = 28
integer width = 4334
integer height = 1268
integer taborder = 30
string dataobject = "d_hpa412a_8"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
String 	ls_member, ls_year, ls_retire_dt, ls_gubun

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_member = dw_con.GetitemString(dw_con.Getrow(), 'member_no') //사원번호
ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4) //정산년도
ls_retire_dt = trim(dw_main.getitemString(dw_main.getrow(), 'h01rtd'))
			
If  left(ls_retire_dt, 4) = ls_year Then
	ls_gubun = 'T'
Else
	ls_gubun = 'J'
End If

ll_rv = This.retrieve(ls_year, ls_member, ls_gubun)

If ll_rv = 0 Then 
	ll_rv = This.Insertrow(0)
End If

//자동생성되지 않는 기타공제 내역만 조회함
dw_tab5_temp.retrieve(ls_year, ls_member, 'N', ls_gubun) 



RETURN ll_rv
end event

event type long ue_update();Long					ll_dw_cnt
Long					ll_i
Long					ll_totmodcont
String					ls_dw_id

ll_totmodcont = 0	


If  This.AcceptText() <> 1 Then
	this.SetFocus()
	RETURN -1
End If


ll_totmodcont = (this.ModifiedCount() + this.DeletedCount())
	
If ll_totmodcont <= 0 Then
	f_set_message("[저장] " + '변경된 내용이 없습니다.', '', parentwin)
	RETURN 0
End If
	
SetPointer(HourGlass!)
	

//입력 데이터에 대한 각종 Validation Check를 기술하십시요.


	If wf_upd_date_set(this) = -1 Then
		RETURN -1
	End If


// Update Property check

	If this.Describe("DataWindow.Table.UpdateTable") = "?" Then
		ls_dw_id = this.DataObject
		
		
		SetPointer(Arrow!)
		gf_message(parentwin, 2, '9999', 'ERROR', 'DataWindow = ' + ls_dw_id + '의 Update속성이 지정되지 않았습니다.')
		RETURN -1
	End If

	If func.of_checknull(dw_tab5) = -1 Then
		RETURN -1
	End If

	If this.Update(TRUE, TRUE) <> 1 Then
		ROLLBACK USING SQLCA;	
		
		SetPointer(Arrow!)
		f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
		RETURN -1
	End If

	

COMMIT USING SQLCA;

ib_excl_yn = FALSE

f_set_message("[저장] " + '성공적으로 저장되었습니다.', '', parentwin)


SetPointer(Arrow!)

RETURN 1
end event

event itemchanged;call super::itemchanged;Long ll_amt, ll_find, ll_rowcnt, ll_deduc_amt
String ls_incom_deduc_gb, ls_year, ls_incom_cd, ls_retire_dt, ls_gubun

accepttext()

Choose Case left(dwo.name, 2) + right(dwo.name, 3)
	Case 'p_amt'
			ls_incom_deduc_gb = mid(dwo.name, 3, 4)
						
			If ls_incom_deduc_gb = '3404' then
				If data <> '0' Then
					If This.Getitemnumber(row, 'p_3405_amt') > 0 or  This.Getitemnumber(row, 'p_3407_amt') > 0 or This.Getitemnumber(row, 'p_4502_amt') > 0 Then
						Messagebox("알림", "600만원 한도 , 1000만원 한도, 1500만원 한도, 주택자금세액공제 금액 중 하나만 입력 가능합니다!")
						This.setitem(row, 'p_3404_amt', 0)
						Return 1
					End If
				End If
			Elseif ls_incom_deduc_gb = '3405' Then
				If data <> '0' Then
					If This.Getitemnumber(row, 'p_3404_amt') > 0 or  This.Getitemnumber(row, 'p_3407_amt') > 0  or This.Getitemnumber(row, 'p_4502_amt') > 0 Then
						Messagebox("알림", "600만원 한도 , 1000만원 한도, 1500만원 한도, 주택자금세액공제 금액 중 하나만 입력 가능합니다!")
						This.setitem(row, 'p_3405_amt', 0)
						Return 1
					End If
				End If
			Elseif ls_incom_deduc_gb = '3407' Then
				If data <> '0' Then
					If This.Getitemnumber(row, 'p_3404_amt') > 0 or  This.Getitemnumber(row, 'p_3405_amt') > 0  or This.Getitemnumber(row, 'p_4502_amt') > 0 Then
						Messagebox("알림", "600만원 한도 , 1000만원 한도, 1500만원 한도, 주택자금세액공제 금액 중 하나만 입력 가능합니다!")
						This.setitem(row, 'p_3407_amt', 0)
						Return 1
					End If
				End If
			Elseif ls_incom_deduc_gb = '4502' Then	//주택자금차입금이자세액공제
				If data <> '0' Then
					If This.Getitemnumber(row, 'p_3404_amt') > 0 or  This.Getitemnumber(row, 'p_3405_amt') > 0  or This.Getitemnumber(row, 'p_3407_amt') > 0 Then
						Messagebox("알림", "600만원 한도 , 1000만원 한도, 1500만원 한도, 주택자금세액공제 금액 중 하나만 입력 가능합니다!")
						This.setitem(row, 'p_4502_amt', 0)
						Return 1
					End If
				End If
			end If
						
			ll_amt = long(data)
			
			ls_year = left(trim(dw_con.getitemstring(dw_con.Getrow(), 'year')), 4)
			ls_retire_dt = trim(dw_main.getitemString(dw_main.getrow(), 'h01rtd'))
			If  left(ls_retire_dt, 4) = ls_year Then
				ls_gubun = 'T'
			Else
				ls_gubun = 'J'
			End If
			
			tab_1.tabpage_5.dw_tab5_temp.update()
			tab_1.tabpage_5.dw_tab5_temp.retrieve(Ls_year, dw_main.object.h01nno[dw_main.getrow()], 'N', ls_gubun)
			 wf_etc_deduc(ls_incom_deduc_gb, ll_amt, row, ls_year)
			
			ll_rowcnt = dW_tab5_temp.rowCount()
			
			ll_find = dw_tab5_temp.find("p41dgb = '" + ls_incom_deduc_gb + "'", 1, ll_rowcnt)
			
			If ll_find = 0 and ll_amt <> 0  Then
				ll_find = dw_tab5_temp.Insertrow(0)
			End If
			
			If ll_amt = 0 and ll_find <> 0 Then 
				dw_tab5_temp.deleterow(ll_find)
				ReTURN  1
			End If
			

				SELECT P40DCD
					INTO :ls_incom_cd
					FROM PADB.HPAP40M
				WHERE P40YAR = :ls_year
					  AND P40DGB = :ls_incom_deduc_gb
				USING SQLCA;
						
			dw_tab5_temp.setitem(ll_find, 'p41yar',  ls_year)
			dw_tab5_temp.setitem(ll_find, 'p41dcd', ls_incom_cd)
			dw_tab5_temp.setitem(ll_find, 'p41dgb', ls_incom_deduc_gb )
			dw_tab5_temp.setitem(ll_find, 'p41nno', dw_main.getitemSTring(dw_main.Getrow(), 'h01nno'))
			dw_tab5_temp.setitem(ll_find, 'p41sam',  ll_amt )
			dw_tab5_temp.setitem(ll_find, 'p41pcn',  1 )
			
			
			ll_deduc_amt = This.GetitemNumber(row, 'd_' + ls_incom_deduc_gb + '_amt')
			
			dw_tab5_temp.setitem(ll_find, 'p41dem', ll_deduc_amt)
			dw_tab5_temp.setitem(ll_find, 'p41ajg', ls_gubun) //연말정산

			
	Case 'p_cnt'  //혼인.이사.장례비용 횟수		
			ls_incom_deduc_gb = mid(dwo.name, 3, 4)
						
			ll_amt = long(data)
			
			ls_year = left(trim(dw_con.getitemstring(dw_con.Getrow(), 'year')), 4)
			ls_retire_dt = trim(dw_main.getitemString(dw_main.getrow(), 'h01rtd'))
			If  left(ls_retire_dt, 4) = ls_year Then
				ls_gubun = 'T'
			Else
				ls_gubun = 'J'
			End If
			
			wf_etc_deduc(ls_incom_deduc_gb, ll_amt, row, ls_year)
			
			ll_rowcnt = dW_tab5_temp.rowCount()
			
			ll_deduc_amt = This.GetitemNumber(row, 'd_' + ls_incom_deduc_gb + '_amt')
			
			ll_find = dw_tab5_temp.find("p41dgb = '" + ls_incom_deduc_gb + "'", 1, ll_rowcnt)
			
			If ll_find = 0 and ll_deduc_amt <> 0  Then  //공제금액이 0이 아닌경우
				ll_find = dw_tab5_temp.Insertrow(0)
			End If
			
			If ll_deduc_amt = 0 and ll_find <> 0 Then  //공제금액이 0이면 delete
				dw_tab5_temp.deleterow(ll_find)
				ReTURN  1
			End If
			

				SELECT P40DCD
					INTO :ls_incom_cd
					FROM PADB.HPAP40M
				WHERE P40YAR = :ls_year
					  AND P40DGB = :ls_incom_deduc_gb
				USING SQLCA;
						
			dw_tab5_temp.setitem(ll_find, 'p41yar',  ls_year)
			dw_tab5_temp.setitem(ll_find, 'p41dcd', ls_incom_cd)
			dw_tab5_temp.setitem(ll_find, 'p41dgb', ls_incom_deduc_gb )
			dw_tab5_temp.setitem(ll_find, 'p41nno', dw_main.getitemSTring(dw_main.Getrow(), 'h01nno'))
			dw_tab5_temp.setitem(ll_find, 'p41sam', 0  )  //대상액은 0
			dw_tab5_temp.setitem(ll_find, 'p41pcn',  ll_amt )  //대상인원을 횟수로사용
			
			
			
			
			dw_tab5_temp.setitem(ll_find, 'p41dem', ll_deduc_amt)
			dw_tab5_temp.setitem(ll_find, 'p41ajg', ls_gubun) //연말정산
	End Choose
			
return 0

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemerror;call super::itemerror;return 1
end event

type dw_tab5_temp from uo_dwlv within tabpage_5
event type long ue_update ( )
boolean visible = false
integer x = 18
integer y = 584
integer width = 4334
integer height = 572
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hpa412a_9"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event type long ue_update();Long					ll_dw_cnt
Long					ll_i
Long					ll_totmodcont
String					ls_dw_id

ll_totmodcont = 0	


If  This.AcceptText() <> 1 Then
	this.SetFocus()
	RETURN -1
End If


ll_totmodcont = (this.ModifiedCount() + this.DeletedCount())
	
If ll_totmodcont <= 0 Then
	f_set_message("[저장] " + '변경된 내용이 없습니다.', '', parentwin)
	RETURN 0
End If
	
SetPointer(HourGlass!)
	

//입력 데이터에 대한 각종 Validation Check를 기술하십시요.


	If wf_upd_date_set(this) = -1 Then
		RETURN -1
	End If


// Update Property check

	If this.Describe("DataWindow.Table.UpdateTable") = "?" Then
		ls_dw_id = this.DataObject
		
		
		SetPointer(Arrow!)
		gf_message(parentwin, 2, '9999', 'ERROR', 'DataWindow = ' + ls_dw_id + '의 Update속성이 지정되지 않았습니다.')
		RETURN -1
	End If

	If func.of_checknull(dw_tab5_temp) = -1 Then
		RETURN -1
	End If

	If this.Update(TRUE, TRUE) <> 1 Then
		ROLLBACK USING SQLCA;	
		
		SetPointer(Arrow!)
		f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
		RETURN -1
	End If

	

COMMIT USING SQLCA;

ib_excl_yn = FALSE

f_set_message("[저장] " + '성공적으로 저장되었습니다.', '', parentwin)


SetPointer(Arrow!)

RETURN 1
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1304
long backcolor = 16777215
string text = "공제내역"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
r_tab6 r_tab6
dw_tab6 dw_tab6
end type

on tabpage_6.create
this.r_tab6=create r_tab6
this.dw_tab6=create dw_tab6
this.Control[]={this.r_tab6,&
this.dw_tab6}
end on

on tabpage_6.destroy
destroy(this.r_tab6)
destroy(this.dw_tab6)
end on

type r_tab6 from rectangle within tabpage_6
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 119
integer y = 48
integer width = 64
integer height = 60
end type

type dw_tab6 from uo_dwlv within tabpage_6
event type long ue_retrieve ( )
event type long ue_insertrow ( )
event type long ue_deleterow ( )
event type long ue_update ( )
integer x = 9
integer y = 28
integer width = 4334
integer height = 1276
integer taborder = 20
string dataobject = "d_hpa412a_9"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
String 	ls_member, ls_year, ls_retire_dt, ls_gubun

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_member = dw_con.GetitemString(dw_con.Getrow(), 'member_no') //사원번호
ls_year = left(trim(dw_con.GetitemString(dw_con.Getrow(), 'year')), 4) //정산년도
ls_retire_dt = trim(dw_main.getitemString(dw_main.getrow(), 'h01rtd'))
			
If  left(ls_retire_dt, 4) = ls_year Then
	ls_gubun = 'T'
Else
	ls_gubun = 'J'
End If


//자동 또는 수동 생성 공제내역 모두 조회
ll_rv = This.retrieve(ls_year, ls_member, '%', ls_gubun)

RETURN ll_rv
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type uo_1 from u_tab within w_hpa412a
integer x = 1317
integer y = 812
integer height = 148
integer taborder = 20
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type uo_family from uo_imgbtn within w_hpa412a
boolean visible = false
integer x = 2546
integer y = 804
integer height = 84
integer taborder = 30
boolean bringtotop = true
string fontface = "돋음"
string btnname = "가족사항가져오기"
end type

on uo_family.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String ls_h01nno, ls_year
Datetime ldt_cur

ldt_cur = func.of_get_datetime()

dw_con.Accepttext()
dw_main.Accepttext()

ls_year = left(trim(dw_con.getitemSTring(dw_con.Getrow(), 'year')), 4)//정산년도
ls_h01nno = trim(dw_con.GetitemSTring(dw_con.Getrow(), 'member_no')) //사번

If ls_h01nno = '' Or isnull(ls_h01nno) Then RETURN 

If Messagebox("알림", "가족사항 가져오기를 실행하시겠습니까?~r부양가족정보에 없는 사항만 가져옵니다!",  Exclamation!, Yesno!, 2) = 2 Then RETURN 

INSERT INTO PADB.HPAP43T 
(		P43YAR,            P43NNO,            P43RNO,            P43REL,            P43GBN,            P43KNM,   
         P43KO1,            P43KO2,            P43KO3,            P43WHM,            P43G01,            P43G02,   
         P43G03,            P43G04,            P43G05,            P43G06,            P43F01,            P43F02,   
         P43F03,            P43F04,            P43F05,            P43F06,              P43BGB,		  P43AGE ,
          WORKER,       IPADD       ,	WORK_DATE       ,JOB_UID           ,JOB_ADD                   ,JOB_DATE                 )
SELECT :ls_year  ,          B.MEMBER_NO,            B.JUMIN_NO,   (SELECT ETC_CD1 FROM  CDDB.KCH102D
						WHERE UPPER(CODE_GB) = 'GWANGAE_CODE'
						AND CODE = TO_CHAR(B.GWANGAE_CODE) ), '1',             B.NAME,   
        'N',    'N',    'N',    'N',   0,0,
       0,0,0,0,0,0,
		 0,0,0,0,   'N', 
		TO_NUMBER(:ls_year) - TO_NUMBER((CASE WHEN SUBSTR(JUMIN_NO, 7, 1) IN ('1','2','5', '6') THEN '19' || SUBSTR(JUMIN_NO, 1, 2)
            ELSE '20' || SUBSTR(JUMIN_NO, 1, 2) END) ),
		:gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
FROM INDB.HIN019H			B
WHERE (B.MEMBER_NO =  :ls_h01nno)
AND B.JUMIN_NO	 NOT IN (SELECT P43RNO FROM PADB.HPAP43T 
 						WHERE (P43YAR = :ls_year)
						    AND (P43NNO = :ls_h01nno)
							AND P43REL <> '0')
AND LENGTH(TRIM( B.JUMIN_NO)) = 13 	
//AND GONGJE_YN = 'Y'
UNION ALL
SELECT  :ls_year ,          B.MEMBER_NO,            B.JUMIN_NO,   '0', (CASE WHEN NVL(B.IS_ALIEN, 'N') = 'N' THEN  '1' ELSE '9' END),             B.NAME,   
        'Y',    'N',    'N',    'N',   0,0,
       0,0,0,0,0,0,
		 0,0,0,0,  	 'N', 
		TO_NUMBER(:ls_year ) - TO_NUMBER((CASE WHEN SUBSTR(JUMIN_NO, 7, 1) IN ('1','2', '5','6') THEN '19' || SUBSTR(JUMIN_NO, 1, 2)
            ELSE '20' || SUBSTR(JUMIN_NO, 1, 2) END) ),
		:gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
FROM INDB.HIN001M			B
WHERE (B.MEMBER_NO = :ls_h01nno)
AND B.JUMIN_NO NOT IN (SELECT P43RNO FROM PADB.HPAP43T 
 						WHERE (P43YAR = :ls_year)
						    AND (P43NNO =:ls_h01nno)
							AND P43REL = '0')		
USING SQLCA							
;					
If SQLCA.SQLCODE = 0  Then 	
	If  SQLCA.SQLNROWS > 0  Then
		f_set_message("[가족사항] " + String(sqlca.sqlnrows) + '건 가족사항 가져오기 성공!.', '', parentwin)
		
//		//자녀양육공제 업데이트(기본공제)
//	UPDATE PADB.HPAP43T 
//		SET P43KO3 = 'Y',
//			  P43KO1 = 'Y'
//	WHERE P43YAR = :ls_year
//		AND P43NNO = :ls_h01nno
//		AND P43REL = '4'
//		AND P43AGE <= 6
//	USING SQLCA;	
//	If SQLCA.SQLCODE <> 0 Then
//			ROLLBACK USING SQLCA;
//			 f_set_message("[가족사항] " + '자녀양육여부 업데이트 에러!.', '', parentwin)
//			 RETURN 
//	End If	
		
		//다자녀 업데이트
	UPDATE PADB.HPAP43T 
		SET P43CON = 'Y'
	WHERE P43YAR = :ls_year
		AND P43NNO = :ls_h01nno
		AND P43REL IN ('4', '5')
		AND P43AGE <= 20
	USING SQLCA;	
	If SQLCA.SQLCODE <> 0 Then
			ROLLBACK USING SQLCA;
			 f_set_message("[가족사항] " + '다자녀 업데이트 에러!.', '', parentwin)
			 RETURN 
	End If		
	
	
		//경로우대 업데이트
	UPDATE PADB.HPAP43T 
		SET P43OGB = 'Y'
	WHERE P43YAR = :ls_year
		AND P43NNO = :ls_h01nno
		AND P43REL in ( '0', '1', '2')
		AND P43AGE >= 70
	USING SQLCA;	
	If SQLCA.SQLCODE <> 0 Then
			ROLLBACK USING SQLCA;
			 f_set_message("[가족사항] " + '경로우대 업데이트 에러!.', '', parentwin)
			 RETURN 
	End If			
		
		COMMIT USING SQLCA;

		
		idw_tab[1].TriggerEvent("ue_Retrieve")
	Else
		f_set_message("[가족사항] " + '가져올 가족사항 정보가 없습니다!.', '', parentwin)
	End If
Else
	ROLLBACK USING SQLCA;
 f_set_message("[가족사항] " + '가족사항 가져오기 실패!.', '', parentwin)
	RETURN 
End If
end event

type uo_create from uo_imgbtn within w_hpa412a
integer x = 1454
integer y = 40
integer height = 84
integer taborder = 40
boolean bringtotop = true
string fontface = "돋음"
string btnname = "가정산"
end type

event clicked;call super::clicked;String ls_std_yy, ls_dept_cd, ls_emp_no, ls_gubun, ls_enter_dt, ls_retire_dt
uo_payfunc lvc_payfunc

dw_con.accepttext()

long ll_cnt


ls_std_yy =  left(trim(dw_con.getitemString(dw_con.GetRow(), 'year')), 4)
//2010.01.14 직종코드로 대체 위해 직급의 left 1자리로 수정
ls_dept_cd = left(trim(dw_main.getitemString(dw_main.Getrow(), 'h01grm')) , 1)
ls_emp_no = dw_main.getitemString(dw_main.Getrow(), 'h01nno')
ls_enter_dt = dw_main.getitemString(dw_main.getrow(), 'h01ede')
ls_retire_dt = trim(dw_main.getitemString(dw_main.getrow(), 'h01rtd'))

If ls_emp_no = '' Or isnull(ls_emp_no) Then RETURN 


lvc_payfunc = Create uo_payfunc

If  left(ls_retire_dt, 4) = ls_std_yy Then
	ls_gubun = 'T'
Else
	ls_gubun = 'J'
End If
	
	

If lvc_payfunc.of_year_deduction(ls_std_yy,ls_gubun, ls_dept_cd, ls_emp_no) <> 1 Then
	ROLLBACK USING SQLCA;
	f_set_message("[공제정보생성] " + '공제정보생성 실패.', '', parentwin)
Else
	COMMIT USING SQLCA;
	f_set_message("[공제정보생성] " + '공제정보생성 성공', '', parentwin)
End If


If lvc_payfunc.of_year_create(ls_std_yy,ls_gubun, ls_dept_cd, ls_emp_no) <> 1 Then
	ROLLBACK USING SQLCA;
	f_set_message("[가정산] " + '연말정산 처리 중 에러발생.', '', parentwin)
Else
	COMMIT USING SQLCA;
	f_set_message("[가정산] " + '연말정산 처리 성공', '', parentwin)
	dw_main.event ue_retrieve()
	uo_report.event clicked()
	
End If

Destroy lvc_payfunc

end event

on uo_create.destroy
call uo_imgbtn::destroy
end on

type uo_singo from uo_imgbtn within w_hpa412a
integer x = 1129
integer y = 40
integer height = 84
integer taborder = 50
boolean bringtotop = true
string fontface = "돋음"
string btnname = "소득공제신고서"
end type

on uo_singo.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String ls_year, ls_h01nno, ls_fr_mm, ls_to_mm, ls_today, ls_frdt, ls_todt
Long ll_row

dw_con.Accepttext()
dw_print.dataobject = 'd_hpa412a_10_2009'
dw_print.title = '소득공제신고서'
dw_print.settransobject(sqlca)
ls_year = dw_con.GetitemString(dw_con.Getrow(), 'year')
ls_h01nno = dw_con.GetitemSTring(dw_con.Getrow(), 'member_no')
ls_today =  String(func.of_get_datetime(), 'yyyymmdd')

//SELECT TRIM(ETC_CD1) , TRIM(ETC_CD2)
//INTO :ls_frdt, :ls_todt
//FROM CDDB.KCH102D
//WHERE CODE_GB = 'HPA06'
//AND CODE = :ls_year
//USING SQLCA;
//
//If SQLCA.SQLCODE <> 0 or isnull(ls_frdt) or ls_frdt = '' Then
//	//Messagebox("알림", "공통코드 HPA06 해당년도 원천징수영수증 출력기간을 확인하세요!")
//	//RETURN 
//	uc_print.of_enable(false)
//Else
//	If ls_today >= ls_frdt and ls_today <= ls_todt Then 
		uc_print.of_enable(true)
//	Else
//		uc_print.of_enable(false)
//	End If
//End If

If ls_h01nno = '' Or isnull(ls_h01nno) Then RETURN 
setpointer(hourglass!)
	SELECT	SUBSTR(A.FDATE,1,6),	SUBSTR(A.TDATE,1,6)
	INTO	:ls_fr_mm,		:ls_to_mm
	FROM	PADB.HPA022M A   /*연말정산기간관리 */
	WHERE	A.YEAR	=	:ls_year
USING SQLCA	;

If sqlca.sqlcode <> 0 or ls_fr_mm = '' or isnull(ls_fr_mm) Then 
	Messagebox("알림", "연말정산기간관리 테이블을 확인하세요!")
	RETURN 
End If

     dw_print.retrieve(ls_year, ls_h01nno, ls_fr_mm, ls_to_mm)

	dw_print.move(dw_con.x, dw_con.y - 20)
	dw_print.visible = true
//	uo_close.visible = true
	dw_print.resize(4389, 2120)
//	uo_close.move(dw_print.x + dw_print.width - uo_close.width - 850  , dw_print.y + 100)
//	uo_close.setposition(totop!)
setpointer(arrow!)
end event

type uo_report from uo_imgbtn within w_hpa412a
integer x = 1806
integer y = 40
integer height = 84
integer taborder = 50
boolean bringtotop = true
string fontface = "돋음"
string btnname = "원천징수영수증"
end type

event clicked;call super::clicked;String ls_year, ls_h01nno
Long ll_row, ll_cnt
String	ls_frdt, ls_todt, ls_today
dw_con.Accepttext()
dw_print.dataobject = 'd_hpa412a_2_2009'
dw_print.title = '원천징수영수증'
dw_print.settransobject(sqlca)
ls_year = dw_con.GetitemString(dw_con.Getrow(), 'year')
ls_h01nno = dw_con.GetitemSTring(dw_con.Getrow(), 'member_no')
ls_today =  String(func.of_get_datetime(), 'yyyymmdd')

SELECT TRIM(ETC_CD1) , TRIM(ETC_CD2)
INTO :ls_frdt, :ls_todt
FROM CDDB.KCH102D
WHERE CODE_GB = 'HPA06'
AND CODE = :ls_year
USING SQLCA;

If SQLCA.SQLCODE <> 0 or isnull(ls_frdt) or ls_frdt = '' Then
	//Messagebox("알림", "공통코드 HPA06 해당년도 원천징수영수증 출력기간을 확인하세요!")
	//RETURN 
	uc_print.of_enable(false)
Else
	If ls_today >= ls_frdt and ls_today <= ls_todt Then 
		uc_print.of_enable(true)
	Else
		uc_print.of_enable(false)
	End If
End If




If ls_h01nno = '' Or isnull(ls_h01nno) Then RETURN 
SELECT COUNT(*) 
INTO :ll_cnt
FROM  PADB.HPAP46T
WHERE P46YAR = :ls_year
AND P46NNO = :ls_h01nno
USING SQLCA;

If ll_Cnt = 0 Then
	Messagebox("알림", "연말정산정보가 존재하지 않습니다")
	RETURN 
End If

setpointer(hourglass!)
     dw_print.retrieve( ls_year, ls_h01nno, '0000', 'ZZZZ', '%')

	dw_print.move(dw_con.x, dw_con.y - 20)
	dw_print.visible = true
//	uo_close.visible = true
	dw_print.resize(4389, 2120)
//	uo_close.move(dw_print.x + dw_print.width - uo_close.width - 850  , dw_print.y + 100)
//	uo_close.setposition(totop!)
setpointer(arrow!)
end event

on uo_report.destroy
call uo_imgbtn::destroy
end on

type uo_medi from uo_imgbtn within w_hpa412a
integer x = 754
integer y = 40
integer height = 84
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string fontface = "돋음"
string btnname = "의료비명세서"
end type

on uo_medi.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String ls_year, ls_h01nno, ls_today, ls_frdt, ls_todt
Long ll_row

dw_con.Accepttext()
dw_print.dataobject = 'd_hpa412a_14_2009'
dw_print.title = '의료비지급명세서'
dw_print.settransobject(sqlca)
ls_year = dw_con.GetitemString(dw_con.Getrow(), 'year')
ls_h01nno = dw_con.GetitemSTring(dw_con.Getrow(), 'member_no')
ls_today =  String(func.of_get_datetime(), 'yyyymmdd')

//SELECT TRIM(ETC_CD1) , TRIM(ETC_CD2)
//INTO :ls_frdt, :ls_todt
//FROM CDDB.KCH102D
//WHERE CODE_GB = 'HPA06'
//AND CODE = :ls_year
//USING SQLCA;
//
//If SQLCA.SQLCODE <> 0 or isnull(ls_frdt) or ls_frdt = '' Then
//	//Messagebox("알림", "공통코드 HPA06 해당년도 원천징수영수증 출력기간을 확인하세요!")
//	//RETURN 
//	uc_print.of_enable(false)
//Else
//	If ls_today >= ls_frdt and ls_today <= ls_todt Then 
		uc_print.of_enable(true)
//	Else
//		uc_print.of_enable(false)
//	End If
//End If

If ls_h01nno = '' Or isnull(ls_h01nno) Then RETURN 
setpointer(hourglass!)
ll_row =     dw_print.retrieve(ls_year, ls_h01nno)
If ll_row = 0 Then
	Messagebox("알림", "의료비지급명세서 출력 대상자가 아닙니다!")
Else
	dw_print.move(dw_con.x, dw_con.y - 20)
	dw_print.visible = true
//	uo_close.visible = true
	dw_print.resize(4389, 2120)
//	uo_close.move(dw_print.x + dw_print.width - uo_close.width - 850  , dw_print.y + 100)
//	uo_close.setposition(totop!)
End If
setpointer(arrow!)
end event

type uo_gibu from uo_imgbtn within w_hpa412a
integer x = 352
integer y = 40
integer height = 84
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string fontface = "돋음"
string btnname = "기부금명세서"
end type

on uo_gibu.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String ls_year, ls_h01nno, ls_frdt, ls_todt, ls_today
Long ll_row

dw_con.Accepttext()
dw_print.dataobject = 'd_hpa412a_16_2009'
dw_print.title = '기부금명세서'
dw_print.settransobject(sqlca)
ls_year = dw_con.GetitemString(dw_con.Getrow(), 'year')
ls_h01nno = dw_con.GetitemSTring(dw_con.Getrow(), 'member_no')
ls_today =  String(func.of_get_datetime(), 'yyyymmdd')

//SELECT TRIM(ETC_CD1) , TRIM(ETC_CD2)
//INTO :ls_frdt, :ls_todt
//FROM CDDB.KCH102D
//WHERE CODE_GB = 'HPA06'
//AND CODE = :ls_year
//USING SQLCA;
//
//If SQLCA.SQLCODE <> 0 or isnull(ls_frdt) or ls_frdt = '' Then
//	//Messagebox("알림", "공통코드 HPA06 해당년도 원천징수영수증 출력기간을 확인하세요!")
//	//RETURN 
//	uc_print.of_enable(false)
//Else
//	If ls_today >= ls_frdt and ls_today <= ls_todt Then 
		uc_print.of_enable(true)
//	Else
//		uc_print.of_enable(false)
//	End If
//End If

If ls_h01nno = '' Or isnull(ls_h01nno) Then RETURN 
setpointer(hourglass!)
ll_row =     dw_print.retrieve(ls_year, ls_h01nno)
If ll_row = 0 Then
	Messagebox("알림", "기부금명세서 출력 대상자가 아닙니다!")
Else
	dw_print.move(dw_con.x, dw_con.y - 20)
	dw_print.visible = true
//	uo_close.visible = true
	dw_print.resize(4389, 2120)
//	uo_close.move(dw_print.x + dw_print.width - uo_close.width - 850  , dw_print.y + 100)
//	uo_close.setposition(totop!)
End If
setpointer(arrow!)
end event

type uc_row_insert from u_picture within w_hpa412a
integer x = 3607
integer y = 804
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;Integer		li_selectedtab

If dw_main.RowCount() > 0 Then
	li_SelectedTab = tab_1.SelectedTab
	If li_SelectedTab = 5 Or li_SelectedTab = 6 Then RETURN -1
	idw_tab[li_SelectedTab].PostEvent("ue_InsertRow")
End If
end event

type uc_row_delete from u_picture within w_hpa412a
integer x = 3886
integer y = 804
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;Integer		li_selectedtab
Long			ll_rv
String			ls_txt

If dw_main.RowCount() > 0 Then
	ls_txt = "[삭제] "
	
	li_SelectedTab = tab_1.SelectedTab
	
	If li_SelectedTab = 5 Or li_SelectedTab = 6 Then RETURN -1
	
	ll_rv = idw_tab[li_SelectedTab].TriggerEvent("ue_DeleteRow")
	
	If ll_rv > 0 Then
		If idw_tab[li_SelectedTab].TriggerEvent("ue_update") = -1 Then
			f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
		Else
			f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
		End If
	ElseIf ll_rv = 0 Then
		
	Else
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	End If
End If

end event

type uc_row_save from u_picture within w_hpa412a
integer x = 4169
integer y = 804
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_save.gif"
end type

event clicked;call super::clicked;Integer		li_selectedtab
boolean lb_update = False
Long ll_rtn


If dw_main.RowCount() > 0 Then
	li_SelectedTab = tab_1.SelectedTab
	
	If li_SelectedTab = 0 Or isnull(li_Selectedtab) Then RETURN -1
//	If func.of_checknull(idw_update[li_SelectedTab]) = -1 Then
//		RETURN -1
//	End If
	
	If li_SelectedTab = 1 Then 
		ll_rtn = tab_1.tabpage_1.dw_tab1_1.accepttext()
		If ll_rtn = -1 Then RETURN -1
	Elseif  li_SelectedTab = 3 Then 
		ll_rtn = tab_1.tabpage_3.dw_tab3.accepttext()
		ll_rtn = tab_1.tabpage_3.dw_tab3_1.accepttext()
	Elseif  li_SelectedTab = 4 Then 
		ll_rtn = tab_1.tabpage_4.dw_tab4.accepttext()
		ll_rtn = tab_1.tabpage_4.dw_tab4_1.accepttext()	
	ElseIf li_SelectedTab = 5 Then 
		ll_rtn = tab_1.tabpage_5.dw_tab5.accepttext()

	ENd If
	
	
	
	
	  idw_update[li_SelectedTab].accepttext()
	 
	 
	
	 
	 ll_rtn = idw_update[li_SelectedTab].triggerevent('ue_update')
	 If ll_rtn <> 1 Then
		RETURN -1
	End If
	 
	//기부금 업데이트 시 기타공제 업데이트  
	 If li_SelectedTab = 3 Then 
		wf_etc_deduc('3500', 0, 0, dw_con.GetitemSTring(dw_con.Getrow(), 'year'))	
//		If func.of_checknull(idw_update[5]) = -1 Then
//			RETURN -1
//		End If
		ll_rtn = idw_update[5].triggerevent('ue_update')
	End If

	// If lb_update = true Then 
	
	If ll_rtn = 1 Then

			String ls_std_yy, ls_dept_cd, ls_emp_no, ls_gubun, ls_retire_dt
			uo_payfunc lvc_payfunc
			
			dw_con.accepttext()
			
			long ll_cnt
			
			
			ls_std_yy =  left(trim(dw_con.getitemString(dw_con.GetRow(), 'year')), 4)
			//2010.01.14 직종코드로 대체 위해 직급의 left 1자리로 수정
			ls_dept_cd = left(trim(dw_main.getitemString(dw_main.Getrow(), 'h01grm')) , 1)
			ls_emp_no = dw_con.getitemString(dw_con.Getrow(), 'member_no')
			ls_retire_dt = trim(dw_main.getitemString(dw_main.getrow(), 'h01rtd'))
			
			lvc_payfunc = Create uo_payfunc
			
			
			If  left(ls_retire_dt, 4) = ls_std_yy Then
				ls_gubun = 'T'
			Else
				ls_gubun = 'J'
			End If
				
			
			
			If lvc_payfunc.of_year_deduction(ls_std_yy,ls_gubun, ls_dept_cd, ls_emp_no) <> 1 Then
				ROLLBACK USING SQLCA;
				f_set_message("[공제정보생성] " + '공제정보생성 실패.', '', parentwin)
			Else
				COMMIT USING SQLCA;
				f_set_message("[공제정보생성] " + '공제정보생성 성공', '', parentwin)
				dw_main.event ue_retrieve()
			End If
			
			Destroy lvc_payfunc
			
			
		End If
	
End If
end event

type uo_gicreate from uo_imgbtn within w_hpa412a
boolean visible = false
integer x = 2880
integer y = 804
integer height = 84
integer taborder = 40
boolean bringtotop = true
string fontface = "돋음"
string btnname = "기부금이월"
end type

on uo_gicreate.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String ls_year, ls_nno, ls_dept, ls_fr_mm, ls_to_mm
Datetime ldt_cur
Long 	ll_cnt, ll_ok

ldt_cur = func.of_get_datetime()

dw_con.Accepttext()
dw_main.Accepttext()

ls_year = left(trim(dw_con.getitemSTring(dw_con.Getrow(), 'YEAR')), 4)//정산년도
ls_nno = trim(dw_con.GetitemSTring(dw_con.Getrow(), 'member_no')) //사번
ls_dept = trim(dw_main.GetitemSTring(dw_main.Getrow(), 'h01dcd')) //부서


	SELECT	SUBSTR(A.FDATE,1,6),	SUBSTR(A.TDATE,1,6)
	INTO	:ls_fr_mm,		:ls_to_mm
	FROM	PADB.HPA022M A   /*연말정산기간관리 */
	WHERE	A.YEAR	=	:ls_year
USING SQLCA	;

If sqlca.sqlcode <> 0 or ls_fr_mm = '' or isnull(ls_fr_mm) Then 
	Messagebox("알림", "연말정산기간관리 테이블을 확인하세요!")
	RETURN 
End If



///////////////////////////////////////////////////////////////////
INSERT INTO PADB.HPAP43T 
(		P43YAR,            P43NNO,            P43RNO,            P43REL,            P43GBN,            P43KNM,   
         P43KO1,            P43KO2,            P43KO3,            P43WHM,            P43G01,            P43G02,   
         P43G03,            P43G04,            P43G05,            P43G06,            P43F01,            P43F02,   
         P43F03,            P43F04,            P43F05,            P43F06,             P43BGB,		  P43AGE,
            WORKER,       IPADD       ,	WORK_DATE       ,JOB_UID           ,JOB_ADD                   ,JOB_DATE )
SELECT  :ls_year ,          B.MEMBER_NO,            B.JUMIN_NO,   '0', '1',             B.NAME,   
        'Y',    'N',    'N',    'N',   0,0,
       0,0,0,0,0,0,
		 0,0,0,0,  	 'N', 
		TO_NUMBER(:ls_year) - TO_NUMBER((CASE WHEN SUBSTR(JUMIN_NO, 7, 1) IN ('1','2','5','6') THEN '19' || SUBSTR(JUMIN_NO, 1, 2)
            ELSE '20' || SUBSTR(JUMIN_NO, 1, 2) END) ),
		:gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
FROM INDB.HIN001M B
 WHERE B.GWA LIKE :ls_dept
	 AND  B.MEMBER_NO LIKE :ls_nno
			 	 AND	NOT EXISTS (SELECT * FROM PADB.HPAP43T 
 						WHERE (P43YAR = :ls_year)
						    AND P43NNO = B.MEMBER_NO
						    AND P43RNO = B.JUMIN_NO						    
							AND P43REL = '0'		)							
AND (NVL(PADB.FU_PAYPAY  (:ls_fr_mm,:ls_to_mm, B.MEMBER_NO),0) + NVL(PADB.FU_PAYBONUS(:ls_fr_mm,:ls_to_mm, B.MEMBER_NO),0)) > 0 
USING SQLCA							
;					
If SQLCA.SQLCODE <> 0  Then 	
			ROLLBACK USING SQLCA;
			f_set_message("[기부금이월] 부양가족정보(PADB.HPAP43T) 본인 insert 에러.", '', parentwin)			
	RETURN
End If


	//경로우대 업데이트
	UPDATE PADB.HPAP43T 
		SET P43OGB = 'Y'
	WHERE P43YAR = :ls_year
		AND P43NNO = :ls_nno
		AND P43REL = '0'
		AND P43AGE >= 70
	USING SQLCA;	
	If SQLCA.SQLCODE <> 0 Then
			ROLLBACK USING SQLCA;
			 f_set_message("[기부금이월] " + '경로우대 업데이트 에러!.', '', parentwin)
			 RETURN 
	End If			



//연계구분 - 2
SELECT COUNT(*) 
   INTO :ll_cnt 
  FROM PADB.HPAP45T 
 WHERE P45YAR = :ls_year
     AND P45NNO = :ls_nno
	AND P45GBN = '2'
USING SQLCA;	

If ll_cnt > 0 Then
	DELETE FROM PADB.HPAP45T 
	 WHERE P45YAR = :ls_year
		  AND P45NNO = :ls_nno
		AND P45GBN = '2'
	USING SQLCA;	

	If SQLCA.SQLCODE <> 0 Then
		ROLLBACK USING SQLCA;
			f_set_message("[기부금이월] 급여 연계 법정기부금 삭제 중 에러!.", '', parentwin)
		RETURN 
	End If
End If
	
//
//
INSERT INTO PADB.HPAP45T 
(P45YAR, P45NNO, P45YRM, P45BNO, P45COD, 
 P45SEQ, P45RNO, P45CHM, P45RLS, P45DEC, 
 P45BNM, P45DTL, P45LOT, P45PTL, P45GBN, 
 P45BGO,   WORKER,       IPADD       ,	WORK_DATE       ,JOB_UID           ,JOB_ADD                   ,JOB_DATE) 
SELECT :ls_year  AS YAR ,
A.MEMBER_NO  AS NNO,
A.YEAR_MONTH AS YRM,
MAX((SELECT BUSINESS_NO  FROM CDDB.KCH000M)) AS BNO,
'10'  AS COD,
MAX(NVL((SELECT MAX(P45SEQ) + 1  
 FROM PADB.HPAP45T
WHERE P45YAR = :ls_year
AND P45NNO = A.MEMBER_NO ), 1))   AS SEQ,
B.P43RNO  AS RNO,
B.P43KNM  AS CHM,
'1'  AS RLS,
'3501'  AS DEC,
MAX((SELECT CAMPUS_NAME  FROM CDDB.KCH000M)) AS BNM,
'성금'  AS DTL,
''  AS LOT, 
SUM(NVL(A.PAY_AMT, 0))  AS PTL,
'2' AS GBN,
''  AS BGO,
:gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
    FROM  PADB.HPA005D A, PADB.HPAP43T B
WHERE    A.YEAR_MONTH  BETWEEN :ls_fr_mm AND :ls_to_mm
    AND   A.MEMBER_NO = B.P43NNO
    AND   A.MEMBER_NO = :ls_nno
    AND   A.CODE = '77'
    AND   B.P43YAR = :ls_year
    AND   B.P43REL = '0'
    GROUP BY A.MEMBER_NO, A.YEAR_MONTH , B.P43RNO,
B.P43KNM,
B.P43REL
    HAVING SUM(NVL(A.PAY_AMT, 0)) > 0   
USING SQLCA;	 


If SQLCA.SQLCODE = 0  Then
	If  SQLCA.SQLNROWS > 0 Then
		ll_ok = ll_ok + SQLCA.SQLNROWS
		f_set_message("[기부금이월] " + String(sqlca.sqlnrows) + '건 급여 연계 성금 가져오기 완료!.', '', parentwin)	
	End If
Else
	ROLLBACK USING SQLCA;
	f_set_message("[기부금이월] 급여 연계 성금 가져오기 중 에러!.", '', parentwin)
		RETURN 
End If



If ll_ok > 0 Then

				UPDATE PADB.HPAP43T A
					SET P43F06 = (SELECT SUM(NVL(P45PTL, 0)) 
										 FROM PADB.HPAP45T
										 WHERE P45YAR = A.P43YAR
											AND P45NNO = A.P43NNO
											AND P45RNO = A.P43RNO)                                
					WHERE P43YAR = :ls_year
					AND P43NNO = :ls_nno
					USING SQLCA;
					
					If SQLCA.SQLCODE <> 0 Then
						ROLLBACK USING SQLCA;
						f_set_message("[기부금이월] 연말정산 부양가족 정보 업데이트 중 에러!", '', parentwin)
					Else		
							COMMIT USING SQLCA;
					End If
					
		 wf_etc_deduc('3500', 0, 0, ls_year)				
		 idw_update[5].triggerevent('ue_update')					

End If
//
////
//////이월구분 - 1
////SELECT COUNT(*) 
////   INTO :ll_cnt 
////  FROM PADB.HPAP45T 
//// WHERE P45YAR = :ls_year
////     AND P45NNO = :ls_nno
////	AND P45GBN = '1'
////USING SQLCA;	
////
////If ll_cnt > 0 Then
////	DELETE FROM PADB.HPAP45T 
////	 WHERE P45YAR = :ls_year
////		  AND P45NNO = :ls_nno
////		AND P45GBN = '1'
////	USING SQLCA;	
////
////	If SQLCA.SQLCODE <> 0 Then
////		ROLLBACK USING SQLCA;
////			f_set_message("[기부금이월] 공인법인기부신탁 기부금 삭제 중 에러!.", '', parentwin)
////		RETURN 
////	End If
////End If


tab_1.tabpage_3.dw_tab3_1.event ue_Retrieve()
end event

type dw_con from uo_dwfree within w_hpa412a
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 20
string dataobject = "d_hpa412a_con"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	If is_magam = 'Y' Then RETURN 
	
s_insa_com	lstr_com
String		ls_KName, ls_member_no
This.accepttext()
ls_KName =  trim(this.object.kor_name[1])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = ''//교직원구분

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kor_name')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.kor_name[1]        = ls_kname					//성명
This.object.member_no[1]     = ls_Member_No				//개인번호
Parent.post event ue_retrieve()	
return 1
End If
end event

event itemchanged;call super::itemchanged;
//uo_hirfunc	lvc_hirfunc
//vector		lvc_data
String		ls_h01nno	,ls_h01knm

//lvc_data		= create vector
//lvc_hirfunc	= create	uo_hirfunc
This.accepttext()
Choose Case	dwo.name
	Case	'member_no','kor_name'
		If dwo.name = 'member_no' Then	ls_h01nno = data
		If dwo.name = 'kor_name' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
			This.Post SetItem(row, 'kor_name'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_h01nno , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_h01nno || '%'
		AND NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.member_no[row] = ls_h01nno
			This.object.kor_name[row] = ls_h01knm
			Parent.post event ue_retrieve()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
		
	Case 'year'
		If Data <= '2008' Then
			is_magam = 'Y'
		Else
			is_magam = 'N'
		End If
		
		Long ll_i
		If is_magam = 'Y' Then
			For ll_i = 1 To 7
				idw_update[ll_i].object.datawindow.readonly = 'Yes'
			NEXT
			tab_1.tabpage_5.dw_tab5.object.datawindow.readonly = 'Yes'
			tab_1.tabpage_1.dw_tab1_1.object.datawindow.readonly = 'Yes'
			

			uo_create.of_Enable(False)

			Parent.post event ue_retrieve()
		Else
			For ll_i = 1 To 7
				idw_update[ll_i].object.datawindow.readonly = 'No'
			NEXT
			tab_1.tabpage_5.dw_tab5.object.datawindow.readonly = 'No'
			tab_1.tabpage_1.dw_tab1_1.object.datawindow.readonly = 'No'

			uo_create.of_Enable(True)
			
			Parent.post event ue_retrieve()			
		End if

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

event constructor;call super::constructor;func.of_design_con( dw_con )
dw_con.settransobject(sqlca)
dw_con.insertrow(0)

String ls_year
ls_year = left(f_today(), 4)
ls_year = STring(long(ls_year) - 1)
dw_con.object.year[1] = ls_year
end event

event itemerror;call super::itemerror;return 1
end event

type dw_print from datawindow within w_hpa412a
boolean visible = false
integer x = 50
integer y = 164
integer width = 4384
integer height = 2108
integer taborder = 50
boolean titlebar = true
string title = "소득공제신고서"
string dataobject = "d_hpa412a_10"
boolean controlmenu = true
boolean vscrollbar = true
boolean border = false
end type

event constructor;This.Settransobject(sqlca)
end event

event clicked;uo_close.setposition(totop!)
end event

type uo_close from picture within w_hpa412a
boolean visible = false
integer x = 2185
integer y = 44
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_close.gif"
boolean focusrectangle = false
end type

event clicked;dw_print.visible = false
uo_close.visible = false
end event

