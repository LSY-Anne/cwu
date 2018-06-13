$PBExportHeader$uo_payfunc.sru
$PBExportComments$급여공통funcion
forward
global type uo_payfunc from nonvisualobject
end type
end forward

global type uo_payfunc from nonvisualobject
event ue_constructor ( )
end type
global uo_payfunc uo_payfunc

type variables
Datastore ids


end variables

forward prototypes
public function integer of_year_deduction (string as_std_yy, string as_gu, string as_dept_cd, string as_emp_no)
public function integer of_year_create (string as_std_yy, string as_gu, string as_dept_cd, string as_emp_no)
public function string of_year_strchg (string as_str, string as_type, long as_len)
public function integer of_year_file (string as_gu, string as_year, string as_jdt, string as_file)
public function integer of_year_create_dan (string as_std_yy, string as_gu, string as_dept_cd, string as_emp_no)
public function integer of_year_file_2008 (string as_gu, string as_year, string as_jdt, string as_file)
end prototypes

public function integer of_year_deduction (string as_std_yy, string as_gu, string as_dept_cd, string as_emp_no);Long ll_cnt, ll_i
Datetime ldt_cur
String ls_k, ls_emp_no
String ls_Err

String	ls_fr_mm, ls_to_mm  //연말정산 기간체크용

ldt_cur = func.of_get_datetime()

//ls_k = left(gs_empcode, 1)
//If ls_k = 'D' Then
//	ls_k = 'K'
//End If
//
//If len(gs_empcode) < 8 Then
//	ls_emp_no = 'K' + gs_empcode
//Else
//	ls_emp_no = gs_empcode
//end If

//   SELECT COUNT(*)
//	  INTO :ll_i
//    FROM CLVDTALB.TZCDA121 
//WHERE ZCCSYSCD = 'MIS'   
//AND         ZCCGRPCD = 'EE9'
//AND         ZCCCOMCD = :ls_emp_no
//AND ZCCUSEYN = 'Y'
//USING SQLCA;
//
//If ll_i = 1 Then
//	ls_k = '%'
//End If

/*연말정산기간관리 */
	SELECT	SUBSTR(A.FDATE,1,6),	SUBSTR(A.TDATE,1,6)
	INTO	:ls_fr_mm,		:ls_to_mm
	FROM	PADB.HPA022M A   
	WHERE	A.YEAR	= :as_std_yy
	USING SQLCA;
	
	If SQLCA.SQLCODE <> 0 or ls_fr_mm = '' or isnull(ls_fr_mm)   Then
		ROLLBACK USING SQLCA;
		Messagebox("알림", "연말정산기간관리 테이블을 확인하세요!")		
		RETURN -1
	End If
		



Setpointer(HourGlass!)




SELECT COUNT(*)
    INTO :ll_cnt
    FROM      INDB.HIN001M B, 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
 WHERE B.MEMBER_NO = P.MEMBER_NO  
 AND SUBSTR(B.DUTY_CODE, 1, 1) LIKE :as_dept_cd
	 AND B.MEMBER_NO LIKE :as_emp_no
	 AND   P.PAY + P.BONUS > 0 
	 AND ( (:as_gu = 'J' AND ((NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' 
AND B.JAEJIK_OPT <> 3) Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy || '1231' )
Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101' )) )
 OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))	
 USING SQLCA;
 
 If SQLCA.SQLCODE = 100 Or ll_cnt = 0 Then
	ROLLBACK USING SQLCA;
	Setpointer(ARROW!)
	If as_emp_no =  '%' Then 		
		Messagebox("알림", "해당년도 급여자료가 존재하지 않습니다!")
		RETURN -1
	Else 
		RETURN 0
	end If
End If

SELECT COUNT(*)
   INTO :ll_cnt
   FROM PADB.HPAP41D A,  INDB.HIN001M  B , PADB.HPAP40M C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.P41NNO = B.MEMBER_NO 
    AND A.P41NNO = P.MEMBER_NO
    AND A.P41DCD = C.P40DCD
    AND A.P41DGB = C.P40DGB
    AND A.P41YAR = C.P40YAR
    AND A.P41DGB = '1101'
    AND A.P41YAR = :as_std_yy
    AND A.P41AJG = :as_gu
    AND SUBSTR(B.DUTY_CODE, 1, 1)  LIKE :as_dept_cd 
    AND A.P41NNO LIKE :as_emp_no
	     AND NVL(C.P40PCG,'Y') <> 'N'
	     AND   P.PAY + P.BONUS > 0 
	 AND( (:as_gu = 'J' AND ((NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' 
AND B.JAEJIK_OPT <> 3) Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy  || '1231' )
Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101'  ))) 
 OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))
USING SQLCA;

 If ll_cnt > 0 Then
	
			DELETE FROM PADB.HPAP41D A
			WHERE P41NNO IN (
					  SELECT B.MEMBER_NO
									FROM  INDB.HIN001M B, 
									    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
										WHERE MEMBER_NO LIKE :AS_EMP_NO 
										    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
										    GROUP BY MEMBER_NO) P
								  WHERE  B.MEMBER_NO = P.MEMBER_NO
								   AND B.MEMBER_NO LIKE :as_emp_no
									 AND SUBSTR(B.DUTY_CODE, 1, 1)  LIKE :as_dept_cd					 
									 AND   P.PAY + P.BONUS > 0 
									 AND ( (:as_gu = 'J' AND ((NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' 
						    AND B.JAEJIK_OPT <> 3) Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy  || '1231' )
						    Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy || '0101'                              ))) 
						     OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))
						     )
					      AND A.P41YAR = :as_std_yy                         
					       AND A.P41AJG = :as_gu    
					       AND A.P41DGB IN (SELECT P40DGB FROM PADB.HPAP40M C WHERE C.P40YAR = :AS_STD_YY   
								        AND NVL(C.P40PCG,'Y') <> 'N')					 
			USING SQLCA;
			
			If SQLCA.SQLCODE <> 0 Then
				ls_err = SQLCA.SQLERRTEXT
				ROLLBACK USING SQLCA;
				MESSAGEBOX("연말정산실행", "연말정산대상정보내역(PADB.HPAP41D) 삭제 에러!~r" + ls_err)
				Setpointer(ARROW!)
				RETURN 0
			End If
			
