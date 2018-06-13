$PBExportHeader$uo_hjfunc.sru
$PBExportComments$행정공통 Function
forward
global type uo_hjfunc from nonvisualobject
end type
end forward

global type uo_hjfunc from nonvisualobject
event ue_constructor ( )
end type
global uo_hjfunc uo_hjfunc

type variables
Datastore ids


end variables

forward prototypes
public function integer of_search_house_year (ref vector avc_data)
public function integer of_search_house (ref vector avc_data)
public function integer of_check_recruit (ref vector avc_data)
public function integer of_house_base_setup (string as_house_gb, string as_std_year, integer ai_row)
public function integer of_schphoto_update (string as_house_gb, string as_std_year, string as_hakbun)
public function integer of_schphoto_down (string as_house_gb, string as_std_year, string as_hakbun)
public function string of_get_house_req_no (string as_house_gb, string as_year)
end prototypes

public function integer of_search_house_year (ref vector avc_data);/*-------------------------------------------------------------------------------------------------
	PROGRAM NAME 	: 	uo_hjfunc
	EVENT NAME   		: 	of_search_house_year
	PARAMETER    		: 	Return 	- 찾은값을 리턴한다.
	DESCRIPTION  		: 	현재 기숙사시스템을 사용할 수 있는 기준년도를 확인한다.
-------------------------------------------------------------------------------------------------*/
/* 변수 초기화 */
String		ls_result[]
Integer	li_err_code
String		ls_err_text

SELECT	 MAX(SUBSTR(CODE,1,4))
			,MAX(FNAME) 
			,MAX(ETC_CD1)
			,MAX(ETC_CD2)
INTO		:ls_result[1],
			:ls_result[2],
			:ls_result[3],
			:ls_result[4]
FROM		CDDB.KCH102D
WHERE		CODE_GB 					= 'SAZ00'
AND		NVL(USE_YN, 'N')		= 'Y'
AND		NVL(ETC_CD3, 'N')		= 'Y'
AND		NVL(ETC_CD4, 'N')		= 'N'
USING SQLCA ;

Choose Case	SQLCA.SQLCODE
	Case	-1
		gf_sqlerr_msg(THIS.Classname(), 'of_search_emp function', String(31), 'SELECT COUNT(*) FROM CDDB.KCH102D', li_err_code, ls_err_text)
		Return -1
	Case	100
		Return 0
	Case	0
		avc_data = Create Vector
		avc_data.SetProperty('std_year',	func.of_nvl(ls_result[1],		''))
		avc_data.SetProperty('year_nm',	func.of_nvl(ls_result[2],		''))
		avc_data.SetProperty('year_str',	func.of_nvl(ls_result[3],		''))
		avc_data.SetProperty('year_end',	func.of_nvl(ls_result[4],		''))
		avc_data.setProperty("parm_cnt",		"1")
		
		Return 1
End Choose

end function

public function integer of_search_house (ref vector avc_data);/*-------------------------------------------------------------------------------------------------
	PROGRAM NAME 	: 	uo_hjfunc
	EVENT NAME   		: 	of_search_housecd
	PARAMETER    		: 	vector    	- 관련 찾은 정보를 담는다.
								Return 	-1 - 오류발생
											 0 - 찾는값이 없는 경우
											 1 - 찾는값을 찾은 경우
	DESCRIPTION  		: 	해당 로그인자의 현재 배정된 기숙사에 대한 관련값을 리턴한다.
-------------------------------------------------------------------------------------------------*/
/* 변수 초기화 */
String		ls_result[], ls_year
Integer	li_rtn, li_err_code
String		ls_err_text
Vector	lvc_data

lvc_data = Create Vector

/* 현재 사용하는 연도를 확인한다. */
li_rtn = of_search_house_year(lvc_data)
If li_rtn <> 1 Then
	Return -1
Else
	ls_year = lvc_data.GetProperty('std_year')
	
	/* 해당 로그인자가 기숙사 관련 사생인지 확인한다. */
	
