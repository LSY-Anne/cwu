$PBExportHeader$uo_hsfunc.sru
$PBExportComments$학사공통 Function
forward
global type uo_hsfunc from nonvisualobject
end type
end forward

global type uo_hsfunc from nonvisualobject
event ue_constructor ( )
end type
global uo_hsfunc uo_hsfunc

type variables
Datastore ids


end variables

forward prototypes
public function integer of_search_house_year (ref vector avc_data)
public function integer of_search_house (ref vector avc_data)
public function integer of_house_base_setup (string as_house_gb, string as_std_year, integer ai_row)
public function integer of_get_yearhakgi (string as_gb, ref vector avc_data)
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

SELECT	 CODE
			,FNAME
			,ETC_CD1
			,ETC_CD2
INTO		:ls_result[1],
			:ls_result[2],
			:ls_result[3],
			:ls_result[4]
FROM		CDDB.KCH102D
WHERE	CODE_GB 				= 'SAZ00'
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
	SELECT	 HOUSE_GB
				,STD_YEAR
				,HOUSE_CD
				,ROOM_CD
				,DOOR_GB
				,DOOR_NO
	INTO		:ls_result[1],
				:ls_result[2],
				:ls_result[3],
				:ls_result[4],
				:ls_result[5],
				:ls_result[6]
	FROM		SCH.SAZ250T
	WHERE	STD_YEAR 	= :ls_year
	AND		HAKBUN		= :gs_empcode
	USING	SQLCA;
	
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

public function integer of_get_yearhakgi (string as_gb, ref vector avc_data);/*-------------------------------------------------------------------------------------------------
	PROGRAM NAME 	: 	uo_hsfunc
	EVENT NAME   		: 	of_get_yearhakgi
	PARAMETER    		: 	as_gb	업무구분
										SUM - 상담관리
									Vector	현재 모집중인 정보를 리턴
								Return 	-1 - 오류발생
											 0 - 찾는값이 없는 경우
											 1 - 찾는값을 찾은 경우
	DESCRIPTION  		: 	업무단위별 현재 사용가능한 년도 및 학기를 구한다.
-------------------------------------------------------------------------------------------------*/
String		ls_year, ls_hakgi, ls_str, ls_end
String		ls_err_text
Integer		li_err_code

Choose Case as_gb
	Case 'SUM'
		SELECT	 YEAR
					,HAKGI, HAKGI_STR, HAKGI_END
		INTO		 :ls_year
					,:ls_hakgi, :ls_str, :ls_end
		FROM	HAKSA.SUM170TL
		WHERE	YEAR||HAKGI = (SELECT MAX(YEAR||HAKGI) FROM HAKSA.SUM170TL WHERE USE_YN = 'Y' GROUP BY YEAR||HAKGI )
		USING SQLCA ;
		
		Choose Case	SQLCA.SQLCODE
			Case	-1
				gf_sqlerr_msg(THIS.Classname(), 'of_get_yearhakgi', String(31), 'SELECT COUNT(*) FROM HAKSA.SUM170TL', li_err_code, ls_err_text)
				Return -1
			Case	100
				Return 0
			Case	0
				avc_data = Create Vector
				avc_data.SetProperty('year',	func.of_nvl(ls_year,		''))
				avc_data.SetProperty('hakgi',	func.of_nvl(ls_hakgi,		''))
				avc_data.SetProperty('hakgi_str',	func.of_nvl(ls_str,		''))
				avc_data.SetProperty('hakgi_end',	func.of_nvl(ls_end,		''))				
				avc_data.setProperty("parm_cnt",		"1")
				
				Return 1
		End Choose
End Choose

Return 1
end function

on uo_hsfunc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_hsfunc.destroy
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