//기부금 자동생성자들 삭제
DELETE FROM PADB.HPAP41D A
			WHERE P41NNO IN (SELECT B.MEMBER_NO
					FROM INDB.HIN001M B , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
				  WHERE B.MEMBER_NO   = P.MEMBER_NO
					 AND B.MEMBER_NO LIKE :as_emp_no
					 AND SUBSTR(B.DUTY_CODE, 1, 1)  LIKE :as_dept_cd
					AND B.MEMBER_NO NOT IN  (SELECT P45NNO FROM PADB.HPAP45T 
						WHERE P45YAR = :as_std_yy		
						AND P45NNO  LIKE :as_emp_no
						AND P45GBN <> '2')		
					AND   P.PAY + P.BONUS > 0 	
					 AND (  (:as_gu = 'J' 
        AND ( (NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND B.JAEJIK_OPT <> 3) 
             Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101' )  ))
       OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))	)
				  AND A.P41YAR = :as_std_yy						 
				 AND A.P41AJG = :as_gu			
				 AND A.P41DCD = '3500'
				AND A.P41DGB = '3501'									
			USING SQLCA;			
	
	If SQLCA.SQLCODE <> 0 Then
		ls_err = SQLCA.SQLERRTEXT
				ROLLBACK USING SQLCA;
				MESSAGEBOX("연말정산실행", "연말정산대상정보내역 법정기부금 자동생성분 (PADB.HPAP41D) 삭제 에러!~r" + ls_err)
				Setpointer(ARROW!)
				RETURN 0
	End If

	DELETE FROM PADB.HPAP45T A
			WHERE P45NNO IN  (SELECT B.MEMBER_NO
					FROM INDB.HIN001M B , 
					    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
						WHERE MEMBER_NO LIKE :AS_EMP_NO 
						    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
						    GROUP BY MEMBER_NO) P
				  WHERE  B.MEMBER_NO  = P.MEMBER_NO
					 AND B.MEMBER_NO LIKE :as_emp_no
					 AND SUBSTR(B.DUTY_CODE, 1, 1)  LIKE :as_dept_cd
					AND B.MEMBER_NO NOT IN (SELECT P45NNO FROM PADB.HPAP45T
						WHERE P45YAR = :as_std_yy        
                        AND P45NNO LIKE :as_emp_no
                        AND P45GBN <> '2')    
                        AND   P.PAY + P.BONUS > 0 
                     AND (  (:as_gu = 'J' 
        AND ( (NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND B.JAEJIK_OPT <> 3) 
             Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy)))     
                AND A.P45YAR = :as_std_yy                       
                AND A.P45GBN = '2'       										
			USING SQLCA;			
	
	If SQLCA.SQLCODE <> 0 Then
		ls_err = SQLCA.SQLERRTEXT
				ROLLBACK USING SQLCA;
				MESSAGEBOX("연말정산실행", "법정기부금 자동생성분 (PADB.HPAP45T) 삭제 에러!~r" + ls_err)
				Setpointer(ARROW!)
				RETURN 0
	End If		
			
End If

//gf_openwait()


///////////////////////////////////////////////////////////////////
INSERT INTO PADB.HPAP43T 
(		P43YAR,            P43NNO,            P43RNO,            P43REL,            P43GBN,            P43KNM,   
         P43KO1,            P43KO2,            P43KO3,            P43WHM,            P43G01,            P43G02,   
         P43G03,            P43G04,            P43G05,            P43G06,            P43F01,            P43F02,   
         P43F03,            P43F04,            P43F05,            P43F06,              P43BGB,		  P43AGE,		P43OGB,
            WORKER,       IPADD       ,	WORK_DATE       ,JOB_UID           ,JOB_ADD                   ,JOB_DATE )
SELECT  :as_std_yy ,          B.MEMBER_NO,            B.JUMIN_NO,   '0', '1',             B.NAME,   
        'Y',    'N',    'N',    'N',   0,0,
       0,0,0,0,0,0,
         0,0,0,0,       'N', 
        TO_NUMBER(:as_std_yy ) - TO_NUMBER((CASE WHEN SUBSTR(JUMIN_NO, 7, 1) IN ('1','2','5','6') THEN '19' || SUBSTR(JUMIN_NO, 1, 2)
            ELSE '20' || SUBSTR(JUMIN_NO, 1, 2) END)),
        CASE WHEN (TO_NUMBER(:as_std_yy ) - TO_NUMBER((CASE WHEN SUBSTR(JUMIN_NO, 7, 1) IN ('1','2','5','6') THEN '19' || SUBSTR(JUMIN_NO, 1, 2)
            ELSE '20' || SUBSTR(JUMIN_NO, 1, 2) END) )) >= 65 THEN 'Y' ELSE 'N' END,
        :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
FROM INDB.HIN001M B , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
        WHERE MEMBER_NO LIKE :AS_EMP_NO 
        AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
        GROUP BY MEMBER_NO) P
 WHERE SUBSTR(B.DUTY_CODE, 1, 1) LIKE :as_dept_cd
 AND B.MEMBER_NO = P.MEMBER_NO
     AND  B.MEMBER_NO LIKE :as_emp_no
     AND B.MEMBER_NO    NOT IN (SELECT P43NNO FROM PADB.HPAP43T 
                         WHERE (P43YAR = :as_std_yy)
                            AND P43NNO LIKE :AS_EMP_NO
                            AND P43REL = '0'        )    
    AND   P.PAY + P.BONUS > 0                         
    AND (  (:as_gu = 'J' 
        AND ( (NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND B.JAEJIK_OPT <> 3) 
             Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))     	 	
USING SQLCA							
;					
If SQLCA.SQLCODE <> 0  Then 	
	ls_err = SQLCA.SQLERRTEXT
			ROLLBACK USING SQLCA;
			 Messagebox('연말정산실행', '부양가족정보(PADB.HPAP43T) 본인 insert 에러!~r' + ls_err)
			Setpointer(Arrow!)
	RETURN 0
End If

//
////성금	 - 퇴직정산일 경우에만...
INSERT INTO PADB.HPAP45T 
(P45YAR, P45NNO, P45YRM, P45BNO, P45COD, 
 P45SEQ, P45RNO, P45CHM, P45RLS, P45DEC, 
 P45BNM, P45DTL, P45LOT, P45PTL, P45GBN, 
 P45BGO,   WORKER,       IPADD       ,	WORK_DATE       ,JOB_UID           ,JOB_ADD                   ,JOB_DATE) 
SELECT :AS_STD_YY  AS YAR ,
A.MEMBER_NO  AS NNO,
A.YEAR_MONTH AS YRM,
MAX((SELECT BUSINESS_NO  FROM CDDB.KCH000M)) AS BNO,
'10'  AS COD,
MAX(NVL((SELECT MAX(P45SEQ) + 1  
 FROM PADB.HPAP45T
WHERE P45YAR = :AS_STD_YY
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
    FROM  PADB.HPA005D A, PADB.HPAP43T B, INDB.HIN001M C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE    A.YEAR_MONTH  BETWEEN :ls_fr_mm AND :ls_to_mm
AND A.MEMBER_NO = P.MEMBER_NO
    AND   A.MEMBER_NO = B.P43NNO
    AND   A.MEMBER_NO = C.MEMBER_NO
    AND   A.MEMBER_NO = :AS_EMP_NO
    AND   A.CODE = '77'
    AND   B.P43YAR = :AS_STD_YY
    AND   B.P43REL = '0'
    AND   P.PAY + P.BONUS > 0 
    AND (  (:as_gu = 'J' 
        AND ( (C.HAKWONHIRE_DATE <= :as_std_yy  || '1231' AND C.JAEJIK_OPT <> 3) 
             Or (C.JAEJIK_OPT = 3 AND  C.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (C.JAEJIK_OPT = 3 AND  C.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND C.JAEJIK_OPT = 3 AND SUBSTR(C.RETIRE_DATE  , 1, 4) = :as_std_yy))	
    GROUP BY A.MEMBER_NO, A.YEAR_MONTH , B.P43RNO,
B.P43KNM,
B.P43REL
    HAVING SUM(NVL(A.PAY_AMT, 0)) > 0   
USING SQLCA;	 

If SQLCA.SQLCODE <> 0  Then 	
	ls_err = SQLCA.SQLERRTEXT
			ROLLBACK USING SQLCA;
			 Messagebox('연말정산실행', '성금 기부금정보(PADB.HPAP45T) insert 에러!~r' + ls_err)
			Setpointer(Arrow!)
	RETURN 0
End If
//
////노동조합비
//INSERT INTO PADB.HPAP45T 
//(P45YAR, P45NNO, P45YRM, P45BNO, P45COD, 
// P45SEQ, P45RNO, P45CHM, P45RLS, P45DEC, 
// P45BNM, P45DTL, P45LOT, P45PTL, P45GBN, 
// P45BGO, CREDTE, CREUID, UPDDTE, UPDUID) 
//SELECT * FROM 
//(SELECT :as_std_yy  AS YAR ,
//P02NNO  AS NNO,
//SUBSTR(P02RDT, 1, 6) AS YRM,
//( SELECT ZCCVAL01 FROM CLVDTALB.TZCDA121 WHERE ZCCSYSCD = 'MIS' AND ZCCGRPCD = 'Z03' AND    ( (SUBSTR(A.P02NNO, 1, 1) = 'K' AND ZCCVAL07 = '1') 
//																																			OR (SUBSTR(A.P02NNO, 1, 1) <> 'K' AND ZCCVAL07 = '2')) ) AS BNO,
//'40'  AS COD,
//NVL((SELECT MAX(P45SEQ) + 1  
// FROM PADB.HPAP45T
//WHERE P45YAR = :as_std_yy
//AND P45NNO = A.P02NNO ), 1)   AS SEQ,
//B.P43RNO  AS RNO,
//B.P43KNM  AS CHM,
//'1'  AS RLS,
//'3504'  AS DEC,
//( SELECT ZCCVAL02 FROM CLVDTALB.TZCDA121 WHERE ZCCSYSCD = 'MIS' AND ZCCGRPCD = 'Z03' AND    ( (SUBSTR(A.P02NNO, 1, 1) = 'K' AND ZCCVAL07 = '1') 
//																																			OR (SUBSTR(A.P02NNO, 1, 1) <> 'K' AND ZCCVAL07 = '2'))  ) AS BNM,
//'노동조합비'  AS DTL,
//''  AS LOT, 
//SUM(NVL(P02S17, 0))  AS PTL,
//'2' AS GBN,
//''  AS BGO,
//CURRENT TIMESTAMP , :gs_empcode ) ,
//		 
//    FROM  PADB.TP02PYA0 A, PADB.HPAP43T B, INDB.HIN001M C
//WHERE     SUBSTR(A.P02RDT, 1, 4) = B.P43YAR
//    AND   A.P02NNO = B.P43NNO
//	AND  B.P43NNO = C.MEMBER_NO
//    AND   B.P43YAR = :as_std_yy
//    AND   B.P43REL = '0'
//	AND  SUBSTR(C.DUTY_CODE, 1, 1) LIKE :as_dept_cd
//	 AND  C.MEMBER_NO LIKE :as_emp_no
//	  AND C.NATION_CODE = 118
//	AND B.P43NNO NOT IN (SELECT DISTINCT P45NNO FROM PADB.HPAP45T 
//													WHERE P45YAR = B.P43YAR
//													    AND P45GBN <> '2')	
//	 AND( (:as_gu = 'J' AND ((NVL(C.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' 
//							AND C.JAEJIK_OPT <> 3) Or (C.JAEJIK_OPT = 3 AND  C.RETIRE_DATE > :as_std_yy  || '1231' )
//							Or (C.JAEJIK_OPT = 3 AND  C.RETIRE_DATE < :as_std_yy  || '0101' 
//AND   
//(SELECT SUM((CASE WHEN P02LCD  = '1' THEN NVL(P02TAM, 0) ELSE NVL(P02P14, 0) + NVL(P02P20, 0) END))
//FROM PADB.TP02PYA0 WHERE SUBSTR(P02RDT, 1, 4) = :as_std_yy and  P02NNO = C.MEMBER_NO) > 0 )) )
//							 OR (:as_gu = 'T' AND C.JAEJIK_OPT = 3 AND SUBSTR(C.RETIRE_DATE  , 1, 4) = :as_std_yy))
//	  AND (:ls_k = '%' Or   
//	  			((:ls_k = 'K' AND SUBSTR(C.MEMBER_NO,1, 1) = 'K') Or
//	 			(:ls_k <> 'K' AND SUBSTR(C.MEMBER_NO,1, 1) <> 'K')))	
//    GROUP BY P02NNO, SUBSTR(P02RDT, 1, 6), B.P43RNO,
//B.P43KNM,
//B.P43REL
//    HAVING SUM(NVL(P02S17, 0)) > 0 ) A
//USING SQLCA;	 
//
//If SQLCA.SQLCODE <> 0  Then 	
//	ls_err = SQLCA.SQLERRTEXT
//			ROLLBACK USING SQLCA;
//			 Messagebox('연말정산실행', '노동조합비 기부금정보(PADB.HPAP45T) insert 에러!~r' + ls_err)
//			Setpointer(Arrow!)
//	RETURN 0
//End If
//
////부양가족정보에 업데이트
UPDATE PADB.HPAP43T A
    SET P43F06 = (SELECT SUM(NVL(P45PTL, 0)) 
             FROM PADB.HPAP45T
             WHERE P45YAR = A.P43YAR
                AND P45NNO = A.P43NNO
                AND P45RNO = A.P43RNO)                                
    WHERE P43YAR = :as_std_yy
        AND P43NNO NOT IN (SELECT P41NNO FROM PADB.HPAP41D
                            WHERE P41YAR = :AS_STD_YY
                              AND P41NNO LIKE :AS_EMP_NO
                              AND P41DCD = '3500') 
    AND P43NNO IN (SELECT B.MEMBER_NO FROM INDB.HIN001M B , 
                (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
                WHERE MEMBER_NO LIKE :AS_EMP_NO 
                    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
                    GROUP BY MEMBER_NO) P
        WHERE B.MEMBER_NO = P.MEMBER_NO
            AND  SUBSTR(DUTY_CODE, 1, 1) LIKE :as_dept_cd
             AND  B.MEMBER_NO LIKE :as_emp_no
             AND   P.PAY + P.BONUS > 0 
             AND (  (:as_gu = 'J' 
        AND ( (NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND B.JAEJIK_OPT <> 3) 
             Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101'                   )  ))
       OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy)))
		USING SQLCA;															

If SQLCA.SQLCODE <> 0  Then 	
	ls_err = SQLCA.SQLERRTEXT
			ROLLBACK USING SQLCA;
			 Messagebox('연말정산실행', '부양가족  기부금정보(PADB.HPAP43T) UPDATE 에러!~r' + ls_err)
			Setpointer(Arrow!)
	RETURN 0
End If

//지정기부금 공제 추가
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,
P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,
JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT P45YAR, 
'3500', 
'3501',
P45NNO,
:AS_GU ,
SUM(P45PTL),
LEAST(SUM(P45PTL),
 (CASE WHEN W.P46ICW <= 5000000 THEN 0 ELSE 
 W.P46ICW -  ROUND(W.P48AM1 + (W.P46ICW - W.P48AM2) * W.P48RTE * 0.01, 0)  END )  * 0.15),
COUNT(DISTINCT P45RNO),
'',
:gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
      FROM PADB.HPAP45T A, INDB.HIN001M C,
       (       
        SELECT T.P46YAR, T.P46GBN, T.P46NNO,
       T.P46ICW,
       NVL((SELECT P48AM1 
       FROM PADB.HPAP48M
       WHERE P48YAR = :as_std_yy
       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE  P48YAR = :as_std_yy and  P48ATU >= T.P46ICW    ) 
           ), 0) AS P48AM1,
     NVL((SELECT P48AM2
       FROM PADB.HPAP48M
       WHERE  P48YAR = :as_std_yy
       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE  P48YAR = :as_std_yy AND P48ATU >= T.P46ICW )
         ),0) AS P48AM2,
     NVL((SELECT P48RTE 
       FROM PADB.HPAP48M
       WHERE  P48YAR = :as_std_yy
       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE  P48YAR = :as_std_yy AND  P48ATU >= T.P46ICW  )
         ),0)     AS P48RTE
FROM PADB.HPAP46T T
WHERE  T.P46YAR = :as_std_yy
AND T.P46GBN =  :as_gu) W , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
        WHERE A.P45NNO = C.MEMBER_NO
        AND A.P45NNO = P.MEMBER_NO
        AND W.P46NNO = A.P45NNO
        AND A.P45YAR = :as_std_yy
        AND A.P45GBN = '2'
        AND  SUBSTR(C.DUTY_CODE, 1, 1) LIKE :as_dept_cd
     AND  C.MEMBER_NO LIKE :as_emp_no
     AND   P.PAY + P.BONUS > 0 
        AND C.MEMBER_NO NOT IN (SELECT P41NNO  FROM PADB.HPAP41D
                            WHERE P41YAR =  :AS_STD_YY
                              AND P41NNO LIKE :AS_EMP_NO
                              AND P41DCD = '3500') 
    AND (  (:as_gu = 'J' 
        AND ( (NVL(C.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND C.JAEJIK_OPT <> 3) 
             Or (C.JAEJIK_OPT = 3 AND  C.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (C.JAEJIK_OPT = 3 AND  C.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND C.JAEJIK_OPT = 3 AND SUBSTR(C.RETIRE_DATE  , 1, 4) = :as_std_yy))
    GROUP BY P45YAR, P45NNO, W.P46ICW,  W.P48AM1, W.P48AM2, W.P48RTE
USING SQLCA;


If SQLCA.SQLCODE <> 0  Then 	
	ls_err = SQLCA.SQLERRTEXT
			ROLLBACK USING SQLCA;
			 Messagebox('연말정산실행', '지정기부금 공제내역(PADB.HPAP41D) insert 에러!~r' + ls_err)
			Setpointer(Arrow!)
	RETURN 0
End If	


///////////////////////////////////////////////////////////////////



//연말정산 대상정보내역 : 1100/1101 본인공제 
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT DISTINCT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
        :as_gu,
	   0,
       B.P40DAM,
       1, 
       ' ',
     :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
FROM   INDB.HIN001M A, PADB.HPAP40M B, PADB.HPAP43T C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
		AND  C.P43YAR = B.P40YAR
AND   C.P43YAR = :as_std_yy
AND   C.P43REL = '0'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '1100'
AND   B.P40DGB = '1101'    
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'  )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:본인공제(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If

//연말정산 대상정보내역 : 1100/1102 배우자공제 
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	  0,	 
       B.P40DAM,
       1, 
       ' ',
       :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
FROM    INDB.HIN001M A, PADB.HPAP40M B, PADB.HPAP43T C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
		AND  C.P43YAR = B.P40YAR
AND   C.P43YAR = :as_std_yy
AND   C.P43REL = 3
AND   C.P43KO1 = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '1100'
AND   B.P40DGB = '1102' 
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'  )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
 USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:배우자공제(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If

//연말정산 대상정보내역 : 1100/1103 부양가족공제 
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
       :as_gu ,
	   0,	 
       COUNT(C.P43RNO) *  B.P40DAM,
       COUNT(C.P43RNO) ,
       ' ',
    :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
FROM    INDB.HIN001M A, PADB.HPAP40M B, PADB.HPAP43T C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
		AND  C.P43YAR = B.P40YAR
AND   C.P43YAR = :as_std_yy
AND   C.P43REL NOT IN ('0','3')
AND   C.P43KO1 = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '1100'
AND   B.P40DGB = '1103'   
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'  )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40DAM
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:부양가족공제(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If



//연말정산 대상정보내역 : 1200/1201 경로우대자(70세이상) 
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
       0,     
       COUNT(C.P43RNO) *  B.P40DAM,
       COUNT(C.P43RNO) ,
       ' ',
    :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
FROM    INDB.HIN001M A, PADB.HPAP40M B, 
			 PADB.HPAP43T  C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
		AND  C.P43YAR = B.P40YAR
AND   C.P43YAR = :as_std_yy
AND   C.P43KO1 = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd 
AND   B.P40DCD = '1200'
AND   B.P40DGB = '1201'   
AND  C.P43OGB = 'Y'
AND   C.P43AGE  >= 70
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40DAM
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:경로우대자[70세이상](PADB.HPAP41D) INSERT 에러!~r" + ls_Err)
	Setpointer(Arrow!)
	RETURN 0
End If


////연말정산 대상정보내역 : 1200/1202 경로우대자(65~70세 미만) 
//INSERT INTO PADB.HPAP41D
//SELECT :as_std_yy , B.P40DCD, B.P40DGB,
//       C.P43NNO,
//     :as_gu ,
//	   0,	 
//       COUNT(C.P43RNO) *  B.P40DAM,
//       COUNT(C.P43RNO) ,
//       ' ',
//     :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
//		 
//FROM    INDB.HIN001M A, PADB.HPAP40M B, 
//		    PADB.HPAP43T  C 
//WHERE A.MEMBER_NO = C.P43NNO
//		AND  C.P43YAR = B.P40YAR
//AND   C.P43YAR = :as_std_yy
//AND   C.P43KO1 = 'Y'
//AND   A.MEMBER_NO LIKE :as_emp_no
//AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
// AND A.IS_ALIEN = 'N'				 
//AND   B.P40DCD = '1200'
//AND   B.P40DGB = '1202'   
//AND  C.P43OGB = 'Y'
//AND  ( C.P43AGE >=  65  AND C.P43AGE <  70 )
//AND( (:as_gu = 'J' AND ((NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' 
//AND A.JAEJIK_OPT <> 3) Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
//Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101' 
//AND   
//(SELECT SUM((CASE WHEN P02LCD  = '1' THEN NVL(P02TAM, 0) ELSE NVL(P02P14, 0) + NVL(P02P20, 0) END))
//FROM PADB.TP02PYA0 WHERE SUBSTR(P02RDT, 1, 4) = :as_std_yy and  P02NNO =a.MEMBER_NO) > 0 )) )
// OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
// AND (:ls_k = '%' Or  
// 				((:ls_k = 'K' AND SUBSTR(A.MEMBER_NO,1, 1) = 'K') Or
//	 			(:ls_k <> 'K' AND SUBSTR(A.MEMBER_NO,1, 1) <> 'K')))
//GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40DAM
//USING SQLCA;
//
//If SQLCA.SQLCODE <> 0 Then
//	ROLLBACK USING SQLCA;
//	Messagebox("연말정산실행", "연말정산대상정보내역:경로우대자[65-70세미만](PADB.HPAP41D) INSERT 에러!")
//	Setpointer(Arrow!)
//	RETURN 0
//End If

//연말정산 대상정보내역 : 1200/1203 장애인
//기본공제 대상 중
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	   0, 
       COUNT(C.P43RNO) *  B.P40DAM,
       COUNT(C.P43RNO) ,
       ' ',
      :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
		AND  C.P43YAR = B.P40YAR
AND   C.P43YAR = :as_std_yy
AND   C.P43KO1 = 'Y'
AND   C.P43KO2 = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd 
AND   B.P40DCD = '1200'
AND   B.P40DGB = '1203'  
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40DAM
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:장애인(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If

//연말정산 대상정보내역 : 1200/1204 자녀양육비
//기본공제 대상이 아니어도 자녀양육비 대상이면 가능
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	   0,
       COUNT(C.P43RNO) *  B.P40DAM,
       COUNT(C.P43RNO) ,
       ' ',
      :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
		AND  C.P43YAR = B.P40YAR
AND   C.P43YAR = :as_std_yy
AND   C.P43KO3 = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '1200'
AND   B.P40DGB = '1204'   
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40DAM
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:자녀양육비(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If

//연말정산 대상정보내역 : 1200/1205 부녀자
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy ,B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	   0,
       B.P40DAM,
       1 ,
       ' ',
   :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
		AND  C.P43YAR = B.P40YAR
AND   C.P43YAR = :as_std_yy
AND   C.P43REL = '0'
AND   C.P43WHM = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd 
AND   B.P40DCD = '1200'
AND   B.P40DGB = '1205'
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:부녀자(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If


//연말정산 대상정보내역 : 1200/1206  다자녀2인
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy ,B.P40DCD, B.P40DGB,
       C.P43NNO,
       :as_gu ,
	    0,
        B.P40DAM,
        COUNT(C.P43RNO) ,
       ' ',
     :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
		AND  C.P43YAR = B.P40YAR
AND   C.P43YAR = :as_std_yy
AND   C.P43REL IN ( '4', '5')
AND   C.P43KO1 = 'Y'
AND   C.P43CON = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '1200'
AND   B.P40DGB = '1206'
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40DAM
HAVING COUNT(C.P43RNO) = 2
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:다자녀2인(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If

//연말정산 대상정보내역 : 1200/1207  다자녀3인이상
//다자녀 2인 금액 + 3인 이상 인원에 따른 금액
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	    0,
       (COUNT(C.P43RNO) - 2) * B.P40DAM + 
       MAX((SELECT P40DAM FROM PADB.HPAP40M WHERE P40YAR = :as_std_yy AND P40DCD = '1200'
                                    AND   P40DGB = '1206')) ,
       COUNT(C.P43RNO)  ,
       ' ',
      :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
		AND  C.P43YAR = B.P40YAR
AND   C.P43YAR = :as_std_yy
AND   C.P43REL IN ( '4', '5')
AND   C.P43KO1 = 'Y'
AND   C.P43CON = 'Y'
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'  )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '1200'
AND   B.P40DGB = '1207'   
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40DAM
HAVING COUNT(C.P43RNO) >= 3
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:다자녀3인이상(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If


//연말정산 대상정보내역 : 1200/1208  출산/입양자공제
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy ,B.P40DCD, B.P40DGB,
       C.P43NNO,
       :as_gu ,
	    0,
        COUNT(C.P43RNO)  * B.P40DAM,
        COUNT(C.P43RNO) ,
       ' ',
     :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
		 
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
		AND  C.P43YAR = B.P40YAR
AND   C.P43YAR = :as_std_yy
AND   C.P43REL IN ( '4', '5')
AND   C.P43BGB = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '1200'
AND   B.P40DGB = '1208'   
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40DAM
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:출산·입양자공제(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If


//연말정산 대상정보내역 : 2100/2101  국민연금
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy ,B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	   D.ANN_PAID_AMT  + NVL((SELECT SUM(NVL(P42PEN, 0)) FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = A.MEMBER_NO), 0),
       D.ANN_PAID_AMT  + NVL((SELECT SUM(NVL(P42PEN, 0)) FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = A.MEMBER_NO), 0) ,
       1 ,
       ' ',
  :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C , 
(SELECT MEMBER_NO, SUM(NVL(PAY_AMT,0))   AS ANN_PAID_AMT 
FROM PADB.HPA005D P
WHERE YEAR_MONTH BETWEEN :ls_fr_mm AND :ls_to_mm
AND CODE = '71'
GROUP BY MEMBER_NO) D , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND   A.MEMBER_NO = D.MEMBER_NO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
		AND  C.P43YAR = B.P40YAR
AND   C.P43REL = '0'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '2100'
AND   B.P40DGB = '2101'  
AND   NVL(D.ANN_PAID_AMT,0)  <> 0
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
    USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:국민연금(PADB.HPAP41D) INSERT 에러!~r" + ls_Err)
	Setpointer(Arrow!)
	RETURN 0
End If


//연말정산 대상정보내역 : 2100/2102  기타연금보험료공제
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy ,B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	   D.ETC_PAID_AMT + NVL((SELECT SUM(NVL(P42DM1, 0)) FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = A.MEMBER_NO), 0), 
       D.ETC_PAID_AMT +  NVL((SELECT SUM(NVL(P42DM1, 0)) FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = A.MEMBER_NO), 0),  
       1 ,
       ' ',
  :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C , 
(SELECT MEMBER_NO, SUM(NVL(PAY_AMT,0))   AS ETC_PAID_AMT 
FROM PADB.HPA005D P
WHERE YEAR_MONTH BETWEEN :ls_fr_mm AND :ls_to_mm
AND CODE = '53'
GROUP BY MEMBER_NO) D , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   A.MEMBER_NO = D.MEMBER_NO
AND   C.P43YAR = :as_std_yy
		AND  C.P43YAR = B.P40YAR
AND   C.P43REL = '0'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '2100'
AND   B.P40DGB = '2102'  
AND   NVL(D.ETC_PAID_AMT,0)  <> 0
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101' )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
    USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:기타연금보험(PADB.HPAP41D) INSERT 에러!~r" + ls_Err)
	Setpointer(Arrow!)
	RETURN 0
End If




//연말정산 대상정보내역 : 3100/3101  건강보험료
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy ,B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
       D.MIN_PAID_AMT + NVL((SELECT SUM(NVL(P42IPR, 0)) FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = A.MEMBER_NO ), 0)  ,
	  D.MIN_PAID_AMT + NVL((SELECT SUM(NVL(P42IPR, 0)) FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = A.MEMBER_NO ), 0)  ,
       1 ,
       ' ',
   :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		  
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C , 
(SELECT MEMBER_NO, SUM(NVL(PAY_AMT,0))   AS MIN_PAID_AMT 
FROM PADB.HPA005D P
WHERE YEAR_MONTH BETWEEN :ls_fr_mm AND :ls_to_mm
AND CODE IN('54', '57')
GROUP BY MEMBER_NO) D , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND   A.MEMBER_NO = D.MEMBER_NO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43REL = '0'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '3100'
AND   B.P40DGB = '3101'  
AND  NVL(D.MIN_PAID_AMT, 0) <> 0
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:건강보험료(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If

//연말정산 대상정보내역 : 3100/3102  고용보험료
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
     :as_gu ,
       D.EMP_INSU_AMT 
              + NVL((SELECT SUM(NVL(P42EMP, 0)) FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = A.MEMBER_NO ), 0),
	  D.EMP_INSU_AMT  
	  + NVL((SELECT SUM(NVL(P42EMP, 0)) FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = A.MEMBER_NO ), 0),
       1 ,
       ' ',
      :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C , 
(SELECT MEMBER_NO, SUM(EMP_INSU_AMT) AS EMP_INSU_AMT
FROM (
SELECT MEMBER_NO, SUM(NVL(PAY_AMT,0))   AS EMP_INSU_AMT 
FROM PADB.HPA005D P
WHERE YEAR_MONTH BETWEEN :ls_fr_mm AND :ls_to_mm
AND CODE = '78'
GROUP BY MEMBER_NO
UNION ALL
SELECT MEMBER_NO, SUM(NVL(GONGIE_AMT, 0)) AS EMP_INSU_AMT 
FROM PADB.HPA009M 
WHERE  (YEAR || TRIM(TO_CHAR(MONTH, '00'))  BETWEEN :Ls_fr_mm AND :Ls_to_mm)
GROUP BY MEMBER_NO) EMP
GROUP BY MEMBER_NO ) D , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND   A.MEMBER_NO = D.MEMBER_NO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43REL = '0'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '3100'
AND   B.P40DGB = '3102'  
AND   NVL(D.EMP_INSU_AMT, 0) <> 0
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:고용보험료(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If

//연말정산 대상정보내역 : 3100/3103  보장성보험료
INSERT INTO PADB.HPAP41D
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	   SUM(NVL(C.P43G01, 0)  + NVL(C.P43F01, 0)),	 
       (CASE WHEN SUM(NVL(C.P43G01, 0)  + NVL(C.P43F01, 0)) > B.P40LIM THEN B.P40LIM 
            ELSE SUM(NVL(C.P43G01, 0)  + NVL(C.P43F01, 0)) END ), 
       COUNT(C.P43RNO) ,
       ' ',
    :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
		 
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43KO1 = 'Y'
AND   C.P43C01 = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '3100'
AND   B.P40DGB = '3103'  
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'  )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))	 
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40LIM
HAVING SUM(NVL(C.P43G01, 0)  + NVL(C.P43F01, 0)) > 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:보장성보험료(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If

//연말정산 대상정보내역 : 3100/3104  장애인보험
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	 SUM(NVL(C.P43G08, 0)  + NVL(C.P43F08, 0)) ,	 
       (CASE WHEN SUM(NVL(C.P43G08, 0)  + NVL(C.P43F08, 0)) > B.P40LIM THEN B.P40LIM 
            ELSE SUM(NVL(C.P43G08, 0)  + NVL(C.P43F08, 0)) END ), 
       COUNT(C.P43RNO) ,
       ' ',
   :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B,  PADB.HPAP43T C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43KO1 = 'Y'
AND   C.P43C01 = 'Y'
AND   C.P43KO2 = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd 
AND   B.P40DCD = '3100'
AND   B.P40DGB = '3104'  
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40LIM
HAVING SUM(NVL(C.P43G08, 0)  + NVL(C.P43F08, 0)) > 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:장애인보험료(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If


//연말정산 대상정보내역 : 3200/3202 일반의료비
//2009.12.30 외국인일 경우 총급여액의 30%를 제한금액을 과세대상근로소득금액으로 한다. 
//* (CASE WHEN A.IS_ALIEN = 'N'    THEN 1 ELSE 0.7 END)
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
     :as_gu ,
	  SUM(NVL(C.P43G02, 0)  + NVL(C.P43F02, 0)),
       (CASE WHEN SUM(NVL(C.P43G02, 0)  + NVL(C.P43F02, 0)) 
                    -  TRUNC( (CASE WHEN A.IS_ALIEN = 'Y'    THEN 0.7 ELSE 1 END) *( P.PAY
		+       P.BONUS
                               -   P.NONTAX1
                               -   P.NONTAX2           + NVL(MAX((SELECT SUM(NVL(P42PTL, 0) + NVL(P42BTL,0) + NVL(P42ATL, 0))   
                                                      FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = C.P43NNO )), 0) )			    
                     * B.P40DRT, 0) > B.P40LIM 
            THEN B.P40LIM 
            ELSE 
                    SUM(NVL(C.P43G02, 0)  + NVL(C.P43F02, 0)) 
                    -  TRUNC((CASE WHEN A.IS_ALIEN = 'Y'    THEN 0.7 ELSE 1 END) * (P.PAY
		+        P.BONUS
                               -    P.NONTAX1
                               -    P.NONTAX2
                                -  NVL(SUM((SELECT  NVL(Q.FOREIGN_AMT,0) 
                                                 FROM    PADB.HPA019H Q
                                               WHERE    Q.YEAR     =    :as_std_yy
                                                      AND    Q.MEMBER_NO   =    C.P43NNO)) , 0)
                                 + NVL(MAX((SELECT SUM(NVL(P42PTL, 0) + NVL(P42BTL,0) + NVL(P42ATL, 0)  ) 
                                                      FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = C.P43NNO )), 0) )
                             * B.P40DRT, 0) 
			END ),
        COUNT(C.P43RNO) ,
       ' ',
  :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B, 
PADB.HPAP43T C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS , SUM(NONTAX1) AS NONTAX1, SUM(NONTAX2) AS NONTAX2 FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43C02 = 'Y'
AND   (C.P43REL <> '0' AND
        C.P43KO2 <> 'Y' AND
         C.P43AGE <  65 )
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '3200'
AND   B.P40DGB = '3202'  
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO, B.P40DRT,B.P40LIM, A.IS_ALIEN, P.PAY, P.BONUS, P.NONTAX1, P.NONTAX2
HAVING SUM(NVL(C.P43G02, 0)  + NVL(C.P43F02, 0)) > 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:일반의료비(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If


//연말정산 대상정보내역 : 3200/3201 본인장애경로의료비
//일반의료비가 총급여의 3% 미달인 경우 해당의료비에서 미달금액을 빼준다.
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	  SUM(NVL(C.P43G02, 0)  + NVL(C.P43F02, 0)), 	 
(CASE WHEN  MAX(NVL((SELECT NVL(P41DEM, 0) 
					 FROM  PADB.HPAP41D
					WHERE P41YAR = :as_std_yy
					AND P41NNO = C.P43NNO
					AND P41DCD = '3200'
					AND P41DGB = '3202' ) , 0)) < 0 THEN
						SUM(NVL(C.P43G02, 0)  + NVL(C.P43F02, 0)) + 
						 MAX(NVL((SELECT NVL(P41DEM, 0) 
									 FROM  PADB.HPAP41D
									WHERE P41YAR = :as_std_yy
									AND P41NNO = C.P43NNO
									AND P41DCD = '3200'
									AND P41DGB = '3202') , 0)) 
		ELSE (CASE WHEN  MAX(NVL((SELECT NVL(P41DEM, 0) 
					 FROM  PADB.HPAP41D
					WHERE P41YAR = :as_std_yy
					AND P41NNO = C.P43NNO
					AND P41DCD = '3200'
					AND P41DGB = '3202' ) , 0)) = 0  
			THEN SUM(NVL(C.P43G02, 0)  + NVL(C.P43F02, 0))  
				-  TRUNC( (CASE WHEN A.IS_ALIEN = 'Y'    THEN 0.7 ELSE 1 END) *  (P.PAY
				+        P.BONUS
						 -   P.NONTAX1
						 -   P.NONTAX2
						   + NVL(MAX((SELECT SUM(NVL(P42PTL, 0) + NVL(P42BTL,0) + NVL(P42ATL, 0)   )
								    FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO = C.P43NNO )), 0) )
						    * B.P40DRT, 0) 
				ELSE SUM(NVL(C.P43G02, 0)  + NVL(C.P43F02, 0))  END)
		END	)	, 
       COUNT(DISTINCT C.P43RNO) ,
       ' ',
   :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, 
			PADB.HPAP40M B,  
		   PADB.HPAP43T  C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS , SUM(NONTAX1) AS NONTAX1, SUM(NONTAX2) AS NONTAX2  FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43C02 = 'Y'
AND   (C.P43REL = '0' OR 
		   C.P43KO2 = 'Y' OR
            C.P43AGE >=  65 )
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '3200'
AND   B.P40DGB = '3201'  
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO,  B.P40DRT,A.IS_ALIEN, P.PAY, P.BONUS, P.NONTAX1, P.NONTAX2
HAVING SUM(NVL(C.P43G02, 0)  + NVL(C.P43F02, 0)) > 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:본인장애경로의료비(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If


//연말정산 대상정보내역 : 3300/3301 본인교육비
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	  NVL(C.P43G03, 0) + NVL(C.P43F03,0),	 
      NVL(C.P43G03, 0) + NVL(C.P43F03,0),
        1 ,
       ' ',
     :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B, PADB.HPAP43T C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43REL = '0'
AND   C.P43C03 = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd	 
AND   B.P40DCD = '3300'
AND   B.P40DGB = '3301' 
AND   NVL(C.P43G03, 0) + NVL(C.P43F03,0)  <> 0
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:본인교육비(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
Setpointer(Arrow!)
	RETURN 0
End If


//교육비 : 취학전, 초중고, 대학생 구분 추가 필요
//연말정산 대상정보내역 : 3300/3302 취학전교육비
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
        SUM(NVL(C.P43G03, 0) + NVL(C.P43F03,0)), 
       SUM(CASE WHEN NVL(C.P43G03, 0) + NVL(C.P43F03,0) > B.P40LIM THEN B.P40LIM
                ELSE NVL(C.P43G03, 0) + NVL(C.P43F03,0) END),    
       COUNT(C.P43RNO),
       ' ',
   :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B, PADB.HPAP43T C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43C03 = 'Y'
AND   C.P43KO2 <> 'Y'
AND   C.P43EDG = '01'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd		 
AND   B.P40DCD = '3300'
AND   B.P40DGB = '3302'  
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'  )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO
HAVING  SUM(NVL(C.P43G03, 0) + NVL(C.P43F03,0)) <> 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:취학전교육비(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If


//연말정산 대상정보내역 : 3300/3303 초중고교육비
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
    :as_gu ,
        SUM(NVL(C.P43G03, 0) + NVL(C.P43F03,0)), 
       SUM(CASE WHEN NVL(C.P43G03, 0) + NVL(C.P43F03,0) > B.P40LIM THEN B.P40LIM
                ELSE NVL(C.P43G03, 0) + NVL(C.P43F03,0) END),    
       COUNT(C.P43RNO),
       ' ',
     :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B, PADB.HPAP43T C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43REL <> '0'
AND   C.P43C03 = 'Y'
AND   C.P43KO2 <> 'Y'
AND   C.P43EDG IN ( '02', 3, '04')
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '3300'
AND   B.P40DGB = '3303'
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'  )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO
HAVING SUM(NVL(C.P43G03, 0) + NVL(C.P43F03,0)) <> 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:초중고교육비(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If


//연말정산 대상정보내역 : 3300/3304 대학생교육비
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
       :as_gu ,
        SUM(NVL(C.P43G03, 0) + NVL(C.P43F03,0)), 
       SUM(CASE WHEN NVL(C.P43G03, 0) + NVL(C.P43F03,0) > B.P40LIM THEN B.P40LIM
                ELSE NVL(C.P43G03, 0) + NVL(C.P43F03,0) END),    
       COUNT(C.P43RNO),
       ' ',
     :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		 
FROM    INDB.HIN001M A, PADB.HPAP40M B, PADB.HPAP43T C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43REL <> '0'
AND   C.P43C03 = 'Y'
AND   C.P43KO2 <> 'Y'
AND   C.P43EDG = '05'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '3300'
AND   B.P40DGB = '3304'  
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'  )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))	 
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO
HAVING  SUM(NVL(C.P43G03, 0) + NVL(C.P43F03,0)) <> 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:대학생교육비(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If

//연말정산 대상정보내역 : 3300/3305 장애인특수교육비
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
       :as_gu ,
       SUM(NVL(C.P43G03, 0) + NVL(C.P43F03,0)),
	  SUM(NVL(C.P43G03, 0) + NVL(C.P43F03,0)),	 
       COUNT(C.P43RNO),
       ' ',
       :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate		   
FROM    INDB.HIN001M A, PADB.HPAP40M B, PADB.HPAP43T C , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND   C.P43REL <> '0'
AND   C.P43KO1 = 'Y'
AND   C.P43C03 = 'Y'
AND   C.P43KO2 = 'Y'
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '3300'
AND   B.P40DGB = '3305'  
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO
HAVING  SUM(NVL(C.P43G03, 0) + NVL(C.P43F03,0)) <> 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:장애인특수교육비(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If



//※ 신용카드 등 소득공제액 = ①, ②, ③ 중 적은 금액 
//①  초과금액  ×  20%
//- 초과금액 : (신용카드 등 사용금액 연간합계액 - 총급여액 20%)
//- 신용카드 등 사용금액 : 신용카드사용금액 + 기명식선불카드사용금액 + 직 불카드사용금액 + 현금영수증사용금액 + 지로납부수강료 - 의료비중복금액 등
//② 총급여액 × 20 %
//③ 연 500만원

//연말정산 대상정보내역 : 4300/4301 신용카드
INSERT INTO PADB.HPAP41D
(  P41YAR ,P41DCD ,P41DGB ,P41NNO ,P41AJG ,P41SAM ,P41DEM ,P41PCN ,P41RMK ,WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy , B.P40DCD, B.P40DGB,
       C.P43NNO,
      :as_gu ,
	 SUM(NVL(C.P43G04, 0)  + NVL(C.P43G05, 0) + NVL(C.P43F04, 0) + NVL(C.P43F05, 0) - NVL(C.P43G07, 0)),
         LEAST(   LEAST ( TRUNC(((SUM(NVL(C.P43G04, 0)  + NVL(C.P43G05, 0) + NVL(C.P43F04, 0) + 
		 								    NVL(C.P43F05, 0) - NVL(C.P43G07, 0))
									 -  TRUNC(  (CASE WHEN A.IS_ALIEN = 'Y'    THEN 0.7 ELSE 1 END) * (
									 P.PAY
									 +    P.BONUS
                                                -    P.NONTAX1
                                               -    P.NONTAX2
                                                  + MAX(NVL((SELECT SUM(NVL(P42PTL, 0)   +  NVL(P42BTL,0) +  NVL(P42ATL, 0))   FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO =C.P43NNO ), 0)))       
                       		   * B.P40LRT, 0)) * B.P40LRT), 0) , B.P40LIM ) ,   
			       TRUNC( (CASE WHEN A.IS_ALIEN = 'Y'    THEN 0.7 ELSE 1 END) *(P.PAY
			       +        P.BONUS
                                 -    P.NONTAX1
                                   -    P.NONTAX2
                                      + MAX(NVL((SELECT SUM(NVL(P42PTL, 0)   +  NVL(P42BTL,0) +  NVL(P42ATL, 0))   FROM PADB.HPAP42T WHERE P42YAR = :as_std_yy AND P42NNO =C.P43NNO ), 0)))
		* B.P40DRT, 0) ),  	
        COUNT(C.P43RNO) ,
       ' ',
      :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate
		 FROM    INDB.HIN001M A, PADB.HPAP40M B, 
 PADB.HPAP43T  C  , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS, SUM(NONTAX1) AS NONTAX1, SUM(NONTAX2) AS NONTAX2  FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.MEMBER_NO = C.P43NNO
AND A.MEMBER_NO = P.MEMBER_NO
AND   C.P43YAR = :as_std_yy
AND  C.P43YAR = B.P40YAR
AND  ( C.P43C04 = 'Y' OR
 C.P43C05 = 'Y')
 AND  C.P43REL NOT IN ('7', '6')
AND   A.MEMBER_NO LIKE :as_emp_no
AND   SUBSTR(A.DUTY_CODE, 1, 1) LIKE :as_dept_cd
AND   B.P40DCD = '4300'
AND   B.P40DGB = '4301'  
AND   P.PAY + P.BONUS > 0 
AND (  (:as_gu = 'J' 
        AND ( (NVL(A.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND A.JAEJIK_OPT <> 3) 
             Or (A.JAEJIK_OPT = 3 AND  A.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (a.JAEJIK_OPT = 3 AND  a.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND A.JAEJIK_OPT = 3 AND SUBSTR(A.RETIRE_DATE  , 1, 4) = :as_std_yy))
GROUP BY B.P40DCD, B.P40DGB, C.P43NNO,  B.P40DRT,B.P40LIM,B.P40LRT, A.IS_ALIEN, P.PAY, P.BONUS, P.NONTAX1, P.NONTAX2
HAVING SUM(NVL(C.P43G04, 0)  + NVL(C.P43G05, 0) + NVL(C.P43F04, 0) + NVL(C.P43F05, 0) - NVL(C.P43G07, 0)) > 0
USING SQLCA;



If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산대상정보내역:신용카드 등 사용금액 공제(PADB.HPAP41D) INSERT 에러!~r" + ls_err)
	Setpointer(Arrow!)
	RETURN 0
End If


//공제금액이 0보다 작거나 같은 경우 ROW 자체를 삭제한다.
DELETE FROM PADB.HPAP41D A
			WHERE P41YAR = :AS_STD_YY 
                  AND A.P41AJG = :as_gu
                  AND A.P41NNO LIKE :AS_EMP_NO					
				 AND  A.P41DGB <> '3202'
            AND NVL(A.P41DEM, 0) <= 0 
            AND P41NNO IN (SELECT B.MEMBER_NO
				FROM INDB.HIN001M B, 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
			  WHERE B.MEMBER_NO   = P.MEMBER_NO
				 AND B.MEMBER_NO LIKE :as_emp_no
				 AND SUBSTR(B.DUTY_CODE, 1, 1)  LIKE :as_dept_cd
				 AND   P.PAY + P.BONUS > 0 
				 AND (  (:as_gu = 'J' 
        AND ( (NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND B.JAEJIK_OPT <> 3) 
             Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy  || '1231' )
             Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
       OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy)))
                 AND A.P41DGB IN (SELECT P40DGB FROM PADB.HPAP40M C 
                                        WHERE C.P40YAR = :as_std_yy
                        				 AND NVL(C.P40PCG,'Y') <> 'N')   
			USING SQLCA;
			
			If SQLCA.SQLCODE <> 0 Then
				ls_err = SQLCA.SQLERRTEXT
				ROLLBACK USING SQLCA;
				MESSAGEBOX("연말정산실행", "연말정산대상정보내역(PADB.HPAP41D) 삭제 에러!~r" + ls_err)
				RETURN 0
			End If


UPDATE  PADB.HPAP41D A
SET  P41DEM = 0
WHERE  P41YAR = :AS_STD_YY 
               AND A.P41AJG = :as_gu
                  AND A.P41NNO LIKE :AS_EMP_NO                    
            AND NVL(A.P41DEM, 0) <= 0 
				AND   A.P41DCD = '3200'
				AND   A.P41DGB = '3202'  
 AND P41NNO IN  (SELECT B.MEMBER_NO
		FROM INDB.HIN001M B,
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
	  WHERE B.MEMBER_NO = P.MEMBER_NO
		 AND B.MEMBER_NO LIKE :as_emp_no
		 AND SUBSTR(B.DUTY_CODE, 1, 1)  LIKE :as_dept_cd
		 		 AND   P.PAY + P.BONUS > 0 
			AND (  (:as_gu = 'J' 
			        AND ( (NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' AND B.JAEJIK_OPT <> 3) 
				   Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy  || '1231' )
				   Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101'   )  ))
			       OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy)))
 AND A.P41DGB IN (SELECT P40DGB FROM PADB.HPAP40M C 
                                        WHERE C.P40YAR = :as_std_yy
                        				 AND NVL(C.P40PCG,'Y') <> 'N')    
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	MESSAGEBOX("연말정산실행", "연말정산대상정보내역(PADB.HPAP41D) 일반의료비 - 금액 업데이트 에러!~r" + ls_err)
	RETURN 0
End If

Setpointer(Arrow!)

RETURN 1

end function

public function integer of_year_create (string as_std_yy, string as_gu, string as_dept_cd, string as_emp_no);Long ll_cnt, ll_i
Datetime ldt_cur
String ls_k, ls_emp_no
String ls_err
String ls_fr_mm, ls_to_mm


ldt_cur = func.of_get_datetime()


SELECT	SUBSTR(A.FDATE,1,6),	SUBSTR(A.TDATE,1,6)
	INTO	:ls_fr_mm, :ls_to_mm
	FROM	PADB.HPA022M A  
	WHERE	A.YEAR	=	:as_std_yy
USING SQLCA	;

If SQLCA.SQLCODE <> 0 Or Isnull(ls_fr_mm) or ls_fr_mm = '' Then 
	ROLLBACK USING SQLCA;
	Messagebox("알림", "연말정산 기간관리 데이터를 확인하세요!")
	RETURN -1
End If

SELECT COUNT(*)
    INTO :ll_cnt
    FROM  INDB.HIN001M B , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE
	    MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
 WHERE   B.MEMBER_NO = P.MEMBER_NO
 AND SUBSTR(B.DUTY_CODE, 1, 1)  LIKE :as_dept_cd
	 AND B.MEMBER_NO LIKE :as_emp_no
	 AND   P.PAY + P.BONUS > 0 
	  AND ( (:as_gu = 'J' AND ((NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' 
AND B.JAEJIK_OPT <> 3) Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy || '1231' )
Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101'  )) )
 OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))	
 USING SQLCA;
 
 
 If SQLCA.SQLCODE = 100 Or ll_cnt = 0 Then
	
	SELECT COUNT(*)
    INTO :ll_cnt
    FROM PADB.HPAP42T A, INDB.HIN001M B , 
    (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
 WHERE A.P42NNO = B.MEMBER_NO
 AND A.P42NNO = P.MEMBER_NO
     AND A.P42YAR = :as_std_yy
 	AND SUBSTR(B.DUTY_CODE, 1, 1) LIKE :as_dept_cd
	 AND A.P42NNO LIKE :as_emp_no
	 AND   P.PAY + P.BONUS > 0 
	 AND ( (:as_gu = 'J' AND ((NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' 
AND B.JAEJIK_OPT <> 3) Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy || '1231' )
Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101'  )) )
 OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))	
 USING SQLCA;
	
	 If SQLCA.SQLCODE = 100 Or ll_cnt = 0 Then	
		ls_err = SQLCA.SQLERRTEXT
		ROLLBACK USING SQLCA;
		If as_emp_no =  '%' Then 		
		Messagebox("알림", "해당년도 급여자료가 존재하지 않습니다!")
		RETURN -1
		Else 
			RETURN 0
		end If
	End If
End If


SELECT COUNT(*)
   INTO :ll_cnt
   FROM PADB.HPAP46T 
WHERE P46YAR = :as_std_yy
    AND P46GBN = :as_gu
    AND P46NNO LIKE :as_emp_no
    AND SUBSTR(P46GRD, 1 , 1)  LIKE :as_dept_cd
USING SQLCA;

 If ll_cnt > 0 Then
	
	If as_emp_no = '%' Then 
		If Messagebox("알림", "해당년도 연말정산내역이 존재합니다.~r삭제 후 재생성 하시겠습니까?", Question!, YesNo! ,2) = 2 Then RETURN 0
	End If
		DELETE FROM PADB.HPAP46T
		WHERE P46YAR = :as_std_yy
		AND     P46GBN = :as_gu
		AND	  P46NNO	LIKE :as_emp_no
		AND	  SUBSTR(P46GRD, 1 , 1)  LIKE :as_dept_cd
		USING SQLCA;
		
		If SQLCA.SQLCODE <> 0 Then
			ls_err = SQLCA.SQLERRTEXT
			ROLLBACK USING SQLCA;
			MESSAGEBOX("연말정산실행", "연말정산내역(PADB.HPAP46T) 삭제 에러!~r" + ls_Err)
			RETURN 0
		End If			
	
End If

//gf_openwait()
Setpointer(Hourglass!)



/*P46YAR	정산년도:
P46GBN	J:연말정산(재직자)T:연말정산(중퇴자):
P46NNO	사원번호:
P46KNM	한글명칭:
P46RNO	주민등록번호:
P46ZIP	우편번호:
P46AD1	우편주소:
P46AD2	상세주소:
P46PTL	급여총액:
P46BTL	상여총액:
P46ATL	인정상여:
P46PPL	최종월정급여:		-------------*
P46FEG	국외근로공제액:    
P46RND	연구활동비과세:
P46NGT	야간근로수당:		-------------*
P46BFM	출산보육수당:		-------------*
P46FFM	외국인근로자:		 
P46GFM	기타비과세:
P46TFM	비과세합계:
P46ICW	근로소득수입금액:
P46SBW	근로소득공제:
P46ICS	근로소득금액:
P46SFS	본인공제:
P46SPD	배우자유무:
P46SPS	배우자공제:
P46CPD	20세미만부양: 		-------------*
P46OPD	60세이상부양-부양가족:
P46STS	부양가족공제:
P46ODS	경로우대공제:
P46EPS	장애자공제:
P46VNS	부녀자세대주공제:
P46SUS	자녀양육비공제:
P46BTS	소수공제자추가공제:    -------------*
P46PEN	기타연금보험료공제:
P46DMD	퇴직연금:					   -------------* 확인필요
P46IPR	기납의료고용보험계:
P46ISU	외부보험료총액:
P46CMD	의료비총액:
P46EDM	교육비총액:
P46HND	주택자금총액:
P46DND	기부금총액:
P46SIS	보험료공제:
P46SCM	의료비공제:
P46SED	교육비공제:
P46SHN	주택마련저축소득공제:-------------*
P46SDN	기부금공제:
P46WSS	계(또는표준공제):
P46WSI	차감소득금액:
P46STK	개인연금총액:
P46INV	투자조합총액:
P46CTT	신용카드총액:
P46SST	개인연금저축공제-2000년이전가입:
P46INS	투자조합공제:
P46CRD	신용카드공제:
P46TSD	과세표준:
P46CTA	산출세액:
P46SAV	재형저축총액:
P46SAG	재형기금총액:
P46SKO	주택자금이자세총액:
P46OSK	주식저축총액:
P46DXW	근로소득세액공제:
P46TSA	재형저축세액공제:
P46TSK	주택차입금공제:
P46TOS	주식저축세액공제:
P46TFE	외국납부세액공제:
P46TFD	재형기금차감액:
P46TYX	세액공제계:
P46TXP	결정소득세:
P46RTR	결정주민세:
P46FTR	결정농특세:
P46JTX	전근무소득세징수액:
P46JRT	전근무주민세징수액:
P46JFT	전근무농특세징수액:
P46HTX	현근무소득세징수액:
P46HRT	현근무주민세징수액:
P46HFT	현근무농특세징수액:
P46CTX	차감소득세:
P46CRT	차감주민세:
P46CFT	차감농특세:
P46DCD	부서코드:
P46CMP	사업장:
P46FGP	직군:
P46FUN	직능:
P46GRD	직급:
P46OAG	65세이상경로:
P46HTH	장애자부양:
P46WHM	부녀자세대주유무:
P46CID	자녀양육인원:
P46NLF	내외국인구분
P46XCD	사업자등록번호 1~3:
P46BNO	사업자등록번호:
P46DM1	주택이자상환액-거치기간10년:
P46DM2	연금저축-2001년이후가입:
P46DM3	장기저축-당해년도:
P46DM4	장기저축-전년도:
P46DM5	장기증권저축세액공제:
P46DM6	직불카드총액:
P46DM7	70세이상경로:
P46DM8	빈컬럼:
P46DM9	본인의료비:
P46DM0	혼인이사장례:
P46DMA	주택이자상환액-거치기간15년:
P46DMB	기부정치자금:
P46DMC	현금영수증:
P46DME	신용카드의료기관사용내역:
P46DMF	타인신용카드의료기관사용액:
P46DMG	의료비미공제액:
P46DMH	다자녀인원수:
P46DMI	다자녀추가공제:
P46DMJ	소기업소상공인공제부금소득공제:
P46DMK	납세조합공제:
P46DML	출산입양인원수:
P46DMM	출산입양공제:
P46DMN	국민연금보험료공제:
P46DMO	주택임차차입금원리금상환액:
P46DMP	장기주택저당차입금이자상환액:
P46DMQ	연간고용보험료:
P46DMR	연간의료보험료:
P46DMS	펀드소득공제:
CREDTE	등록일자:
CREUID	등록사번:
UPDDTE	수정일자:
UPDUID	수정사번:	
*/

INSERT INTO PADB.HPAP46T
(
P46YAR, P46GBN, P46NNO, P46KNM, P46RNO, 
P46ZIP, P46AD1, P46AD2, P46PTL, P46BTL, 
P46ATL, P46PPL, P46FEG, P46RND, P46NGT, P46BFM, 
P46FFM, P46GFM, P46TFM, P46ICW, P46SBW, 
P46ICS, P46SFS, P46SPD, P46SPS, P46CPD,
P46OPD, P46STS, P46ODS, P46EPS, P46VNS, 
P46SUS, P46BTS, P46PEN, P46DMD, P46IPR,
P46ISU, P46CMD, P46EDM, P46HND, P46DND, 
P46SIS, P46SCM, P46SED, P46SHN, P46SDN,
P46WSS, P46WSI, P46STK, P46INV, P46CTT,
P46SST, P46INS, P46CRD, P46TSD, P46CTA, 
P46SAV, P46SAG, P46SKO, P46OSK, P46DXW, 
P46TSA, P46TSK, P46TOS, P46TFE, P46TFD, 
P46TYX, P46TXP, P46RTR, P46FTR, P46JTX, 
P46JRT, P46JFT, P46HTX, P46HRT, P46HFT, 
P46CTX, P46CRT, P46CFT, P46DCD, P46CMP, 
P46FGP, P46FUN, P46GRD, P46OAG, P46HTH, 
P46WHM, P46CID, P46NLF, P46XCD, P46BNO, 
P46DM1, P46DM2, P46DM3, P46DM4, P46DM5, 
P46DM6, P46DM7, P46DM8, P46DM9, P46DM0, 
P46DMA, P46DMB, P46DMC, P46DME, P46DMF,
P46DMG, P46DMH, P46DMI, P46DMJ, P46DMK, 
P46DML, P46DMM, P46DMN, P46DMO, P46DMP, 
P46DMQ,  P46DMR, P46DMS, P46NAT, 
WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy ,       :as_gu ,        B.MEMBER_NO,       
		B.NAME, /*한글명칭:*/
		B.JUMIN_NO, /*주민등록번호:*/
	    MAX((SELECT HOME_POSTNO FROM INDB.HIN011M WHERE MEMBER_NO = B.MEMBER_NO)) AS HOME_POSTNO,   /*우편번호:*/
        MAX((SELECT HOME_ADDR1 FROM INDB.HIN011M WHERE MEMBER_NO = B.MEMBER_NO))    AS HOME_ADDR1,   /* 우편주소:*/
        MAX((SELECT HOME_ADDR2 FROM INDB.HIN011M WHERE MEMBER_NO = B.MEMBER_NO))    AS HOME_ADDR2,  /*상세주소:*/
       P.PAY
                    -   P.NONTAX1
                    -    P.NONTAX2                          AS P41PTL  ,      /*급여총액:*/
       P.BONUS  AS P41BTL,   /*상여총액:*/
          NVL(C.P42ATL, 0) AS P46ATL,    /*인정상여: */
             0 AS P46PPL,    /*최종월정급여:*/ 
             NVL(C.P42FWK,0)   AS P42FWK , /*국외근로공제액:*/ 
             NVL(C.P42RND, 0) +  P.NONTAX2  AS P42RND, /*연구활동비과세:*/
             NVL(C.P42NGT, 0) AS P46NGT, /*    야간근로수당:*/
             NVL(C.P42BON, 0) AS P46BFM,    /*출산보육수당:*/
        (CASE WHEN NVL(B.IS_ALIEN, 'N') = 'N' THEN 0 ELSE  (P.PAY
                    -    P.NONTAX1
                    -    P.NONTAX2
                     + P.BONUS
             +  NVL(C.TAX_AMT, 0)) *  0.3  END)          
         AS P46FFM, /*     외국인근로자 */
            P.NONTAX1
                             +  NVL(C.P42GFM, 0) AS P46GFM,     /*기타비과세: */
            NVL(C.P42FWK, 0) +  (CASE WHEN NVL(B.IS_ALIEN, 'N') = 'N' THEN 0 ELSE  ( P.PAY
                    -    P.NONTAX1
                    -    P.NONTAX2
                     + P.BONUS
             +  NVL(C.TAX_AMT, 0)) *  0.3  END)     
                                       + C.P42RND + P.NONTAX2
                        + NVL(C.P42NGT, 0) + NVL(C.P42BON, 0) + P.NONTAX1
                          + NVL(C.P42GFM, 0)                                                AS P46TFM,    /*비과세합계:   */
           ( P.PAY
                    -   P.NONTAX1
                    -    P.NONTAX2
                     + P.BONUS
             +  NVL(C.TAX_AMT, 0)) * (CASE WHEN NVL(B.IS_ALIEN, 'N') = 'N' THEN 1 ELSE 0.7 END)  AS P46ICW,    /*근로소득수입금액: */
            0   AS P41SBW, /*근로소득공제:*/
             0   AS P41ICS,  /*근로소득금액:*/
             SUM(CASE WHEN A.P41DGB = '1101' THEN A.P41DEM ELSE 0 END) AS P41SFS , /*본인공제:*/
             (CASE WHEN SUM((CASE WHEN A.P41DGB = '1102' THEN  A.P41PCN ELSE 0 END)) = 1 THEN 'Y' ELSE 'N' END) AS P46SPD, /*배우자유무:*/
             SUM(CASE WHEN A.P41DGB = '1102' THEN A.P41DEM ELSE 0 END) AS P41SPS, /*배우자공제:*/
             0 AS P46CPD,    /*20세미만부양: */
             SUM(CASE WHEN A.P41DGB =  '1103' THEN  A.P41PCN ELSE 0 END) AS P46OPD, /*60세이상부양-부양가족:*/
             SUM(CASE WHEN A.P41DGB = '1103' THEN A.P41DEM ELSE 0 END) AS P41STS, /*부양가족공제:*/
             SUM(CASE WHEN A.P41DGB = '1201' THEN A.P41DEM ELSE (CASE WHEN A.P41DGB = '1202' THEN A.P41DEM ELSE 0 END) END) AS P41ODS, /*경로우대공제:*/
             SUM(CASE WHEN A.P41DGB = '1203' THEN A.P41DEM ELSE 0 END) AS P41EPS,/*장애자공제:*/
              SUM(CASE WHEN A.P41DGB = '1205' THEN A.P41DEM ELSE 0 END) AS P41VNS, /*부녀자세대주공제:*/
              SUM(CASE WHEN A.P41DGB = '1204' THEN A.P41DEM ELSE 0 END) AS P41SUS, /*자녀양육비공제:*/
                0   AS P41BTS,  /*소수공제자추가공제:*/
                 SUM(CASE WHEN A.P41DGB = '2102' THEN A.P41DEM ELSE 0 END)  AS P41PEN, /*기타연금보험료공제:*/
                 SUM(CASE WHEN A.P41DGB = '4103' THEN A.P41DEM ELSE 0 END) AS P46DMD, /*퇴직연금:    */
                 SUM(CASE WHEN A.P41DGB IN ('3101','3102') THEN A.P41SAM ELSE 0 END) AS P46IPR,/*기납의료고용보험계:*/
                SUM(CASE WHEN A.P41DGB IN ('3103','3104') THEN A.P41SAM ELSE 0 END) AS P46ISU, /*외부보험료총액:*/
                 MAX((SELECT SUM(NVL(P44PTL, 0)) 
                        FROM  PADB.HPAP44T A
                        WHERE P44YAR = :as_std_yy AND P44NNO = B.MEMBER_NO))  AS P46CMD, /*의료비총액:*/
            SUM(CASE WHEN A.P41DGB IN ('3301','3302','3303','3304','3305') THEN A.P41SAM ELSE 0 END) AS P46EDM ,     /*교육비총액:*/
            SUM(CASE WHEN A.P41DGB IN ('3402','3404','3405', '3407') THEN A.P41SAM ELSE 0 END) AS P46HND ,     /*주택자금총액:*/     
            MAX((SELECT SUM(NVL(P45PTL, 0))
                    FROM  PADB.HPAP45T A
                    WHERE P45YAR = :as_std_yy AND P45NNO = B.MEMBER_NO))  AS P46DND ,         /*기부금총액:*/ 
              SUM(CASE WHEN A.P41DGB IN ('3101','3102','3103','3104') THEN A.P41DEM ELSE 0 END) AS P46SIS,/*보험료공제:*/
              SUM(CASE WHEN A.P41DGB IN ('3201','3202') THEN A.P41DEM ELSE 0 END)  AS P46SCM, /*의료비공제:*/
              SUM(CASE WHEN A.P41DGB IN ('3301','3302','3303','3304','3305') THEN A.P41DEM ELSE 0 END) AS P46SED, /*교육비공제:*/
            SUM(CASE WHEN A.P41DGB = '3401' THEN A.P41DEM ELSE 0 END) AS P46SHN, /*주택마련저축소득공제:*/
            SUM(CASE WHEN A.P41DGB IN ('3501','3502','3503', '3504', '3505', '3506') THEN A.P41DEM ELSE 0 END)  AS P46SDN, /*기부금공제:*/
            0 AS P46WSS, /*계(또는표준공제):*/
            0 AS P46WSI, /*차감소득금액:*/
             SUM(CASE WHEN A.P41DGB = '4101' THEN A.P41SAM ELSE 0 END) AS P46STK, /*개인연금총액:*/
             SUM(CASE WHEN A.P41DGB = '4201' THEN A.P41SAM ELSE 0 END) AS P46INV, /*투자조합총액:*/
             SUM(CASE WHEN A.P41DGB = '4301' THEN A.P41SAM ELSE 0 END) AS P46CTT, /*신용카드총액:*/
            SUM(CASE WHEN A.P41DGB = '4101' THEN A.P41DEM ELSE 0 END)  AS P46SST    , /*개인연금저축공제-2000년이전가입:*/
             SUM(CASE WHEN A.P41DCD = '4200' THEN A.P41DEM ELSE 0 END) AS P46INS, /*투자조합공제:*/
            SUM(CASE WHEN A.P41DGB = '4301' THEN A.P41DEM ELSE 0 END)  AS P46CRD, /*신용카드공제:*/
            0 AS P46TSD, /*과세표준:*/
            0 AS P46CTA, /*산출세액:*/
            0 AS P46SAV, /*재형저축총액:*/
            0 AS P46SAG    , /*재형기금총액:*/
            SUM(CASE WHEN A.P41DGB = '4502' THEN A.P41SAM ELSE 0 END)  AS P46SKO, /*주택자금이자세총액:*/
            0 AS P46OSK, /*주식저축총액:*/
            0 AS P46DXW, /*근로소득세액공제:*/
            0 AS P46TSA, /*재형저축세액공제:*/
            SUM(CASE WHEN A.P41DGB = '4502' THEN A.P41DEM ELSE 0 END) AS P46TSK, /*주택차입금공제:*/
            0 AS P46TOS, /*주식저축세액공제:*/
            SUM(CASE WHEN A.P41DGB = '4507' THEN A.P41DEM ELSE 0 END) P46TFE    , /*외국납부세액공제:*/
            0 AS P46TFD, /*재형기금차감액:*/
            0 AS P46TYX, /*세액공제계:*/
            0 AS P46TXP    , /*결정소득세:*/
            0 AS P46RTR    , /*결정주민세:*/
            0 AS P46FTR    , /*결정농특세:*/
            C.P42TXR AS P46JTX    ,  /*전근무소득세징수액:*/
            C.P42RTR AS P46JRT    , /*전근무주민세징수액:*/
            C.P42FTR AS P46JFT    , /*전근무농특세징수액:*/
           P.TAX1 AS P46HTX, /*현근무소득세징수액:*/
            P.TAX2  AS P46HRT, /*현근무주민세징수액:*/
            0 AS P46HFT, /*현근무농특세징수액:*/
            0 AS P46CTX    , /*차감소득세:*/
            0 AS P46CRT    , /*차감주민세:*/
            0 AS P46CFT    , /*차감농특세:*/
            B.GWA    AS P46DCD, /*부서코드:*/
            ''    AS P46CMP, /*회사구분*/
            B.JIKWI_CODE     AS P46FGP, /*직군:*/
            B.JIKMU_CODE    AS P46FUN, /*직능:*/
            B.DUTY_CODE    AS P46GRD, /*직급:*/
            SUM(CASE WHEN A.P41DGB = '1202' THEN A.P41PCN ELSE 0 END)  AS P46OAG, /*65세이상경로:*/
             SUM(CASE WHEN A.P41DGB = '1203' THEN A.P41PCN ELSE 0 END)  AS P46HTH, /*장애자부양:*/
             (CASE WHEN SUM(CASE WHEN A.P41DGB = '1205' THEN A.P41PCN ELSE 0 END) = 1 THEN 'Y'  ELSE 'N' END)  AS P46WHM    , /*부녀자세대주유무:*/
            SUM(CASE WHEN A.P41DGB = '1204' THEN A.P41PCN ELSE 0 END) AS P46CID    , /*자녀양육인원:*/
            (CASE WHEN NVL(B.IS_ALIEN, 'N') = 'Y' THEN '9' ELSE '1' END)  AS P46NLF, /*내외국인구분 */
            ''    AS P46XCD    , /*사업자등록번호 1~3: */
            ''  AS P46BNO    ,/*사업자등록번호: */
            0 AS P46DM1,    /*주택이자상환액-거치기간10년: */
             SUM(CASE WHEN A.P41DGB = '4102' THEN A.P41DEM ELSE 0 END) AS P46DM2, /*    연금저축-2001년이후가입: */
            0 AS P46DM3,    /*장기저축-당해년도:*/
            0 AS P46DM4,    /*장기저축-전년도:*/
            0 AS P46DM5,    /*장기증권저축세액공제:*/
            0 AS P46DM6,    /*직불카드총액:*/
             SUM(CASE WHEN A.P41DGB = '1201' THEN A.P41PCN ELSE 0 END) AS P46DM7,    /*70세이상경로: */
            0 AS P46DM8    ,
            SUM(CASE WHEN A.P41DGB = '3201' THEN A.P41DEM ELSE 0 END) AS P46DM9,    /*본인의료비:*/
            SUM(CASE WHEN A.P41DGB = '3601' THEN A.P41DEM ELSE 0 END) AS P46DM0,    /*혼인이사장례:*/
            0 AS P46DMA,    /*주택이자상환액-거치기간15년: */
            SUM(CASE WHEN A.P41DGB = '4501' THEN A.P41DEM ELSE 0 END) AS P46DMB,    /*기부정치자금:*/
            0 AS P46DMC,     /*현금영수증: */
            0 AS P46DME,     /*신용카드의료기관사용내역: */
            0 AS P46DMF,    /*타인신용카드의료기관사용액:*/
            0    AS P46DMG,     /*의료비미공제액:*/
            SUM(CASE WHEN A.P41DGB = '1206' THEN A.P41PCN ELSE (CASE WHEN A.P41DGB = '1207' THEN A.P41PCN ELSE 0 END) END) AS  P46DMH, /*    다자녀인원수:*/
            SUM(CASE WHEN A.P41DGB = '1206' THEN A.P41DEM ELSE (CASE WHEN A.P41DGB = '1207' THEN A.P41DEM ELSE 0 END) END) AS P46DMI,    /*다자녀추가공제:*/
            SUM(CASE WHEN A.P41DGB = '4601' THEN A.P41DEM ELSE 0 END) AS P46DMJ,    /*소기업소상공인공제부금소득공제: */
            SUM(CASE WHEN A.P41DGB = '4505' THEN A.P41DEM ELSE 0 END) AS P46DMK,    /*납세조합공제:*/
            SUM(CASE WHEN A.P41DGB = '1208' THEN A.P41PCN ELSE 0 END) AS P46DML,    /*출산입양인원수:*/
            SUM(CASE WHEN A.P41DGB = '1208' THEN A.P41DEM ELSE 0 END)  AS P46DMM,     /*출산입양공제:*/
            SUM(CASE WHEN A.P41DGB = '2101' THEN A.P41DEM ELSE 0 END)  AS P46DMN,    /*국민연금보험료공제: */
            SUM(CASE WHEN A.P41DGB = '3402' THEN A.P41DEM ELSE 0 END)  AS P46DMO,    /*주택임차차입금원리금상환액: */
            SUM(CASE WHEN A.P41DGB IN ('3404', '3405', '3407') THEN A.P41DEM ELSE 0 END)  AS P46DMP,    /*장기주택저당차입금이자상환액:*/
            SUM(CASE WHEN A.P41DGB = '3102' THEN A.P41DEM ELSE 0 END)  AS P46DMQ,    /*연간고용보험료:*/
            SUM(CASE WHEN A.P41DGB = '3101' THEN A.P41DEM ELSE 0 END) AS P46DMR,    /*연간의료보험료:*/
            SUM(CASE WHEN A.P41DGB IN ('4701','4702','4703') THEN A.P41DEM ELSE 0 END)  AS P46DMS, /*펀드소득공제 */
            MAX((SELECT ETC_CD1    FROM CDDB.KCH102D 
                    WHERE UPPER(CODE_GB) = 'KUKJUK_CODE'   
                    AND         CODE = to_char(B.NATION_CODE))) AS P46NAT,  /*국적*/             
            :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate    
FROM PADB.HPAP41D A, INDB.HIN001M B,
 (                    
SELECT P42NNO AS MEMBER_NO, SUM(NVL(P42PTL, 0)  + NVL(P42BTL,0) + NVL(P42ATL, 0)) AS TAX_AMT,
       SUM(NVL(P42NGT, 0) ) AS P42NGT,
       SUM( NVL(P42GFM, 0)) AS P42GFM,
       SUM( NVL(P42RND, 0)) AS P42RND,
       SUM( NVL(P42FWK, 0)) AS P42FWK,
       SUM( NVL(P42BON, 0)) AS P42BON,
       SUM(NVL(P42TXR, 0))  AS P42TXR,
       SUM(NVL(P42RTR, 0)) AS P42RTR,
       SUM(NVL(P42FTR, 0))  AS P42FTR,
       SUM(NVL(P42ATL, 0))  AS P42ATL
    FROM   PADB.HPAP42T 
WHERE P42YAR = :as_std_yy 
                    GROUP BY P42NNO 
) C,
  (SELECT MEMBER_NO, SUM(PAY) AS PAY, SUM(BONUS) AS BONUS, SUM(NONTAX1) AS NONTAX1, SUM(NONTAX2) AS NONTAX2,
  SUM(TAX1) AS TAX1, SUM(TAX2) AS TAX2 FROM PADB.PAY_VIEW
    	WHERE MEMBER_NO LIKE :AS_EMP_NO 
	    AND YEAR_MONTH BETWEEN :LS_FR_MM AND :LS_TO_MM
	    GROUP BY MEMBER_NO) P
WHERE A.P41NNO = B.MEMBER_NO 
AND   A.P41NNO = C.MEMBER_NO(+)
AND A.P41NNO = P.MEMBER_NO
AND   A.P41YAR = :as_std_yy     
AND   A.P41AJG = :as_gu
AND   B.MEMBER_NO LIKE :as_emp_no
AND P.PAY + P.BONUS > 0 
AND   SUBSTR(B.DUTY_CODE, 1, 1) LIKE :as_dept_cd
 AND ( (:as_gu = 'J' AND ((NVL(B.HAKWONHIRE_DATE, :as_std_yy || '0101') <= :as_std_yy  || '1231' 
AND B.JAEJIK_OPT <> 3) Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy || '1231' )
Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101'  )) )
 OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))    
GROUP BY B.MEMBER_NO, B.GWA, B.NAME, B.JUMIN_NO,  B.JIKWI_CODE, NVL(B.IS_ALIEN, 'N'),
                B.JIKMU_CODE, B.DUTY_CODE, C.TAX_AMT,
    C.P42NGT,         C.P42GFM, C.P42RND, C.P42FWK, C.P42BON, C.P42TXR, C.P42RTR, C.P42FTR, C.P42ATL, P.PAY, P.BONUS, P.NONTAX1, P.NONTAX2,
    P.TAX1, P.TAX2
USING SQLCA;


If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산내역(PADB.HPAP46T) INSERT 에러!~r" + ls_err)

	Setpointer(Arrow!)
	RETURN 0
End If

//근로자소득공제/과세대상근로소득금액
 UPDATE PADB.HPAP46T B
 SET (P46SBW, P46ICS)
 = 
 ( 
 SELECT (CASE WHEN A.P46ICW <= 5000000 THEN TRUNC(A.P46ICW * A.P48RTE * 0.01, 0) ELSE TRUNC(A.P48AM1 + (A.P46ICW - A.P48AM2) * A.P48RTE * 0.01 , 0) END)
			 ,
			 (CASE WHEN A.P46ICW <= 5000000 THEN A.P46ICW - TRUNC(A.P46ICW * A.P48RTE * 0.01, 0)  ELSE A.P46ICW -  TRUNC(A.P48AM1 + (A.P46ICW - A.P48AM2) * A.P48RTE * 0.01, 0) END)		
FROM (
SELECT A.P46YAR, A.P46GBN, A.P46NNO,
       A.P46ICW,
       NVL((SELECT P48AM1 
       FROM PADB.HPAP48M
       WHERE P48YAR = :as_std_yy
       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE  P48YAR = :as_std_yy AND P48ATU >= A.P46ICW   ) ), 0) AS P48AM1,
     NVL((SELECT P48AM2
       FROM PADB.HPAP48M
       WHERE P48YAR = :as_std_yy 
       AND  P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE P48YAR = :as_std_yy AND P48ATU >= A.P46ICW )),0) AS P48AM2,
     NVL((SELECT P48RTE 
       FROM PADB.HPAP48M
       WHERE P48YAR = :as_std_yy
       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE P48YAR = :as_std_yy AND  P48ATU >= A.P46ICW )),0)     AS P48RTE
FROM PADB.HPAP46T A
WHERE	A.P46YAR = :as_std_yy
AND A.P46GBN =  :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
	) A
WHERE A.P46YAR = B.P46YAR
AND A.P46GBN = B.P46GBN
AND A.P46NNO = B.P46NNO )
WHERE	B.P46YAR = :as_std_yy
AND B.P46GBN =  :as_gu
AND B.P46NNO LIKE :as_emp_no
AND SUBSTR(B.P46GRD, 1 , 1) LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산내역(PADB.HPAP46T) 세액계산 UPDATE 에러!~r" + ls_Err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

//특별공제계(또는표준공제), 차감소득금액,  종합소득과세표준, 세액공제계
UPDATE PADB.HPAP46T A
   SET   
       A.P46WSS  =    NVL(A.P46SIS, 0) +   /*보험료공제 */
					 NVL(A.P46SCM, 0) +    /*의료비공제:*/
					 NVL(A.P46SED, 0) +    /*교육비공제 */
					 NVL(A.P46DMO, 0) + /*주택임차차입금원리금상환액: */
					 NVL(A.P46DMP, 0) +  /*장기주택저당차입금이자상환액:*/
					 NVL(A.P46SDN, 0)  + /*기부금공제:*/
					 NVL(A.P46DM0, 0)	 ,
       A.P46WSI =  NVL(A.P46ICS,0) - 
       (NVL(A.P46SFS, 0) +
       NVL(A.P46SPS, 0) +
       NVL(A.P46ODS, 0) +
       NVL(A.P46EPS, 0) +
       NVL(A.P46STS, 0) +
       NVL(A.P46VNS, 0) +         
       NVL(A.P46SUS, 0) +
		  NVL(A.P46DMM, 0) +
       NVL(A.P46DMI, 0) +
       NVL(A.P46DMN, 0) +
		 NVL(A.P46PEN, 0) +
		 NVL(A.P46DMD, 0) +
	   (CASE WHEN (NVL(A.P46SIS, 0) +   /*보험료공제 */
			 NVL(A.P46SCM, 0) +    /*의료비공제:*/
			 NVL(A.P46SED, 0) +    /*교육비공제 */
			 NVL(A.P46DMO, 0) + /*주택임차차입금원리금상환액: */
			 NVL(A.P46DMP, 0) +  /*장기주택저당차입금이자상환액:*/
			 NVL(A.P46SDN, 0)  + /*기부금공제:*/
			 NVL(A.P46DM0, 0)   /*혼인이사장례:*/ ) < 1000000 THEN 1000000 ELSE 
		 (NVL(A.P46SIS, 0) +   /*보험료공제 */
		 NVL(A.P46SCM, 0) +    /*의료비공제:*/
		 NVL(A.P46SED, 0) +    /*교육비공제 */
		 NVL(A.P46DMO, 0) + /*주택임차차입금원리금상환액: */
		 NVL(A.P46DMP, 0) +  /*장기주택저당차입금이자상환액:*/
		 NVL(A.P46SDN, 0)  + /*기부금공제:*/
		 NVL(A.P46DM0, 0) /*혼인이사장례:*/)   END)) ,
       A.P46TSD =  NVL(A.P46ICS,0) - 
						 (NVL(A.P46SFS, 0) +
						 NVL(A.P46SPS, 0) +
						 NVL(A.P46ODS, 0) +
						 NVL(A.P46EPS, 0) +
						 NVL(A.P46STS, 0) +
						 NVL(A.P46VNS, 0) +         
						 NVL(A.P46SUS, 0) +
						  NVL(A.P46DMM, 0) +
						 NVL(A.P46DMI, 0) +
						 NVL(A.P46DMN, 0) +
						 NVL(A.P46PEN, 0) +
						 NVL(A.P46DMD, 0) +
						(CASE WHEN (NVL(A.P46SIS, 0) +   /*보험료공제 */
							 NVL(A.P46SCM, 0) +    /*의료비공제:*/
							 NVL(A.P46SED, 0) +    /*교육비공제 */
							 NVL(A.P46DMO, 0) + /*주택임차차입금원리금상환액: */
							 NVL(A.P46DMP, 0) +  /*장기주택저당차입금이자상환액:*/
							 NVL(A.P46SDN, 0)  + /*기부금공제:*/
							 NVL(A.P46DM0, 0) /*혼인이사장례:*/) < 1000000 THEN 1000000 ELSE 
						 (NVL(A.P46SIS, 0) +   /*보험료공제 */
						 NVL(A.P46SCM, 0) +    /*의료비공제:*/
						 NVL(A.P46SED, 0) +    /*교육비공제 */
						 NVL(A.P46DMO, 0) + /*주택임차차입금원리금상환액: */
						 NVL(A.P46DMP, 0) +  /*장기주택저당차입금이자상환액:*/
						 NVL(A.P46SDN, 0)  + /*기부금공제:*/
						 NVL(A.P46DM0, 0) /*혼인이사장례:*/)   END) +
       NVL(A.P46SST, 0) +
       NVL(A.P46DM2, 0) +
		  NVL(A.P46DMJ, 0) +
		    NVL(A.P46SHN, 0) +
       NVL(A.P46INS, 0) +
       NVL(A.P46CRD, 0) +
	  NVL(A.P46DMS, 0)	 )  	   
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
USING SQLCA;


If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 차감소득금액 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If



//
//세액계산 :  산출세액 UPDATE
UPDATE PADB.HPAP46T A
SET P46CTA = (SELECT TRUNC(A.P46TSD    * TAX_RATE * 0.01 - TAX_SUM_AMT, 0)  
					FROM PADB.HPA013M
					WHERE   TAX_YEAR = :as_std_yy 
					AND   TAX_FROM_DATE = (SELECT MIN(TAX_FROM_DATE) 
								FROM PADB.HPA013M 
								WHERE TAX_YEAR = :as_std_yy 
								  AND TAX_TO_DATE >= A.P46TSD))
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 산출세액 UPDATE 에러!~r" + ls_err)
//	gf_closewait()
Setpointer(Arrow!)
	RETURN 0
End If

//세액계산 :  근로소득세액공제 UPDATE
UPDATE PADB.HPAP46T A
SET P46DXW =    (CASE WHEN NVL(A.P46CTA, 0) > 500000 THEN 
							(CASE WHEN TRUNC(((A.P46CTA - 500000) * 0.3 + 275000), 0) > 500000 THEN 500000
								ELSE TRUNC(((A.P46CTA - 500000) * 0.3 + 275000), 0) END)
				    ELSE TRUNC((A.P46CTA * 0.55) , 0) END) 
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 근로소득세액공제 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

// 세액공제계
UPDATE PADB.HPAP46T A
SET P46TYX =    NVL(P46DXW,0) 
                                                  + NVL(P46DMK, 0) + NVL(P46TSK,0)  
								              + NVL(P46DMB,0) + NVL(P46TFE,0) 
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제계 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


//소득세
UPDATE PADB.HPAP46T A
SET P46TXP =   NVL(P46CTA, 0) - NVL(P46TYX, 0)																					
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 소득세 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


//주민세
UPDATE PADB.HPAP46T A
SET P46RTR = TRUNC(NVL(P46TXP, 0) * 0.1,0)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 주민세 UPDATE 에러!~r" + ls_Err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If
//
//차감소득금액이 0보다 작거나 같으면 이하 0update
UPDATE PADB.HPAP46T A
SET P46WSI = 0,
P46SST	 =0,
P46DM2 = 0,
P46DMJ = 0,
P46SHN = 0,
P46INS = 0,
P46CRD = 0,
P46DMS = 0,
P46TSD	 = 0, 
P46CTA = 0,
P46DXW = 0,
P46DMK = 0, 
P46TSK = 0,
P46DMB = 0, 
P46TFE = 0,
P46TYX = 0,
P46TXP = 0,
P46RTR =0, 
P46FTR = 0
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46WSI, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 차감소득금액 0  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

//종합소득과세표준 0보다 작거나 같으면 이하 0update

UPDATE PADB.HPAP46T A
SET P46SST	 =  (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) <= 0 THEN NVL(P46WSI,0)
													ELSE  NVL(P46SST,0)  END) 
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(개인연금저축)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

UPDATE PADB.HPAP46T A
SET P46DM2 = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) <= 0 THEN NVL(P46WSI,0) - NVL(P46SST,0)
									   ELSE  NVL(P46DM2,0) END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(연금저축)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


UPDATE PADB.HPAP46T A
SET P46DMJ = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) <= 0 THEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0)
									  ELSE  NVL(P46DMJ,0) END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(소기업소상공인)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


UPDATE PADB.HPAP46T A
SET P46SHN = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) <= 0 THEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0)
									   ELSE   NVL(P46SHN, 0) END)  
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(주택마련저축)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

UPDATE PADB.HPAP46T A
SET P46INS = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0)  - NVL(P46INS,0) <= 0 THEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) 
									   ELSE  NVL(P46INS,0) END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(투자조합출자)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If
							
							
UPDATE PADB.HPAP46T A
SET P46CRD = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) - NVL(P46INS,0) - NVL(P46CRD,0) <= 0 THEN 
                      NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) - NVL(P46INS,0)
									    ELSE   NVL(P46CRD,0)  END)  
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(신용카드)  UPDATE 에러!~r" + ls_Err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

UPDATE PADB.HPAP46T A
SET P46DMS = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) - NVL(P46INS,0) - NVL(P46CRD,0)  - NVL(P46DMS, 0) <= 0 THEN 
                     NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) - NVL(P46INS,0) - NVL(P46CRD,0) 
									    ELSE NVL(P46DMS,0) 
									 END) 
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(장기주식형저축소득공제)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

 



UPDATE PADB.HPAP46T A
SET 
P46TSD	 = 0, 
P46CTA = 0,
P46DXW = 0,
P46DMK = 0, 
P46TSK = 0,
P46DMB = 0, 
P46TFE = 0,
P46TYX = 0,
P46TXP = 0,
P46RTR =0, 
P46FTR = 0
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


// 결정세액 0보다 작거나 같으면 이하 0update

UPDATE PADB.HPAP46T A
SET P46DXW	 =  (CASE WHEN NVL(P46CTA, 0)  - NVL(P46DXW,0) <= 0 THEN NVL(P46CTA, 0)										     
											ELSE  NVL(P46DXW,0)  END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0 (근로소득세액공제) UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

UPDATE PADB.HPAP46T A
SET P46DMK	 =  (CASE WHEN NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0) <= 0 THEN  NVL(P46CTA, 0)  - NVL(P46DXW,0)								     
											ELSE  NVL(P46DMK,0)  END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0 (납세조합공제) UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


UPDATE PADB.HPAP46T A
SET P46TSK	 =  (CASE WHEN NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0)  - NVL(P46TSK,0) <= 0 THEN 
					 NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0)
											ELSE  NVL(P46TSK,0)  END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0 (주택차입금공제) UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


UPDATE PADB.HPAP46T A
SET P46DMB	 =  (CASE WHEN NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0)  - NVL(P46TSK,0)   - NVL(P46DMB,0) <= 0 THEN 
					 NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0) - NVL(P46TSK,0) 
											ELSE  NVL(P46DMB,0)  END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0 (기부정치자금) UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

UPDATE PADB.HPAP46T A
SET P46TFE	 =  (CASE WHEN NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0)  - NVL(P46TSK,0)   - NVL(P46DMB,0)     - NVL(P46TFE,0) <= 0 THEN 
					 NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0) - NVL(P46TSK,0)  - NVL(P46DMB,0)
											ELSE  NVL(P46TFE,0)  END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0 (최국납부세액공제) UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


UPDATE PADB.HPAP46T A
SET 
P46TXP = 0,
P46RTR =0, 
P46FTR = 0
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0  UPDATE 에러!~r" + ls_Err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

// 결정세액 0보다 작거나 같으면 이하 0update
// 세액공제계 = 근로소득세액공제 + 납세조합공제 + 주택차입금 + 기부정치자금 + 외국납부
UPDATE PADB.HPAP46T A
SET  P46TYX = NVL(P46DXW, 0) + NVL(P46DMK, 0) + NVL(P46TSK, 0) +
											 NVL(P46DMB, 0) + NVL(P46TFE,0)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제계 0  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


//농특세 :  주택자금 차입금이자세액공제 또는 투자조합출자 소득공제가 있을 경우
UPDATE PADB.HPAP46T A
SET P46FTR = (CASE WHEN NVL(P46TSK, 0) > 0 THEN P46TSK * 0.2 ELSE 0 END) +
					(CASE WHEN NVL(P46INS, 0) > 0 THEN 			
							(((SELECT TRUNC((A.P46TSD + A.P46INS )  -  ROUND((A.P46TSD + A.P46INS )   * TAX_RATE * 0.01 - TAX_SUM_AMT, 0), 0)  FROM PADB.HPA013M
							WHERE  TAX_YEAR = :as_std_yy 
							  AND TAX_FROM_DATE = (SELECT MIN(TAX_FROM_DATE) FROM PADB.HPA013M WHERE   
                                          TAX_YEAR = :as_std_yy  AND TAX_TO_DATE >= (A.P46TSD + A.P46INS))) - A.P46CTA) * 0.2)
                    ELSE 0 END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
AND P46TSK > 0 OR P46INS > 0				 
USING SQLCA;


If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 농특세   UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If





//차감징수세액(소득세)
UPDATE PADB.HPAP46T A
SET P46CTX = TRUNC((NVL(P46TXP, 0))/10 , 0) * 10 - NVL(P46JTX, 0) - NVL(P46HTX, 0),
      P46CRT = TRUNC((NVL(P46RTR, 0))/10 , 0) * 10 - NVL(P46JRT, 0) -  NVL(P46HRT, 0),
	P46CFT = TRUNC((NVL(P46FTR, 0))/10 , 0) * 10 - NVL(P46JFT, 0) - NVL(P46HFT, 0)	
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 차감징수세액 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


//UPDATE PADB.HPAP46T A
//SET	 P46BFM = NVL((SELECT SUM(NVL(P02P37, 0)) FROM PADB.TP02PYA0  WHERE SUBSTR(P02RDT, 1, 4) = A.P46YAR AND P02NNO = A.P46NNO), 0)
//WHERE   A.P46YAR = :as_std_yy
//AND A.P46GBN = :as_gu
//AND A.P46NNO LIKE :as_emp_no
//AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
//
//USING SQLCA;			
//
//If SQLCA.SQLCODE <> 0 Then
//	ls_err = SQLCA.SQLERRTEXT
//	ROLLBACK USING SQLCA;
//	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 출산축의금 UPDATE 에러!~r" + ls_err)
//	//gf_closewait()
//	Setpointer(Arrow!)
//	RETURN 0
//End If

//2009.06.02 이경진 대리 요청으로 출산축의금만 보여지게 하기 위해 비과세 주석처리
//
////UPDATE PADB.HPAP46T A
////SET	 P46GFM = NVL(P46GFM, 0) + NVL(( SELECT  SUM( NVL(P02S03, 0) + NVL(P02S04, 0)  + NVL(P02S18, 0))	
////FROM PADB.TP02PYA0 WHERE ( SUBSTR(P02RDT, 1, 6) BETWEEN A.P46YAR || '01' AND A.P46YAR || '04' ) AND P02NNO = A.P46NNO), 0)
////WHERE   A.P46YAR = :as_std_yy
////AND A.P46GBN = :as_gu
////AND A.P46NNO LIKE :as_emp_no
////AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
////USING SQLCA;			
////
////If SQLCA.SQLCODE <> 0 Then
////	ls_err = SQLCA.SQLERRTEXT
////	ROLLBACK USING SQLCA;
////	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 기타비과세 UPDATE 에러!~r" + ls_err)
////	//gf_closewait()
////	Setpointer(Arrow!)
////	RETURN 0
////End If


UPDATE PADB.HPAP46T A
SET	 P46TFM = NVL(P46FFM, 0) + NVL(P46FEG,0) +  NVL(P46RND,0) + NVL( P46NGT,0) + NVL( P46BFM, 0) + NVL(P46GFM, 0)
WHERE   A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND SUBSTR(A.P46GRD, 1 , 1) LIKE :as_dept_cd
USING SQLCA;			

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 비과세총액 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If



//gf_closewait()
Setpointer(Arrow!)

RETURN 1

end function

public function string of_year_strchg (string as_str, string as_type, long as_len);/*연말정산 파일용 레이아웃 적용
as_str : 데이터
as_type : 자료형태
as_len : 길이
*/

String ls_return, ls_format
Long ll_len, ll_i

ll_len = len(trim(as_str))
as_str = trim(as_str)

If as_type = 'X' Then //문자형

FOR ll_i = 1 TO LEN(as_str)
	If ASC(Mid(as_str, ll_i, 1)) > 127 Then
		
		ll_len = ll_len + lenA(Mid(as_str, ll_i, 1)) - 1 //한글일 경우 길이를 + 1 한다.
	End If
NEXT

If ll_len > as_len Then 	as_str = mida(as_str,1, as_len)
ll_len = LenA(as_str)
ls_return = trim(as_str) + space(as_len - ll_len ) 

	
Else  //숫자형 9
	If trim(as_str) = '' Or isnull(trim(as_str)) Then as_str = '0'
	If ll_len > as_len Then 	as_str = left(trim(as_str), as_len)
	

		For ll_i  = 1 To as_len
			ls_format = ls_format + '0' 
		Next
		
		ls_return = String(dec(trim(as_str)), ls_format)

End If

RETURN ls_return


end function

public function integer of_year_file (string as_gu, string as_year, string as_jdt, string as_file);/*
as_gu :캡스/캡스텍 1 : 2
as_year : 정산년도
as_jdt : 정산일자

*/

//사업자등록번호, 대표자명
String ls_saupno, ls_saupnm, ls_daepyo, ls_bupinno
String ls_tax, ls_dnm, ls_knm, ls_tel, ls_fax, ls_htx, ls_wkg


SELECT BUSINESS_NO,  /*사업자번호 */
		CAMPUS_NAME,  /*상호 */
		PRESIDENT, /*대표자*/
		CORP_NO, /*법인등록번호*/
	TAX_OFFICE_CODE,		/*세무서: */
TEL_PHONE,  /*	담당전화번호: */
NVL(FAX_PHONE, ' ') 	/*담당팩스번호: */
INTO :ls_saupno, : ls_saupnm, :ls_daepyo, :ls_bupinno, :ls_tax,  :ls_tel, :ls_fax
FROM CDDB.KCH000M
 USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	Messagebox("연말정산지급조서생성", "회사정보 가져오기 중 에러!")
	RETURN -1
End If


SELECT NVL(ETC_CD1, ' '), NVL(ETC_CD2, ' '), NVL(ETC_CD3, ' ')
INTO :ls_dnm, :ls_knm, :ls_htx
FROM CDDB.KCH102D
WHERE CODE_GB = 'HPA01' 
AND CODE = 'HPA01'
USING SQLCA;

If SQLCA.SQLCODE = 100 or ls_dnm = '' Or ls_knm = '' or ls_htx = '' Then
	Messagebox("알림", "공통코드 HPA01 연말정산신고담당 정보를 확인하세요!")
	RETURN -1
End if



//해당 A~E 레코드까지의 최고 항목번호를 배열에 적용한다.
//2008년 113, 2009년 120
String ls_type[5,120], ls_str[5,120]
Long ll_len[5, 120]
String ls_record[],  ls_str_recode[]
String ls_cod
Long ll_cnt, ll_i, ll_t
String ls_cd
String ls_nno //사번

String ls_pgm_name, ls_path, ls_file
Int li_rc, li_FileNum

ls_pgm_name = as_file + left(ls_saupno, 7) + "." + right(ls_saupno, 3)

	ls_path = "C:\" + ls_pgm_name 
			li_rc = GetFileSaveName ( "Select File", ls_path, ls_pgm_name, right(ls_saupno, 3),  right(ls_saupno, 3) + " (*.*), *." +  right(ls_saupno, 3), "C:\My Documents", 32770)
	
	IF li_rc = 1 Then
		IF FileExists(ls_path) THEN
			If MessageBox("확인", ls_path + "은(는) 이미 있습니다.~r~n바꾸시겠습니까?", Question!, YesNo!) = 2 Then Return -1
			FileDelete(ls_path)
		End If
		
		li_FileNum = FileOpen(ls_path, LineMode!, Write!, LockWrite!, Append!)
Choose Case as_file
	Case 'C'

ls_record[1] = 'A'
ls_record[2] = 'B'
ls_record[3] = 'C'
ls_record[4] = 'D'
ls_record[5] = 'E'

For ll_i = 1 To 5

ll_cnt = 0  //초기화

SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
INTO :ll_cnt
FROM CDDB.KCH102D 
WHERE CODE_GB = 'HPA02' 
AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
USING SQLCA;


//ll_i, ll_t

	For ll_t = 1 To ll_cnt  
		ls_cd = ls_record[ll_i] + String(ll_t, '000')
		SELECT ETC_CD1,  /*자료형태 */
			TO_NUMBER(ETC_CD2)  /*길이 */
		INTO :ls_type[ll_i, ll_t], :ll_len[ll_i, ll_t]
		FROM CDDB.KCH102D 
		WHERE CODE_GB = 'HPA02' 
		AND CODE = :ls_cd
		 USING SQLCA;
	Next
Next

//################################################
//A 레코드
//################################################

ls_str[1,1] = 'A'     //레코드구분
ls_str[1,2] = '20'   //자료구분
ls_str[1,3] = ls_tax  //세무서
ls_str[1,4] = as_jdt  //제출년월일
ls_str[1,5] = '2'    //제출자 (1:세무대리인, 2:법인 , 3:개인)
ls_str[1,6] = ''
ls_str[1,7] = ls_htx //홈텍스번호
ls_str[1,8] = '9000' //기타프로그램
ls_str[1,9] = ls_saupno //사업자등록번호
ls_str[1,10] = ls_saupnm  //상호
ls_str[1,11] = ls_dnm  //담당부서명
ls_str[1,12] = ls_knm  //담당자성명
ls_str[1,13] = ls_tel //담당전화번호

ls_str[1,14] =  '1'   //원천징수의무자수(B레코드수)
ls_str[1,15] = '101'  //한글코드종류 (국가표준)
ls_str[1,16] = ''  //공란


//################################################
//B 레코드
//################################################
ls_str[2,1] = 'B'     //레코드구분
ls_str[2,2] = '20'   //자료구분
ls_str[2,3] = ls_tax  //세무서
ls_str[2,4] = '1'     //일련번호
ls_str[2,5] = ls_saupno //사업자등록번호
ls_str[2,6] = ls_saupnm  //상호
ls_str[2,7] = ls_daepyo   //대표자성명
ls_str[2,8] = ls_bupinno  //법인번호
ls_str[2,13] = '0'  //공란
ls_str[2,17] = '1'  //제출대상기간 코드- 연간지급분
ls_str[2,18] = '' //공란


SELECT TO_CHAR(SUM(NVL(P46ICW, 0))), /*총급여총계 */
TO_CHAR(SUM(NVL(P46TXP, 0))), /*소득세결정세액총계 */
TO_CHAR(SUM(NVL(P46RTR, 0))), /*주민세결정세액총계 */
TO_CHAR(SUM(NVL(P46FTR, 0))), /*농특세결정세액총계 */
TO_CHAR(SUM(NVL(P46TXP, 0) + NVL(P46RTR, 0) + NVL(P46FTR, 0))), /*결정세액총계 */
COUNT(*),  /*주현근무처수 */
SUM((SELECT COUNT(*) FROM PADB.HPAP42T WHERE P42YAR = :as_year AND P42NNO = A.P46NNO ))
INTO :ls_str[2,11],
:ls_str[2,12],
:ls_str[2,14],
:ls_str[2,15],
:ls_str[2,16],
:ls_str[2,9],
:ls_str[2,10]
   FROM PADB.HPAP46T A
WHERE P46YAR = :as_year
USING SQLCA;				 


//A,B 레코드 filewrite
ll_cnt = 0  //초기화

For ll_i = 1 To 2
		
	SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
	INTO :ll_cnt
	FROM CDDB.KCH102D 
	WHERE CODE_GB = 'HPA02' 
	AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
	USING SQLCA;

	
	
	
	ls_str_recode[ll_i] = ''	 //초기화
	For ll_t = 1 To ll_cnt   
		ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
		ls_str_recode[ll_i] = ls_str_recode[ll_i] + ls_str[ll_i, ll_t]
	Next
	
	FileWrite(li_FileNum, ls_str_recode[ll_i])
Next

//################################################
//C 레코드
//################################################
ls_str[3,1] = 'C'     //레코드구분
ls_str[3,2] = '20'   //자료구분
ls_str[3,3] = ls_tax  //세무서
//ls_str[3,4] =  //일련번호
ls_str[3,5] = ls_saupno //사업자등록번호
//ls_str[3,6] = //종전근무처수
ls_str[3,7] = '1'   //거주자구분코드
ls_str[3,8] = ''  //거주지국코드
//ls_str[3,9] = '2' //외국인단일세율적용
ls_str[3,15] ='0' //감면기간시작연월일
ls_str[3,16] ='0' //감면기간종료연월일
ls_str[3,22] = '0'  //공란



String  ls_crow  //사번
Dec{0} ld_71, ld_72, ld_ipr

DECLARE HPAP46T CURSOR FOR 
SELECT P46NNO,
to_char(ROW_NUMBER() OVER (ORDER BY p46nno ASC)) AS ROWNUMber,/*일련번호 4 */ 
TO_CHAR((SELECT COUNT(*) FROM PADB.HPAP42T WHERE P42YAR = A.P46YAR AND P42NNO = A.P46NNO)) AS BEFCNT, /*종전 근무처수 6 */ 
 '2' AS FORTAX,  /*외국인단일세율적용 9*/
(CASE WHEN (SELECT COUNT(*) FROM PADB.HPAP42T WHERE P42YAR = A.P46YAR AND P42NNO = A.P46NNO) > 0 
             THEN :as_year  || '0101' 
              ELSE 
                  (CASE WHEN   NVL(B.HAKWONHIRE_DATE, :as_year || '0101')  <= :as_year || '0101' 
                        THEN :as_year  || '0101' 
                        ELSE B.HAKWONHIRE_DATE END)
              END),  /*귀속년도시작년월일 10*/
  (CASE WHEN (CASE WHEN NVL(TRIM(B.RETIRE_DATE), '29991231') = '' THEN '29991231'
                        ELSE NVL(TRIM(B.RETIRE_DATE), '29991231') END)  < :as_year  || '1231'  
              THEN (CASE WHEN B.RETIRE_DATE <  :as_year  || '0101'  THEN :as_year  || '1231'    ELSE B.RETIRE_DATE END)
              ELSE  :as_year  || '1231'   
              END), /*귀속년도종료년월일 11*/                         
      A.P46KNM, /*성명 12*/ 
      A.P46NLF,  /*내외국인 구분코드 13*/
      A.P46RNO, /*주민등록번호 14*/  
 TO_CHAR(NVL(P46PTL, 0)), /*급여총액   17:*/
 TO_CHAR(NVL(P46BTL, 0)), /*상여총액   18 :*/
 '0', /*인정상여   19:*/
 '0'   ,   /* 주식매주 선택권 행사이익   20 */
 '0'   ,   /* 우리사주조합인출금   21 */
 TO_CHAR(NVL(P46PTL, 0) + NVL(P46BTL, 0) ) AS HSUM , /*주현급여총액 23 */
 '0' , /*비과세학자금 24 */
 '0' , /*무보수위원수당 25 */
 '0' , /*경호,승선수당 26 */
 '0' , /*유아,초중등  27 */
 '0' , /*고등교육법 28 */
 '0' , /*특별법 29 */
 TO_CHAR(P46RND - NVL((SELECT SUM(NVL(P42RND, 0)) FROM PADB.HPAP42T WHERE P42YAR = A.P46YAR AND P42NNO =A.P46NNO) , 0)), /*연구활동비과세 30:*/
 '0' , /*기업연구소 31 */
 '0' , /*취재수당 32 */
 '0' , /*벽지수당 33 */
 '0' , /*재해관련급여 34 */
 '0' , /*외국정부등근무자 35 */
 '0' , /*외국주둔군인등 36 */
 '0' , /*국외근로100만원 37 */
 '0' , /*국외근로150만원 38 */
 TO_CHAR(P46FEG  - NVL((SELECT SUM(NVL(P42FWK, 0)) FROM PADB.HPAP42T WHERE P42YAR = A.P46YAR AND P42NNO =A.P46NNO) , 0)), /*국외근로공제액 39:*/
 TO_CHAR(P46NGT - NVL((SELECT SUM(NVL(P42NGT, 0)) FROM PADB.HPAP42T WHERE P42YAR = A.P46YAR AND P42NNO =A.P46NNO) , 0)), /*야간근로수당: 40*/
 TO_CHAR( P46BFM  - NVL((SELECT SUM(NVL(P42BON, 0)) FROM PADB.HPAP42T WHERE P42YAR = A.P46YAR AND P42NNO =A.P46NNO) , 0)), /*출산보육수당: 41*/
 '0' , /*주식매수선택권 42 */
 '0' , /*외국인기술자 43 */
 TO_CHAR( P46FFM), /*외국인근로자 44:*/
 '0' , /*우리사주조합배정 45 */
 '0' , /*우리사주조합인출금50% 46 */
 '0' , /*우리사주조합인출금75% 47 */
 '0' , /*주택자금보조금 48 */
 '0' , /*해저광물자원개발 49 */
TO_CHAR( P46GFM - NVL(C.NONTAX_AMT, 0) 
	 - NVL((SELECT SUM(NVL(P42GFM, 0)) FROM PADB.HPAP42T WHERE P42YAR = A.P46YAR AND P42NNO =A.P46NNO) , 0)), /*기타비과세: 50*/
TO_CHAR( P46TFM - NVL(C.NONTAX_AMT, 0) 
		  - NVL((SELECT SUM(NVL(P42GFM, 0) + NVL(P42BON, 0) + NVL(P42NGT, 0) + NVL(P42FWK, 0) + NVL(P42RND, 0)) FROM PADB.HPAP42T WHERE P42YAR = A.P46YAR AND P42NNO =A.P46NNO) , 0)   ), /*비과세합계:51*/
TO_CHAR( P46ICW), /*근로소득수입금액 52:*/
TO_CHAR( P46SBW), /*근로소득공제 53:*/
TO_CHAR( P46ICS), /*근로소득금액 54:*/
TO_CHAR( P46SFS), /*본인공제 55:*/
TO_CHAR( P46SPS), /*배우자공제 56:*/
TO_CHAR( P46OPD), /*부양가족공제인원 57:*/
TO_CHAR( P46STS), /*부양가족공제금액 58:*/
TO_CHAR(  NVL(A.P46OAG, 0) + NVL(A.P46DM7, 0)), /*경로우대공제인원 70세이상:59 */
TO_CHAR( P46ODS), /*경로우대공제 60:*/
TO_CHAR(  P46HTH), /*장애자부양 61:*/
TO_CHAR( P46EPS), /*장애자공제  62:*/
TO_CHAR( P46VNS), /*부녀자세대주공제 63:*/
TO_CHAR(  P46CID), /*자녀양육인원 64:*/
TO_CHAR( P46SUS), /*자녀양육비공제 65:*/
TO_CHAR(  P46DML), /*출산입양인원수 66:*/
TO_CHAR( P46DMM), /*출산입양공제 67:*/
 '0' ,  /*공란 68 */ 
TO_CHAR(  P46DMH), /*다자녀인원수 69:*/
TO_CHAR( P46DMI), /*다자녀추가공제 70:*/
TO_CHAR(  P46DMN), /*국민연금보험료공제 71:*/
TO_CHAR( P46PEN), /*기타연금보험료공제 72:*/
TO_CHAR( P46DMD), /*퇴직연금  73:*/
TO_CHAR(  NVL(P46SIS, 0)),
//TO_CHAR(  NVL(P46SIS, 0) - NVL(P46IPR, 0)), /*보험료공제 74:*/
TO_CHAR( P46SCM), /*의료비공제 75:*/
TO_CHAR( P46SED), /*교육비공제 76:*/
TO_CHAR(  P46DMO), /*주택임차차입금원리금상환액 77:*/
TO_CHAR( P46DMP), /*장기주택저당차입금이자상환액 78:*/
TO_CHAR(  P46SDN), /*기부금공제 79:*/
   '0' , /*공란 80 */ 
TO_CHAR(NVL(P46WSS,0)) /* 계 81 */,	
TO_CHAR(  CASE WHEN   NVL(P46WSS, 0) < 1000000 THEN   1000000 ELSE   0 END) /* 표준공제 82 */,
TO_CHAR( P46WSI), /*차감소득금액 83:*/
TO_CHAR(  P46SST), /*개인연금저축공제-2000년이전가입 84:*/
TO_CHAR(   P46DM2), /*연금저축-2001년이후가입 85:*/
TO_CHAR(    P46DMJ), /*소기업소상공인공제부금소득공제  86:*/
TO_CHAR( P46SHN), /*주택마련저축소득공제  87:*/
TO_CHAR( P46INS), /*투자조합공제  88:*/
TO_CHAR( P46CRD), /*신용카드공제 89:*/
 '0' , /*우리사주조합소득공제 90*/  
TO_CHAR(  P46DMS),  /*   펀드소득공제:  91 */  
'0' , /* 고용유지중소기업근로자소득공제  92*/
'0' , /* 공란 93 */
TO_CHAR(   NVL(p46sst, 0) + NVL(p46dm2, 0) + NVL(P46dmj, 0) + 
 NVL(P46shn, 0) + NVL(p46ins, 0) + NVL(p46crd, 0) + NVL(p46dms, 0))   as etcsum, /*그밖의 소득공제계  94*/   
TO_CHAR(CASE WHEN  NVL(P46WSI, 0) - ( NVL(p46sst, 0) + NVL(p46dm2, 0) + NVL(P46dmj, 0) + 
 NVL(P46shn, 0) + NVL(p46ins, 0) + NVL(p46crd, 0) + NVL(p46dms, 0)) <= 0 THEN 0 ELSE
 NVL(P46WSI, 0) - ( NVL(p46sst, 0) + NVL(p46dm2, 0) + NVL(P46dmj, 0) + 
 NVL(P46shn, 0) + NVL(p46ins, 0) + NVL(p46crd, 0) + NVL(p46dms, 0)) END), /*과세표준  95:*/
TO_CHAR( P46CTA), /*산출세액  96:*/
 '0' , /*소득세법세액감면 97 */ 
 '0' , /*조특법세액감면 98 */
 '0' , /*공란 99 */
 '0' , /*감면세액계 100 */
TO_CHAR(  P46DXW), /*근로소득세액공제 101:*/
  TO_CHAR( P46DMK), /*납세조합공제  102:*/
 TO_CHAR( P46TSK), /*주택차입금공제  103:*/
TO_CHAR(  P46DMB), /*기부정치자금 104:*/
TO_CHAR( P46TFE), /*외국납부세액공제 105:*/
 '0' , /*공란 106 */ 
TO_CHAR(  P46TYX), /*세액공제계 107:*/
TO_CHAR( P46TXP), /*결정소득세  108:*/
TO_CHAR( P46RTR), /*결정주민세  109:*/
TO_CHAR( P46FTR), /*결정농특세  110:*/
TO_CHAR( NVL(P46TXP, 0) + NVL(P46RTR, 0) + NVL(P46FTR, 0)) AS TXSUM , /*결정세액계  111 */ 
TO_CHAR(  P46HTX), /*현근무소득세징수액:  112*/
TO_CHAR( P46HRT), /*현근무주민세징수액:  113*/
TO_CHAR( P46HFT), /*현근무농특세징수액:  114*/
TO_CHAR( NVL(P46HTX, 0) + NVL(P46HRT, 0) + NVL(P46HFT, 0)) AS TXSUM , /*현근무지세액계  115 */ 
TO_CHAR((CASE WHEN NVL(P46CTX,0) >= 0 THEN 0 ELSE 1 END)) ||
TRIM(TO_CHAR((CASE WHEN NVL(P46CTX,0) >= 0 AND NVL(P46CTX,0) < 1000 THEN 0 ELSE ABS(NVL(P46CTX,0)) END), '0000000000')) , /*차감징수소득세 116 */
TO_CHAR((CASE WHEN NVL(P46CRT,0) >= 0 THEN 0 ELSE 1 END)) ||
TRIM(TO_CHAR((CASE WHEN NVL(P46CTX,0) >= 0 AND NVL(P46CTX,0) < 1000 THEN 0 ELSE ABS(NVL(P46CRT,0)) END), '0000000000')) , /*차감징수주민세 117 */
TO_CHAR((CASE WHEN NVL(P46CFT,0) >= 0 THEN 0 ELSE 1 END)) ||
TRIM(TO_CHAR((CASE WHEN NVL(P46CFT,0) >= 0 AND NVL(P46CFT,0) < 1000 THEN 0 ELSE ABS(NVL(P46CFT,0)) END), '0000000000')) , /*차감징수농특세 118 */
TO_CHAR((CASE WHEN NVL(P46CTX,0) + NVL(P46CRT, 0) + NVL(P46CFT, 0) >= 0 THEN 0 ELSE 1 END)) ||
TRIM(TO_CHAR((CASE WHEN NVL(P46CTX,0) + NVL(P46CRT, 0) + NVL(P46CFT, 0) >= 0 AND NVL(P46CTX,0) + NVL(P46CRT, 0) + NVL(P46CFT, 0) < 1000
	THEN 0 ELSE ABS(NVL(P46CTX,0) + NVL(P46CRT, 0) + NVL(P46CFT, 0)) END), '0000000000')) , /*차감징수 계 119 */
' ' , /* 공란 120 */
 NVL(P46IPR,0)
  FROM 
   INDB.HIN001M B ,
  PADB.HPAP46T A,
   (SELECT MEMBER_NO, SUM(NONTAX_AMT) AS NONTAX_AMT 
                FROM PADB.HPA005D
                WHERE  SUBSTR(YEAR_MONTH, 1, 4) = :as_year
                 AND CODE = '17'
                 GROUP BY MEMBER_NO )  C
WHERE A.P46NNO = B.MEMBER_NO
AND A.P46NNO = C.MEMBER_NO(+)
AND A.P46YAR = :as_year
USING SQLCA;
//
	OPEN HPAP46T ;
 	FETCH HPAP46T INTO :ls_nno, :ls_str[3,4],
:ls_str[3,6],  :ls_str[3,9],   :ls_str[3,10], :ls_str[3,11], :ls_str[3,12], :ls_str[3,13], :ls_str[3,14], :ls_str[3,17], :ls_str[3,18], :ls_str[3,19],
:ls_str[3,20], :ls_str[3,21],  :ls_str[3,23], :ls_str[3,24], :ls_str[3,25], :ls_str[3,26], :ls_str[3,27], :ls_str[3,28],
:ls_str[3,29], :ls_str[3,30], :ls_str[3,31], :ls_str[3,32], :ls_str[3,33], :ls_str[3,34], :ls_str[3,35], :ls_str[3,36], :ls_str[3,37],
:ls_str[3,38], :ls_str[3,39], :ls_str[3,40], :ls_str[3,41], :ls_str[3,42], :ls_str[3,43], :ls_str[3,44], :ls_str[3,45], :ls_str[3,46],
:ls_str[3,47], :ls_str[3,48], :ls_str[3,49], :ls_str[3,50], :ls_str[3,51], :ls_str[3,52], :ls_str[3,53], :ls_str[3,54], :ls_str[3,55],
:ls_str[3,56], :ls_str[3,57], :ls_str[3,58], :ls_str[3,59], :ls_str[3,60], :ls_str[3,61], :ls_str[3,62], :ls_str[3,63], :ls_str[3,64],
:ls_str[3,65], :ls_str[3,66], :ls_str[3,67], :ls_str[3,68], :ls_str[3,69], :ls_str[3,70], :ls_str[3,71], :ls_str[3,72], :ls_str[3,73],
:ls_str[3,74], :ls_str[3,75], :ls_str[3,76], :ls_str[3,77], :ls_str[3,78], :ls_str[3,79], :ls_str[3,80], :ls_str[3,81], :ls_str[3,82],
:ls_str[3,83], :ls_str[3,84], :ls_str[3,85], :ls_str[3,86], :ls_str[3,87], :ls_str[3,88], :ls_str[3,89], :ls_str[3,90], :ls_str[3,91],
:ls_str[3,92], :ls_str[3,93], :ls_str[3,94], :ls_str[3,95], :ls_str[3,96], :ls_str[3,97], :ls_str[3,98], :ls_str[3,99], :ls_str[3,100], 
:ls_str[3,101], :ls_str[3,102], :ls_str[3,103], :ls_str[3,104], :ls_str[3,105], :ls_str[3,106], :ls_str[3,107], :ls_str[3,108], :ls_str[3,109], 
:ls_str[3,110], :ls_str[3,111], :ls_str[3,112], :ls_str[3,113], :ls_str[3,114], :ls_str[3,115], :ls_str[3,116], :ls_str[3,117], :ls_str[3,118], 
:ls_str[3,119], :ls_str[3,120],:ld_ipr ;
	 DO WHILE SQLCA.SQLCODE = 0
		
		
//C,D,E 레코드 filewrite
ll_cnt = 0  //초기화

For ll_i = 3 To 5
	If ll_i = 4 Then	 
	//################################################
	//D 레코드
	//################################################	
	
	If long(ls_str[3,6]) > 0 Then  //종전근무처수가 0보다 클 경우
	ls_str[4,1] = 'D' //레코드구분
	ls_str[4,2] = '20'  //자료구분
	ls_str[4,3] = ls_tax  //세무서
	ls_str[4,4] = ls_str[3,4]  //일련번호
	ls_str[4,5] = ls_saupno //사업자등록번호
	ls_str[4,6] = '' //공란
	ls_str[4,7] = ls_str[3,14]  //소득자주민등록번호
	ls_str[4,12] = '0' //감면시작일
	ls_str[4,13] = '0' //감면종료일
	ls_str[4,19] = '0' //공란
	ls_str[4,54] = '' //공란
	
			
	SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
		INTO :ll_cnt
		FROM CDDB.KCH102D 
		WHERE CODE_GB = 'HPA02' 
		AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
		USING SQLCA;

	
	DECLARE HPAP42T CURSOR FOR 
					SELECT NVL(P42CNM, ' '), /*법인명상호 8*/ 
					SUBSTR(TRIM(P42BNB), 1, 10), /*사업자등록번호 9 */ 
					P42STR, /* 근무기간 시작연월일  10 */
					P42END, /* 근무기간 종료연월일  11 */
					NVL(P42PTL,0) , /*급여총액 14 */ 
					NVL(P42BTL, 0), /*상여총액 15 */ 
					NVL(P42ATL, 0),  /*인정상여 16 */ 
					'0',  /*주식매수선택권행사이익 17 */ 
					'0',  /*우리사주조합인출금 18 */ 
					NVL(P42PTL,0) + NVL(P42BTL, 0) +NVL(P42ATL, 0), /*계 20 */ 
					 '0' , /*비과세학자금 21 */
					 '0' , /*무보수위원수당 22 */
					 '0' , /*경호,승선수당 23 */
					 '0' , /*유아,초중등  24 */
					 '0' , /*고등교육법 25 */
					 '0' , /*특별법 26 */
					 TO_CHAR(NVL(P42RND, 0)), /*연구활동비과세 27:*/
					 '0' , /*기업연구소 28 */
					 '0' , /*취재수당 29 */
					 '0' , /*벽지수당 30 */
					 '0' , /*재해관련급여 31 */
					 '0' , /*외국정부등근무자 32 */
					 '0' , /*외국주둔군인등 33 */
					 '0' , /*국외근로100만원 34 */
					 '0' , /*국외근로150만원 35 */
					 TO_CHAR( NVL(P42FWK,0)), /*국외근로공제액 36:*/
					 TO_CHAR(NVL(P42NGT,0)), /*야간근로수당: 37*/
					 TO_CHAR( NVL(P42BON, 0)), /*출산보육수당: 38*/
					 '0' , /*주식매수선택권 39 */
					 '0' , /*외국인기술자 40 */
					 '0', /*외국인근로자 41:*/
					 '0' , /*우리사주조합배정 42 */
					 '0' , /*우리사주조합인출금50% 43 */
					 '0' , /*우리사주조합인출금75% 44 */
					 '0' , /*주택자금보조금 45 */
					 '0' , /*해저광물자원개발 46 */
					TO_CHAR( NVL(P42GFM, 0)), /*기타비과세: 47*/
					TO_CHAR( NVL(P42RND, 0) + NVL(P42FWK,0) +NVL(P42NGT,0) + NVL(P42BON, 0) + NVL(P42GFM, 0) ), /*비과세합계:48*/
					TO_CHAR( NVL(P42TXR, 0)), /*전근무소득세징수액:  49*/
					TO_CHAR( NVL(P42RTR, 0)), /*전근무주민세징수액:  50 */
					TO_CHAR( NVL(P42FTR, 0)), /*전근무농특세징수액:  51*/
					TO_CHAR( NVL(P42TXR, 0) + NVL(P42RTR, 0) + NVL(P42FTR, 0)) AS TXSUM , /*전근무지세액계  52 */ 
					TO_char(ROW_NUMBER() OVER (ORDER BY P42BNB ASC)) AS ROWNUMBER  /*일련번호 53 */ 
					 FROM PADB.HPAP42T WHERE P42YAR = :as_year AND P42NNO =:ls_nno
	 USING SQLCA;
	
	
		OPEN HPAP42T ;
		FETCH HPAP42T INTO
		:ls_str[4,8], :ls_str[4,9], :ls_str[4,10], :ls_str[4,11], :ls_str[4,14], :ls_str[4,15], :ls_str[4,16], :ls_str[4,17],
		:ls_str[4,18], :ls_str[4,20], :ls_str[4,21], :ls_str[4,22], :ls_str[4,23], :ls_str[4,24], :ls_str[4,25], :ls_str[4,26],
		:ls_str[4,27], :ls_str[4,28], :ls_str[4,29], :ls_str[4,30], :ls_str[4,31], :ls_str[4,32], :ls_str[4,33], :ls_str[4,34],
		:ls_str[4,35], :ls_str[4,36], :ls_str[4,37], :ls_str[4,38], :ls_str[4,39], :ls_str[4,40], :ls_str[4,41], :ls_str[4,42],
		:ls_str[4,43], :ls_str[4,44], :ls_str[4,45], :ls_str[4,46], :ls_str[4,47], :ls_str[4,48], :ls_str[4,49], :ls_str[4,50],
		:ls_str[4,51], :ls_str[4,52], :ls_str[4,53]	;
		 DO WHILE SQLCA.SQLCODE = 0
			
		    ls_str_recode[ll_i] = ''	 //초기화
			 
			For ll_t = 1 To ll_cnt   
				ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
				ls_str_recode[ll_i] = ls_str_recode[ll_i] + ls_str[ll_i, ll_t]
			Next
			
			//D1, D2, D3 ... C레코드 이후 종전근무처수만큼 write 함.
			FileWrite(li_FileNum, ls_str_recode[ll_i])	
			
		FETCH HPAP42T INTO
		:ls_str[4,8], :ls_str[4,9], :ls_str[4,10], :ls_str[4,11], :ls_str[4,14], :ls_str[4,15], :ls_str[4,16], :ls_str[4,17],
		:ls_str[4,18], :ls_str[4,20], :ls_str[4,21], :ls_str[4,22], :ls_str[4,23], :ls_str[4,24], :ls_str[4,25], :ls_str[4,26],
		:ls_str[4,27], :ls_str[4,28], :ls_str[4,29], :ls_str[4,30], :ls_str[4,31], :ls_str[4,32], :ls_str[4,33], :ls_str[4,34],
		:ls_str[4,35], :ls_str[4,36], :ls_str[4,37], :ls_str[4,38], :ls_str[4,39], :ls_str[4,40], :ls_str[4,41], :ls_str[4,42],
		:ls_str[4,43], :ls_str[4,44], :ls_str[4,45], :ls_str[4,46], :ls_str[4,47], :ls_str[4,48], :ls_str[4,49], :ls_str[4,50],
		:ls_str[4,51], :ls_str[4,52], :ls_str[4,53]	;
	
		Loop
		  CLOSE HPAP42T;
	End If
Elseif ll_i = 5 Then
//################################################
//E 레코드 : 소득공제명세
//################################################	
ls_str[5,1] = 'E' //레코드구분
ls_str[5,2] = '20'  //자료구분
ls_str[5,3] = ls_tax  //세무서
ls_str[5,4] = ls_str[3,4]  //일련번호
ls_str[5,5] = ls_saupno //사업자등록번호
ls_str[5,6] = ls_str[3,14]  //소득자주민등록번호
ls_str[5,113] = '' //공란

Long ll_e , ll_erow, ll_reset, ll_e_str
Long ll_seq = 0
String ls_e[]


SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
	INTO :ll_cnt
	FROM CDDB.KCH102D 
	WHERE CODE_GB = 'HPA02' 
	AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
	USING SQLCA;


ll_e = 7  //부양가족정보 배열 초기화
 ls_str_recode[ll_i] = ''	 //초기화
		
For ll_reset = ll_e To 112
	ls_str[5, ll_reset] = ''
Next


DECLARE HPAP43T CURSOR FOR 
		SELECT P43REL, /*관계 7*/ 
		P43GBN, /*내외국인구분코드 8 */ 
		P43KNM , /*성명 9 */ 
		P43RNO, /*주민등록번호: 10 */ 
		CASE WHEN P43KO1 = 'Y' THEN '1' ELSE ' ' END, /*기본공제: 11 */ 
		CASE WHEN P43KO2 = 'Y' THEN '1' ELSE ' ' END, /*장애인:: 12 */ 
		CASE WHEN P43KO3 = 'Y' THEN '1' ELSE ' ' END, /*자녀양육비:: 13 */ 
		CASE WHEN P43WHM = 'Y' THEN '1' ELSE ' ' END, /*부녀자세대주유무:: 14 */ 
		CASE WHEN P43OGB = 'Y' THEN '1' ELSE ' ' END, /*경로우대유무: 15 */ 
		CASE WHEN P43BGB = 'Y' THEN '1' ELSE ' ' END, /*출산입양가족유무: 16 */ 
		NVL(P43G01, 0) + NVL(P43G08, 0)    + NVL((CASE WHEN P43REL = '0' THEN TO_NUMBER(:ld_ipr)  ELSE 0 END), 0) ,  /*보험료1:  17 */ 
		NVL(P43G02, 0),  /*의료비1: 18 */ 
		NVL(P43G03, 0),  /*교육비1:  19 */ 
		NVL(P43G04, 0) , /*신용카드1:  20 */ 
		 NVL(P43G05, 0),  /*현금영수증1: 21 */ 
		  NVL(P43G06, 0),  /*기부금1: 22 */ 
		NVL(P43F01, 0) + NVL(P43F08, 0),  /*보험료2:  23 */ 
		NVL(P43F02, 0),  /*의료비2: 24 */ 
		NVL(P43F03, 0),  /*교육비2:  25 */ 
		NVL(P43F04, 0) , /*신용카드2:  26 */ 
		 NVL(P43F06, 0),  /*기부금2: 27 */ 
		ROW_NUMBER() OVER (ORDER BY P43REL, P43RNO ASC) AS ROWNUMber 
		 FROM PADB.HPAP43T WHERE P43YAR = :as_year AND P43NNO =:ls_nno
		 ORDER BY P43REL, P43RNO
	 USING SQLCA;
	
	
		OPEN HPAP43T ;
		FETCH HPAP43T INTO
		:ls_str[5,ll_e], :ls_str[5,ll_e + 1], :ls_str[5,ll_e + 2], :ls_str[5,ll_e + 3], :ls_str[5,ll_e + 4], :ls_str[5,ll_e + 5], :ls_str[5,ll_e + 6], :ls_str[5,ll_e + 7],
		:ls_str[5,ll_e + 8], :ls_str[5,ll_e + 9], :ls_str[5,ll_e + 10], :ls_str[5,ll_e + 11], :ls_str[5,ll_e + 12], :ls_str[5,ll_e + 13], :ls_str[5,ll_e + 14],
		:ls_str[5,ll_e + 15], :ls_str[5,ll_e + 16], :ls_str[5,ll_e + 17], :ls_str[5,ll_e + 18], :ls_str[5,ll_e + 19], :ls_str[5,ll_e + 20], :ll_erow
			;
		 DO WHILE SQLCA.SQLCODE = 0
			

		If mod(ll_erow, 5) = 1 Then 
			ll_seq ++
			ls_str[ll_i, 112] = String(ll_seq)
		End If

		If mod(ll_erow, 5) = 0 Then  
			For ll_t = 1 To ll_cnt   
				ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
				ls_e[ll_seq] = ls_e[ll_seq] + ls_str[ll_i, ll_t]
			Next	
			
			ll_e = 7
			For ll_reset = ll_e To 112
				ls_str[5, ll_reset] = ''
			Next
		Else
			ll_e = ll_e + 21	
		End If
		
		
		
		FETCH HPAP43T INTO 
		:ls_str[5,ll_e], :ls_str[5,ll_e + 1], :ls_str[5,ll_e + 2], :ls_str[5,ll_e + 3], :ls_str[5,ll_e + 4], :ls_str[5,ll_e + 5], :ls_str[5,ll_e + 6], :ls_str[5,ll_e + 7],
		:ls_str[5,ll_e + 8], :ls_str[5,ll_e + 9], :ls_str[5,ll_e + 10], :ls_str[5,ll_e + 11], :ls_str[5,ll_e + 12], :ls_str[5,ll_e + 13], :ls_str[5,ll_e + 14],
		:ls_str[5,ll_e + 15], :ls_str[5,ll_e + 16], :ls_str[5,ll_e + 17], :ls_str[5,ll_e + 18], :ls_str[5,ll_e + 19], :ls_str[5,ll_e + 20], :ll_erow 
		;
	
		
		Loop
		  CLOSE HPAP43T;
			
			If mod(ll_erow,5) > 0 Then
				ls_str[ll_i, 112] = String(ll_seq)
				For ll_t = 1 To ll_cnt   
					ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
					ls_e[ll_seq] = ls_e[ll_seq] + ls_str[ll_i, ll_t]
				Next	
			End If
			
			For ll_e_str = 1 To ll_seq
			//E1, E2, E3 ... 부양가족수를 5명 단위로 write함
				FileWrite(li_FileNum, ls_e[ll_e_str])		
				ls_e[ll_e_str] = ''
				If  ll_e_str = ll_seq then
					ll_seq = 0
				end If
			NEXT
Else  //C 레코드 일 경우
		SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
		INTO :ll_cnt
		FROM CDDB.KCH102D 
		WHERE CODE_GB = 'HPA02' 
		AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
		USING SQLCA;
		
		
		ls_str_recode[ll_i] = ''	 //초기화
		For ll_t = 1 To ll_cnt   
			ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
			ls_str_recode[ll_i] = ls_str_recode[ll_i] + ls_str[ll_i, ll_t]
		Next
		//C레코드는 1번씩만 write 함
			FileWrite(li_FileNum, ls_str_recode[ll_i])
End If		
	

Next


	FETCH HPAP46T INTO :ls_nno, :ls_str[3,4],
:ls_str[3,6],  :ls_str[3,9],   :ls_str[3,10], :ls_str[3,11], :ls_str[3,12], :ls_str[3,13], :ls_str[3,14], :ls_str[3,17], :ls_str[3,18], :ls_str[3,19],
:ls_str[3,20], :ls_str[3,21],  :ls_str[3,23], :ls_str[3,24], :ls_str[3,25], :ls_str[3,26], :ls_str[3,27], :ls_str[3,28],
:ls_str[3,29], :ls_str[3,30], :ls_str[3,31], :ls_str[3,32], :ls_str[3,33], :ls_str[3,34], :ls_str[3,35], :ls_str[3,36], :ls_str[3,37],
:ls_str[3,38], :ls_str[3,39], :ls_str[3,40], :ls_str[3,41], :ls_str[3,42], :ls_str[3,43], :ls_str[3,44], :ls_str[3,45], :ls_str[3,46],
:ls_str[3,47], :ls_str[3,48], :ls_str[3,49], :ls_str[3,50], :ls_str[3,51], :ls_str[3,52], :ls_str[3,53], :ls_str[3,54], :ls_str[3,55],
:ls_str[3,56], :ls_str[3,57], :ls_str[3,58], :ls_str[3,59], :ls_str[3,60], :ls_str[3,61], :ls_str[3,62], :ls_str[3,63], :ls_str[3,64],
:ls_str[3,65], :ls_str[3,66], :ls_str[3,67], :ls_str[3,68], :ls_str[3,69], :ls_str[3,70], :ls_str[3,71], :ls_str[3,72], :ls_str[3,73],
:ls_str[3,74], :ls_str[3,75], :ls_str[3,76], :ls_str[3,77], :ls_str[3,78], :ls_str[3,79], :ls_str[3,80], :ls_str[3,81], :ls_str[3,82],
:ls_str[3,83], :ls_str[3,84], :ls_str[3,85], :ls_str[3,86], :ls_str[3,87], :ls_str[3,88], :ls_str[3,89], :ls_str[3,90], :ls_str[3,91],
:ls_str[3,92], :ls_str[3,93], :ls_str[3,94], :ls_str[3,95], :ls_str[3,96], :ls_str[3,97], :ls_str[3,98], :ls_str[3,99], :ls_str[3,100], 
:ls_str[3,101], :ls_str[3,102], :ls_str[3,103], :ls_str[3,104], :ls_str[3,105], :ls_str[3,106], :ls_str[3,107], :ls_str[3,108], :ls_str[3,109], 
:ls_str[3,110], :ls_str[3,111], :ls_str[3,112], :ls_str[3,113], :ls_str[3,114], :ls_str[3,115], :ls_str[3,116], :ls_str[3,117], :ls_str[3,118], 
:ls_str[3,119], :ls_str[3,120],:ld_ipr ;

	Loop
     CLOSE HPAP46T;
		
FileClose(li_FileNum)

MESSAGEBOX('확인', '근로소득 지급조서 파일 작성이 완료 되었습니다. ~r~r' + &
						ls_path + '파일을 확인해주세요')				
		
		

Case 'CA'
		
			//################################################
			//의료비
			//################################################	
			ls_str[1,1] = 'A' //레코드구분
			ls_str[1,2] = '26'  //자료구분
			ls_str[1,3] = ls_tax  //세무서
			//ls_str[1,4] =   //일련번호
			ls_str[1,5] = as_jdt  //제출년월일
			ls_str[1,6] = ls_saupno //사업자등록번호
			ls_str[1,7] = ls_htx //홈텍스번호
			ls_str[1,8] = '9000' //기타프로그램
			ls_str[1,9] = ls_saupno //사업자등록번호
			ls_str[1,10] = ls_saupnm  //상호
			ls_str[1,22] = '1'  //제출대상기간코드 - 연간합산제출
			
			ls_str[1, 1] = of_year_strchg(ls_str[1, 1], 'X' , 1)		
			ls_str[1, 2] = of_year_strchg(ls_str[1, 2], '9' , 2)	
			ls_str[1, 3] = of_year_strchg(ls_str[1, 3], 'X' , 3)	
			
			ls_str[1, 5] = of_year_strchg(ls_str[1, 5], '9' , 8)	
			ls_str[1, 6] = of_year_strchg(ls_str[1, 6], 'X' , 10)	
			ls_str[1, 7] = of_year_strchg(ls_str[1, 7], 'X' , 20)	
			ls_str[1, 8] = of_year_strchg(ls_str[1, 8], 'X' , 4)	
			ls_str[1, 9] = of_year_strchg(ls_str[1, 9], 'X' , 10)	
			ls_str[1, 10] = of_year_strchg(ls_str[1, 10], 'X' , 40)
			ls_str[1, 22] = of_year_strchg(ls_str[1, 22], '9' , 1)
			ll_seq = 0
			
			DECLARE HPAP44T CURSOR FOR 
						SELECT A.P46RNO, /*주민등록번호: 11 */
			 A.P46NLF, /*내외국인코드 12 */
			NVL(A.P46KNM, ' '), /*한글명칭:: 13 */
			B.P44BNO, /*사업자번호: 14 */
			NVL(B.P44BNM, ' '), /*상호: 15 */
			B.P44HSG, /*의료비증빙코드: 16 */
			(CASE WHEN B.P44HSG  = '1' THEN 0 ELSE  NVL(B.P44CNT, 0) END) , /*건수 : 17 */
			NVL(B.P44PTL, 0), /*지급금액: 18 */
			B.P44RNO, /*주민번호: 19 */
			B.P44FRG, /*외국인구분: 20 */
			B.P44GBN, /*본인 장애,경로: 21 */
			' ' /*공란 23 */
			FROM PADB.HPAP46T A, 
			(
			SELECT P44YAR, P44NNO, P44RNO, P44BNO, P44BNM, P44HNM, SUM(NVL(P44CNT,1)) AS P44CNT,
			SUM(NVL(P44PTL, 0)) AS P44PTL, (CASE WHEN P44GBN = 'Y' THEN '1' ELSE '2' END) AS P44GBN,  P44FRG, P44HSG
			FROM PADB.HPAP44T B
			WHERE B.P44YAR =  :as_year
			GROUP BY P44YAR, P44NNO, P44RNO, P44BNO, P44BNM, P44HNM,P44GBN,  P44FRG, P44HSG
			) B
			WHERE A.P46YAR = B.P44YAR
			AND A.P46NNO = B.P44NNO
			AND A.P46SCM >= 2000000
			AND A.P46YAR = :as_year
			ORDER BY A.P46NNO, B.P44RNO
			USING SQLCA;
				
				
					OPEN HPAP44T ;
					FETCH HPAP44T INTO
					:ls_str[1,11], :ls_str[1,12], :ls_str[1,13], :ls_str[1, 14], :ls_str[1,15], :ls_str[1,16], :ls_str[1,17], :ls_str[1,18],
					:ls_str[1,19], :ls_str[1,20], :ls_str[1,21], :ls_str[1,23]
						;
					 DO WHILE SQLCA.SQLCODE = 0
						
			
						ll_seq ++
						ls_str[1, 4] = String(ll_seq)
						ls_str[1, 4] = of_year_strchg(ls_str[1, 4], '9' , 6)	
			
					
				
					ls_str[1, 11] = of_year_strchg(ls_str[1, 11], 'X' , 13)	
					ls_str[1, 12] = of_year_strchg(ls_str[1, 12], '9' , 1)	
					ls_str[1, 13] = of_year_strchg(ls_str[1, 13], 'X' , 30)	
					ls_str[1, 14] = of_year_strchg(ls_str[1, 14], 'X' , 10)	
					ls_str[1, 15] = of_year_strchg(ls_str[1, 15], 'X' , 40)	
					ls_str[1, 16] = of_year_strchg(ls_str[1, 16], 'X' , 1)	
					ls_str[1, 17] = of_year_strchg(ls_str[1, 17], '9' , 5)	
					ls_str[1, 18] = of_year_strchg(ls_str[1, 18], '9' , 11)	
					ls_str[1, 19] = of_year_strchg(ls_str[1, 19], 'X' , 13)	
					ls_str[1, 20] = of_year_strchg(ls_str[1, 20], '9' , 1)	
					ls_str[1, 21] = of_year_strchg(ls_str[1, 21], '9' , 1)	
					ls_str[1, 23] = of_year_strchg(ls_str[1, 23], 'X' , 19)	
					
					ls_str_recode[1] = ''	 //초기화
					For ll_t = 1 To 23
						ls_str_recode[1] = ls_str_recode[1] + ls_str[1, ll_t]
						//ls_str[1, ll_t] = ''
					Next
					
					FileWrite(li_FileNum, ls_str_recode[1])
					
					FETCH HPAP44T INTO 
					:ls_str[1,11], :ls_str[1,12], :ls_str[1,13], :ls_str[1, 14], :ls_str[1,15], :ls_str[1,16], :ls_str[1,17], :ls_str[1,18],
					:ls_str[1,19], :ls_str[1,20], :ls_str[1,21], :ls_str[1,23]
					;
				
					
					Loop
					  CLOSE HPAP44T;
			
			
			FileClose(li_FileNum)
			
			MESSAGEBOX('확인', '의료비명세서 지급조서 파일 작성이 완료 되었습니다. ~r~r' + &
									ls_path + '파일을 확인해주세요')				
				
	Case 'H'			
			//################################################
			//기부금
			//################################################	
			ls_str[1,1] = 'A' //레코드구분
			ls_str[1,2] = '27'  //자료구분
			ls_str[1,3] = ls_tax  //세무서
			//ls_str[1,4] =   //일련번호
			ls_str[1,5] = as_jdt  //제출년월일
			ls_str[1,6] = ls_saupno //사업자등록번호
			ls_str[1,7] = ls_htx //홈텍스번호
			ls_str[1,8] = '9000' //기타프로그램
			ls_str[1,9] = ls_saupno //사업자등록번호
			ls_str[1,10] = ls_saupnm  //상호
//			ls_str[1,20] = '1'  //내외국인 구분 :내국인 1
//			ls_str[1,23] = '20080101' //과세기간시작일 '20080101'
//			ls_str[1,24] = '20081231' //과세기간종료일 '20081231'
//			ls_str[1,25] = '0' //이월액잔액
//			ls_str[1,26] = '0' //해당과세기간공제금액
//			ls_str[1,27] = '0'  //이월액
			ls_str[1,33] = '1'  //제출대상기간코드 - 1 연간합산제출
			ls_str[1,34] = ''  //공란
//			
			
			
			ls_str[1, 1] = of_year_strchg(ls_str[1, 1], 'X' , 1)		
			ls_str[1, 2] = of_year_strchg(ls_str[1, 2], '9' , 2)	
			ls_str[1, 3] = of_year_strchg(ls_str[1, 3], 'X' , 3)	
			
			ls_str[1, 5] = of_year_strchg(ls_str[1, 5], '9' , 8)	
			ls_str[1, 6] = of_year_strchg(ls_str[1, 6], 'X' , 10)	
			ls_str[1, 7] = of_year_strchg(ls_str[1, 7], 'X' , 20)	
			ls_str[1, 8] = of_year_strchg(ls_str[1, 8], 'X' , 4)	
			ls_str[1, 9] = of_year_strchg(ls_str[1, 9], 'X' , 10)	
			ls_str[1, 10] = of_year_strchg(ls_str[1, 10], 'X' , 40)	
			//ls_str[1, 20] = of_year_strchg(ls_str[1, 20], '9' , 1)	
			ls_str[1, 33] = of_year_strchg(ls_str[1, 33], '9' , 1)
			ls_str[1, 34] = of_year_strchg(ls_str[1, 34], 'X' , 62)
			
			ll_seq = 0
			
			DECLARE HPAP45T CURSOR FOR 
						SELECT A.P46RNO, /*주민등록번호: 11 */
			A.P46NLF , /*내외국인코드 12 */
			NVL(A.P46KNM, ' '), /*한글명칭:: 13 */
			B.P45BNO, /*사업자번호: 14 */
			NVL(B.P45BNM, ' '), /*상호: 15 */
			B.P45COD, /*코드: 16 */
			NVL(B.P45CNT, 0), /*건수 : 17 */
			NVL(B.P45PTL, 0), /*지급금액: 18 */
			B.P45RLS, /*관계: 19 */
			(SELECT P43GBN FROM PADB.HPAP43T WHERE P43YAR = B.P45YAR AND P43NNO = B.P45NNO AND P43RNO = B.P45RNO) , /* 내외국인구분 20 */
			B.P45CHM, /*성명: 21 */
			B.P45RNO, /*주민번호 22 */
		   (CASE WHEN B.P45COD = '31' AND B.P45GBN = '1'  THEN '20080101' ELSE '0' END) , /*과세기간 시작일 23 */ 
		   (CASE WHEN B.P45COD = '31' AND B.P45GBN = '1'  THEN '20081231' ELSE '0' END) , /*과세기간 종료일 24 */ 
		   '0' , /*이월액잔액 25 */ 
		   '0' , /*과세기간공제금액 26 */ 
		   '0' , /*이월액 27 */ 
		     (CASE WHEN B.P45COD = '31' AND B.P45GBN = '0'  THEN '20090101' ELSE '0' END) , /*과세기간 시작일 28 */ 
		   (CASE WHEN B.P45COD = '31' AND B.P45GBN = '0'  THEN '20091231' ELSE '0' END) , /*과세기간 종료일 29 */ 
		   '0' , /*이월액잔액 30 */ 
		   '0' , /*과세기간공제금액 31 */ 
		   '0'  /*이월액 32 */ 
			FROM PADB.HPAP46T A, 		
      	(  
  		SELECT 		P45YAR, P45NNO,  P45BNO, P45COD, P45RNO, P45CHM, P45RLS,  P45BNM, P45GBN,  SUM(1) AS P45CNT, SUM(P45PTL)	 AS P45PTL	
 				     FROM PADB.HPAP45T B
			WHERE B.P45YAR =  :as_year
			AND B.P45PTL <> 0
			GROUP BY 	P45YAR, P45NNO,  P45BNO, P45COD, P45RNO, P45CHM, P45RLS,  P45BNM , P45GBN
  		) B
			WHERE A.P46YAR = B.P45YAR
			AND A.P46NNO = B.P45NNO
			AND A.P46SDN >= 500000
			AND A.P46YAR = :as_year
			ORDER BY A.P46NNO, B.P45RNO
			USING SQLCA;
				
				
					OPEN HPAP45T ;
					FETCH HPAP45T INTO
					:ls_str[1,11], :ls_str[1,12], :ls_str[1,13], :ls_str[1, 14], :ls_str[1,15], :ls_str[1,16], :ls_str[1,17], :ls_str[1,18],
					:ls_str[1,19], :ls_str[1,20], :ls_str[1,21], :ls_str[1,22],  :ls_str[1,23], :ls_str[1, 24], :ls_str[1,25], :ls_str[1,26], 
					:ls_str[1,27], :ls_str[1,28], :ls_str[1,29], :ls_str[1,30],  :ls_str[1,31], :ls_str[1, 32]
						;
					 DO WHILE SQLCA.SQLCODE = 0
						
			
						ll_seq ++
						ls_str[1, 4] = String(ll_seq)
						ls_str[1, 4] = of_year_strchg(ls_str[1, 4], '9' , 7)	
			
					
				
					ls_str[1, 11] = of_year_strchg(ls_str[1, 11], 'X' , 13)	
					ls_str[1, 12] = of_year_strchg(ls_str[1, 12], '9' , 1)	
					ls_str[1, 13] = of_year_strchg(ls_str[1, 13], 'X' , 30)	
					ls_str[1, 14] = of_year_strchg(ls_str[1, 14], 'X' , 13)			
					
									
					ls_str[1, 15] = of_year_strchg(ls_str[1, 15], 'X' , 30)	
					If lenA(ls_str[1, 15]) < 30 Then 
						ls_str[1, 15] = ls_str[1, 15] + space(30 - lenA(ls_str[1, 15]))
					End If
					
					
					ls_str[1, 16] = of_year_strchg(ls_str[1, 16], 'X' , 2)	
					ls_str[1, 17] = of_year_strchg(ls_str[1, 17], '9' , 5)	
					ls_str[1, 18] = of_year_strchg(ls_str[1, 18], '9' , 13)	
					ls_str[1, 19] = of_year_strchg(ls_str[1, 19], 'X' , 1)	
					ls_str[1, 20] = of_year_strchg(ls_str[1, 20], 'X' , 1)
					
					ls_str[1, 21] = of_year_strchg(ls_str[1, 21], 'X' , 20)	
					ls_str[1, 22] = of_year_strchg(ls_str[1, 22], 'X' , 13)	
					ls_str[1, 23] = of_year_strchg(ls_str[1, 23], '9' , 8)		
					ls_str[1, 24] = of_year_strchg(ls_str[1, 24], '9' , 8)	
					ls_str[1, 25] = of_year_strchg(ls_str[1, 25], '9' , 13)
					ls_str[1, 26] = of_year_strchg(ls_str[1, 26], '9' , 13)		
					ls_str[1, 27] = of_year_strchg(ls_str[1, 27], '9' , 13)	
					ls_str[1, 28] = of_year_strchg(ls_str[1, 28], '9' , 8)		
					ls_str[1, 29] = of_year_strchg(ls_str[1, 29], '9' , 8)	
					ls_str[1, 30] = of_year_strchg(ls_str[1, 30], '9' , 13)
					ls_str[1, 31] = of_year_strchg(ls_str[1, 31], '9' , 13)		
					ls_str[1, 32] = of_year_strchg(ls_str[1, 32], '9' , 13)	
				
							
					ls_str_recode[1] = ''	 //초기화
					For ll_t = 1 To 34   		
						ls_str_recode[1] = ls_str_recode[1] + ls_str[1, ll_t]
						//ls_str[1, ll_t] = ''
					Next
					
					FileWrite(li_FileNum, ls_str_recode[1])
					
					FETCH HPAP45T INTO 
					:ls_str[1,11], :ls_str[1,12], :ls_str[1,13], :ls_str[1, 14], :ls_str[1,15], :ls_str[1,16], :ls_str[1,17], :ls_str[1,18],
					:ls_str[1,19], :ls_str[1,20], :ls_str[1,21], :ls_str[1,22],  :ls_str[1,23], :ls_str[1, 24], :ls_str[1,25], :ls_str[1,26], 
					:ls_str[1,27], :ls_str[1,28], :ls_str[1,29], :ls_str[1,30],  :ls_str[1,31], :ls_str[1, 32]
					;
				
					
					Loop
					  CLOSE HPAP45T;
			
			
			FileClose(li_FileNum)
			
			MESSAGEBOX('확인', '기부금명세서 지급조서 파일 작성이 완료 되었습니다. ~r~r' + &
									ls_path + '파일을 확인해주세요')				
//	Case 'E'  //퇴직소득 지급조서
//		//#############################################################
//		//퇴직소득
//		//#############################################################
//
//ls_record[1] = 'A'
//ls_record[2] = 'B'
//ls_record[3] = 'C'
//ls_record[4] = 'D'
//
//
//For ll_i = 1 To 4
//
//ll_cnt = 0  //초기화
//
//
//
//
//SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
//		INTO :ll_cnt
//		FROM CDDB.KCH102D 
//		WHERE CODE_GB = 'HPA03' 
//		AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
//		USING SQLCA;
//
//	For ll_t = 1 To ll_cnt  
//		ls_cd = ls_record[ll_i] + String(ll_t, '000')
//		
//		 SELECT ETC_CD1,  /*자료형태 */
//			TO_NUMBER(ETC_CD2)  /*길이 */
//		INTO :ls_type[ll_i, ll_t], :ll_len[ll_i, ll_t]
//		FROM CDDB.KCH102D 
//		WHERE CODE_GB = 'HPA03' 
//		AND CODE = :ls_cd
//		 USING SQLCA;
//	Next
//Next
//
////################################################
////A 레코드
////################################################
//
//ls_str[1,1] = 'A'     //레코드구분
//ls_str[1,2] = '22'   //자료구분
//ls_str[1,3] = ls_tax  //세무서
//ls_str[1,4] = as_jdt  //제출년월일
//ls_str[1,5] = '2'    //제출자 (1:세무대리인, 2:법인 , 3:개인)
//ls_str[1,6] = ''
//ls_str[1,7] = ls_htx //홈텍스번호
//ls_str[1,8] = '9000' //기타프로그램
//ls_str[1,9] = ls_saupno //사업자등록번호
//ls_str[1,10] = ls_saupnm  //상호
//ls_str[1,11] = ls_dnm  //담당부서명
//ls_str[1,12] = ls_knm  //담당자성명
//ls_str[1,13] = ls_tel //담당전화번호
//
//ls_str[1,14] =  '1'   //원천징수의무자수(B레코드수)
//ls_str[1,15] = '101'  //한글코드종류 (국가표준)
//ls_str[1,16] = '1'  //연간지급분
//ls_str[1,17] = ''  //공란
//
//
////################################################
////B 레코드
////################################################
//ls_str[2,1] = 'B'     //레코드구분
//ls_str[2,2] = '22'   //자료구분
//ls_str[2,3] = ls_tax  //세무서
//ls_str[2,4] = '1'     //일련번호
//ls_str[2,5] = ls_saupno //사업자등록번호
//ls_str[2,6] = ls_saupnm  //상호
//ls_str[2,7] = ls_daepyo   //대표자성명
//ls_str[2,8] = ls_bupinno  //법인번호
//ls_str[2,13] = '0'  //법인세
//ls_str[2,17] = '' //공란
//
//SELECT TO_CHAR(SUM(NVL(P33PTT, 0) + NVL(P33RIR, 0))), /*퇴직급여액 총계 11 */
//TO_CHAR(SUM(NVL(P33TXR, 0))), /*소득세결정세액총계 12*/
//TO_CHAR(SUM(NVL(P33RTR, 0))), /*주민세결정세액총계 14*/
//TO_CHAR(SUM(NVL(P33FTR, 0))), /*농특세결정세액총계 15*/
//TO_CHAR(SUM(NVL(P33TXR, 0) + NVL(P33RTR, 0) + NVL(P33FTR, 0))), /*결정세액총계  16*/
//COUNT(*),  /*주현근무처수 9*/
//0 /*종전근무처수 10*/
//INTO :ls_str[2,11],
//:ls_str[2,12],
//:ls_str[2,14],
//:ls_str[2,15],
//:ls_str[2,16],
//:ls_str[2,9],
//:ls_str[2,10]
//   FROM PADB.TP33PYA0 A
//   WHERE ((LENGTH(TRIM(P33RTD)) = 8 AND SUBSTR(P33TDT,1, 4) = :as_year AND P33AJG = 'T' ) OR
//(LENGTH(TRIM(P33RTD)) <> 8 AND SUBSTR(P33JDT,1, 4) = :as_year AND P33AJG = 'J' ) )
////WHERE ((LENGTH(TRIM(P32RTD)) = 8 AND SUBSTR(P33TDT,1, 4) = :as_year ) OR
////(LENGTH(TRIM(P32RTD)) <> 8 AND SUBSTR(P33JDT,1, 4) = :as_year ) )
// AND	((:as_gu = '1' AND SUBSTR(P33NNO,1, 1) = 'K') Or
//	 			(:as_gu <> '1' AND SUBSTR(P33NNO,1, 1) <> 'K'))	
//USING SQLCA;					 
//
//
////A,B 레코드 filewrite
//ll_cnt = 0  //초기화
//
//For ll_i = 1 To 2
//	SELECT CAST(SUBSTR(MAX(ZCCCOMCD), 2, 3) AS NUMERIC)
//	INTO :ll_cnt
//	FROM CLVDTALB.TZCDA121 
//	WHERE ZCCSYSCD = 'MIS' 
//	AND ZCCGRPCD = 'EE6'    
//	AND SUBSTR(ZCCCOMCD, 1, 1) = :ls_record[ll_i]
//	USING SQLCA;
//	
//	ls_str_recode[ll_i] = ''	 //초기화
//	For ll_t = 1 To ll_cnt   
//		ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
//		ls_str_recode[ll_i] = ls_str_recode[ll_i] + ls_str[ll_i, ll_t]
//	Next
//	
//	FileWrite(li_FileNum, ls_str_recode[ll_i])
//Next
//
////################################################
////C 레코드
////################################################
//ls_str[3,1] = 'C'     //레코드구분
//ls_str[3,2] = '22'   //자료구분
//ls_str[3,3] = ls_tax  //세무서
////ls_str[3,4] =  //일련번호
//ls_str[3,5] = ls_saupno //사업자등록번호
//ls_str[3,6] = '0'
//ls_str[3,7] = '1'   //거주자구분코드
//ls_str[3,8] = ''  //거주지국코드
//ls_str[3,12] = '1'  //내외국인 코드
//ls_str[3,56] = ''  //공란
//
//
//
//
//DECLARE TP33PYA0 CURSOR FOR 
//SELECT P33NNO,
//	(CASE WHEN P33EGD <= CAST(:as_year AS  VARTO_CHAR(4)) || '0101' THEN CAST(:as_year AS  VARTO_CHAR(4)) || '0101'
//            ELSE P33EGD END),   /*귀속년도시작일 9*/
//      (CASE WHEN  LENGTH(TRIM(P33RTD)) = 8 THEN P33TDT ELSE CAST(:as_year AS  VARTO_CHAR(4)) || '1231' END) ,   /*귀속년도종료일 10*/    
//       H01KNM,  /*성명 11*/
//       H01RNO,  /*주민등록번호 13*/
//       TO_CHAR(NVL(P33PTT,0)),  /*퇴직급여 14*/
//       '0',  /*명예퇴직수당 15*/  
//       TO_CHAR(NVL(P33RIR,0)),   /*퇴직연금일시금 16 */
//       TO_CHAR(NVL(P33PTT,0) + NVL(P33RIR,0)),  /*계 17 */
//       TO_CHAR(NVL(P33IP2,0)),   /*비과세소득 18 */
//       '0',  /*퇴직연금 총수령액 19*/
//       '0',  /*퇴직연금 원리금합계액 20 */
//       '0',  /*퇴직연금 소득자불입액 21*/
//       '0',  /*퇴직연금 퇴지연금소득공제액 22 */
//       '0',  /*퇴직연금 일시금 23*/
//       '0',  /*퇴직연금 일시금지급예상액 24 */ 
//       '0',  /*퇴직연금 총일시금 25*/
//       '0',  /*수령가능퇴직급여액 26 */
//       '0',  /*환산퇴직소득공제27*/
//       '0',  /*환산퇴직소득과세표준 28 */
//       '0',  /*환산연평균과세표준 29*/
//       '0',  /*환산연평균산출세액 30 */
//       P33FDT,  /*퇴직금산정시작일: 31*/
//       P33TDT,  /*퇴사일자: 32 */
//       TO_CHAR(NVL(P33MON,0)),  /*근속월수: 33*/
//       TO_CHAR(NVL(CEIL(P33LOT/30/10) * 10, 0)),  /*휴직일수 34 */
//       '0',  /*종전근무지 입사연월일 35*/
//       '0',  /*종전근무지 퇴사연월일 36 */ 
//       '0',  /*종전근무지근속월수 37*/
//       '0',  /*종전근무지 제외월수 38 */
//       '0',  /*중복월수 39*/
//       TO_CHAR(NVL(P33YER, 0)),  /*근속년수 40 */
//      TO_CHAR(NVL(P33PTT,0)),  /*퇴직급여액 41*/
//       TO_CHAR(NVL(P33ICT, 0)),  /*퇴직소득공제 42*/
//       TO_CHAR(NVL(P33TRS, 0)),  /*퇴직소득과세표준 43 */
//       TO_CHAR(NVL(P33ATS,0)),  /*연평균과표: 44*/
//       TO_CHAR(NVL(P33YCT,0)),  /*연평균산출세액: 45 */ 
//       TO_CHAR(NVL(P33CTA,0)),  /*산출세액: 46*/
//       TO_CHAR(NVL(P33TYX,0)),  /*세액공제: 47 */
//       TO_CHAR(NVL(P33TXR,0)),  /*소득세: 48*/
//       TO_CHAR(NVL(P33RTR,0)),  /*주민세: 49 */
//       TO_CHAR(NVL(P33FTR,0)),  /*농특세: 50*/
//       TO_CHAR(NVL(P33TXR,0) + NVL(P33RTR, 0) + NVL(P33FTR, 0)), /*결정세액계 51*/
//       '0', /*종전근무지 소득세 52 */
//       '0', /*종전근무지 주민세 53*/
//        '0', /*종전근무지 농특세 54 */
//       '0'/*종전근무지 계 55*/
//   FROM PADB.TP33PYA0 A, PADB.TH01HRA0 B
//WHERE A.P33NNO = B.H01NNO
//AND ((LENGTH(TRIM(P33RTD)) = 8 AND SUBSTR(P33TDT,1, 4) = :as_year  AND P33AJG = 'T') OR
//(LENGTH(TRIM(P33RTD)) <> 8 AND SUBSTR(P33JDT,1, 4) = :as_year AND P33AJG = 'J' ) )
// AND	((:as_gu = '1' AND SUBSTR(P33NNO,1, 1) = 'K') Or
//	 			(:as_gu <> '1' AND SUBSTR(P33NNO,1, 1) <> 'K'))			 
//USING SQLCA;
////
//	OPEN TP33PYA0 ;
// 	FETCH TP33PYA0 INTO :ls_nno, 
//:ls_str[3,9], :ls_str[3,10], :ls_str[3,11],  :ls_str[3,13], :ls_str[3,14], :ls_str[3,15], :ls_str[3,16], :ls_str[3,17], :ls_str[3,18], :ls_str[3,19],
//:ls_str[3,20], :ls_str[3,21], :ls_str[3,22], :ls_str[3,23], :ls_str[3,24], :ls_str[3,25], :ls_str[3,26], :ls_str[3,27], :ls_str[3,28],
//:ls_str[3,29], :ls_str[3,30], :ls_str[3,31], :ls_str[3,32], :ls_str[3,33], :ls_str[3,34], :ls_str[3,35], :ls_str[3,36], :ls_str[3,37],
//:ls_str[3,38], :ls_str[3,39], :ls_str[3,40], :ls_str[3,41], :ls_str[3,42], :ls_str[3,43], :ls_str[3,44], :ls_str[3,45], :ls_str[3,46],
//:ls_str[3,47], :ls_str[3,48], :ls_str[3,49], :ls_str[3,50], :ls_str[3,51], :ls_str[3,52], :ls_str[3,53], :ls_str[3,54], :ls_str[3,55]
// ;
//	 DO WHILE SQLCA.SQLCODE = 0
//		
//	ll_seq ++
//	ls_str[3, 4] = String(ll_seq)
////C,D,E 레코드 filewrite
//ll_cnt = 0  //초기화
//
//ll_i = 3  //C레코드
//	//################################################
//	//D 레코드 : 없음
//	//################################################	
//	
//	
//
//		SELECT CAST(SUBSTR(MAX(ZCCCOMCD), 2, 3) AS NUMERIC)
//		INTO :ll_cnt
//		FROM CLVDTALB.TZCDA121 
//		WHERE ZCCSYSCD = 'MIS' 
//		AND ZCCGRPCD = 'EE6'    
//		AND SUBSTR(ZCCCOMCD, 1, 1) = :ls_record[ll_i]
//		USING SQLCA;
//		
//		
//		ls_str_recode[ll_i] = ''	 //초기화
//		For ll_t = 1 To ll_cnt   
//			ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
//			ls_str_recode[ll_i] = ls_str_recode[ll_i] + ls_str[ll_i, ll_t]
//		Next
//		//C레코드는 1번씩만 write 함
//			FileWrite(li_FileNum, ls_str_recode[ll_i])
//
//	
//
//
//	 	FETCH TP33PYA0 INTO :ls_nno, 
//:ls_str[3,9], :ls_str[3,10], :ls_str[3,11],  :ls_str[3,13], :ls_str[3,14], :ls_str[3,15], :ls_str[3,16], :ls_str[3,17], :ls_str[3,18], :ls_str[3,19],
//:ls_str[3,20], :ls_str[3,21], :ls_str[3,22], :ls_str[3,23], :ls_str[3,24], :ls_str[3,25], :ls_str[3,26], :ls_str[3,27], :ls_str[3,28],
//:ls_str[3,29], :ls_str[3,30], :ls_str[3,31], :ls_str[3,32], :ls_str[3,33], :ls_str[3,34], :ls_str[3,35], :ls_str[3,36], :ls_str[3,37],
//:ls_str[3,38], :ls_str[3,39], :ls_str[3,40], :ls_str[3,41], :ls_str[3,42], :ls_str[3,43], :ls_str[3,44], :ls_str[3,45], :ls_str[3,46],
//:ls_str[3,47], :ls_str[3,48], :ls_str[3,49], :ls_str[3,50], :ls_str[3,51], :ls_str[3,52], :ls_str[3,53], :ls_str[3,54], :ls_str[3,55]
//;
//	Loop
//     CLOSE TP33PYA0;
//		
//FileClose(li_FileNum)
//
//MESSAGEBOX('확인', '퇴직소득 지급조서 파일 작성이 완료 되었습니다. ~r~r' + &
//						ls_path + '파일을 확인해주세요')			
						
						
End Choose
End If

gvc_val.setproperty('yfilepath', ls_path)


RETURN 1
end function

public function integer of_year_create_dan (string as_std_yy, string as_gu, string as_dept_cd, string as_emp_no);//외국인단일세율 적용

Long ll_cnt, ll_i
Datetime ldt_cur
String ls_k, ls_emp_no
String ls_err
String ls_fr_mm, ls_to_mm


ldt_cur = func.of_get_datetime()


SELECT	SUBSTR(A.FDATE,1,6),	SUBSTR(A.TDATE,1,6)
	INTO	:ls_fr_mm, :ls_to_mm
	FROM	PADB.HPA022M A  
	WHERE	A.YEAR	=	:as_std_yy
USING SQLCA	;

If SQLCA.SQLCODE <> 0 Or Isnull(ls_fr_mm) or ls_fr_mm = '' Then 
	ROLLBACK USING SQLCA;
	Messagebox("알림", "연말정산 기간관리 데이터를 확인하세요!")
	RETURN -1
End If

SELECT COUNT(*)
    INTO :ll_cnt
    FROM PADB.HPA015M A, INDB.HIN001M B
 WHERE A.MEMBER_NO = B.MEMBER_NO
     AND (YEAR_MONTH BETWEEN :ls_fr_mm AND :ls_to_mm)
 	AND B.GWA LIKE :as_dept_cd
	 AND A.MEMBER_NO LIKE :as_emp_no
	  AND ( (:as_gu = 'J' AND ((B.HAKWONHIRE_DATE <= :as_std_yy  || '1231' 
AND B.JAEJIK_OPT <> 3) Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy || '1231' )
Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101' 
AND   
(NVL(PADB.FU_PAYPAY  (:ls_fr_mm,:ls_to_mm, B.MEMBER_NO),0) + NVL(PADB.FU_PAYBONUS(:ls_fr_mm,:ls_to_mm, B.MEMBER_NO),0)) > 0 )) )
 OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))	
 USING SQLCA;
 
 
 If SQLCA.SQLCODE = 100 Or ll_cnt = 0 Then
	
	SELECT COUNT(*)
    INTO :ll_cnt
    FROM PADB.HPAP42T A, INDB.HIN001M B
 WHERE A.P42NNO = B.MEMBER_NO
     AND A.P42YAR = :as_std_yy
 	AND B.GWA LIKE :as_dept_cd
	 AND A.P42NNO LIKE :as_emp_no
	 AND ( (:as_gu = 'J' AND ((B.HAKWONHIRE_DATE <= :as_std_yy  || '1231' 
AND B.JAEJIK_OPT <> 3) Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy || '1231' )
Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101' 
AND   
(NVL(PADB.FU_PAYPAY  (:ls_fr_mm,:ls_to_mm, B.MEMBER_NO),0) + NVL(PADB.FU_PAYBONUS(:ls_fr_mm,:ls_to_mm, B.MEMBER_NO),0)) > 0 )) )
 OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))	
 USING SQLCA;
	
	 If SQLCA.SQLCODE = 100 Or ll_cnt = 0 Then	
		ls_err = SQLCA.SQLERRTEXT
		ROLLBACK USING SQLCA;
		Messagebox("알림", "해당년도 급여자료가 존재하지 않습니다!~r" + ls_err)
		RETURN 0
	End If
End If


SELECT COUNT(*)
   INTO :ll_cnt
   FROM PADB.HPAP46T 
WHERE P46YAR = :as_std_yy
    AND P46GBN = :as_gu
    AND P46NNO LIKE :as_emp_no
    AND P46DCD  LIKE :as_dept_cd
USING SQLCA;

 If ll_cnt > 0 Then
	
	If as_emp_no = '%' Then 
		If Messagebox("알림", "해당년도 연말정산내역이 존재합니다.~r삭제 후 재생성 하시겠습니까?", Question!, YesNo! ,2) = 2 Then RETURN 0
	End If
		DELETE FROM PADB.HPAP46T
		WHERE P46YAR = :as_std_yy
		AND     P46GBN = :as_gu
		AND	  P46NNO	LIKE :as_emp_no
		AND	  P46DCD  LIKE :as_dept_cd
		USING SQLCA;
		
		If SQLCA.SQLCODE <> 0 Then
			ls_err = SQLCA.SQLERRTEXT
			ROLLBACK USING SQLCA;
			MESSAGEBOX("연말정산실행", "연말정산내역(PADB.HPAP46T) 삭제 에러!~r" + ls_Err)
			RETURN 0
		End If			
	
End If

//gf_openwait()
Setpointer(Hourglass!)



/*P46YAR	정산년도:
P46GBN	J:연말정산(재직자)T:연말정산(중퇴자):
P46NNO	사원번호:
P46KNM	한글명칭:
P46RNO	주민등록번호:
P46ZIP	우편번호:
P46AD1	우편주소:
P46AD2	상세주소:
P46PTL	급여총액:
P46BTL	상여총액:
P46ATL	인정상여:
P46PPL	최종월정급여:		-------------*
P46FEG	국외근로공제액:    
P46RND	연구활동비과세:
P46NGT	야간근로수당:		-------------*
P46BFM	출산보육수당:		-------------*
P46FFM	외국인근로자:		 
P46GFM	기타비과세:
P46TFM	비과세합계:
P46ICW	근로소득수입금액:
P46SBW	근로소득공제:
P46ICS	근로소득금액:
P46SFS	본인공제:
P46SPD	배우자유무:
P46SPS	배우자공제:
P46CPD	20세미만부양: 		-------------*
P46OPD	60세이상부양-부양가족:
P46STS	부양가족공제:
P46ODS	경로우대공제:
P46EPS	장애자공제:
P46VNS	부녀자세대주공제:
P46SUS	자녀양육비공제:
P46BTS	소수공제자추가공제:    -------------*
P46PEN	기타연금보험료공제:
P46DMD	퇴직연금:					   -------------* 확인필요
P46IPR	기납의료고용보험계:
P46ISU	외부보험료총액:
P46CMD	의료비총액:
P46EDM	교육비총액:
P46HND	주택자금총액:
P46DND	기부금총액:
P46SIS	보험료공제:
P46SCM	의료비공제:
P46SED	교육비공제:
P46SHN	주택마련저축소득공제:-------------*
P46SDN	기부금공제:
P46WSS	계(또는표준공제):
P46WSI	차감소득금액:
P46STK	개인연금총액:
P46INV	투자조합총액:
P46CTT	신용카드총액:
P46SST	개인연금저축공제-2000년이전가입:
P46INS	투자조합공제:
P46CRD	신용카드공제:
P46TSD	과세표준:
P46CTA	산출세액:
P46SAV	재형저축총액:
P46SAG	재형기금총액:
P46SKO	주택자금이자세총액:
P46OSK	주식저축총액:
P46DXW	근로소득세액공제:
P46TSA	재형저축세액공제:
P46TSK	주택차입금공제:
P46TOS	주식저축세액공제:
P46TFE	외국납부세액공제:
P46TFD	재형기금차감액:
P46TYX	세액공제계:
P46TXP	결정소득세:
P46RTR	결정주민세:
P46FTR	결정농특세:
P46JTX	전근무소득세징수액:
P46JRT	전근무주민세징수액:
P46JFT	전근무농특세징수액:
P46HTX	현근무소득세징수액:
P46HRT	현근무주민세징수액:
P46HFT	현근무농특세징수액:
P46CTX	차감소득세:
P46CRT	차감주민세:
P46CFT	차감농특세:
P46DCD	부서코드:
P46CMP	사업장:
P46FGP	직군:
P46FUN	직능:
P46GRD	직급:
P46OAG	65세이상경로:
P46HTH	장애자부양:
P46WHM	부녀자세대주유무:
P46CID	자녀양육인원:
P46NLF	Y:생보대상자:
P46XCD	사업자등록번호 1~3:
P46BNO	사업자등록번호:
P46DM1	주택이자상환액-거치기간10년:
P46DM2	연금저축-2001년이후가입:
P46DM3	장기저축-당해년도:
P46DM4	장기저축-전년도:
P46DM5	장기증권저축세액공제:
P46DM6	직불카드총액:
P46DM7	70세이상경로:
P46DM8	빈컬럼:
P46DM9	본인의료비:
P46DM0	혼인이사장례:
P46DMA	주택이자상환액-거치기간15년:
P46DMB	기부정치자금:
P46DMC	현금영수증:
P46DME	신용카드의료기관사용내역:
P46DMF	타인신용카드의료기관사용액:
P46DMG	의료비미공제액:
P46DMH	다자녀인원수:
P46DMI	다자녀추가공제:
P46DMJ	소기업소상공인공제부금소득공제:
P46DMK	납세조합공제:
P46DML	출산입양인원수:
P46DMM	출산입양공제:
P46DMN	국민연금보험료공제:
P46DMO	주택임차차입금원리금상환액:
P46DMP	장기주택저당차입금이자상환액:
P46DMQ	연간고용보험료:
P46DMR	연간의료보험료:
P46DMS	펀드소득공제:
CREDTE	등록일자:
CREUID	등록사번:
UPDDTE	수정일자:
UPDUID	수정사번:	
*/

INSERT INTO PADB.HPAP46T
(
P46YAR, P46GBN, P46NNO, P46KNM, P46RNO, 
P46ZIP, P46AD1, P46AD2, P46PTL, P46BTL, 
P46ATL, P46PPL, P46FEG, P46RND, P46NGT, P46BFM, 
P46FFM, P46GFM, P46TFM, P46ICW, P46SBW, 
P46ICS, P46SFS, P46SPD, P46SPS, P46CPD,
P46OPD, P46STS, P46ODS, P46EPS, P46VNS, 
P46SUS, P46BTS, P46PEN, P46DMD, P46IPR,
P46ISU, P46CMD, P46EDM, P46HND, P46DND, 
P46SIS, P46SCM, P46SED, P46SHN, P46SDN,
P46WSS, P46WSI, P46STK, P46INV, P46CTT,
P46SST, P46INS, P46CRD, P46TSD, P46CTA, 
P46SAV, P46SAG, P46SKO, P46OSK, P46DXW, 
P46TSA, P46TSK, P46TOS, P46TFE, P46TFD, 
P46TYX, P46TXP, P46RTR, P46FTR, P46JTX, 
P46JRT, P46JFT, P46HTX, P46HRT, P46HFT, 
P46CTX, P46CRT, P46CFT, P46DCD, P46CMP, 
P46FGP, P46FUN, P46GRD, P46OAG, P46HTH, 
P46WHM, P46CID, P46NLF, P46XCD, P46BNO, 
P46DM1, P46DM2, P46DM3, P46DM4, P46DM5, 
P46DM6, P46DM7, P46DM8, P46DM9, P46DM0, 
P46DMA, P46DMB, P46DMC, P46DME, P46DMF,
P46DMG, P46DMH, P46DMI, P46DMJ, P46DMK, 
P46DML, P46DMM, P46DMN, P46DMO, P46DMP, 
P46DMQ,  P46DMR, P46DMS, P46NAT, 
WORKER ,IPADD ,WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
SELECT :as_std_yy ,       :as_gu ,        B.MEMBER_NO,       
		B.NAME, /*한글명칭:*/
		B.JUMIN_NO, /*주민등록번호:*/
	    MAX((SELECT HOME_POSTNO FROM INDB.HIN011M WHERE MEMBER_NO = B.MEMBER_NO)) AS HOME_POSTNO,   /*우편번호:*/
        MAX((SELECT HOME_ADDR1 FROM INDB.HIN011M WHERE MEMBER_NO = B.MEMBER_NO))    AS HOME_ADDR1,   /* 우편주소:*/
        MAX((SELECT HOME_ADDR2 FROM INDB.HIN011M WHERE MEMBER_NO = B.MEMBER_NO))    AS HOME_ADDR2,  /*상세주소:*/
        NVL(padb.FU_PAYPAY(:ls_fr_mm, :ls_to_mm, b.Member_No),0)
                    -    NVL(padb.FU_PAYNONTAX(:ls_fr_mm, :ls_to_mm, b.Member_No,'1'),0)
                    -    NVL(padb.FU_PAYNONTAX(:ls_fr_mm, :ls_to_mm, b.Member_No,'2'),0)
                    -  NVL(D.FOREIGN_AMT,0)          AS P41PTL  ,      /*급여총액:*/
         NVL(padb.FU_PAYBONUS(:Ls_fr_mm, :Ls_to_mm, B.Member_No),0) AS P41BTL,   /*상여총액:*/
          NVL(C.P42ATL, 0) AS P46ATL,    /*인정상여: */
             0 AS P46PPL,    /*최종월정급여:*/ 
             NVL(C.P42FWK,0) + nvl(D.FOREIGN_AMT,0) AS P42FWK , /*국외근로공제액:*/ 
             NVL(C.P42RND, 0) + NVL(PADB.FU_PAYNONTAX(:ls_fr_mm, :ls_to_mm, b.Member_No,'2'),0) AS P42RND, /*연구활동비과세:*/
             NVL(C.P42NGT, 0) AS P46NGT, /*    야간근로수당:*/
             NVL(C.P42BON, 0) AS P46BFM,    /*출산보육수당:*/
            nvl(D.NON_TAXFOR_AMT,0)  AS P46FFM, /*     외국인근로자 */
            NVL(PADB.FU_PAYNONTAX(:ls_fr_mm, :ls_to_mm, B.MEMBER_NO,'1'),0) 
                        +  nvl(D.FOREIGN_AMT,0)
                             +  NVL(C.P42GFM, 0) AS P46GFM,     /*기타비과세: */
            NVL(C.P42FWK, 0) + nvl(D.FOREIGN_AMT,0) + NVL(D.NON_TAXFOR_AMT,0)
                                       + C.P42RND + NVL(PADB.FU_PAYNONTAX(:ls_fr_mm, :ls_to_mm, b.Member_No,'2'),0) 
                        + NVL(C.P42NGT, 0) + NVL(C.P42BON, 0) + NVL(PADB.FU_PAYNONTAX(:ls_fr_mm, :ls_to_mm, B.MEMBER_NO,'1'),0) 
                          + NVL(C.P42GFM, 0)                                                AS P46TFM,    /*비과세합계:   */
            NVL(PADB.FU_PAYPAY(:ls_fr_mm, :ls_to_mm, b.Member_No),0)
                    -    NVL(PADB.FU_PAYNONTAX(:ls_fr_mm, :ls_to_mm, b.Member_No,'1'),0)
                    -    NVL(PADB.FU_PAYNONTAX(:ls_fr_mm, :ls_to_mm, b.Member_No,'2'),0)
                    -  NVL(D.FOREIGN_AMT,0) 
                     + NVL(PADB.FU_PAYBONUS(:Ls_fr_mm, :Ls_to_mm, B.Member_No),0) 
             +  NVL(C.TAX_AMT, 0)  AS P46ICW,    /*근로소득수입금액: */
            0   AS P41SBW, /*근로소득공제:*/
             0   AS P41ICS,  /*근로소득금액:*/
             SUM(CASE WHEN A.P41DGB = '1101' THEN A.P41DEM ELSE 0 END) AS P41SFS , /*본인공제:*/
             (CASE WHEN SUM((CASE WHEN A.P41DGB = '1102' THEN  A.P41PCN ELSE 0 END)) = 1 THEN 'Y' ELSE 'N' END) AS P46SPD, /*배우자유무:*/
             SUM(CASE WHEN A.P41DGB = '1102' THEN A.P41DEM ELSE 0 END) AS P41SPS, /*배우자공제:*/
             0 AS P46CPD,    /*20세미만부양: */
             SUM(CASE WHEN A.P41DGB =  '1103' THEN  A.P41PCN ELSE 0 END) AS P46OPD, /*60세이상부양-부양가족:*/
             SUM(CASE WHEN A.P41DGB = '1103' THEN A.P41DEM ELSE 0 END) AS P41STS, /*부양가족공제:*/
             SUM(CASE WHEN A.P41DGB = '1201' THEN A.P41DEM ELSE (CASE WHEN A.P41DGB = '1202' THEN A.P41DEM ELSE 0 END) END) AS P41ODS, /*경로우대공제:*/
             SUM(CASE WHEN A.P41DGB = '1203' THEN A.P41DEM ELSE 0 END) AS P41EPS,/*장애자공제:*/
              SUM(CASE WHEN A.P41DGB = '1205' THEN A.P41DEM ELSE 0 END) AS P41VNS, /*부녀자세대주공제:*/
              SUM(CASE WHEN A.P41DGB = '1204' THEN A.P41DEM ELSE 0 END) AS P41SUS, /*자녀양육비공제:*/
                0   AS P41BTS,  /*소수공제자추가공제:*/
                 SUM(CASE WHEN A.P41DGB = '2102' THEN A.P41DEM ELSE 0 END)  AS P41PEN, /*기타연금보험료공제:*/
                 SUM(CASE WHEN A.P41DGB = '4103' THEN A.P41DEM ELSE 0 END) AS P46DMD, /*퇴직연금:    */
                 SUM(CASE WHEN A.P41DGB IN ('3101','3102') THEN A.P41SAM ELSE 0 END) AS P46IPR,/*기납의료고용보험계:*/
                SUM(CASE WHEN A.P41DGB IN ('3103','3104') THEN A.P41SAM ELSE 0 END) AS P46ISU, /*외부보험료총액:*/
                 MAX((SELECT SUM(NVL(P44PTL, 0)) 
                        FROM  PADB.HPAP44T A
                        WHERE P44YAR = :as_std_yy AND P44NNO = B.MEMBER_NO))  AS P46CMD, /*의료비총액:*/
            SUM(CASE WHEN A.P41DGB IN ('3301','3302','3303','3304','3305') THEN A.P41SAM ELSE 0 END) AS P46EDM ,     /*교육비총액:*/
            SUM(CASE WHEN A.P41DGB IN ('3402','3404','3405') THEN A.P41SAM ELSE 0 END) AS P46HND ,     /*주택자금총액:*/     
            MAX((SELECT SUM(NVL(P45PTL, 0))
                    FROM  PADB.HPAP45T A
                    WHERE P45YAR = :as_std_yy AND P45NNO = B.MEMBER_NO))  AS P46DND ,         /*기부금총액:*/ 
              SUM(CASE WHEN A.P41DGB IN ('3101','3102','3103','3104') THEN A.P41DEM ELSE 0 END) AS P46SIS,/*보험료공제:*/
              SUM(CASE WHEN A.P41DGB IN ('3201','3202') THEN A.P41DEM ELSE 0 END)  AS P46SCM, /*의료비공제:*/
              SUM(CASE WHEN A.P41DGB IN ('3301','3302','3303','3304','3305') THEN A.P41DEM ELSE 0 END) AS P46SED, /*교육비공제:*/
            SUM(CASE WHEN A.P41DGB = '3401' THEN A.P41DEM ELSE 0 END) AS P46SHN, /*주택마련저축소득공제:*/
            SUM(CASE WHEN A.P41DGB IN ('3501','3502','3503', '3504', '3505', '3506') THEN A.P41DEM ELSE 0 END)  AS P46SDN, /*기부금공제:*/
            0 AS P46WSS, /*계(또는표준공제):*/
            0 AS P46WSI, /*차감소득금액:*/
             SUM(CASE WHEN A.P41DGB = '4101' THEN A.P41SAM ELSE 0 END) AS P46STK, /*개인연금총액:*/
             SUM(CASE WHEN A.P41DGB = '4201' THEN A.P41SAM ELSE 0 END) AS P46INV, /*투자조합총액:*/
             SUM(CASE WHEN A.P41DGB = '4301' THEN A.P41SAM ELSE 0 END) AS P46CTT, /*신용카드총액:*/
            SUM(CASE WHEN A.P41DGB = '4101' THEN A.P41DEM ELSE 0 END)  AS P46SST    , /*개인연금저축공제-2000년이전가입:*/
             SUM(CASE WHEN A.P41DCD = '4200' THEN A.P41DEM ELSE 0 END) AS P46INS, /*투자조합공제:*/
            SUM(CASE WHEN A.P41DGB = '4301' THEN A.P41DEM ELSE 0 END)  AS P46CRD, /*신용카드공제:*/
            0 AS P46TSD, /*과세표준:*/
            0 AS P46CTA, /*산출세액:*/
            0 AS P46SAV, /*재형저축총액:*/
            0 AS P46SAG    , /*재형기금총액:*/
            SUM(CASE WHEN A.P41DGB = '4502' THEN A.P41SAM ELSE 0 END)  AS P46SKO, /*주택자금이자세총액:*/
            0 AS P46OSK, /*주식저축총액:*/
            0 AS P46DXW, /*근로소득세액공제:*/
            0 AS P46TSA, /*재형저축세액공제:*/
            SUM(CASE WHEN A.P41DGB = '4502' THEN A.P41DEM ELSE 0 END) AS P46TSK, /*주택차입금공제:*/
            0 AS P46TOS, /*주식저축세액공제:*/
            SUM(CASE WHEN A.P41DGB = '4507' THEN A.P41DEM ELSE 0 END) P46TFE    , /*외국납부세액공제:*/
            0 AS P46TFD, /*재형기금차감액:*/
            0 AS P46TYX, /*세액공제계:*/
            0 AS P46TXP    , /*결정소득세:*/
            0 AS P46RTR    , /*결정주민세:*/
            0 AS P46FTR    , /*결정농특세:*/
            C.P42TXR AS P46JTX    ,  /*전근무소득세징수액:*/
            C.P42RTR AS P46JRT    , /*전근무주민세징수액:*/
            C.P42FTR AS P46JFT    , /*전근무농특세징수액:*/
            NVL(PADB.FU_PAYTAX(:as_std_yy, B.MEMBER_NO, '1'),0) AS P46HTX, /*현근무소득세징수액:*/
            NVL(PADB.FU_PAYTAX(:as_std_yy, B.MEMBER_NO, '2'),0) AS P46HRT, /*현근무주민세징수액:*/
            0 AS P46HFT, /*현근무농특세징수액:*/
            0 AS P46CTX    , /*차감소득세:*/
            0 AS P46CRT    , /*차감주민세:*/
            0 AS P46CFT    , /*차감농특세:*/
            B.GWA    AS P46DCD, /*부서코드:*/
            ''    AS P46CMP, /*회사구분*/
            B.JIKWI_CODE     AS P46FGP, /*직군:*/
            B.JIKMU_CODE    AS P46FUN, /*직능:*/
            B.DUTY_CODE    AS P46GRD, /*직급:*/
            SUM(CASE WHEN A.P41DGB = '1202' THEN A.P41PCN ELSE 0 END)  AS P46OAG, /*65세이상경로:*/
             SUM(CASE WHEN A.P41DGB = '1203' THEN A.P41PCN ELSE 0 END)  AS P46HTH, /*장애자부양:*/
             (CASE WHEN SUM(CASE WHEN A.P41DGB = '1205' THEN A.P41PCN ELSE 0 END) = 1 THEN 'Y'  ELSE 'N' END)  AS P46WHM    , /*부녀자세대주유무:*/
            SUM(CASE WHEN A.P41DGB = '1204' THEN A.P41PCN ELSE 0 END) AS P46CID    , /*자녀양육인원:*/
            'N' AS P46NLF, /*Y:생보대상자: */
            ''    AS P46XCD    , /*사업자등록번호 1~3: */
            ''  AS P46BNO    ,/*사업자등록번호: */
            0 AS P46DM1,    /*주택이자상환액-거치기간10년: */
             SUM(CASE WHEN A.P41DGB = '4102' THEN A.P41DEM ELSE 0 END) AS P46DM2, /*    연금저축-2001년이후가입: */
            0 AS P46DM3,    /*장기저축-당해년도:*/
            0 AS P46DM4,    /*장기저축-전년도:*/
            0 AS P46DM5,    /*장기증권저축세액공제:*/
            0 AS P46DM6,    /*직불카드총액:*/
             SUM(CASE WHEN A.P41DGB = '1201' THEN A.P41PCN ELSE 0 END) AS P46DM7,    /*70세이상경로: */
            0 AS P46DM8    ,
            SUM(CASE WHEN A.P41DGB = '3201' THEN A.P41DEM ELSE 0 END) AS P46DM9,    /*본인의료비:*/
            SUM(CASE WHEN A.P41DGB = '3601' THEN A.P41DEM ELSE 0 END) AS P46DM0,    /*혼인이사장례:*/
            0 AS P46DMA,    /*주택이자상환액-거치기간15년: */
            SUM(CASE WHEN A.P41DGB = '4501' THEN A.P41DEM ELSE 0 END) AS P46DMB,    /*기부정치자금:*/
            0 AS P46DMC,     /*현금영수증: */
            0 AS P46DME,     /*신용카드의료기관사용내역: */
            0 AS P46DMF,    /*타인신용카드의료기관사용액:*/
            0    AS P46DMG,     /*의료비미공제액:*/
            SUM(CASE WHEN A.P41DGB = '1206' THEN A.P41PCN ELSE (CASE WHEN A.P41DGB = '1207' THEN A.P41PCN ELSE 0 END) END) AS  P46DMH, /*    다자녀인원수:*/
            SUM(CASE WHEN A.P41DGB = '1206' THEN A.P41DEM ELSE (CASE WHEN A.P41DGB = '1207' THEN A.P41DEM ELSE 0 END) END) AS P46DMI,    /*다자녀추가공제:*/
            SUM(CASE WHEN A.P41DGB = '4601' THEN A.P41DEM ELSE 0 END) AS P46DMJ,    /*소기업소상공인공제부금소득공제: */
            SUM(CASE WHEN A.P41DGB = '4505' THEN A.P41DEM ELSE 0 END) AS P46DMK,    /*납세조합공제:*/
            SUM(CASE WHEN A.P41DGB = '1208' THEN A.P41PCN ELSE 0 END) AS P46DML,    /*출산입양인원수:*/
            SUM(CASE WHEN A.P41DGB = '1208' THEN A.P41DEM ELSE 0 END)  AS P46DMM,     /*출산입양공제:*/
            SUM(CASE WHEN A.P41DGB = '2101' THEN A.P41DEM ELSE 0 END)  AS P46DMN,    /*국민연금보험료공제: */
            SUM(CASE WHEN A.P41DGB = '3402' THEN A.P41DEM ELSE 0 END)  AS P46DMO,    /*주택임차차입금원리금상환액: */
            SUM(CASE WHEN A.P41DGB IN ('3404', '3405') THEN A.P41DEM ELSE 0 END)  AS P46DMP,    /*장기주택저당차입금이자상환액:*/
            SUM(CASE WHEN A.P41DGB = '3102' THEN A.P41DEM ELSE 0 END)  AS P46DMQ,    /*연간고용보험료:*/
            SUM(CASE WHEN A.P41DGB = '3101' THEN A.P41DEM ELSE 0 END) AS P46DMR,    /*연간의료보험료:*/
            SUM(CASE WHEN A.P41DGB IN ('4701','4702','4703') THEN A.P41DEM ELSE 0 END)  AS P46DMS, /*펀드소득공제 */
            MAX((SELECT ETC_CD1    FROM CDDB.KCH102D 
                    WHERE UPPER(CODE_GB) = 'KUKJUK_CODE'   
                    AND         CODE = to_char(B.NATION_CODE))) AS P46NAT,  /*국적*/             
            :gs_empcode, :gs_ip, sysdate, :gs_empcode, :gs_ip, sysdate    
FROM PADB.HPAP41D A, INDB.HIN001M B,
 (                    
SELECT P42NNO AS MEMBER_NO, SUM(NVL(P42PTL, 0)  + NVL(P42BTL,0) + NVL(P42ATL, 0)) AS TAX_AMT,
       SUM(NVL(P42NGT, 0) ) AS P42NGT,
       SUM( NVL(P42GFM, 0)) AS P42GFM,
       SUM( NVL(P42RND, 0)) AS P42RND,
       SUM( NVL(P42FWK, 0)) AS P42FWK,
       SUM( NVL(P42BON, 0)) AS P42BON,
       SUM(NVL(P42TXR, 0))  AS P42TXR,
       SUM(NVL(P42RTR, 0)) AS P42RTR,
       SUM(NVL(P42FTR, 0))  AS P42FTR,
       SUM(NVL(P42ATL, 0))  AS P42ATL
    FROM   PADB.HPAP42T 
WHERE P42YAR = :as_std_yy 
                    GROUP BY P42NNO 
) C,
(SELECT MEMBER_NO, SUM(NVL(FOREIGN_AMT,0)) AS FOREIGN_AMT, SUM(NVL(NON_TAXFOR_AMT,0)) AS NON_TAXFOR_AMT
                            FROM    PADB.HPA019H 
                            WHERE    YEAR     =    :as_std_yy
                            GROUP BY MEMBER_NO) D 
WHERE A.P41NNO = B.MEMBER_NO 
AND   A.P41NNO = C.MEMBER_NO(+)
AND   A.P41NNO = D.MEMBER_NO(+)
AND   A.P41YAR = :as_std_yy     
AND   A.P41AJG = :as_gu
AND   B.MEMBER_NO LIKE :as_emp_no
AND   B.GWA LIKE :as_dept_cd
 AND ( (:as_gu = 'J' AND ((B.HAKWONHIRE_DATE <= :as_std_yy  || '1231' 
AND B.JAEJIK_OPT <> 3) Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE > :as_std_yy || '1231' )
Or (B.JAEJIK_OPT = 3 AND  B.RETIRE_DATE < :as_std_yy  || '0101' 
AND   
(NVL(PADB.FU_PAYPAY  (:ls_fr_mm,:ls_to_mm, B.MEMBER_NO),0) + NVL(PADB.FU_PAYBONUS(:ls_fr_mm,:ls_to_mm, B.MEMBER_NO),0)) > 0 )) )
 OR (:as_gu = 'T' AND B.JAEJIK_OPT = 3 AND SUBSTR(B.RETIRE_DATE  , 1, 4) = :as_std_yy))    
GROUP BY B.MEMBER_NO, B.GWA, B.NAME, B.JUMIN_NO,  B.JIKWI_CODE, 
                B.JIKMU_CODE, B.DUTY_CODE, C.TAX_AMT,
    C.P42NGT,         C.P42GFM, C.P42RND, C.P42FWK, C.P42BON, C.P42TXR, C.P42RTR, C.P42FTR, C.P42ATL, D.FOREIGN_AMT, D.NON_TAXFOR_AMT
USING SQLCA;


If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산내역(PADB.HPAP46T) INSERT 에러!~r" + ls_err)

	Setpointer(Arrow!)
	RETURN 0
End If

//근로자소득공제/과세대상근로소득금액
 UPDATE PADB.HPAP46T B
 SET (P46SBW, P46ICS)
 = 
 ( 
 SELECT (CASE WHEN A.IS_ALIEN = 'N' THEN (CASE WHEN A.P46ICW <= 5000000 THEN TRUNC(A.P46ICW * A.P48RTE * 0.01, 0) ELSE TRUNC(A.P48AM1 + (A.P46ICW - A.P48AM2) * A.P48RTE * 0.01 , 0) END)
			ELSE 0 END) ,
			(CASE WHEN A.IS_ALIEN = 'N' THEN (CASE WHEN A.P46ICW <= 5000000 THEN 0 ELSE A.P46ICW -  TRUNC(A.P48AM1 + (A.P46ICW - A.P48AM2) * A.P48RTE * 0.01, 0) END)
		ELSE B.P46ICW END)
FROM (
SELECT A.P46YAR, A.P46GBN, A.P46NNO,
       A.P46ICW,
       NVL((SELECT P48AM1 
       FROM PADB.HPAP48M
       WHERE P48YAR = :as_std_yy
       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE  P48YAR = :as_std_yy AND P48ATU >= A.P46ICW   ) ), 0) AS P48AM1,
     NVL((SELECT P48AM2
       FROM PADB.HPAP48M
       WHERE P48YAR = :as_std_yy 
       AND  P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE P48YAR = :as_std_yy AND P48ATU >= A.P46ICW )),0) AS P48AM2,
     NVL((SELECT P48RTE 
       FROM PADB.HPAP48M
       WHERE P48YAR = :as_std_yy
       AND P48ATU = (SELECT MIN(P48ATU) FROM PADB.HPAP48M WHERE P48YAR = :as_std_yy AND  P48ATU >= A.P46ICW )),0)     AS P48RTE,
       M.IS_ALIEN  AS  IS_ALIEN
FROM PADB.HPAP46T A, INDB.HIN001M M
WHERE	A.P46NNO = M.MEMBER_NO
AND A.P46YAR = :as_std_yy
AND A.P46GBN =  :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
	) A
WHERE A.P46YAR = B.P46YAR
AND A.P46GBN = B.P46GBN
AND A.P46NNO = B.P46NNO )
WHERE	B.P46YAR = :as_std_yy
AND B.P46GBN =  :as_gu
AND B.P46NNO LIKE :as_emp_no
AND B.P46DCD LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행", "연말정산내역(PADB.HPAP46T) 세액계산 UPDATE 에러!~r" + ls_Err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

//특별공제계(또는표준공제), 차감소득금액,  종합소득과세표준, 세액공제계
UPDATE PADB.HPAP46T A
   SET   
       A.P46WSS  =   (CASE WHEN (SELECT IS_ALIEN FROM INDB.HIN001M WHERE MEMBER_NO = A.P46NNO) = 'N' THEN  NVL(A.P46SIS, 0) +   /*보험료공제 */
					 NVL(A.P46SCM, 0) +    /*의료비공제:*/
					 NVL(A.P46SED, 0) +    /*교육비공제 */
					 NVL(A.P46DMO, 0) + /*주택임차차입금원리금상환액: */
					 NVL(A.P46DMP, 0) +  /*장기주택저당차입금이자상환액:*/
					 NVL(A.P46SDN, 0)  + /*기부금공제:*/
					 NVL(A.P46DM0, 0) ELSE 0 END)	 ,
       A.P46WSI = (CASE WHEN (SELECT IS_ALIEN FROM INDB.HIN001M WHERE MEMBER_NO = A.P46NNO) = 'N' THEN NVL(A.P46ICS,0) - 
       (NVL(A.P46SFS, 0) +
       NVL(A.P46SPS, 0) +
       NVL(A.P46ODS, 0) +
       NVL(A.P46EPS, 0) +
       NVL(A.P46STS, 0) +
       NVL(A.P46VNS, 0) +         
       NVL(A.P46SUS, 0) +
		  NVL(A.P46DMM, 0) +
       NVL(A.P46DMI, 0) +
       NVL(A.P46DMN, 0) +
		 NVL(A.P46PEN, 0) +
		 NVL(A.P46DMD, 0) +
	   (CASE WHEN (NVL(A.P46SIS, 0) +   /*보험료공제 */
			 NVL(A.P46SCM, 0) +    /*의료비공제:*/
			 NVL(A.P46SED, 0) +    /*교육비공제 */
			 NVL(A.P46DMO, 0) + /*주택임차차입금원리금상환액: */
			 NVL(A.P46DMP, 0) +  /*장기주택저당차입금이자상환액:*/
			 NVL(A.P46SDN, 0)  + /*기부금공제:*/
			 NVL(A.P46DM0, 0)   /*혼인이사장례:*/ ) < 1000000 THEN 1000000 ELSE 
		 (NVL(A.P46SIS, 0) +   /*보험료공제 */
		 NVL(A.P46SCM, 0) +    /*의료비공제:*/
		 NVL(A.P46SED, 0) +    /*교육비공제 */
		 NVL(A.P46DMO, 0) + /*주택임차차입금원리금상환액: */
		 NVL(A.P46DMP, 0) +  /*장기주택저당차입금이자상환액:*/
		 NVL(A.P46SDN, 0)  + /*기부금공제:*/
		 NVL(A.P46DM0, 0) /*혼인이사장례:*/)   END)) ELSE A.P46ICW END),
       A.P46TSD = (CASE WHEN A.P46NAT = 'KR' THEN NVL(A.P46ICS,0) - 
						 (NVL(A.P46SFS, 0) +
						 NVL(A.P46SPS, 0) +
						 NVL(A.P46ODS, 0) +
						 NVL(A.P46EPS, 0) +
						 NVL(A.P46STS, 0) +
						 NVL(A.P46VNS, 0) +         
						 NVL(A.P46SUS, 0) +
						  NVL(A.P46DMM, 0) +
						 NVL(A.P46DMI, 0) +
						 NVL(A.P46DMN, 0) +
						 NVL(A.P46PEN, 0) +
						 NVL(A.P46DMD, 0) +
						(CASE WHEN (NVL(A.P46SIS, 0) +   /*보험료공제 */
							 NVL(A.P46SCM, 0) +    /*의료비공제:*/
							 NVL(A.P46SED, 0) +    /*교육비공제 */
							 NVL(A.P46DMO, 0) + /*주택임차차입금원리금상환액: */
							 NVL(A.P46DMP, 0) +  /*장기주택저당차입금이자상환액:*/
							 NVL(A.P46SDN, 0)  + /*기부금공제:*/
							 NVL(A.P46DM0, 0) /*혼인이사장례:*/) < 1000000 THEN 1000000 ELSE 
						 (NVL(A.P46SIS, 0) +   /*보험료공제 */
						 NVL(A.P46SCM, 0) +    /*의료비공제:*/
						 NVL(A.P46SED, 0) +    /*교육비공제 */
						 NVL(A.P46DMO, 0) + /*주택임차차입금원리금상환액: */
						 NVL(A.P46DMP, 0) +  /*장기주택저당차입금이자상환액:*/
						 NVL(A.P46SDN, 0)  + /*기부금공제:*/
						 NVL(A.P46DM0, 0) /*혼인이사장례:*/)   END) +
       NVL(A.P46SST, 0) +
       NVL(A.P46DM2, 0) +
		  NVL(A.P46DMJ, 0) +
		    NVL(A.P46SHN, 0) +
       NVL(A.P46INS, 0) +
       NVL(A.P46CRD, 0) +
	  NVL(A.P46DMS, 0)	 )  ELSE A.P46ICW END)  	   
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
USING SQLCA;


If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 차감소득금액 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If



//
//세액계산 :  산출세액 UPDATE
UPDATE PADB.HPAP46T A
SET P46CTA = (CASE WHEN A.P46NAT = 'KR' THEN (SELECT TRUNC(A.P46TSD    * TAX_RATE * 0.01 - TAX_SUM_AMT, 0)  
					FROM PADB.HPA013M
					WHERE   TAX_YEAR = :as_std_yy 
					AND   TAX_FROM_DATE = (SELECT MIN(TAX_FROM_DATE) 
								FROM PADB.HPA013M 
								WHERE TAX_YEAR = :as_std_yy 
								  AND TAX_TO_DATE >= A.P46TSD)) ELSE TRUNC(A.P46TSD *  NVL((SELECT TO_NUMBER(NVL(ETC_CD1, '0')) 
										FROM CDDB.KCH102D
										WHERE CODE_GB = 'HPA05'
										AND CODE = :as_std_yy), 0) * 0.01, 0) END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 산출세액 UPDATE 에러!~r" + ls_err)
//	gf_closewait()
Setpointer(Arrow!)
	RETURN 0
End If

//세액계산 :  근로소득세액공제 UPDATE
UPDATE PADB.HPAP46T A
SET P46DXW =   (CASE WHEN A.P46NAT = 'KR' THEN (CASE WHEN NVL(A.P46CTA, 0) > 500000 THEN 
							(CASE WHEN TRUNC(((A.P46CTA - 500000) * 0.3 + 275000), 0) > 500000 THEN 500000
								ELSE TRUNC(((A.P46CTA - 500000) * 0.3 + 275000), 0) END)
				    ELSE TRUNC((A.P46CTA * 0.55) , 0) END) ELSE 0 END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 근로소득세액공제 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

// 세액공제계
UPDATE PADB.HPAP46T A
SET P46TYX =   (CASE WHEN A.P46NAT = 'KR' THEN NVL(P46DXW,0) 
                                                  + NVL(P46DMK, 0) + NVL(P46TSK,0)  
								              + NVL(P46DMB,0) + NVL(P46TFE,0) ELSE 0 END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제계 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


//소득세
UPDATE PADB.HPAP46T A
SET P46TXP =  (CASE WHEN A.P46NAT = 'KR' THEN NVL(P46CTA, 0) - NVL(P46TYX, 0)
							ELSE TRUNC(A.P46TSD * NVL((SELECT TO_NUMBER(NVL(ETC_CD1, '0')) 
										FROM CDDB.KCH102D
										WHERE CODE_GB = 'HPA05'
										AND CODE = :as_std_yy), 0) * 0.01
, 0) END)															
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 소득세 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


//주민세
UPDATE PADB.HPAP46T A
SET P46RTR = TRUNC(NVL(P46TXP, 0) * 0.1,0)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 주민세 UPDATE 에러!~r" + ls_Err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If
//
//차감소득금액이 0보다 작거나 같으면 이하 0update
UPDATE PADB.HPAP46T A
SET P46WSI = 0,
P46SST	 =0,
P46DM2 = 0,
P46DMJ = 0,
P46SHN = 0,
P46INS = 0,
P46CRD = 0,
P46DMS = 0,
P46TSD	 = 0, 
P46CTA = 0,
P46DXW = 0,
P46DMK = 0, 
P46TSK = 0,
P46DMB = 0, 
P46TFE = 0,
P46TYX = 0,
P46TXP = 0,
P46RTR =0, 
P46FTR = 0
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46WSI, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 차감소득금액 0  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

//종합소득과세표준 0보다 작거나 같으면 이하 0update

UPDATE PADB.HPAP46T A
SET P46SST	 =  (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) <= 0 THEN NVL(P46WSI,0)
													ELSE  NVL(P46SST,0)  END) 
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(개인연금저축)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

UPDATE PADB.HPAP46T A
SET P46DM2 = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) <= 0 THEN NVL(P46WSI,0) - NVL(P46SST,0)
									   ELSE  NVL(P46DM2,0) END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(연금저축)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


UPDATE PADB.HPAP46T A
SET P46DMJ = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) <= 0 THEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0)
									  ELSE  NVL(P46DMJ,0) END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(소기업소상공인)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


UPDATE PADB.HPAP46T A
SET P46SHN = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) <= 0 THEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0)
									   ELSE   NVL(P46SHN, 0) END)  
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(주택마련저축)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

UPDATE PADB.HPAP46T A
SET P46INS = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0)  - NVL(P46INS,0) <= 0 THEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) 
									   ELSE  NVL(P46INS,0) END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(투자조합출자)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If
							
							
UPDATE PADB.HPAP46T A
SET P46CRD = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) - NVL(P46INS,0) - NVL(P46CRD,0) <= 0 THEN 
                      NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) - NVL(P46INS,0)
									    ELSE   NVL(P46CRD,0)  END)  
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(신용카드)  UPDATE 에러!~r" + ls_Err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