//	SELECT	 HOUSE_GB
//				,STD_YEAR
//				,HOUSE_CD
//				,ROOM_CD
//				,DOOR_GB
//				,DOOR_NO
//	INTO		:ls_result[1],
//				:ls_result[2],
//				:ls_result[3],
//				:ls_result[4],
//				:ls_result[5],
//				:ls_result[6]
//	FROM		SCH.SAZ250T
//	WHERE	STD_YEAR 	= :ls_year
//	AND		HAKBUN		= :gs_empcode
//	USING	SQLCA;

	SELECT  HOUSE_GB
			 ,STD_YEAR
			 ,HOUSE_CD
			 ,ALLOCATE_NO
			 ,(SELECT RECRUIT_NO FROM SCH.SAZ220T WHERE HOUSE_GB = A.HOUSE_GB 
				  AND STD_YEAR = A.STD_YEAR
				  AND HOUSE_REQ_NO = A.HOUSE_REQ_NO)
			 ,HOUSE_REQ_NO
			 ,ROOM_CD
			 ,DOOR_GB
			 ,DOOR_NO
		 INTO  :ls_result[1],
			 :ls_result[2],
			 :ls_result[3],
			 :ls_result[4],
			 :ls_result[5],
			 :ls_result[6],
			 :ls_result[7],
			 :ls_result[8],
			 :ls_result[9]    
	 FROM  SCH.SAZ250T A
	 WHERE STD_YEAR  = :ls_year
	 AND  HAKBUN  = :gs_empcode
	 USING SQLCA;
 
	Choose Case	SQLCA.SQLCODE
		Case	-1
			gf_sqlerr_msg(THIS.Classname(), 'of_search_house', String(31), 'SELECT COUNT(*) FROM SCH.SAZ250T', li_err_code, ls_err_text)
			Return -1
		Case	100
			Return 0
		Case	0
			avc_data = Create Vector
			avc_data.SetProperty('house_gb',	func.of_nvl(ls_result[1],		''))
			avc_data.SetProperty('std_year',	func.of_nvl(ls_result[2],		''))
			avc_data.SetProperty('allcate_no',	func.of_nvl(ls_result[3],		''))
			avc_data.SetProperty('recruit_no',	func.of_nvl(ls_result[4],		''))
			avc_data.SetProperty('house_req_no',	func.of_nvl(ls_result[5],		''))
			avc_data.SetProperty('house_cd',	func.of_nvl(ls_result[6],		''))
			avc_data.SetProperty('room_cd',	func.of_nvl(ls_result[7],		''))
			avc_data.SetProperty('door_gb',	func.of_nvl(ls_result[8],		''))
			avc_data.SetProperty('door_no',	func.of_nvl(ls_result[9],		''))
			avc_data.setProperty("parm_cnt",		"1")
			
			Return 1
	End Choose
End If
end function

public function integer of_check_recruit (ref vector avc_data);/*-------------------------------------------------------------------------------------------------
	PROGRAM NAME 	: 	uo_hjfunc
	EVENT NAME   		: 	of_check_recruit
	PARAMETER    		: 	Vector	현재 모집중인 정보를 리턴
								Return 	-1 - 오류발생
											 0 - 찾는값이 없는 경우
											 1 - 찾는값을 찾은 경우
	DESCRIPTION  		: 	현재시점이 모집기간인지를 확인하여 리턴한다.
-------------------------------------------------------------------------------------------------*/
String		ls_date, ls_house_gb, ls_data[]
String		ls_err_text, ls_sex
Integer	li_err_code

ls_date 			= func.of_get_sdate('YYYYMMDD')
ls_house_gb		= avc_data.GetProperty('house_gb')
ls_sex			= avc_data.GetProperty("sex")

SELECT	 HOUSE_GB
			,STD_YEAR
			,RECRUIT_NO
			,NOTICE_DT
			,RECRUIT_NM
			,To_Char(COLLECT_PER, '00000')
			,MID_ENTER
			,HAKJUK_GB
			,ENTER_TERM
			,SEX
			,DOOR_TY
			,REQ_STR
			,REQ_END
			,ENTER_STR
			,ENTER_END