UPDATE PADB.HPAP46T A
SET P46DMS = (CASE WHEN NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) - NVL(P46INS,0) - NVL(P46CRD,0)  - NVL(P46DMS, 0) <= 0 THEN 
                     NVL(P46WSI,0) - NVL(P46SST,0) - NVL(P46DM2,0) - NVL(P46DMJ, 0) - NVL(P46SHN, 0) - NVL(P46INS,0) - NVL(P46CRD,0) 
									    ELSE NVL(P46DMS,0) 
									 END) 
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0(장기주식형저축소득공제)  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

 



UPDATE PADB.HPAP46T A
SET 
P46TSD	 = 0, 
P46CTA = 0,
P46DXW = 0,
P46DMK = 0, 
P46TSK = 0,
P46DMB = 0, 
P46TFE = 0,
P46TYX = 0,
P46TXP = 0,
P46RTR =0, 
P46FTR = 0
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TSD, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 종합소득과세표준 0  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


// 결정세액 0보다 작거나 같으면 이하 0update

UPDATE PADB.HPAP46T A
SET P46DXW	 =  (CASE WHEN NVL(P46CTA, 0)  - NVL(P46DXW,0) <= 0 THEN NVL(P46CTA, 0)										     
											ELSE  NVL(P46DXW,0)  END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0 (근로소득세액공제) UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

UPDATE PADB.HPAP46T A
SET P46DMK	 =  (CASE WHEN NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0) <= 0 THEN  NVL(P46CTA, 0)  - NVL(P46DXW,0)								     
											ELSE  NVL(P46DMK,0)  END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0 (납세조합공제) UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


UPDATE PADB.HPAP46T A
SET P46TSK	 =  (CASE WHEN NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0)  - NVL(P46TSK,0) <= 0 THEN 
					 NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0)
											ELSE  NVL(P46TSK,0)  END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0 (주택차입금공제) UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


UPDATE PADB.HPAP46T A
SET P46DMB	 =  (CASE WHEN NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0)  - NVL(P46TSK,0)   - NVL(P46DMB,0) <= 0 THEN 
					 NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0) - NVL(P46TSK,0) 
											ELSE  NVL(P46DMB,0)  END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0 (기부정치자금) UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

UPDATE PADB.HPAP46T A
SET P46TFE	 =  (CASE WHEN NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0)  - NVL(P46TSK,0)   - NVL(P46DMB,0)     - NVL(P46TFE,0) <= 0 THEN 
					 NVL(P46CTA, 0)  - NVL(P46DXW,0)   - NVL(P46DMK,0) - NVL(P46TSK,0)  - NVL(P46DMB,0)
											ELSE  NVL(P46TFE,0)  END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0 (최국납부세액공제) UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


UPDATE PADB.HPAP46T A
SET 
P46TXP = 0,
P46RTR =0, 
P46FTR = 0
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제 0  UPDATE 에러!~r" + ls_Err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If

// 결정세액 0보다 작거나 같으면 이하 0update
// 세액공제계 = 근로소득세액공제 + 납세조합공제 + 주택차입금 + 기부정치자금 + 외국납부
UPDATE PADB.HPAP46T A
SET  P46TYX = NVL(P46DXW, 0) + NVL(P46DMK, 0) + NVL(P46TSK, 0) +
											 NVL(P46DMB, 0) + NVL(P46TFE,0)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND NVL(P46TXP, 0) <= 0
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 세액공제계 0  UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