INTO		 :ls_data[1]
			,:ls_data[2]
			,:ls_data[3]
			,:ls_data[4]
			,:ls_data[5]
			,:ls_data[6]
			,:ls_data[7]
			,:ls_data[8]
			,:ls_data[9]
			,:ls_data[10]
			,:ls_data[11]
			,:ls_data[12]
			,:ls_data[13]
			,:ls_data[14]
			,:ls_data[15]
FROM		SCH.SAZ210T
WHERE	HOUSE_GB = :ls_house_gb
AND		:ls_date	between REQ_STR and REQ_END
AND		SEX = :ls_sex
AND		Nvl(CLOSE_YN, 'N') = 'N'
USING SQLCA ;

Choose Case	SQLCA.SQLCODE
	Case	-1
		gf_sqlerr_msg(THIS.Classname(), 'of_check_recruit', String(31), 'SELECT COUNT(*) FROM SCH.SAZ210T', li_err_code, ls_err_text)
		Return -1
	Case	100
		MessageBox("확인", "현재 신청기간이 아닙니다.")
		Return 0
	Case	0
		avc_data = Create Vector
		avc_data.SetProperty('house_gb',	func.of_nvl(ls_data[1],		''))
		avc_data.SetProperty('std_year',	func.of_nvl(ls_data[2],		''))
		avc_data.SetProperty('recruit_no',	func.of_nvl(ls_data[3],		''))
		avc_data.SetProperty('notice_dt',	func.of_nvl(ls_data[4],		''))
		avc_data.SetProperty('recruit_nm',	func.of_nvl(ls_data[5],		''))
		avc_data.SetProperty('collect_per',	func.of_nvl(ls_data[6],		''))
		avc_data.SetProperty('mid_enter',	func.of_nvl(ls_data[7],		''))
		avc_data.SetProperty('hakjuk_gb',	func.of_nvl(ls_data[8],		''))
		avc_data.SetProperty('enter_term',	func.of_nvl(ls_data[9],		''))
		avc_data.SetProperty('sex',			func.of_nvl(ls_data[10],		''))
		avc_data.SetProperty('door_gb',	func.of_nvl(ls_data[11],		''))
		avc_data.SetProperty('req_str',		func.of_nvl(ls_data[12],		''))
		avc_data.SetProperty('req_end',	func.of_nvl(ls_data[13],		''))
		avc_data.SetProperty('enter_str',	func.of_nvl(ls_data[14],		''))
		avc_data.SetProperty('enter_end',	func.of_nvl(ls_data[15],		''))
		avc_data.setProperty("parm_cnt",		"1")
		
		Return 1
End Choose

Return 1
end function

public function integer of_house_base_setup (string as_house_gb, string as_std_year, integer ai_row);/*-------------------------------------------------------------------------------------------------
	PROGRAM NAME 	: 	uo_hjfunc
	EVENT NAME   		: 	of_house_base_setup
	PARAMETER    		: 	String		as_house_gb - 기초자료 생성하고자 하는 기숙사구분코드
								String		as_std_year	  - 기초자료 생성하고자 하는 년도
								Integer	ai_row		  - 작업구분 (공통코드 SAZ28 참조)
								Return 	-1 - 오류발생
											 0 - 찾는값이 없는 경우
											 1 - 찾는값을 찾은 경우
	DESCRIPTION  		: 	해당 기숙사코드 년도에 기초 Setup 자료를 생성한다.
-------------------------------------------------------------------------------------------------*/
String		ls_bef_year
String		ls_err_text
Integer	li_err_code, li_cnt, rtn

ls_bef_year = Left(func.of_month_add(as_std_year + '0101', -12), 4)

Choose Case ai_row
	Case 1	// 기숙사 호실정보 생성
		SELECT 	Count(*)
		INTO		:li_cnt
		FROM		SCH.SAZ120D
		WHERE	HOUSE_GB	= :as_house_gb
		AND		STD_YEAR	= :ls_bef_year
		USING	SQLCA ;
		
		If li_cnt > 0 Then
			rtn = MessageBox("확인","해당 년도의 기초자료가 존재합니다. 재생성 할까요? ", Question!, YesNo!)
		End If
		
		If rtn = 1 Then
			DELETE 	FROM		SCH.SAZ120D
			WHERE	HOUSE_GB	= :as_house_gb
			AND		STD_YEAR	= :ls_bef_year
			USING	SQLCA ;
			
			If Sqlca.SqlCode < 0 Then
				gf_sqlerr_msg(THIS.Classname(), 'of_house_base_setup', String(31), 'SCH.SAZ120D Data Clear Error', li_err_code, ls_err_text)
				RollBack Using Sqlca ;
				Return -1
			End If
		ElseIf rtn = 2 Then
			Return 0
		End If
		
		INSERT INTO SCH.SAZ120D
		(HOUSE_GB, STD_YEAR, HOUSE_CD, ROOM_CD, DOOR_GB, ROOM_NM, FLOOR, SEX, AVL_PER, REMARK, WORKER, IPADD, WORK_DATE, JOB_UID, JOB_ADD, JOB_DATE)
		SELECT 	 HOUSE_GB
					,:as_std_year
					,HOUSE_CD
					,ROOM_CD
					,DOOR_GB
					,ROOM_NM
					,FLOOR
					,SEX
					,AVL_PER
					,REMARK
					,:gs_empcode
					,Null
					,SYSDATE
					,:gs_empcode
					,Null
					,SYSDATE
		FROM		SCH.SAZ120D
		WHERE	HOUSE_GB	= :as_house_gb
		AND		STD_YEAR	= :ls_bef_year
		USING	SQLCA ;
	Case 2	// 기숙사비 기준표 생성
		SELECT 	Count(*)
		INTO		:li_cnt
		FROM		SCH.SAZ130M
		WHERE	HOUSE_GB	= :as_house_gb
		AND		STD_YEAR	= :ls_bef_year
		USING	SQLCA ;
		
		If li_cnt > 0 Then
			rtn = MessageBox("확인","해당 년도의 기초자료가 존재합니다. 재생성 할까요? ", Question!, YesNo!)
		End If
		
		If rtn = 1 Then
			DELETE 	FROM		SCH.SAZ130M
			WHERE	HOUSE_GB	= :as_house_gb
			AND		STD_YEAR	= :ls_bef_year
			USING	SQLCA ;
			
			If Sqlca.SqlCode < 0 Then
				gf_sqlerr_msg(THIS.Classname(), 'of_house_base_setup', String(31), 'SCH.SAZ130M Data Clear Error', li_err_code, ls_err_text)
				RollBack Using Sqlca ;
				Return -1
			End If
		ElseIf rtn = 2 Then
			Return 0
		End If
		
		INSERT INTO SCH.SAZ130M
		(HOUSE_GB, STD_YEAR, ENTER_TERM, DOOR_GB, GUARANTEE_AMT, ENTER_AMT, MNG_AMT, FOOD_AMT, STD_WEEK, REMARK, HOUSE_CD, WORKER, IPADD, WORK_DATE, JOB_UID, JOB_ADD, JOB_DATE)
		SELECT 	 HOUSE_GB
					,:as_std_year
					,ENTER_TERM
					,DOOR_GB
					,GUARANTEE_AMT
					,ENTER_AMT
					,MNG_AMT
					,FOOD_AMT
					,STD_WEEK
					,REMARK
					,HOUSE_CD
					,:gs_empcode
					,Null
					,SYSDATE
					,:gs_empcode
					,Null
					,SYSDATE
		FROM		SCH.SAZ130M
		WHERE	HOUSE_GB	= :as_house_gb
		AND		STD_YEAR	= :ls_bef_year
		USING	SQLCA ;
	Case 3	// 기숙사비 반환기준표 생성
		SELECT 	Count(*)
		INTO		:li_cnt
		FROM		SCH.SAZ140M
		WHERE	HOUSE_GB	= :as_house_gb
		AND		STD_YEAR	= :ls_bef_year
		USING	SQLCA ;
		
		If li_cnt > 0 Then
			rtn = MessageBox("확인","해당 년도의 기초자료가 존재합니다. 재생성 할까요? ", Question!, YesNo!)
		End If
		
		If rtn = 1 Then
			DELETE 	FROM		SCH.SAZ140M
			WHERE	HOUSE_GB	= :as_house_gb
			AND		STD_YEAR	= :ls_bef_year
			USING	SQLCA ;
			
			If Sqlca.SqlCode < 0 Then
				gf_sqlerr_msg(THIS.Classname(), 'of_house_base_setup', String(31), 'SCH.SAZ130M Data Clear Error', li_err_code, ls_err_text)
				RollBack Using Sqlca ;
				Return -1
			End If
		ElseIf rtn = 2 Then
			Return 0
		End If
		
		INSERT INTO SCH.SAZ140M
		(HOUSE_GB, STD_YEAR, ENTER_TERM, OUT_STD_WEEK, RETURN_RATE, RETURN_OVER_WEEK, REMARK, HOUSE_CD, WORKER, IPADD, WORK_DATE, JOB_UID, JOB_ADD, JOB_DATE)
		SELECT 	 HOUSE_GB
					,:as_std_year
					,ENTER_TERM
					,OUT_STD_WEEK
					,RETURN_RATE
					,RETURN_OVER_WEEK
					,REMARK
					,HOUSE_CD
					,:gs_empcode
					,Null
					,SYSDATE
					,:gs_empcode
					,Null
					,SYSDATE
		FROM		SCH.SAZ140M
		WHERE	HOUSE_GB	= :as_house_gb
		AND		STD_YEAR	= :ls_bef_year
		USING	SQLCA ;