//농특세 :  주택자금 차입금이자세액공제 또는 투자조합출자 소득공제가 있을 경우
UPDATE PADB.HPAP46T A
SET P46FTR = (CASE WHEN NVL(P46TSK, 0) > 0 THEN P46TSK * 0.2 ELSE 0 END) +
					(CASE WHEN NVL(P46INS, 0) > 0 THEN 			
							(((SELECT TRUNC((A.P46TSD + A.P46INS )  -  ROUND((A.P46TSD + A.P46INS )   * TAX_RATE * 0.01 - TAX_SUM_AMT, 0), 0)  FROM PADB.HPA013M
							WHERE  TAX_YEAR = :as_std_yy 
							  AND TAX_FROM_DATE = (SELECT MIN(TAX_FROM_DATE) FROM PADB.HPA013M WHERE   
                                          TAX_YEAR = :as_std_yy  AND TAX_TO_DATE >= (A.P46TSD + A.P46INS))) - A.P46CTA) * 0.2)
                    ELSE 0 END)
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
AND P46TSK > 0 OR P46INS > 0				 
USING SQLCA;


If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 농특세   UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If





//차감징수세액(소득세)
UPDATE PADB.HPAP46T A
SET P46CTX = TRUNC((NVL(P46TXP, 0))/10 , 0) * 10 - NVL(P46JTX, 0) - NVL(P46HTX, 0),
      P46CRT = TRUNC((NVL(P46RTR, 0))/10 , 0) * 10 - NVL(P46JRT, 0) -  NVL(P46HRT, 0),
	P46CFT = TRUNC((NVL(P46FTR, 0))/10 , 0) * 10 - NVL(P46JFT, 0) - NVL(P46HFT, 0)	