End Choose

Choose Case	SQLCA.SQLCODE
	Case	-1
		gf_sqlerr_msg(THIS.Classname(), 'of_house_base_setup', String(31), 'Insert Data Error', li_err_code, ls_err_text)
		RollBack Using Sqlca ;
		Return -1
	Case	100
		Return 0
	Case	0
		Return 1
End Choose

Return 1
end function

public function integer of_schphoto_update (string as_house_gb, string as_std_year, string as_hakbun);//입사생사진정보업데이트
string ls_hakbun

Blob      lbBmp
long      LL_size, LL_write
int       FP, Li_count, i ,fh

DECLARE SCHPHO CURSOR FOR 
							SELECT    A.HAKBUN
							FROM      HAKSA.PHOTO A,
										 SCH.SAZ220T B
							WHERE     A.HAKBUN = B.HAKBUN
							AND       B.HAKBUN NOT IN ((SELECT HAKBUN FROM SCH.SAZ150M))
							AND       B.HOUSE_GB = :as_house_gb
							AND       B.STD_YEAR    = :as_std_year
							AND       B.HAKBUN LIKE :as_hakbun
										ORDER BY A.HAKBUN
			USING SQLCA;
			
OPEN SCHPHO ;
FETCH SCHPHO INTO :ls_hakbun;
DO WHILE SQLCA.SQLCODE = 0
setnull(lbBmp)
LL_size=0
LL_write=0
FP=0
Li_count=0
i=0
fh=0
	
	
	
INSERT INTO SCH.SAZ150M (HAKBUN, JOB_DATE)
VALUES ( :ls_hakbun, sysdate);
IF sqlca.sqlcode <> 0 then 
	ROLLBACK USING SQLCA;
	messagebox('알림','SAZ150M 에러!')
	return -1
END IF



SELECTBLOB P_IMAGE
        INTO  :lbBmp 
        FROM HAKSA.PHOTO
        WHERE HAKBUN = :ls_hakbun
        USING sqlca ;
       
IF sqlca.sqlcode = 0 then
//	 LL_size = Len(lbBmp)
//	 IF LL_size > 32765 THEN
//          	 IF Mod(LL_size, 32765) = 0 THEN
//     	              	 Li_count = LL_size / 32765
//     		 ELSE
//     			 Li_count = (LL_size / 32765) + 1
//     		 END IF
//      ELSE
//     		 Li_count = 1
//      END IF
//      FP = FileOpen("c:\emp_image\" + ls_hakbun + ".jpg", StreamMode!, Write!, Shared!, Replace!)
//      FOR i = 1 to Li_count
//     	    LL_write    = FileWrite(fp,lbBmp )
//     	    IF LL_write = 32765 THEN
//     			  lbBmp    = BlobMid(lbBmp, 32766)
//     	    END IF
//      NEXT
		
	UPDATEBLOB SCH.SAZ150M SET P_IMAGE = :lbBmp
    WHERE HAKBUN = :ls_hakbun
    USING sqlca ;

	IF sqlca.sqlcode <> 0 THEN
			 
			ROLLBACK  USING sqlca ;
			messagebox('알림',ls_hakbun + '사진저장 실패')
			return -1  
	END IF
//     	     FileClose(FP)
ELSE 
	 messagebox('알림',ls_hakbun + '사진가져오기 실패')
	 return -1
END IF

FETCH SCHPHO INTO :ls_hakbun;

Loop
CLOSE SCHPHO;


					
return 1
end function

public function integer of_schphoto_down (string as_house_gb, string as_std_year, string as_hakbun);//입사생사진정보다운로드
string ls_hakbun, ls_cd, ls_hname

Blob      lbBmp
long      LL_size, LL_write
int       FP, Li_count, i ,fh

DECLARE SCHPHO CURSOR FOR 
							SELECT    A.HAKBUN,
							B.HNAME,
							C.HOUSE_CD || '-' || C.ROOM_CD || '-' ||   C.DOOR_GB || '-' || C.DOOR_NO
							FROM      SCH.SAZ150M A,
										 SCH.SAZ220T B,
										SCH.SAZ250T C
							WHERE     A.HAKBUN = B.HAKBUN
							AND		B.HAKBUN = C.HAKBUN
							AND		B.HOUSE_GB = C.HOUSE_GB
							AND		B.STD_YEAR = C.STD_YEAR
							AND       B.HOUSE_GB = :as_house_gb
							AND       B.STD_YEAR    = :as_std_year
							AND       B.HAKBUN LIKE :as_hakbun
										ORDER BY A.HAKBUN
			USING SQLCA;
			
OPEN SCHPHO ;
FETCH SCHPHO INTO :ls_hakbun, :ls_hname,  :ls_cd;
DO WHILE SQLCA.SQLCODE = 0
setnull(lbBmp)
LL_size=0
LL_write=0
FP=0
Li_count=0
i=0
fh=0

SELECTBLOB P_IMAGE
        INTO  :lbBmp 
        FROM SCH.SAZ150M
        WHERE HAKBUN = :ls_hakbun
        USING sqlca ;
       
IF sqlca.sqlcode = 0 then
	 LL_size = Len(lbBmp)
	 IF LL_size > 32765 THEN
          	 IF Mod(LL_size, 32765) = 0 THEN
     	              	 Li_count = LL_size / 32765
     		 ELSE
     			 Li_count = (LL_size / 32765) + 1
     		 END IF
      ELSE
     		 Li_count = 1
      END IF
      FP = FileOpen("c:\emp_image\" + ls_hname + "-"+ ls_hakbun + "-" +ls_cd  + ".jpg", StreamMode!, Write!, Shared!, Replace!)
      FOR i = 1 to Li_count
     	    LL_write    = FileWrite(fp,lbBmp )
     	    IF LL_write = 32765 THEN
     			  lbBmp    = BlobMid(lbBmp, 32766)
     	    END IF
      NEXT
		     FileClose(FP)
ELSE 
	 messagebox('알림',ls_hakbun + '사진가져오기 실패')
	 return -1
END IF

FETCH SCHPHO INTO :ls_hakbun, :ls_hname, :ls_cd;

Loop
CLOSE SCHPHO;


					
return 1
end function

public function string of_get_house_req_no (string as_house_gb, string as_year);String ls_house_req_no
//신청순번 : 3자리 '000'

SELECT TO_CHAR(MAX(TO_NUMBER(HOUSE_REQ_NO)) + 1, '000')
INTO :ls_house_req_no
FROM SCH.SAZ220T
WHERE HOUSE_GB = :as_house_gb
AND STD_YEAR = :as_year
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_house_req_no = ''
Else
	If ls_house_req_no = '' or isnull(ls_house_req_no) Then ls_house_req_no = '001'
End If
	


RETURN ls_house_req_no
end function

on uo_hjfunc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_hjfunc.destroy
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