WHERE  A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 차감징수세액 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If


//UPDATE PADB.HPAP46T A
//SET	 P46BFM = NVL((SELECT SUM(NVL(P02P37, 0)) FROM PADB.TP02PYA0  WHERE SUBSTR(P02RDT, 1, 4) = A.P46YAR AND P02NNO = A.P46NNO), 0)
//WHERE   A.P46YAR = :as_std_yy
//AND A.P46GBN = :as_gu
//AND A.P46NNO LIKE :as_emp_no
//AND A.P46DCD LIKE :as_dept_cd
//
//USING SQLCA;			
//
//If SQLCA.SQLCODE <> 0 Then
//	ls_err = SQLCA.SQLERRTEXT
//	ROLLBACK USING SQLCA;
//	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 출산축의금 UPDATE 에러!~r" + ls_err)
//	//gf_closewait()
//	Setpointer(Arrow!)
//	RETURN 0
//End If

//2009.06.02 이경진 대리 요청으로 출산축의금만 보여지게 하기 위해 비과세 주석처리
//
////UPDATE PADB.HPAP46T A
////SET	 P46GFM = NVL(P46GFM, 0) + NVL(( SELECT  SUM( NVL(P02S03, 0) + NVL(P02S04, 0)  + NVL(P02S18, 0))	
////FROM PADB.TP02PYA0 WHERE ( SUBSTR(P02RDT, 1, 6) BETWEEN A.P46YAR || '01' AND A.P46YAR || '04' ) AND P02NNO = A.P46NNO), 0)
////WHERE   A.P46YAR = :as_std_yy
////AND A.P46GBN = :as_gu
////AND A.P46NNO LIKE :as_emp_no
////AND A.P46DCD LIKE :as_dept_cd
////USING SQLCA;			
////
////If SQLCA.SQLCODE <> 0 Then
////	ls_err = SQLCA.SQLERRTEXT
////	ROLLBACK USING SQLCA;
////	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 기타비과세 UPDATE 에러!~r" + ls_err)
////	//gf_closewait()
////	Setpointer(Arrow!)
////	RETURN 0
////End If


UPDATE PADB.HPAP46T A
SET	 P46TFM = NVL(P46FEG,0) +  NVL(P46RND,0) + NVL( P46NGT,0) + NVL( P46BFM, 0) + NVL(P46GFM, 0)
WHERE   A.P46YAR = :as_std_yy
AND A.P46GBN = :as_gu
AND A.P46NNO LIKE :as_emp_no
AND A.P46DCD LIKE :as_dept_cd
USING SQLCA;			

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("연말정산실행",  "연말정산내역(PADB.HPAP46T) 비과세총액 UPDATE 에러!~r" + ls_err)
	//gf_closewait()
	Setpointer(Arrow!)
	RETURN 0
End If



//gf_closewait()
Setpointer(Arrow!)

RETURN 1

end function

public function integer of_year_file_2008 (string as_gu, string as_year, string as_jdt, string as_file);/*
as_gu :캡스/캡스텍 1 : 2
as_year : 정산년도
as_jdt : 정산일자

*/

//사업자등록번호, 대표자명
String ls_saupno, ls_saupnm, ls_daepyo, ls_bupinno
String ls_tax, ls_dnm, ls_knm, ls_tel, ls_fax, ls_htx, ls_wkg


SELECT BUSINESS_NO,  /*사업자번호 */
		CAMPUS_NAME,  /*상호 */
		PRESIDENT, /*대표자*/
		CORP_NO, /*법인등록번호*/
	TAX_OFFICE_CODE,		/*세무서: */
TEL_PHONE,  /*	담당전화번호: */
NVL(FAX_PHONE, ' ') 	/*담당팩스번호: */
INTO :ls_saupno, : ls_saupnm, :ls_daepyo, :ls_bupinno, :ls_tax,  :ls_tel, :ls_fax
FROM CDDB.KCH000M
 USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	Messagebox("연말정산지급조서생성", "회사정보 가져오기 중 에러!")
	RETURN -1
End If


SELECT NVL(ETC_CD1, ' '), NVL(ETC_CD2, ' '), NVL(ETC_CD3, ' ')
INTO :ls_dnm, :ls_knm, :ls_htx
FROM CDDB.KCH102D
WHERE CODE_GB = 'HPA01' 
AND CODE = 'HPA01'
USING SQLCA;

If SQLCA.SQLCODE = 100 or ls_dnm = '' Or ls_knm = '' or ls_htx = '' Then
	Messagebox("알림", "공통코드 HPA01 연말정산신고담당 정보를 확인하세요!")
	RETURN -1
End if




String ls_type[5,113], ls_str[5,113]
Long ll_len[5, 113]
String ls_record[],  ls_str_recode[]
String ls_cod
Long ll_cnt, ll_i, ll_t
String ls_cd
String ls_nno //사번

String ls_pgm_name, ls_path, ls_file
Int li_rc, li_FileNum

ls_pgm_name = as_file + left(ls_saupno, 7) + "." + right(ls_saupno, 3)

	ls_path = "C:\CAPSERP\Download\" + ls_pgm_name 
			li_rc = GetFileSaveName ( "Select File", ls_path, ls_pgm_name, right(ls_saupno, 3),  right(ls_saupno, 3) + " (*.*), *." +  right(ls_saupno, 3), "C:\My Documents", 32770)
	
	IF li_rc = 1 Then
		IF FileExists(ls_path) THEN
			If MessageBox("확인", ls_path + "은(는) 이미 있습니다.~r~n바꾸시겠습니까?", Question!, YesNo!) = 2 Then Return -1
			FileDelete(ls_path)
		End If
		
		li_FileNum = FileOpen(ls_path, LineMode!, Write!, LockWrite!, Append!)
Choose Case as_file
	Case 'C'

ls_record[1] = 'A'
ls_record[2] = 'B'
ls_record[3] = 'C'
ls_record[4] = 'D'
ls_record[5] = 'E'

For ll_i = 1 To 5

ll_cnt = 0  //초기화

SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
INTO :ll_cnt
FROM CDDB.KCH102D 
WHERE CODE_GB = 'HPA02' 
AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
USING SQLCA;


//ll_i, ll_t

	For ll_t = 1 To ll_cnt  
		ls_cd = ls_record[ll_i] + String(ll_t, '000')
		SELECT ETC_CD1,  /*자료형태 */
			TO_NUMBER(ETC_CD2)  /*길이 */
		INTO :ls_type[ll_i, ll_t], :ll_len[ll_i, ll_t]
		FROM CDDB.KCH102D 
		WHERE CODE_GB = 'HPA02' 
		AND CODE = :ls_cd
		 USING SQLCA;
	Next
Next

//################################################
//A 레코드
//################################################

ls_str[1,1] = 'A'     //레코드구분
ls_str[1,2] = '20'   //자료구분
ls_str[1,3] = ls_tax  //세무서
ls_str[1,4] = as_jdt  //제출년월일
ls_str[1,5] = '2'    //제출자 (1:세무대리인, 2:법인 , 3:개인)
ls_str[1,6] = ''
ls_str[1,7] = ls_htx //홈텍스번호
ls_str[1,8] = '9000' //기타프로그램
ls_str[1,9] = ls_saupno //사업자등록번호
ls_str[1,10] = ls_saupnm  //상호
ls_str[1,11] = ls_dnm  //담당부서명
ls_str[1,12] = ls_knm  //담당자성명
ls_str[1,13] = ls_tel //담당전화번호

ls_str[1,14] =  '1'   //원천징수의무자수(B레코드수)
ls_str[1,15] = '101'  //한글코드종류 (국가표준)
ls_str[1,16] = '1'  //연간지급분
ls_str[1,17] = ''  //공란


//################################################
//B 레코드
//################################################
ls_str[2,1] = 'B'     //레코드구분
ls_str[2,2] = '20'   //자료구분
ls_str[2,3] = ls_tax  //세무서
ls_str[2,4] = '1'     //일련번호
ls_str[2,5] = ls_saupno //사업자등록번호
ls_str[2,6] = ls_saupnm  //상호
ls_str[2,7] = ls_daepyo   //대표자성명
ls_str[2,8] = ls_bupinno  //법인번호
ls_str[2,13] = '0'  //법인번호
//ls_str[2,17] = '1'  //제출대상기간 코드- 연간지급분
ls_str[2,17] = '' //공란


SELECT TO_CHAR(SUM(NVL(P46ICW, 0))), /*총급여총계 */
TO_CHAR(SUM(NVL(P46TXP, 0))), /*소득세결정세액총계 */
TO_CHAR(SUM(NVL(P46RTR, 0))), /*주민세결정세액총계 */
TO_CHAR(SUM(NVL(P46FTR, 0))), /*농특세결정세액총계 */
TO_CHAR(SUM(NVL(P46TXP, 0) + NVL(P46RTR, 0) + NVL(P46FTR, 0))), /*결정세액총계 */
COUNT(*),  /*주현근무처수 */
SUM((SELECT COUNT(*) FROM PADB.HPAP42T WHERE P42YAR = :as_year AND P42NNO = A.P46NNO ))
INTO :ls_str[2,11],
:ls_str[2,12],
:ls_str[2,14],
:ls_str[2,15],
:ls_str[2,16],
:ls_str[2,9],
:ls_str[2,10]
   FROM PADB.HPAP46T A
WHERE P46YAR = :as_year
USING SQLCA;				 


//A,B 레코드 filewrite
ll_cnt = 0  //초기화

For ll_i = 1 To 2
		
	SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
	INTO :ll_cnt
	FROM CDDB.KCH102D 
	WHERE CODE_GB = 'HPA02' 
	AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
	USING SQLCA;

	
	
	
	ls_str_recode[ll_i] = ''	 //초기화
	For ll_t = 1 To ll_cnt   
		ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
		ls_str_recode[ll_i] = ls_str_recode[ll_i] + ls_str[ll_i, ll_t]
	Next
	
	FileWrite(li_FileNum, ls_str_recode[ll_i])
Next

//################################################
//C 레코드
//################################################
ls_str[3,1] = 'C'     //레코드구분
ls_str[3,2] = '20'   //자료구분
ls_str[3,3] = ls_tax  //세무서
//ls_str[3,4] =  //일련번호
ls_str[3,5] = ls_saupno //사업자등록번호
//ls_str[3,6] = //종전근무처수
ls_str[3,7] = '1'   //거주자구분코드
ls_str[3,8] = ''  //거주지국코드
ls_str[3,9] = '2' //외국인단일세율적용
ls_str[3,15] ='0' //감면기간시작연월일
ls_str[3,16] ='0' //감면기간종료연월일



String  ls_crow  //사번
Dec{0} ld_71, ld_72, ld_ipr

DECLARE HPAP46T CURSOR FOR 
SELECT P46NNO,
to_char(ROW_NUMBER() OVER (ORDER BY p46nno ASC)) AS ROWNUMber,/*일련번호 4 */ 
TO_CHAR((SELECT COUNT(*) FROM PADB.HPAP42T WHERE P42YAR = A.P46YAR AND P42NNO = A.P46NNO)) AS BEFCNT, /*종전 근무처수 6 */ 
(CASE WHEN (SELECT COUNT(*) FROM PADB.HPAP42T WHERE P42YAR = A.P46YAR AND P42NNO = A.P46NNO) > 0 
             THEN :as_year  || '0101' 
              ELSE 
                  (CASE WHEN B.HAKWONHIRE_DATE <= :as_year || '0101' 
                        THEN :as_year  || '0101' 
                        ELSE B.HAKWONHIRE_DATE END)
              END),  /*귀속년도시작년월일 10*/
  (CASE WHEN (CASE WHEN NVL(TRIM(B.RETIRE_DATE), '29991231') = '' THEN '29991231'
                        ELSE NVL(TRIM(B.RETIRE_DATE), '29991231') END)  < :as_year  || '1231'  
              THEN (CASE WHEN B.RETIRE_DATE <  :as_year  || '0101'  THEN :as_year  || '1231'    ELSE B.RETIRE_DATE END)
              ELSE  :as_year  || '1231'   
              END), /*귀속년도종료년월일 11*/                         
      A.P46KNM, /*성명 12*/ 
      (CASE WHEN A.P46NAT = 'KR' THEN '1' 
            ELSE '9' END),  /*내외국인 구분코드 13*/
      A.P46RNO, /*주민등록번호 14*/  
 TO_CHAR(NVL(P46PTL, 0)), /*급여총액   17:*/
 TO_CHAR(NVL(P46BTL, 0)), /*상여총액   18 :*/
 '0', /*인정상여   19:*/
 '0'   ,   /* 주식매주 선택권 행사이익   20 */
 TO_CHAR(NVL(P46PTL, 0) + NVL(P46BTL, 0) ) AS HSUM , /*주현급여총액 21 */
 TO_CHAR(P46RND), /*연구활동비과세 22:*/
 TO_CHAR(P46FEG), /*국외근로공제액 23:*/
 TO_CHAR(P46NGT), /*야간근로수당: 24*/
TO_CHAR( P46BFM), /*출산보육수당: 25*/
TO_CHAR( P46FFM), /*외국인근로자 26:*/
TO_CHAR( P46GFM), /*기타비과세: 27*/
TO_CHAR( P46TFM), /*비과세합계:28*/
TO_CHAR( P46ICW), /*근로소득수입금액29:*/
TO_CHAR( P46SBW), /*근로소득공제 30:*/
TO_CHAR( P46ICS), /*근로소득금액 31:*/
TO_CHAR( P46SFS), /*본인공제 32:*/
TO_CHAR( P46SPS), /*배우자공제 33:*/
TO_CHAR( P46OPD), /*60세이상부양-부양가족 34:*/
TO_CHAR( P46STS), /*부양가족공제 35:*/
TO_CHAR(  NVL(A.P46OAG, 0) + NVL(A.P46DM7, 0)), /*65세이상경로 36:*/
TO_CHAR( P46ODS), /*경로우대공제 37:*/
TO_CHAR(  P46HTH), /*장애자부양 38:*/
TO_CHAR( P46EPS), /*장애자공제  39:*/
TO_CHAR( P46VNS), /*부녀자세대주공제 40:*/
TO_CHAR(  P46CID), /*자녀양육인원 41:*/
TO_CHAR( P46SUS), /*자녀양육비공제 42:*/
TO_CHAR(  P46DML), /*출산입양인원수 43:*/
TO_CHAR( P46DMM), /*출산입양공제 44:*/
 '0' ,  /*공란 45 */ 
TO_CHAR(  P46DMH), /*다자녀인원수 46:*/
TO_CHAR( P46DMI), /*다자녀추가공제 47:*/
TO_CHAR(  P46DMN), /*국민연금보험료공제 48:*/
TO_CHAR( P46PEN), /*기타연금보험료공제 49:*/
TO_CHAR( P46DMD), /*퇴직연금  50:*/
TO_CHAR(  NVL(P46SIS, 0)),
//TO_CHAR(  NVL(P46SIS, 0) - NVL(P46IPR, 0)), /*보험료공제 51:*/
TO_CHAR( P46SCM), /*의료비공제 52:*/
TO_CHAR( P46SED), /*교육비공제 53:*/
TO_CHAR(  P46DMO), /*주택임차차입금원리금상환액 54:*/
TO_CHAR( P46DMP), /*장기주택저당차입금이자상환액 55:*/
TO_CHAR(  P46SDN), /*기부금공제 56:*/
TO_CHAR(   P46DM0), /*혼인이사장례 57:*/
   '0' , /*공란 58 */ 
TO_CHAR(NVL(P46WSS,0)),	
TO_CHAR(  CASE WHEN   NVL(P46WSS, 0) < 1000000 THEN   1000000 ELSE   0 END),
TO_CHAR( P46WSI), /*차감소득금액 61:*/
TO_CHAR(  P46SST), /*개인연금저축공제-2000년이전가입 62:*/
TO_CHAR(   P46DM2), /*연금저축-2001년이후가입 63:*/
TO_CHAR(    P46DMJ), /*소기업소상공인공제부금소득공제  64:*/
TO_CHAR( P46SHN), /*주택마련저축소득공제  65:*/
TO_CHAR( P46INS), /*투자조합공제  66:*/
TO_CHAR( P46CRD), /*신용카드공제 67:*/
 '0' , /*우리사주조합소득공제 68*/  
TO_CHAR(  P46DMS),  /*   펀드소득공제:  69 */  
TO_CHAR(   NVL(p46sst, 0) + NVL(p46dm2, 0) + NVL(P46dmj, 0) + 
 NVL(P46shn, 0) + NVL(p46ins, 0) + NVL(p46crd, 0) + NVL(p46dms, 0))   as etcsum, /*그밖의 소득공제계  70*/   
TO_CHAR(CASE WHEN  NVL(P46WSI, 0) - ( NVL(p46sst, 0) + NVL(p46dm2, 0) + NVL(P46dmj, 0) + 
 NVL(P46shn, 0) + NVL(p46ins, 0) + NVL(p46crd, 0) + NVL(p46dms, 0)) <= 0 THEN 0 ELSE
 NVL(P46WSI, 0) - ( NVL(p46sst, 0) + NVL(p46dm2, 0) + NVL(P46dmj, 0) + 
 NVL(P46shn, 0) + NVL(p46ins, 0) + NVL(p46crd, 0) + NVL(p46dms, 0)) END), /*과세표준  71:*/
TO_CHAR( P46CTA), /*산출세액  72:*/
 '0' , /*소득세법세액감면 73 */ 
 '0' , /*조특법세액감면 74 */
 '0' , /*공란 75 */
 '0' , /*감면세액계 76 */
TO_CHAR(  P46DXW), /*근로소득세액공제 77:*/
  TO_CHAR( P46DMK), /*납세조합공제  78:*/
 TO_CHAR( P46TSK), /*주택차입금공제  79:*/
TO_CHAR(  P46DMB), /*기부정치자금 80:*/
TO_CHAR( P46TFE), /*외국납부세액공제 81:*/
 '0' , /*공란 82 */ 
TO_CHAR(  P46TYX), /*세액공제계 83:*/
TO_CHAR( P46TXP), /*결정소득세  84:*/
TO_CHAR( P46RTR), /*결정주민세  85:*/
TO_CHAR( P46FTR), /*결정농특세  86:*/
TO_CHAR( NVL(P46TXP, 0) + NVL(P46RTR, 0) + NVL(P46FTR, 0)) AS TXSUM , /*결정세액계  87 */ 
TO_CHAR( P46JTX), /*전근무소득세징수액:  88*/
TO_CHAR( P46JRT), /*전근무주민세징수액:  89 */
TO_CHAR( P46JFT), /*전근무농특세징수액:  90*/
TO_CHAR( NVL(P46JTX, 0) + NVL(P46JRT, 0) + NVL(P46JFT, 0)) AS TXSUM , /*전근무지세액계  91 */ 
TO_CHAR(  P46HTX), /*현근무소득세징수액:  92*/
TO_CHAR( P46HRT), /*현근무주민세징수액:  93*/
TO_CHAR( P46HFT), /*현근무농특세징수액:  94*/
TO_CHAR( NVL(P46HTX, 0) + NVL(P46HRT, 0) + NVL(P46HFT, 0)) AS TXSUM , /*현근무지세액계  95 */ 
 ' ' ,/*공란 96 */ 
 NVL(P46IPR,0)
  FROM 
   INDB.HIN001M B ,
  PADB.HPAP46T A
WHERE A.P46NNO = B.MEMBER_NO
AND A.P46YAR = :as_year
USING SQLCA;
//
	OPEN HPAP46T ;
 	FETCH HPAP46T INTO :ls_nno, :ls_str[3,4],
:ls_str[3,6], :ls_str[3,10], :ls_str[3,11], :ls_str[3,12], :ls_str[3,13], :ls_str[3,14], :ls_str[3,17], :ls_str[3,18], :ls_str[3,19],
:ls_str[3,20], :ls_str[3,21], :ls_str[3,22], :ls_str[3,23], :ls_str[3,24], :ls_str[3,25], :ls_str[3,26], :ls_str[3,27], :ls_str[3,28],
:ls_str[3,29], :ls_str[3,30], :ls_str[3,31], :ls_str[3,32], :ls_str[3,33], :ls_str[3,34], :ls_str[3,35], :ls_str[3,36], :ls_str[3,37],
:ls_str[3,38], :ls_str[3,39], :ls_str[3,40], :ls_str[3,41], :ls_str[3,42], :ls_str[3,43], :ls_str[3,44], :ls_str[3,45], :ls_str[3,46],
:ls_str[3,47], :ls_str[3,48], :ls_str[3,49], :ls_str[3,50], :ls_str[3,51], :ls_str[3,52], :ls_str[3,53], :ls_str[3,54], :ls_str[3,55],
:ls_str[3,56], :ls_str[3,57], :ls_str[3,58], :ls_str[3,59], :ls_str[3,60], :ls_str[3,61], :ls_str[3,62], :ls_str[3,63], :ls_str[3,64],
:ls_str[3,65], :ls_str[3,66], :ls_str[3,67], :ls_str[3,68], :ls_str[3,69], :ls_str[3,70], :ls_str[3,71], :ls_str[3,72], :ls_str[3,73],
:ls_str[3,74], :ls_str[3,75], :ls_str[3,76], :ls_str[3,77], :ls_str[3,78], :ls_str[3,79], :ls_str[3,80], :ls_str[3,81], :ls_str[3,82],
:ls_str[3,83], :ls_str[3,84], :ls_str[3,85], :ls_str[3,86], :ls_str[3,87], :ls_str[3,88], :ls_str[3,89], :ls_str[3,90], :ls_str[3,91],
:ls_str[3,92], :ls_str[3,93], :ls_str[3,94], :ls_str[3,95], :ls_str[3,96],  :ld_ipr
 ;
	 DO WHILE SQLCA.SQLCODE = 0
		
		
//C,D,E 레코드 filewrite
ll_cnt = 0  //초기화

For ll_i = 3 To 5
	If ll_i = 4 Then	 
	//################################################
	//D 레코드
	//################################################	
	
	If long(ls_str[3,6]) > 0 Then  //종전근무처수가 0보다 클 경우
	ls_str[4,1] = 'D' //레코드구분
	ls_str[4,2] = '20'  //자료구분
	ls_str[4,3] = ls_tax  //세무서
	ls_str[4,4] = ls_str[3,4]  //일련번호
	ls_str[4,5] = ls_saupno //사업자등록번호
	ls_str[4,6] = '' //공란
	ls_str[4,7] = ls_str[3,14]  //소득자주민등록번호
	ls_str[4,16] = '' //공란
	
			
	SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
		INTO :ll_cnt
		FROM CDDB.KCH102D 
		WHERE CODE_GB = 'HPA02' 
		AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
		USING SQLCA;

	
	DECLARE HPAP42T CURSOR FOR 
					SELECT NVL(P42CNM, ' '), /*법인명상호 8*/ 
					SUBSTR(TRIM(P42BNB), 1, 10), /*사업자등록번호 9 */ 
					NVL(P42PTL,0) , /*급여총액 10 */ 
					NVL(P42BTL, 0), /*상여총액 11 */ 
					NVL(P42ATL, 0),  /*인정상여 12 */ 
					0,  /*주식매수선택권행사이익 13 */ 
					NVL(P42PTL,0) + NVL(P42BTL, 0) +NVL(P42ATL, 0), /*계 14 */ 
					TO_char(ROW_NUMBER() OVER (ORDER BY P42BNB ASC)) AS ROWNUMBER  /*일련번호 15 */ 
					 FROM PADB.HPAP42T WHERE P42YAR = :as_year AND P42NNO =:ls_nno
	 USING SQLCA;
	
	
		OPEN HPAP42T ;
		FETCH HPAP42T INTO
		:ls_str[4,8], :ls_str[4,9], :ls_str[4,10], :ls_str[4,11], :ls_str[4,12], :ls_str[4,13], :ls_str[4,14], :ls_str[4,15]
			;
		 DO WHILE SQLCA.SQLCODE = 0
			
		    ls_str_recode[ll_i] = ''	 //초기화
			 
			For ll_t = 1 To ll_cnt   
				ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
				ls_str_recode[ll_i] = ls_str_recode[ll_i] + ls_str[ll_i, ll_t]
			Next
			
			//D1, D2, D3 ... C레코드 이후 종전근무처수만큼 write 함.
			FileWrite(li_FileNum, ls_str_recode[ll_i])	
			
		FETCH HPAP42T INTO 
		:ls_str[4,8], :ls_str[4,9], :ls_str[4,10], :ls_str[4,11], :ls_str[4,12], :ls_str[4,13], :ls_str[4,14], :ls_str[4,15];
	
		Loop
		  CLOSE HPAP42T;
	End If
Elseif ll_i = 5 Then
//################################################
//E 레코드 : 소득공제명세
//################################################	
ls_str[5,1] = 'E' //레코드구분
ls_str[5,2] = '20'  //자료구분
ls_str[5,3] = ls_tax  //세무서
ls_str[5,4] = ls_str[3,4]  //일련번호
ls_str[5,5] = ls_saupno //사업자등록번호
ls_str[5,6] = ls_str[3,14]  //소득자주민등록번호
ls_str[5,113] = '' //공란

Long ll_e , ll_erow, ll_reset, ll_e_str
Long ll_seq = 0
String ls_e[]


SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
	INTO :ll_cnt
	FROM CDDB.KCH102D 
	WHERE CODE_GB = 'HPA02' 
	AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
	USING SQLCA;


ll_e = 7  //부양가족정보 배열 초기화
 ls_str_recode[ll_i] = ''	 //초기화
		
For ll_reset = ll_e To 112
	ls_str[5, ll_reset] = ''
Next


DECLARE HPAP43T CURSOR FOR 
		SELECT P43REL, /*관계 7*/ 
		P43GBN, /*내외국인구분코드 8 */ 
		P43KNM , /*성명 9 */ 
		P43RNO, /*주민등록번호: 10 */ 
		CASE WHEN P43KO1 = 'Y' THEN '1' ELSE ' ' END, /*기본공제: 11 */ 
		CASE WHEN P43KO2 = 'Y' THEN '1' ELSE ' ' END, /*장애인:: 12 */ 
		CASE WHEN P43KO3 = 'Y' THEN '1' ELSE ' ' END, /*자녀양육비:: 13 */ 
		CASE WHEN P43WHM = 'Y' THEN '1' ELSE ' ' END, /*부녀자세대주유무:: 14 */ 
		CASE WHEN P43OGB = 'Y' THEN '1' ELSE ' ' END, /*경로우대유무: 15 */ 
		CASE WHEN P43CON = 'Y' THEN '1' ELSE ' ' END, /*다자녀대상유무: 16 */ 
		CASE WHEN P43BGB = 'Y' THEN '1' ELSE ' ' END, /*출산입양가족유무: 17 */ 
		NVL(P43G01, 0) + NVL(P43G08, 0)    + NVL((CASE WHEN P43REL = '0' THEN TO_NUMBER(:ld_ipr)  ELSE 0 END), 0) ,  /*보험료1:  18 */ 
		NVL(P43G02, 0),  /*의료비1: 19 */ 
		NVL(P43G03, 0),  /*교육비1:  20 */ 
		NVL(P43G04, 0) , /*신용카드1:  21 */ 
		 NVL(P43G05, 0),  /*현금영수증1: 22 */ 
		NVL(P43F01, 0) + NVL(P43F08, 0),  /*보험료2:  23 */ 
		NVL(P43F02, 0),  /*의료비2: 24 */ 
		NVL(P43F03, 0),  /*교육비2:  25 */ 
		NVL(P43F04, 0) , /*신용카드2:  26 */ 
		 NVL(P43F06, 0),  /*기부금2: 27 */ 
		ROW_NUMBER() OVER (ORDER BY P43REL, P43RNO ASC) AS ROWNUMber 
		 FROM PADB.HPAP43T WHERE P43YAR = :as_year AND P43NNO =:ls_nno
		 ORDER BY P43REL, P43RNO
	 USING SQLCA;
	
	
		OPEN HPAP43T ;
		FETCH HPAP43T INTO
		:ls_str[5,ll_e], :ls_str[5,ll_e + 1], :ls_str[5,ll_e + 2], :ls_str[5,ll_e + 3], :ls_str[5,ll_e + 4], :ls_str[5,ll_e + 5], :ls_str[5,ll_e + 6], :ls_str[5,ll_e + 7],
		:ls_str[5,ll_e + 8], :ls_str[5,ll_e + 9], :ls_str[5,ll_e + 10], :ls_str[5,ll_e + 11], :ls_str[5,ll_e + 12], :ls_str[5,ll_e + 13], :ls_str[5,ll_e + 14],
		:ls_str[5,ll_e + 15], :ls_str[5,ll_e + 16], :ls_str[5,ll_e + 17], :ls_str[5,ll_e + 18], :ls_str[5,ll_e + 19], :ls_str[5,ll_e + 20], :ll_erow
			;
		 DO WHILE SQLCA.SQLCODE = 0
			

		If mod(ll_erow, 5) = 1 Then 
			ll_seq ++
			ls_str[ll_i, 112] = String(ll_seq)
		End If

		If mod(ll_erow, 5) = 0 Then  
			For ll_t = 1 To ll_cnt   
				ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
				ls_e[ll_seq] = ls_e[ll_seq] + ls_str[ll_i, ll_t]
			Next	
			
			ll_e = 7
			For ll_reset = ll_e To 112
				ls_str[5, ll_reset] = ''
			Next
		Else
			ll_e = ll_e + 21	
		End If
		
		
		
		FETCH HPAP43T INTO 
		:ls_str[5,ll_e], :ls_str[5,ll_e + 1], :ls_str[5,ll_e + 2], :ls_str[5,ll_e + 3], :ls_str[5,ll_e + 4], :ls_str[5,ll_e + 5], :ls_str[5,ll_e + 6], :ls_str[5,ll_e + 7],
		:ls_str[5,ll_e + 8], :ls_str[5,ll_e + 9], :ls_str[5,ll_e + 10], :ls_str[5,ll_e + 11], :ls_str[5,ll_e + 12], :ls_str[5,ll_e + 13], :ls_str[5,ll_e + 14],
		:ls_str[5,ll_e + 15], :ls_str[5,ll_e + 16], :ls_str[5,ll_e + 17], :ls_str[5,ll_e + 18], :ls_str[5,ll_e + 19], :ls_str[5,ll_e + 20], :ll_erow 
		;
	
		
		Loop
		  CLOSE HPAP43T;
			
			If mod(ll_erow,5) > 0 Then
				ls_str[ll_i, 112] = String(ll_seq)
				For ll_t = 1 To ll_cnt   
					ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
					ls_e[ll_seq] = ls_e[ll_seq] + ls_str[ll_i, ll_t]
				Next	
			End If
			
			For ll_e_str = 1 To ll_seq
			//E1, E2, E3 ... 부양가족수를 5명 단위로 write함
				FileWrite(li_FileNum, ls_e[ll_e_str])		
				ls_e[ll_e_str] = ''
				If  ll_e_str = ll_seq then
					ll_seq = 0
				end If
			NEXT
Else  //C 레코드 일 경우
		SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
		INTO :ll_cnt
		FROM CDDB.KCH102D 
		WHERE CODE_GB = 'HPA02' 
		AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
		USING SQLCA;
		
		
		ls_str_recode[ll_i] = ''	 //초기화
		For ll_t = 1 To ll_cnt   
			ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
			ls_str_recode[ll_i] = ls_str_recode[ll_i] + ls_str[ll_i, ll_t]
		Next
		//C레코드는 1번씩만 write 함
			FileWrite(li_FileNum, ls_str_recode[ll_i])
End If		
	

Next


	FETCH HPAP46T INTO :ls_nno, :ls_str[3,4],
:ls_str[3,6], :ls_str[3,10], :ls_str[3,11], :ls_str[3,12], :ls_str[3,13], :ls_str[3,14], :ls_str[3,17], :ls_str[3,18], :ls_str[3,19],
:ls_str[3,20], :ls_str[3,21], :ls_str[3,22], :ls_str[3,23], :ls_str[3,24], :ls_str[3,25], :ls_str[3,26], :ls_str[3,27], :ls_str[3,28],
:ls_str[3,29], :ls_str[3,30], :ls_str[3,31], :ls_str[3,32], :ls_str[3,33], :ls_str[3,34], :ls_str[3,35], :ls_str[3,36], :ls_str[3,37],
:ls_str[3,38], :ls_str[3,39], :ls_str[3,40], :ls_str[3,41], :ls_str[3,42], :ls_str[3,43], :ls_str[3,44], :ls_str[3,45], :ls_str[3,46],
:ls_str[3,47], :ls_str[3,48], :ls_str[3,49], :ls_str[3,50], :ls_str[3,51], :ls_str[3,52], :ls_str[3,53], :ls_str[3,54], :ls_str[3,55],
:ls_str[3,56], :ls_str[3,57], :ls_str[3,58], :ls_str[3,59], :ls_str[3,60], :ls_str[3,61], :ls_str[3,62], :ls_str[3,63], :ls_str[3,64],
:ls_str[3,65], :ls_str[3,66], :ls_str[3,67], :ls_str[3,68], :ls_str[3,69], :ls_str[3,70], :ls_str[3,71], :ls_str[3,72], :ls_str[3,73],
:ls_str[3,74], :ls_str[3,75], :ls_str[3,76], :ls_str[3,77], :ls_str[3,78], :ls_str[3,79], :ls_str[3,80], :ls_str[3,81], :ls_str[3,82],
:ls_str[3,83], :ls_str[3,84], :ls_str[3,85], :ls_str[3,86], :ls_str[3,87], :ls_str[3,88], :ls_str[3,89], :ls_str[3,90], :ls_str[3,91],
:ls_str[3,92], :ls_str[3,93], :ls_str[3,94], :ls_str[3,95], :ls_str[3,96], :ld_ipr ;

	Loop
     CLOSE HPAP46T;
		
FileClose(li_FileNum)

MESSAGEBOX('확인', '근로소득 지급조서 파일 작성이 완료 되었습니다. ~r~r' + &
						ls_path + '파일을 확인해주세요')				
		
		

Case 'CA'
		
			//################################################
			//의료비
			//################################################	
			ls_str[1,1] = 'A' //레코드구분
			ls_str[1,2] = '26'  //자료구분
			ls_str[1,3] = ls_tax  //세무서
			//ls_str[1,4] =   //일련번호
			ls_str[1,5] = as_jdt  //제출년월일
			ls_str[1,6] = ls_saupno //사업자등록번호
			ls_str[1,7] = ls_htx //홈텍스번호
			ls_str[1,8] = '9000' //기타프로그램
			ls_str[1,9] = ls_saupno //사업자등록번호
			ls_str[1,10] = ls_saupnm  //상호
			
			ls_str[1, 1] = of_year_strchg(ls_str[1, 1], 'X' , 1)		
			ls_str[1, 2] = of_year_strchg(ls_str[1, 2], '9' , 2)	
			ls_str[1, 3] = of_year_strchg(ls_str[1, 3], 'X' , 3)	
			
			ls_str[1, 5] = of_year_strchg(ls_str[1, 5], '9' , 8)	
			ls_str[1, 6] = of_year_strchg(ls_str[1, 6], 'X' , 10)	
			ls_str[1, 7] = of_year_strchg(ls_str[1, 7], 'X' , 20)	
			ls_str[1, 8] = of_year_strchg(ls_str[1, 8], 'X' , 4)	
			ls_str[1, 9] = of_year_strchg(ls_str[1, 9], 'X' , 10)	
			ls_str[1, 10] = of_year_strchg(ls_str[1, 10], 'X' , 40)	
			ll_seq = 0
			
			DECLARE HPAP44T CURSOR FOR 
						SELECT A.P46RNO, /*주민등록번호: 11 */
			CASE WHEN A.P46NAT = 'KR' THEN '1' ELSE '9' END , /*내외국인코드 12 */
			NVL(A.P46KNM, ' '), /*한글명칭:: 13 */
			B.P44BNO, /*사업자번호: 14 */
			NVL(B.P44BNM, ' '), /*상호: 15 */
			B.P44HSG, /*의료비증빙코드: 16 */
			NVL(B.P44CNT, 0), /*건수 : 17 */
			NVL(B.P44PTL, 0), /*지급금액: 18 */
			B.P44RNO, /*주민번호: 19 */
			B.P44FRG, /*외국인구분: 20 */
			B.P44GBN, /*본인 장애,경로: 21 */
			' ' /*공란 22 */
			FROM PADB.HPAP46T A, 
			(
			SELECT P44YAR, P44NNO, P44RNO, P44BNO, P44BNM, P44HNM, SUM(NVL(P44CNT,1)) AS P44CNT,
			SUM(NVL(P44PTL, 0)) AS P44PTL, (CASE WHEN P44GBN = 'Y' THEN '1' ELSE '2' END) AS P44GBN,  P44FRG, P44HSG
			FROM PADB.HPAP44T B
			WHERE B.P44YAR =  :as_year
			GROUP BY P44YAR, P44NNO, P44RNO, P44BNO, P44BNM, P44HNM,P44GBN,  P44FRG, P44HSG
			) B
			WHERE A.P46YAR = B.P44YAR
			AND A.P46NNO = B.P44NNO
			AND A.P46SCM >= 2000000
			AND A.P46YAR = :as_year
			 AND	((:as_gu = '1' AND SUBSTR(A.P46NNO,1, 1) = 'K') Or
	 			(:as_gu <> '1' AND SUBSTR(A.P46NNO,1, 1) <> 'K'))	
			ORDER BY A.P46NNO, B.P44RNO
			USING SQLCA;
				
				
					OPEN HPAP44T ;
					FETCH HPAP44T INTO
					:ls_str[1,11], :ls_str[1,12], :ls_str[1,13], :ls_str[1, 14], :ls_str[1,15], :ls_str[1,16], :ls_str[1,17], :ls_str[1,18],
					:ls_str[1,19], :ls_str[1,20], :ls_str[1,21], :ls_str[1,22]
						;
					 DO WHILE SQLCA.SQLCODE = 0
						
			
						ll_seq ++
						ls_str[1, 4] = String(ll_seq)
						ls_str[1, 4] = of_year_strchg(ls_str[1, 4], '9' , 6)	
			
					
				
					ls_str[1, 11] = of_year_strchg(ls_str[1, 11], 'X' , 13)	
					ls_str[1, 12] = of_year_strchg(ls_str[1, 12], '9' , 1)	
					ls_str[1, 13] = of_year_strchg(ls_str[1, 13], 'X' , 30)	
					ls_str[1, 14] = of_year_strchg(ls_str[1, 14], 'X' , 10)	
					ls_str[1, 15] = of_year_strchg(ls_str[1, 15], 'X' , 40)	
					ls_str[1, 16] = of_year_strchg(ls_str[1, 16], 'X' , 1)	
					ls_str[1, 17] = of_year_strchg(ls_str[1, 17], '9' , 5)	
					ls_str[1, 18] = of_year_strchg(ls_str[1, 18], '9' , 11)	
					ls_str[1, 19] = of_year_strchg(ls_str[1, 19], 'X' , 13)	
					ls_str[1, 20] = of_year_strchg(ls_str[1, 20], '9' , 1)	
					ls_str[1, 21] = of_year_strchg(ls_str[1, 21], '9' , 1)	
					ls_str[1, 22] = of_year_strchg(ls_str[1, 22], 'X' , 20)	
					
					ls_str_recode[1] = ''	 //초기화
					For ll_t = 1 To 22   		
						ls_str_recode[1] = ls_str_recode[1] + ls_str[1, ll_t]
						//ls_str[1, ll_t] = ''
					Next
					
					FileWrite(li_FileNum, ls_str_recode[1])
					
					FETCH HPAP44T INTO 
					:ls_str[1,11], :ls_str[1,12], :ls_str[1,13], :ls_str[1, 14], :ls_str[1,15], :ls_str[1,16], :ls_str[1,17], :ls_str[1,18],
					:ls_str[1,19], :ls_str[1,20], :ls_str[1,21], :ls_str[1,22]
					;
				
					
					Loop
					  CLOSE HPAP44T;
			
			
			FileClose(li_FileNum)
			
			MESSAGEBOX('확인', '의료비명세서 지급조서 파일 작성이 완료 되었습니다. ~r~r' + &
									ls_path + '파일을 확인해주세요')				
				
	Case 'H'			
			//################################################
			//기부금
			//################################################	
			ls_str[1,1] = 'A' //레코드구분
			ls_str[1,2] = '27'  //자료구분
			ls_str[1,3] = ls_tax  //세무서
			//ls_str[1,4] =   //일련번호
			ls_str[1,5] = as_jdt  //제출년월일
			ls_str[1,6] = ls_saupno //사업자등록번호
			ls_str[1,7] = ls_htx //홈텍스번호
			ls_str[1,8] = '9000' //기타프로그램
			ls_str[1,9] = ls_saupno //사업자등록번호
			ls_str[1,10] = ls_saupnm  //상호
			ls_str[1,20] = '1'  //내외국인 구분 :내국인 1
//			ls_str[1,23] = '20080101' //과세기간시작일 '20080101'
//			ls_str[1,24] = '20081231' //과세기간종료일 '20081231'
//			ls_str[1,25] = '0' //이월액잔액
//			ls_str[1,26] = '0' //해당과세기간공제금액
//			ls_str[1,27] = '0'  //이월액
			ls_str[1,28] = ''  //공란
//			
			
			
			ls_str[1, 1] = of_year_strchg(ls_str[1, 1], 'X' , 1)		
			ls_str[1, 2] = of_year_strchg(ls_str[1, 2], '9' , 2)	
			ls_str[1, 3] = of_year_strchg(ls_str[1, 3], 'X' , 3)	
			
			ls_str[1, 5] = of_year_strchg(ls_str[1, 5], '9' , 8)	
			ls_str[1, 6] = of_year_strchg(ls_str[1, 6], 'X' , 10)	
			ls_str[1, 7] = of_year_strchg(ls_str[1, 7], 'X' , 20)	
			ls_str[1, 8] = of_year_strchg(ls_str[1, 8], 'X' , 4)	
			ls_str[1, 9] = of_year_strchg(ls_str[1, 9], 'X' , 10)	
			ls_str[1, 10] = of_year_strchg(ls_str[1, 10], 'X' , 40)	
			ls_str[1, 20] = of_year_strchg(ls_str[1, 20], '9' , 1)	
			
			ls_str[1, 28] = of_year_strchg(ls_str[1, 28], 'X' , 118)
			
			ll_seq = 0
			
			DECLARE HPAP45T CURSOR FOR 
						SELECT A.P46RNO, /*주민등록번호: 11 */
			CASE WHEN A.P46NAT = 'KR' THEN '1' ELSE '9' END , /*내외국인코드 12 */
			NVL(A.P46KNM, ' '), /*한글명칭:: 13 */
			B.P45BNO, /*사업자번호: 14 */
			NVL(B.P45BNM, ' '), /*상호: 15 */
			B.P45COD, /*코드: 16 */
			NVL(B.P45CNT, 0), /*건수 : 17 */
			NVL(B.P45PTL, 0), /*지급금액: 18 */
			B.P45RLS, /*관계: 19 */
			B.P45CHM, /*성명: 21 */
			B.P45RNO, /*주민번호 22 */
		   (CASE WHEN B.P45COD = '31' THEN '20080101' ELSE '0' END) , /*과세기간 시작일 23 */ 
		   (CASE WHEN B.P45COD = '31' THEN '20081231' ELSE '0' END) , /*과세기간 종료일 24 */ 
		   '0' , /*이월액잔액 25 */ 
		   '0' , /*과세기간공제금액 26 */ 
		   '0'  /*이월액 27 */ 
			FROM PADB.HPAP46T A, 		
      	(  
  		SELECT 		P45YAR, P45NNO,  P45BNO, P45COD, P45RNO, P45CHM, P45RLS,  P45BNM,  SUM(1) AS P45CNT, SUM(P45PTL)	 AS P45PTL	
      FROM PADB.HPAP45T B
			WHERE B.P45YAR =  :as_year
			GROUP BY 	P45YAR, P45NNO,  P45BNO, P45COD, P45RNO, P45CHM, P45RLS,  P45BNM 
  		) B
			WHERE A.P46YAR = B.P45YAR
			AND A.P46NNO = B.P45NNO
			AND A.P46SDN >= 1000000
			AND A.P46YAR = :as_year
			ORDER BY A.P46NNO, B.P45RNO
			USING SQLCA;
				
				
					OPEN HPAP45T ;
					FETCH HPAP45T INTO
					:ls_str[1,11], :ls_str[1,12], :ls_str[1,13], :ls_str[1, 14], :ls_str[1,15], :ls_str[1,16], :ls_str[1,17], :ls_str[1,18],
					:ls_str[1,19], :ls_str[1,21], :ls_str[1,22],  :ls_str[1,23], :ls_str[1, 24], :ls_str[1,25], :ls_str[1,26], :ls_str[1,27]
						;
					 DO WHILE SQLCA.SQLCODE = 0
						
			
						ll_seq ++
						ls_str[1, 4] = String(ll_seq)
						ls_str[1, 4] = of_year_strchg(ls_str[1, 4], '9' , 7)	
			
					
				
					ls_str[1, 11] = of_year_strchg(ls_str[1, 11], 'X' , 13)	
					ls_str[1, 12] = of_year_strchg(ls_str[1, 12], '9' , 1)	
					ls_str[1, 13] = of_year_strchg(ls_str[1, 13], 'X' , 30)	
					ls_str[1, 14] = of_year_strchg(ls_str[1, 14], 'X' , 13)	
					ls_str[1, 15] = of_year_strchg(ls_str[1, 15], 'X' , 30)	
					ls_str[1, 16] = of_year_strchg(ls_str[1, 16], 'X' , 2)	
					ls_str[1, 17] = of_year_strchg(ls_str[1, 17], '9' , 5)	
					ls_str[1, 18] = of_year_strchg(ls_str[1, 18], '9' , 13)	
					ls_str[1, 19] = of_year_strchg(ls_str[1, 19], 'X' , 1)	
					ls_str[1, 21] = of_year_strchg(ls_str[1, 21], 'X' , 20)	
					ls_str[1, 22] = of_year_strchg(ls_str[1, 22], 'X' , 13)	
					ls_str[1, 23] = of_year_strchg(ls_str[1, 23], '9' , 8)		
					ls_str[1, 24] = of_year_strchg(ls_str[1, 24], '9' , 8)	
					ls_str[1, 25] = of_year_strchg(ls_str[1, 25], '9' , 13)
					ls_str[1, 26] = of_year_strchg(ls_str[1, 26], '9' , 13)		
					ls_str[1, 27] = of_year_strchg(ls_str[1, 27], '9' , 13)	
				
							
					ls_str_recode[1] = ''	 //초기화
					For ll_t = 1 To 28   		
						ls_str_recode[1] = ls_str_recode[1] + ls_str[1, ll_t]
						//ls_str[1, ll_t] = ''
					Next
					
					FileWrite(li_FileNum, ls_str_recode[1])
					
					FETCH HPAP45T INTO 
					:ls_str[1,11], :ls_str[1,12], :ls_str[1,13], :ls_str[1, 14], :ls_str[1,15], :ls_str[1,16], :ls_str[1,17], :ls_str[1,18],
					:ls_str[1,19], :ls_str[1,21], :ls_str[1,22],  :ls_str[1,23], :ls_str[1, 24], :ls_str[1,25], :ls_str[1,26], :ls_str[1,27]
					;
				
					
					Loop
					  CLOSE HPAP45T;
			
			
			FileClose(li_FileNum)
			
			MESSAGEBOX('확인', '기부금명세서 지급조서 파일 작성이 완료 되었습니다. ~r~r' + &
									ls_path + '파일을 확인해주세요')				
//	Case 'E'  //퇴직소득 지급조서
//		//#############################################################
//		//퇴직소득
//		//#############################################################
//
//ls_record[1] = 'A'
//ls_record[2] = 'B'
//ls_record[3] = 'C'
//ls_record[4] = 'D'
//
//
//For ll_i = 1 To 4
//
//ll_cnt = 0  //초기화
//
//
//
//
//SELECT TO_NUMBER(SUBSTR(MAX(CODE), 2, 3) )
//		INTO :ll_cnt
//		FROM CDDB.KCH102D 
//		WHERE CODE_GB = 'HPA03' 
//		AND SUBSTR(CODE, 1, 1) = :ls_record[ll_i]
//		USING SQLCA;
//
//	For ll_t = 1 To ll_cnt  
//		ls_cd = ls_record[ll_i] + String(ll_t, '000')
//		
//		 SELECT ETC_CD1,  /*자료형태 */
//			TO_NUMBER(ETC_CD2)  /*길이 */
//		INTO :ls_type[ll_i, ll_t], :ll_len[ll_i, ll_t]
//		FROM CDDB.KCH102D 
//		WHERE CODE_GB = 'HPA03' 
//		AND CODE = :ls_cd
//		 USING SQLCA;
//	Next
//Next
//
////################################################
////A 레코드
////################################################
//
//ls_str[1,1] = 'A'     //레코드구분
//ls_str[1,2] = '22'   //자료구분
//ls_str[1,3] = ls_tax  //세무서
//ls_str[1,4] = as_jdt  //제출년월일
//ls_str[1,5] = '2'    //제출자 (1:세무대리인, 2:법인 , 3:개인)
//ls_str[1,6] = ''
//ls_str[1,7] = ls_htx //홈텍스번호
//ls_str[1,8] = '9000' //기타프로그램
//ls_str[1,9] = ls_saupno //사업자등록번호
//ls_str[1,10] = ls_saupnm  //상호
//ls_str[1,11] = ls_dnm  //담당부서명
//ls_str[1,12] = ls_knm  //담당자성명
//ls_str[1,13] = ls_tel //담당전화번호
//
//ls_str[1,14] =  '1'   //원천징수의무자수(B레코드수)
//ls_str[1,15] = '101'  //한글코드종류 (국가표준)
//ls_str[1,16] = '1'  //연간지급분
//ls_str[1,17] = ''  //공란
//
//
////################################################
////B 레코드
////################################################
//ls_str[2,1] = 'B'     //레코드구분
//ls_str[2,2] = '22'   //자료구분
//ls_str[2,3] = ls_tax  //세무서
//ls_str[2,4] = '1'     //일련번호
//ls_str[2,5] = ls_saupno //사업자등록번호
//ls_str[2,6] = ls_saupnm  //상호
//ls_str[2,7] = ls_daepyo   //대표자성명
//ls_str[2,8] = ls_bupinno  //법인번호
//ls_str[2,13] = '0'  //법인세
//ls_str[2,17] = '' //공란
//
//SELECT TO_CHAR(SUM(NVL(P33PTT, 0) + NVL(P33RIR, 0))), /*퇴직급여액 총계 11 */
//TO_CHAR(SUM(NVL(P33TXR, 0))), /*소득세결정세액총계 12*/
//TO_CHAR(SUM(NVL(P33RTR, 0))), /*주민세결정세액총계 14*/
//TO_CHAR(SUM(NVL(P33FTR, 0))), /*농특세결정세액총계 15*/
//TO_CHAR(SUM(NVL(P33TXR, 0) + NVL(P33RTR, 0) + NVL(P33FTR, 0))), /*결정세액총계  16*/
//COUNT(*),  /*주현근무처수 9*/
//0 /*종전근무처수 10*/
//INTO :ls_str[2,11],
//:ls_str[2,12],
//:ls_str[2,14],
//:ls_str[2,15],
//:ls_str[2,16],
//:ls_str[2,9],
//:ls_str[2,10]
//   FROM PADB.TP33PYA0 A
//   WHERE ((LENGTH(TRIM(P33RTD)) = 8 AND SUBSTR(P33TDT,1, 4) = :as_year AND P33AJG = 'T' ) OR
//(LENGTH(TRIM(P33RTD)) <> 8 AND SUBSTR(P33JDT,1, 4) = :as_year AND P33AJG = 'J' ) )
////WHERE ((LENGTH(TRIM(P32RTD)) = 8 AND SUBSTR(P33TDT,1, 4) = :as_year ) OR
////(LENGTH(TRIM(P32RTD)) <> 8 AND SUBSTR(P33JDT,1, 4) = :as_year ) )
// AND	((:as_gu = '1' AND SUBSTR(P33NNO,1, 1) = 'K') Or
//	 			(:as_gu <> '1' AND SUBSTR(P33NNO,1, 1) <> 'K'))	
//USING SQLCA;					 
//
//
////A,B 레코드 filewrite
//ll_cnt = 0  //초기화
//
//For ll_i = 1 To 2
//	SELECT CAST(SUBSTR(MAX(ZCCCOMCD), 2, 3) AS NUMERIC)
//	INTO :ll_cnt
//	FROM CLVDTALB.TZCDA121 
//	WHERE ZCCSYSCD = 'MIS' 
//	AND ZCCGRPCD = 'EE6'    
//	AND SUBSTR(ZCCCOMCD, 1, 1) = :ls_record[ll_i]
//	USING SQLCA;
//	
//	ls_str_recode[ll_i] = ''	 //초기화
//	For ll_t = 1 To ll_cnt   
//		ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
//		ls_str_recode[ll_i] = ls_str_recode[ll_i] + ls_str[ll_i, ll_t]
//	Next
//	
//	FileWrite(li_FileNum, ls_str_recode[ll_i])
//Next
//
////################################################
////C 레코드
////################################################
//ls_str[3,1] = 'C'     //레코드구분
//ls_str[3,2] = '22'   //자료구분
//ls_str[3,3] = ls_tax  //세무서
////ls_str[3,4] =  //일련번호
//ls_str[3,5] = ls_saupno //사업자등록번호
//ls_str[3,6] = '0'
//ls_str[3,7] = '1'   //거주자구분코드
//ls_str[3,8] = ''  //거주지국코드
//ls_str[3,12] = '1'  //내외국인 코드
//ls_str[3,56] = ''  //공란
//
//
//
//
//DECLARE TP33PYA0 CURSOR FOR 
//SELECT P33NNO,
//	(CASE WHEN P33EGD <= CAST(:as_year AS  VARTO_CHAR(4)) || '0101' THEN CAST(:as_year AS  VARTO_CHAR(4)) || '0101'
//            ELSE P33EGD END),   /*귀속년도시작일 9*/
//      (CASE WHEN  LENGTH(TRIM(P33RTD)) = 8 THEN P33TDT ELSE CAST(:as_year AS  VARTO_CHAR(4)) || '1231' END) ,   /*귀속년도종료일 10*/    
//       H01KNM,  /*성명 11*/
//       H01RNO,  /*주민등록번호 13*/
//       TO_CHAR(NVL(P33PTT,0)),  /*퇴직급여 14*/
//       '0',  /*명예퇴직수당 15*/  
//       TO_CHAR(NVL(P33RIR,0)),   /*퇴직연금일시금 16 */
//       TO_CHAR(NVL(P33PTT,0) + NVL(P33RIR,0)),  /*계 17 */
//       TO_CHAR(NVL(P33IP2,0)),   /*비과세소득 18 */
//       '0',  /*퇴직연금 총수령액 19*/
//       '0',  /*퇴직연금 원리금합계액 20 */
//       '0',  /*퇴직연금 소득자불입액 21*/
//       '0',  /*퇴직연금 퇴지연금소득공제액 22 */
//       '0',  /*퇴직연금 일시금 23*/
//       '0',  /*퇴직연금 일시금지급예상액 24 */ 
//       '0',  /*퇴직연금 총일시금 25*/
//       '0',  /*수령가능퇴직급여액 26 */
//       '0',  /*환산퇴직소득공제27*/
//       '0',  /*환산퇴직소득과세표준 28 */
//       '0',  /*환산연평균과세표준 29*/
//       '0',  /*환산연평균산출세액 30 */
//       P33FDT,  /*퇴직금산정시작일: 31*/
//       P33TDT,  /*퇴사일자: 32 */
//       TO_CHAR(NVL(P33MON,0)),  /*근속월수: 33*/
//       TO_CHAR(NVL(CEIL(P33LOT/30/10) * 10, 0)),  /*휴직일수 34 */
//       '0',  /*종전근무지 입사연월일 35*/
//       '0',  /*종전근무지 퇴사연월일 36 */ 
//       '0',  /*종전근무지근속월수 37*/
//       '0',  /*종전근무지 제외월수 38 */
//       '0',  /*중복월수 39*/
//       TO_CHAR(NVL(P33YER, 0)),  /*근속년수 40 */
//      TO_CHAR(NVL(P33PTT,0)),  /*퇴직급여액 41*/
//       TO_CHAR(NVL(P33ICT, 0)),  /*퇴직소득공제 42*/
//       TO_CHAR(NVL(P33TRS, 0)),  /*퇴직소득과세표준 43 */
//       TO_CHAR(NVL(P33ATS,0)),  /*연평균과표: 44*/
//       TO_CHAR(NVL(P33YCT,0)),  /*연평균산출세액: 45 */ 
//       TO_CHAR(NVL(P33CTA,0)),  /*산출세액: 46*/
//       TO_CHAR(NVL(P33TYX,0)),  /*세액공제: 47 */
//       TO_CHAR(NVL(P33TXR,0)),  /*소득세: 48*/
//       TO_CHAR(NVL(P33RTR,0)),  /*주민세: 49 */
//       TO_CHAR(NVL(P33FTR,0)),  /*농특세: 50*/
//       TO_CHAR(NVL(P33TXR,0) + NVL(P33RTR, 0) + NVL(P33FTR, 0)), /*결정세액계 51*/
//       '0', /*종전근무지 소득세 52 */
//       '0', /*종전근무지 주민세 53*/
//        '0', /*종전근무지 농특세 54 */
//       '0'/*종전근무지 계 55*/
//   FROM PADB.TP33PYA0 A, PADB.TH01HRA0 B
//WHERE A.P33NNO = B.H01NNO
//AND ((LENGTH(TRIM(P33RTD)) = 8 AND SUBSTR(P33TDT,1, 4) = :as_year  AND P33AJG = 'T') OR
//(LENGTH(TRIM(P33RTD)) <> 8 AND SUBSTR(P33JDT,1, 4) = :as_year AND P33AJG = 'J' ) )
// AND	((:as_gu = '1' AND SUBSTR(P33NNO,1, 1) = 'K') Or
//	 			(:as_gu <> '1' AND SUBSTR(P33NNO,1, 1) <> 'K'))			 
//USING SQLCA;
////
//	OPEN TP33PYA0 ;
// 	FETCH TP33PYA0 INTO :ls_nno, 
//:ls_str[3,9], :ls_str[3,10], :ls_str[3,11],  :ls_str[3,13], :ls_str[3,14], :ls_str[3,15], :ls_str[3,16], :ls_str[3,17], :ls_str[3,18], :ls_str[3,19],
//:ls_str[3,20], :ls_str[3,21], :ls_str[3,22], :ls_str[3,23], :ls_str[3,24], :ls_str[3,25], :ls_str[3,26], :ls_str[3,27], :ls_str[3,28],
//:ls_str[3,29], :ls_str[3,30], :ls_str[3,31], :ls_str[3,32], :ls_str[3,33], :ls_str[3,34], :ls_str[3,35], :ls_str[3,36], :ls_str[3,37],
//:ls_str[3,38], :ls_str[3,39], :ls_str[3,40], :ls_str[3,41], :ls_str[3,42], :ls_str[3,43], :ls_str[3,44], :ls_str[3,45], :ls_str[3,46],
//:ls_str[3,47], :ls_str[3,48], :ls_str[3,49], :ls_str[3,50], :ls_str[3,51], :ls_str[3,52], :ls_str[3,53], :ls_str[3,54], :ls_str[3,55]
// ;
//	 DO WHILE SQLCA.SQLCODE = 0
//		
//	ll_seq ++
//	ls_str[3, 4] = String(ll_seq)
////C,D,E 레코드 filewrite
//ll_cnt = 0  //초기화
//
//ll_i = 3  //C레코드
//	//################################################
//	//D 레코드 : 없음
//	//################################################	
//	
//	
//
//		SELECT CAST(SUBSTR(MAX(ZCCCOMCD), 2, 3) AS NUMERIC)
//		INTO :ll_cnt
//		FROM CLVDTALB.TZCDA121 
//		WHERE ZCCSYSCD = 'MIS' 
//		AND ZCCGRPCD = 'EE6'    
//		AND SUBSTR(ZCCCOMCD, 1, 1) = :ls_record[ll_i]
//		USING SQLCA;
//		
//		
//		ls_str_recode[ll_i] = ''	 //초기화
//		For ll_t = 1 To ll_cnt   
//			ls_str[ll_i, ll_t] = of_year_strchg(ls_str[ll_i, ll_t], ls_type[ll_i, ll_t], ll_len[ll_i, ll_t])		
//			ls_str_recode[ll_i] = ls_str_recode[ll_i] + ls_str[ll_i, ll_t]
//		Next
//		//C레코드는 1번씩만 write 함
//			FileWrite(li_FileNum, ls_str_recode[ll_i])
//
//	
//
//
//	 	FETCH TP33PYA0 INTO :ls_nno, 
//:ls_str[3,9], :ls_str[3,10], :ls_str[3,11],  :ls_str[3,13], :ls_str[3,14], :ls_str[3,15], :ls_str[3,16], :ls_str[3,17], :ls_str[3,18], :ls_str[3,19],
//:ls_str[3,20], :ls_str[3,21], :ls_str[3,22], :ls_str[3,23], :ls_str[3,24], :ls_str[3,25], :ls_str[3,26], :ls_str[3,27], :ls_str[3,28],
//:ls_str[3,29], :ls_str[3,30], :ls_str[3,31], :ls_str[3,32], :ls_str[3,33], :ls_str[3,34], :ls_str[3,35], :ls_str[3,36], :ls_str[3,37],
//:ls_str[3,38], :ls_str[3,39], :ls_str[3,40], :ls_str[3,41], :ls_str[3,42], :ls_str[3,43], :ls_str[3,44], :ls_str[3,45], :ls_str[3,46],
//:ls_str[3,47], :ls_str[3,48], :ls_str[3,49], :ls_str[3,50], :ls_str[3,51], :ls_str[3,52], :ls_str[3,53], :ls_str[3,54], :ls_str[3,55]
//;
//	Loop
//     CLOSE TP33PYA0;
//		
//FileClose(li_FileNum)
//
//MESSAGEBOX('확인', '퇴직소득 지급조서 파일 작성이 완료 되었습니다. ~r~r' + &
//						ls_path + '파일을 확인해주세요')			
						
						
End Choose
End If

gvc_val.setproperty('yfilepath', ls_path)


RETURN 1
end function

on uo_payfunc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_payfunc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// 공통코드 list retrieve
//IF not isValid(ids) THEN ids = CREATE Datastore
//ids.dataobject = "d_dddw_code"
//ids.SetTransObject(sqlca)
//ids.Retrieve()
//
Post Event ue_constructor()

end event

