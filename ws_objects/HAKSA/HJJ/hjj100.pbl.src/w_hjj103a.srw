$PBExportHeader$w_hjj103a.srw
$PBExportComments$[청운대]졸업사정
forward
global type w_hjj103a from w_condition_window
end type
type st_6 from statictext within w_hjj103a
end type
type st_4 from statictext within w_hjj103a
end type
type st_5 from statictext within w_hjj103a
end type
type dw_con from uo_dwfree within w_hjj103a
end type
type dw_main from uo_dwfree within w_hjj103a
end type
type uo_1 from uo_imgbtn within w_hjj103a
end type
type uo_2 from uo_imgbtn within w_hjj103a
end type
type uo_3 from uo_imgbtn within w_hjj103a
end type
type uo_4 from uo_imgbtn within w_hjj103a
end type
end forward

global type w_hjj103a from w_condition_window
st_6 st_6
st_4 st_4
st_5 st_5
dw_con dw_con
dw_main dw_main
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
uo_4 uo_4
end type
global w_hjj103a w_hjj103a

forward prototypes
public function integer wf_yebimove_hjmod (string as_year, string as_junhugi)
public function integer wf_yebimove_sugang (string as_year, string as_junhugi)
public function integer wf_yebimove_sungjukgye (string as_year, string as_junhugi)
public function integer wf_move_sugang (string as_year, string as_junhugi)
public function integer wf_move_sungjukgye (string as_year, string as_junhugi)
public function integer wf_yebimove_hakjuk (string as_year, string as_junhugi)
public function integer wf_move_hjmod (string as_year, string as_junhugi)
public function integer wf_yebimove_sinsang (string as_year, string as_junhugi)
public function integer wf_move_hakjuk (string as_year, string as_junhugi)
public function integer wf_move_sinsang (string as_year, string as_junhugi)
end prototypes

public function integer wf_yebimove_hjmod (string as_year, string as_junhugi);INSERT INTO HAKSA.JOLUP_HAKBYEN
(	SELECT	HB.*
	FROM		HAKSA.HAKJUKBYENDONG	HB	,
				HAKSA.JOLUP_SAJUNG	JS
	WHERE		HB.HAKBUN	= JS.HAKBUN
	AND		JS.YEAR		= :as_year
	AND		JS.JUNHUGI	= :as_junhugi
	AND		JS.HAPGYUK_GUBUN	IN ('1', '2')
) USING SQLCA ;

if sqlca.sqlcode = 0 then

		return 1

elseif sqlca.sqlcode = -1 then
	
	messagebox("오류", "학적변동자료 이관을 실패하였습니다!")
	return 0
	
end if
	
end function

public function integer wf_yebimove_sugang (string as_year, string as_junhugi);INSERT INTO HAKSA.JOLUP_SUGANG
(	SELECT	SG.HAKBUN,
			  	SG.YEAR,
				SG.HAKGI,
				SG.HAKYUN,
				SG.GWA,
				SG.GWAMOK_ID,
				SG.GWAMOK_SEQ,
				SG.ISU_ID,
				SG.HAKJUM,
				SG.JUMSU_1,
				SG.JUMSU_2,
				SG.JUMSU_3,
				SG.JUMSU_4,
				SG.JUMSU_5,
				SG.JUMSU,
				SG.HWANSAN_JUMSU,
				SG.PYENGJUM,
				SG.SUNGJUK_INJUNG,
				SG.JESU_YEAR,
				SG.JESU_HAKGI,
				SG.JESU_GWAMOK_ID,
				SG.JESU_GWAMOK_SEQ,
				SG.WORKER,
				SG.IPADDR,
				SG.WORK_DATE,
				SG.JOB_UID,
				SG.JOB_ADD,
				SG.JOB_DATE
	FROM		HAKSA.SUGANG	SG	,
				HAKSA.JOLUP_SAJUNG	JS
	WHERE		SG.HAKBUN	= JS.HAKBUN
	AND		JS.YEAR		= :as_year
	AND		JS.JUNHUGI	= :as_junhugi
	AND		JS.HAPGYUK_GUBUN	IN ('1', '2')
) USING SQLCA ;

if sqlca.sqlcode = 0 then

		return 1
		
elseif sqlca.sqlcode = -1 then
	
	messagebox("오류", "수강자료 이관을 실패하였습니다!")
	return 0
	
end if
	
end function

public function integer wf_yebimove_sungjukgye (string as_year, string as_junhugi);INSERT INTO HAKSA.JOLUP_SUNGJUKGYE
(	SELECT	SJ.HAKBUN,
				SJ.YEAR,
				SJ.HAKGI,
				SJ.HAKYUN,
				SJ.GWA,
				SJ.SINCHUNG_SU,
				SJ.SINCHUNG_HAKJUM,
				SJ.CHIDK_SU,
				SJ.CHIDK_HAKJUM,
				SJ.F_CNT,
				SJ.TOTAL_PYENGJUM,
				SJ.AVG_PYENGJUM,
				SJ.TOTAL_SILJUM,
				SJ.AVG_SILJUM,
				SJ.SUKCHA,
				SJ.JH_SUKCHA,
				SJ.GYUNGGO_YN,
				SJ.GYUNGGO_CNT,
				SJ.INJUNG_YN,
				SJ.WORKER,
				SJ.IPADDR,
				SJ.WORK_DATE,
				SJ.JOB_UID,
				SJ.JOB_ADD,
				SJ.JOB_DATE
	FROM		HAKSA.SUNGJUKGYE		SJ	,
				HAKSA.JOLUP_SAJUNG	JS
	WHERE		SJ.HAKBUN	= JS.HAKBUN
	AND		JS.YEAR		= :as_year
	AND		JS.JUNHUGI	= :as_junhugi
	AND		JS.HAPGYUK_GUBUN	IN ('1', '2')
) USING SQLCA ;

if sqlca.sqlcode = 0 then

		return 1

elseif sqlca.sqlcode = -1 then
	
	messagebox("오류", "성적계자료 이관을 실패하였습니다!")
	return 0
	
end if
	
end function

public function integer wf_move_sugang (string as_year, string as_junhugi);INSERT INTO HAKSA.JOLUP_SUGANG
(	SELECT	SG.HAKBUN,
			  	SG.YEAR,
				SG.HAKGI,
				SG.HAKYUN,
				SG.GWA,
				SG.GWAMOK_ID,
				SG.GWAMOK_SEQ,
				SG.ISU_ID,
				SG.HAKJUM,
				SG.JUMSU_1,
				SG.JUMSU_2,
				SG.JUMSU_3,
				SG.JUMSU_4,
				SG.JUMSU_5,
				SG.JUMSU,
				SG.HWANSAN_JUMSU,
				SG.PYENGJUM,
				SG.SUNGJUK_INJUNG,
				SG.JESU_YEAR,
				SG.JESU_HAKGI,
				SG.JESU_GWAMOK_ID,
				SG.JESU_GWAMOK_SEQ,
				SG.WORKER,
				SG.IPADDR,
				SG.WORK_DATE,
				SG.JOB_UID,
				SG.JOB_ADD,
				SG.JOB_DATE
	FROM		HAKSA.SUGANG	SG	,
				HAKSA.JOLUP_SAJUNG	JS
	WHERE		SG.HAKBUN	= JS.HAKBUN
	AND		JS.YEAR		= :as_year
	AND		JS.JUNHUGI	= :as_junhugi
	AND		JS.HAPGYUK_GUBUN	IN ('1', '2')
//	AND		JS.HAKBUN 	in( '20041703','20066101')
) USING SQLCA ;

if sqlca.sqlcode = 0 then
	DELETE FROM	HAKSA.SUGANG	SG
	WHERE			SG.HAKBUN	IN	(	SELECT	HAKBUN
											FROM		HAKSA.JOLUP_SAJUNG
											WHERE		YEAR		= :as_year
											AND		JUNHUGI	= :as_junhugi
											AND		HAPGYUK_GUBUN	IN ('1', '2')
//											AND		HAKBUN 	in( '20041703','20066101')	
										)
	USING SQLCA ;
	
	if sqlca.sqlcode = 0 then
		return 1
		
	elseif sqlca.sqlcode = -1 then
		messagebox("오류", "수강자료 삭제를 실패하였습니다!")
		return 0
	end if
	
elseif sqlca.sqlcode = -1 then
	messagebox("오류", "수강자료 이관을 실패하였습니다!")
	return 0
end if
	
end function

public function integer wf_move_sungjukgye (string as_year, string as_junhugi);INSERT INTO HAKSA.JOLUP_SUNGJUKGYE
(	SELECT	SJ.HAKBUN,
				SJ.YEAR,
				SJ.HAKGI,
				SJ.HAKYUN,
				SJ.GWA,
				SJ.SINCHUNG_SU,
				SJ.SINCHUNG_HAKJUM,
				SJ.CHIDK_SU,
				SJ.CHIDK_HAKJUM,
				SJ.F_CNT,
				SJ.TOTAL_PYENGJUM,
				SJ.AVG_PYENGJUM,
				SJ.TOTAL_SILJUM,
				SJ.AVG_SILJUM,
				SJ.SUKCHA,
				SJ.JH_SUKCHA,
				SJ.GYUNGGO_YN,
				SJ.GYUNGGO_CNT,
				SJ.INJUNG_YN,
				SJ.WORKER,
				SJ.IPADDR,
				SJ.WORK_DATE,
				SJ.JOB_UID,
				SJ.JOB_ADD,
				SJ.JOB_DATE
	FROM		HAKSA.SUNGJUKGYE		SJ	,
				HAKSA.JOLUP_SAJUNG	JS
	WHERE		SJ.HAKBUN	= JS.HAKBUN
	AND		JS.YEAR		= :as_year
	AND		JS.JUNHUGI	= :as_junhugi
	AND		JS.HAPGYUK_GUBUN	IN ('1', '2')
//	AND		JS.HAKBUN 		in( '20041703','20066101')
) USING SQLCA ;

if sqlca.sqlcode = 0 then
	DELETE FROM	HAKSA.SUNGJUKGYE		SJ
	WHERE			SJ.HAKBUN	IN	(	SELECT	HAKBUN
											FROM		HAKSA.JOLUP_SAJUNG
											WHERE		YEAR		= :as_year
											AND		JUNHUGI	= :as_junhugi
											AND		HAPGYUK_GUBUN	IN ('1', '2')
//											AND		HAKBUN 		in( '20041703','20066101')
										)
	USING SQLCA ;
	
	if sqlca.sqlcode = 0 then
		return 1
		
	elseif sqlca.sqlcode = -1 then
		messagebox("오류", "성적계자료 삭제를 실패하였습니다!")
		return 0
	end if
	
elseif sqlca.sqlcode = -1 then
	messagebox("오류", "성적계자료 이관을 실패하였습니다!")
	return 0
end if
	
end function

public function integer wf_yebimove_hakjuk (string as_year, string as_junhugi);INSERT INTO HAKSA.JOLUP_HAKJUK
(	SELECT	JH.HAKBUN,                
				JH.GWA,    
				KC.FNAME,
				KC.ENAME,
				KC.GROUP7_CODE,
				JH.JUNGONG_ID,            
				JH.BUJUNGONG_ID,          
				JH.JUNGONG_GUBUN,         
				'4',             
				JH.SU_HAKYUN,             
				JH.DR_HAKYUN,             
				JH.HAKGI,                 
				JH.JUYA_GUBUN ,           
				JH.BAN,                   
				JH.HNAME,                 
				JH.CNAME,                 
				JH.ENAME,                 
				JH.JUMIN_NO,              
				JH.SEX,                   
				JH.GUKGA_ID,              
				JH.JIYUK_ID,              
				JH.ZIP_ID,                
				JH.ADDR,                  
				JH.ADDR_E,                
				JH.TEL,                   
				JH.HP,                    
				JH.EMAIL,                 
				JH.BO_ZIP_ID,             
				JH.BO_ADDR,               
				JH.BO_TEL,                
				JH.BO_NAME,               
				JH.BO_JUMIN_NO,           
				JH.BO_GWANGYE,            
				JH.BO_JOB,                
				JH.BO_GRADE,              
				JH.HIGH_ID,               
				JH.HIGH_NAME,             
				JH.HIGH_JOL_DATE,         
				JH.COLLEGE_ID,            
				JH.COLLEGE_NAME,          
				JH.COLLEGE_GWA,           
				JH.COLLEGE_GWANAME,       
				JH.COLLEGE_JOL_DATE,      
				JH.COLLEGE_JOL_HAKYUN,    
				JH.COLLEGE_GUBUN,        
				JH.INJUNG_HAKJUM,         
				DECODE(JS.HAPGYUK_GUBUN,	'1',	'04',	'05')	,
				'G',							
				DECODE(JS.HAPGYUK_GUBUN,	'1',	DECODE(:as_junhugi,	'1',	'G11',	'G12'), 'G13')			,       
				JH.JOLUP_DATE,         
				JH.HUHAK_DATE,            
				JH.JAEIPHAK_DATE,         
				JH.IPHAK_DATE,           
				JH.IPHAK_GUBUN,           
				JH.IPHAK_JUNHYUNG,        
				JH.IPHAK_GWA,             
				JH.IPHAK_JUNGONG,
				JH.IPHAK_HAKYUN,
				JH.SU_JUMSU,              
				JH.JOLUP_DATE,           
				JH.JOLUP_COUNT,           
				JH.HAKWI_NO,              
				JH.HAKWI_NAME,            
				JH.HAKWI_ENAME,           
				JH.JUNG_NO,               
				JH.SURYO_NO,              
				JH.JOLUP_SUKCHA,          
				JH.BOHUN_ID,              
				JH.BOHUN_HAKGI,           
				JH.BOHUN_GUBUN,           
				JH.BOHUN_SAYU,            
				JH.GYOJIK_YN,             
				JH.GUNBUN,                
				JH.IPDAE_DATE,            
				JH.JUNYUK_DATE,           
				JH.YUKJONG_ID,            
				JH.GUNBYUL_ID,            
				JH.GRADE_ID,              
				JH.JOLUP_YN,              
				JH.PASSWORD,              
				JH.BANK_ID,               
				JH.ACCOUNT_NAME,          
				JH.ACCOUNT_NO,  
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL
//				gstru_uid_uname.uid,              
//				gstru_uid_uname.address,              
//				f_sysdate(),             
//				gstru_uid_uname.uid,              
//				gstru_uid_uname.address,              
//				f_sysdate()                
	FROM		HAKSA.JAEHAK_HAKJUK	JH,
				HAKSA.JOLUP_SAJUNG	JS,
				(	SELECT 	GWA,
								FNAME,
								ENAME,
								GROUP7_CODE
					FROM		CDDB.KCH003M
					WHERE		GWA_GUBUN = '1'
					AND		SUBSTR(GWA, 1, 2) NOT IN  ('AM','AH','TA')
				)	KC
	WHERE		JH.HAKBUN	= JS.HAKBUN
	AND		JH.GWA		= KC.GWA
	AND		JS.YEAR		= :as_year
	AND		JS.JUNHUGI	= :as_junhugi
	AND		JS.HAPGYUK_GUBUN	IN ('1', '2')
) USING SQLCA ;

if sqlca.sqlcode = 0 then

		return 1

elseif sqlca.sqlcode = -1 then
	
	messagebox("오류", "학적자료 이관을 실패하였습니다!")
	messagebox("에러",sqlca.sqlerrtext)		
	return 0
	
end if
	
	
	
	
	
	
	
	
	
end function

public function integer wf_move_hjmod (string as_year, string as_junhugi);INSERT INTO HAKSA.JOLUP_HAKBYEN
(	SELECT	HB.*
	FROM		HAKSA.HAKJUKBYENDONG	HB	,
				HAKSA.JOLUP_SAJUNG	JS
	WHERE		HB.HAKBUN	= JS.HAKBUN
	AND		JS.YEAR		= :as_year
	AND		JS.JUNHUGI	= :as_junhugi
	AND		JS.HAPGYUK_GUBUN	IN ('1', '2')	
//	AND		JS.HAKBUN 		in( '20041703','20066101')
) USING SQLCA ;

if sqlca.sqlcode = 0 then
	DELETE FROM	HAKSA.HAKJUKBYENDONG	HB
	WHERE			HB.HAKBUN	IN	(	SELECT	HAKBUN
											FROM		HAKSA.JOLUP_SAJUNG
											WHERE		YEAR		= :as_year
											AND		JUNHUGI	= :as_junhugi
											AND		HAPGYUK_GUBUN	IN ('1', '2')
//											AND		HAKBUN 		in( '20041703','20066101')
										)  USING SQLCA ;
	
	if sqlca.sqlcode = 0 then
		return 1
		
	elseif sqlca.sqlcode = -1 then
		messagebox("오류", "학적변동자료 삭제를 실패하였습니다!")
		return 0
	end if
	
elseif sqlca.sqlcode = -1 then
	messagebox("오류", "학적변동자료 이관을 실패하였습니다!")
	return 0
end if

end function

public function integer wf_yebimove_sinsang (string as_year, string as_junhugi);INSERT INTO HAKSA.JOLUP_SINSANG
(	SELECT	JH.HAKBUN,
				NULL,
				NULL,				
				NULL,
				NULL,	
				NULL,
				NULL,	
				NULL,
				NULL,	
				NULL,
				NULL,				
				NULL,
				NULL,	
				NULL,
				NULL,	
				NULL,
				NULL,	
				NULL,
				NULL,	
				NULL,
				NULL,				
				NULL,
				NULL,	
				NULL,
				NULL,
				NULL,	
				NULL,
				NULL				
	FROM		HAKSA.JAEHAK_HAKJUK	JH,
				HAKSA.JOLUP_SAJUNG	JS
	WHERE		JH.HAKBUN	= JS.HAKBUN
	AND		JS.YEAR		= :as_year
	AND		JS.JUNHUGI	= :as_junhugi
	AND		JS.HAPGYUK_GUBUN	IN ('1', '2')
) USING SQLCA ;

if sqlca.sqlcode = 0 then

		return 1

elseif sqlca.sqlcode = -1 then
	messagebox("오류", "신상자료 이관을 실패하였습니다!")
	messagebox("에러",sqlca.sqlerrtext)		
	return 0
	
end if

end function

public function integer wf_move_hakjuk (string as_year, string as_junhugi);
INSERT INTO HAKSA.JOLUP_HAKJUK
(	SELECT	JH.HAKBUN,                
				JH.GWA,    
				KC.FNAME,
				KC.ENAME,
				KC.GROUP7_CODE,
				JH.JUNGONG_ID,            
				JH.BUJUNGONG_ID,          
				JH.JUNGONG_GUBUN,         
				'4',             
				JH.SU_HAKYUN,             
				JH.DR_HAKYUN,             
				JH.HAKGI,                 
				JH.JUYA_GUBUN ,           
				JH.BAN,                   
				JH.HNAME,                 
				JH.CNAME,                 
				JH.ENAME,                 
				JH.JUMIN_NO,              
				JH.SEX,                   
				JH.GUKGA_ID,              
				JH.JIYUK_ID,              
				JH.ZIP_ID,                
				JH.ADDR,                  
				JH.ADDR_E,                
				JH.TEL,                   
				JH.HP,                    
				JH.EMAIL,                 
				JH.BO_ZIP_ID,             
				JH.BO_ADDR,               
				JH.BO_TEL,                
				JH.BO_NAME,               
				JH.BO_JUMIN_NO,           
				JH.BO_GWANGYE,            
				JH.BO_JOB,                
				JH.BO_GRADE,              
				JH.HIGH_ID,               
				JH.HIGH_NAME,             
				JH.HIGH_JOL_DATE,         
				JH.COLLEGE_ID,            
				JH.COLLEGE_NAME,          
				JH.COLLEGE_GWA,           
				JH.COLLEGE_GWANAME,       
				JH.COLLEGE_JOL_DATE,      
				JH.COLLEGE_JOL_HAKYUN,    
				JH.COLLEGE_GUBUN,        
				JH.INJUNG_HAKJUM,         
				DECODE(JS.HAPGYUK_GUBUN,	'1',	'04',	'05')	,
				'G',							
				DECODE(JS.HAPGYUK_GUBUN,	'1',	DECODE(:as_junhugi,	'1',	'G11',	'G12'), 'G13')			,       
				JH.JOLUP_DATE,            
				JH.HUHAK_DATE,            
				JH.JAEIPHAK_DATE,         
				JH.IPHAK_DATE,           
				JH.IPHAK_GUBUN,           
				JH.IPHAK_JUNHYUNG,        
				JH.IPHAK_GWA,             
				JH.IPHAK_JUNGONG,
				JH.IPHAK_HAKYUN,
				JH.SU_JUMSU,              
				JH.JOLUP_DATE,           
				JH.JOLUP_COUNT,           
				JH.HAKWI_NO,              
				JH.HAKWI_NAME,            
				JH.HAKWI_ENAME,           
				JH.JUNG_NO,               
				JH.SURYO_NO,              
				JH.JOLUP_SUKCHA,          
				JH.BOHUN_ID,              
				JH.BOHUN_HAKGI,           
				JH.BOHUN_GUBUN,           
				JH.BOHUN_SAYU,            
				JH.GYOJIK_YN,             
				JH.GUNBUN,                
				JH.IPDAE_DATE,            
				JH.JUNYUK_DATE,           
				JH.YUKJONG_ID,            
				JH.GUNBYUL_ID,            
				JH.GRADE_ID,              
				JH.JOLUP_YN,              
				JH.PASSWORD,              
				JH.BANK_ID,               
				JH.ACCOUNT_NAME,          
				JH.ACCOUNT_NO,  
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL
//				gstru_uid_uname.uid,              
//				gstru_uid_uname.address,              
//				f_sysdate(),             
//				gstru_uid_uname.uid,              
//				gstru_uid_uname.address,              
//				f_sysdate()                
	FROM		HAKSA.JAEHAK_HAKJUK	JH,
				HAKSA.JOLUP_SAJUNG	JS,
				(	SELECT 	GWA,
								FNAME,
								ENAME,
								GROUP7_CODE
					FROM		CDDB.KCH003M
					WHERE		GWA_GUBUN = '1'
					AND		SUBSTR(GWA, 1, 2) NOT IN  ('AM','AH','TA')
				)	KC
	WHERE		JH.HAKBUN	= JS.HAKBUN
	AND		JH.GWA		= KC.GWA
	AND		JS.YEAR		= :as_year
	AND		JS.JUNHUGI	= :as_junhugi
	AND		JS.HAPGYUK_GUBUN	IN ('1', '2')
//	AND		JS.HAKBUN 	in( '20041703','20066101')
) USING SQLCA ;

if sqlca.sqlcode = 0 then

	DELETE FROM	HAKSA.JAEHAK_HAKJUK JH
	WHERE			JH.HAKBUN	IN	(	SELECT	HAKBUN
											FROM		HAKSA.JOLUP_SAJUNG
											WHERE		YEAR		= :as_year
											AND		JUNHUGI	= :as_junhugi
											AND		HAPGYUK_GUBUN	IN ('1', '2')
//											AND		HAKBUN 	in( '20041703','20066101')
										)	USING SQLCA ;
	
	if sqlca.sqlcode = 0 then
		return 1
		
	elseif sqlca.sqlcode = -1 then
		messagebox("오류", "학적자료 삭제를 실패하였습니다!")
		return 0
	end if
	
elseif sqlca.sqlcode = -1 then

	messagebox("오류", "학적자료 이관을 실패하였습니다!")
	messagebox("에러",sqlca.sqlerrtext)	
	return 0
end if
	
end function

public function integer wf_move_sinsang (string as_year, string as_junhugi);	
INSERT INTO HAKSA.JOLUP_SINSANG
(	SELECT	JH.HAKBUN,
				NULL,
				NULL,				
				NULL,
				NULL,	
				NULL,
				NULL,	
				NULL,
				NULL,	
				NULL,
				NULL,				
				NULL,
				NULL,	
				NULL,
				NULL,	
				NULL,
				NULL,	
				NULL,
				NULL,	
				NULL,
				NULL,				
				NULL,
				NULL,	
				NULL,
				NULL,
				NULL,	
				NULL,
				NULL				
	FROM		HAKSA.JOLUP_HAKJUK	JH,
				HAKSA.JOLUP_SAJUNG	JS
	WHERE		JH.HAKBUN	= JS.HAKBUN
	AND		JS.YEAR		= :as_year
	AND		JS.JUNHUGI	= :as_junhugi
	AND		JS.HAPGYUK_GUBUN	IN ('1', '2')
//	AND		JS.HAKBUN 		in( '20041703','20066101')	
	) USING SQLCA ;	

if sqlca.sqlcode = 0 then
	DELETE FROM	HAKSA.JAEHAK_SINSANG	HB
	WHERE			HB.HAKBUN	IN	(	SELECT	HAKBUN
											FROM		HAKSA.JOLUP_SAJUNG
											WHERE		YEAR		= :as_year
											AND		JUNHUGI	= :as_junhugi
											AND		HAPGYUK_GUBUN	IN ('1', '2')
//											AND		HAKBUN 	in( '20041703','20066101')
										) USING SQLCA ;
	
	if sqlca.sqlcode = 0 then
		return 1
		
	elseif sqlca.sqlcode = -1 then
		messagebox("오류", "신상자료 삭제를 실패하였습니다!")
		return 0
	end if
	
elseif sqlca.sqlcode = -1 then
	messagebox("오류", "신상자료 이관을 실패하였습니다!")
	return 0
end if

end function

on w_hjj103a.create
int iCurrent
call super::create
this.st_6=create st_6
this.st_4=create st_4
this.st_5=create st_5
this.dw_con=create dw_con
this.dw_main=create dw_main
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
this.uo_4=create uo_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_6
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.dw_con
this.Control[iCurrent+5]=this.dw_main
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.uo_3
this.Control[iCurrent+9]=this.uo_4
end on

on w_hjj103a.destroy
call super::destroy
destroy(this.st_6)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.uo_4)
end on

event ue_retrieve;string	ls_year		,&
			ls_junhugi	,&
			ls_hakgwa
long		ll_row

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_junhugi   = dw_con.Object.junhugi[1]

ll_row = dw_main.retrieve( ls_year, ls_junhugi, ls_hakgwa )

if ll_row = 0 then
	uf_messagebox(7)
	
elseif ll_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1
end event

event open;call super::open;String ls_year

idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

ls_year	= f_haksa_iljung_year()

dw_con.Object.year[1]  = ls_year

end event

event ue_save;int		li_ans

dw_main.AcceptText()

li_ans = dw_main.update()				/*	자료의 저장				*/

IF li_ans = -1  THEN
	ROLLBACK USING SQLCA;
	uf_messagebox(3)            		/*	저장오류 메세지 출력	*/

ELSE
	
	COMMIT USING SQLCA;
	uf_messagebox(2)            		/*	저장확인 메세지 출력	*/
END IF
Return 1

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjj103a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjj103a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjj103a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjj103a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjj103a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjj103a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjj103a
end type

type uc_insert from w_condition_window`uc_insert within w_hjj103a
end type

type uc_delete from w_condition_window`uc_delete within w_hjj103a
end type

type uc_save from w_condition_window`uc_save within w_hjj103a
end type

type uc_excel from w_condition_window`uc_excel within w_hjj103a
end type

type uc_print from w_condition_window`uc_print within w_hjj103a
end type

type st_line1 from w_condition_window`st_line1 within w_hjj103a
end type

type st_line2 from w_condition_window`st_line2 within w_hjj103a
end type

type st_line3 from w_condition_window`st_line3 within w_hjj103a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjj103a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjj103a
end type

type gb_1 from w_condition_window`gb_1 within w_hjj103a
end type

type gb_2 from w_condition_window`gb_2 within w_hjj103a
end type

type st_6 from statictext within w_hjj103a
integer x = 50
integer y = 296
integer width = 4384
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 15793151
long backcolor = 8388736
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_hjj103a
integer x = 1778
integer y = 336
integer width = 279
integer height = 48
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 15793151
long backcolor = 8388736
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_hjj103a
integer x = 1993
integer y = 324
integer width = 242
integer height = 48
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 15793151
long backcolor = 8388736
string text = "진행율 :"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hjj103a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hjj102a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hjj103a
integer x = 50
integer y = 396
integer width = 4384
integer height = 1868
integer taborder = 190
boolean bringtotop = true
string dataobject = "d_hjj103a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjj103a
integer x = 155
integer y = 40
integer width = 352
integer taborder = 20
boolean bringtotop = true
string btnname = "졸업사정"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgwa, ls_junhugi, ls_iphak_year, ls_sunisu_yn, ls_bj_gubun, ls_pi_gubun, ls_junhugi_nm
long		ll_count, ll_row, ll_ans, ll_rtn
double 	ld_pyungjum_avg
int		li_chidk, li_jungong, li_gyoyang, li_jungwa_count, li_f_jungong, li_f_gyoyang, li_f_sunisu, li_bujun, li_boksu		
string	ls_iphak_gubun, ls_gyohwan_hakyun, ls_pyunip_yn, ls_jungwa_yn, ls_gyohwan_yn, ls_pilsu_yn, ls_gyopil_yn,&
			ls_junpil_yn, ls_hakbun, ls_gyopil_yabu, ls_junpil_yabu, ls_exam_yn, ls_hapgyuk_yn

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_junhugi   = dw_con.Object.junhugi[1]
If ls_junhugi = '1' Then
	ls_junhugi_nm = '전기졸업'
Else
	ls_junhugi_nm = '후기졸업'
End If

ll_count = dw_main.rowcount()

if ll_count = 0 then
	messagebox("확인", "조회된 자료가 없습니다. " &
				+ "~r~n 성적이 계산 될 졸업예정자를 조회하세요!")
	return
end if

ll_ans	= messagebox("확인", ls_year + " 학년도 " + ls_junhugi_nm + " 예정자들의 졸업사정을 하시겠습니까?",&
								question!, yesno!, 2)

if ll_ans = 1 then
	
	setpointer(hourglass!)
	
	for ll_row = 1 to ll_count
		
		st_4.text = string(ll_row) + "/" + string(ll_count)
				
		ls_hakbun			= dw_main.object.jolup_sajung_hakbun[ll_row]
		ls_hakgwa			= dw_main.object.jolup_sajung_gwa[ll_row]
		
		ld_pyungjum_avg	= dw_main.object.jolup_sajung_pyengjum_avg[ll_row]
		li_chidk				= dw_main.object.jolup_sajung_chidk_total[ll_row]
		li_jungong			= dw_main.object.jolup_sajung_jungong[ll_row]
		li_gyoyang			= dw_main.object.jolup_sajung_gyoyang[ll_row]
		li_bujun				= dw_main.object.jolup_sajung_bu_jungong[ll_row]
		li_boksu				= dw_main.object.jolup_sajung_boksu_jungong[ll_row]
		//ls_exam_yn			= dw_main.object.jolup_sajung_exam_yn[ll_row]
		
		/*	종합시험 체크	*/
		SELECT	HAPGYUK_YN
		INTO		:ls_exam_yn
		FROM		HAKSA.JOLUP_SIHUM
		WHERE	HAKBUN	= :ls_hakbun
		AND		JOLUP_YEAR	= (	SELECT	MAX(JOLUP_YEAR)
											FROM		HAKSA.JOLUP_SIHUM
											WHERE		HAKBUN	= :ls_hakbun	
											GROUP BY HAKBUN	)
		USING SQLCA ;
		
		dw_main.object.jolup_sajung_exam_yn[ll_row] = ls_exam_yn
				
		/*	교양필수과목이수 체크	*/
		SELECT	COUNT(*)
		INTO		:li_f_gyoyang
		FROM		HAKSA.MIISU_GWAMOK
		WHERE	ISU_ID = '11'
		AND		HAKBUN = :ls_hakbun
		USING SQLCA ;
		
		if li_f_gyoyang > 0 then
			ls_gyopil_yn = 'N'
			dw_main.object.jolup_sajung_gyopil_yn[ll_row] = 'N'
			ls_gyopil_yabu = 'N'
		else
			ls_gyopil_yn = 'Y'
			dw_main.object.jolup_sajung_gyopil_yn[ll_row] = 'Y'
			ls_gyopil_yabu = 'Y'
		end if
		
		/*	전공필수과목이수 체크	*/
		SELECT	COUNT(*)
		INTO		:li_f_jungong
		FROM		HAKSA.MIISU_GWAMOK
		WHERE	ISU_ID in ('21')
		AND		HAKBUN = :ls_hakbun
		USING SQLCA ;
		
		if li_f_jungong > 0 then
			ls_junpil_yn = 'N'
			dw_main.object.jolup_sajung_junpil_yn[ll_row] = 'N'
			ls_junpil_yabu = 'N'
		else
			ls_junpil_yn = 'Y'
			dw_main.object.jolup_sajung_junpil_yn[ll_row] = 'Y'
			ls_junpil_yabu = 'Y'
		end if

		/*	선이수과목이수 체크	*/
		SELECT	COUNT(*)
		INTO		:li_f_sunisu
		FROM		HAKSA.MIISU_GWAMOK
		WHERE	ISU_ID in ('30')
		AND		HAKBUN = :ls_hakbun
		USING SQLCA ;
		
		if li_f_sunisu > 0 then
			ls_sunisu_yn = 'N'
		else
			ls_sunisu_yn = 'Y'
		end if		
		
		/*	편입생 여부	*/
		SELECT	SUBSTR(JAEHAK_HAKJUK.IPHAK_DATE,1,4),
					NVL(JAEHAK_HAKJUK.IPHAK_GUBUN, ''),
					NVL(DECODE(JAEHAK_HAKJUK.JUNGONG_GUBUN, '0', ''),''),   //1복수전공 2부전공 0취소 나머진 ''
					NVL(JAEHAK_HAKJUK.COLLEGE_GUBUN, '')
		INTO		:ls_iphak_year,
					:ls_iphak_gubun,
					:ls_bj_gubun,
					:ls_pi_gubun
		FROM		HAKSA.JAEHAK_HAKJUK
		WHERE	JAEHAK_HAKJUK.HAKBUN = :ls_hakbun
		USING SQLCA ;

		/*	졸업사정	*/	
		
		/*	편입생의 경우*/	
		if ls_iphak_gubun = '04' then	
			
			/*	동일계인 경우 
				(교필/전필/선이수 모두 이수하고 전공학점이 35이상 취득학점이 140이상) */
			if ls_pi_gubun = '1' then 
				/*	졸업	*/			
				if (	ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and ls_exam_yn = 'Y' and  &	
						li_jungong >= 35 and li_chidk >= 140)  then
					ls_hapgyuk_yn	= '1'		
					dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
				/*	수료	*/	
//				elseif ls_pilsu_yabu = '1' and ld_pyungjum_avg < 2.0 and li_chidk >= 140 and	ls_exam_yn = '1' then
//					ls_hapgyuk_yn	= '2'		
//					dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '2'
//				/*	미졸업	*/
				else
					ls_hapgyuk_yn	= '0'		
					dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
				end if
				
			/*	비동일계인 경우 
				(교필/전필/선이수 모두 이수하고 전공학점이 50이상 취득학점이 140이상) */
			else
				
				/*	졸업	*/
				if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and ls_exam_yn = 'Y' and &	
					li_jungong >= 50 and li_chidk >= 140  then
					ls_hapgyuk_yn	= '1'		
					dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
				/*	수료	*/	
				/*	미졸업	*/
				else
					ls_hapgyuk_yn	= '0'		
					dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
				end if
			end if
			
			
		/*	일반학생의 경우*/	
		else
			
			/*	입학년가 2000년 이전인자 
				(교필/전필/선이수 모두 이수하고  취득학점이 140이상) */
			if long(ls_iphak_year) < 2000 then
				/*	부전공/복수전공없는 학생	*/
				if ls_bj_gubun = '' or isnull(ls_bj_gubun) then
					/*	졸업	*/
//					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and & 
					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_exam_yn = 'Y' and & 					
						li_chidk >= 140 then
						ls_hapgyuk_yn	= '1'						
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
					/*	수료	*/	
	//				elseif ls_pilsu_yabu = '1' and ld_pyungjum_avg < 2.0 and li_chidk >= 140 and &
	//				li_jungong >= 65 and li_gyoyang >= 36 and	ls_exam_yn = '1' then
	//					ls_hapgyuk_yn	= '2'		
	//					dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '2'
					/*	미졸업	*/
					else
						ls_hapgyuk_yn	= '0'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
					end if
				/*	부전공 학생	*/
				elseif ls_bj_gubun = '2' then
					/*	졸업	*/
//					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and & 
					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_exam_yn = 'Y' and  & 					
						li_bujun >= 21 and li_chidk >= 140 then
						ls_hapgyuk_yn	= '1'						
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
					/*	수료	*/	
					/*	미졸업	*/
					else
						ls_hapgyuk_yn	= '0'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
					end if
				/*	복수전공 학생	*/
				elseif ls_bj_gubun = '1' then
					/*	졸업	*/
//					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and & 
					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_exam_yn = 'Y' and & 
						li_boksu >= 35 and li_chidk >= 140 then
						ls_hapgyuk_yn	= '1'						
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
					/*	수료	*/	
					/*	미졸업	*/
					else
						ls_hapgyuk_yn	= '0'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
					end if
				end if
				
				
			/*	입학년가 2000년 2001년입학생  
				(교필/전필/선이수 모두 이수하고 전공학점 70이상, 교양학점 30이상, 취득학점이 140이상) */
			elseif long(ls_iphak_year) = 2000 or long(ls_iphak_year) = 2001 then
				/*	부전공/복수전공없는 학생	*/

				if ls_bj_gubun = '' or isnull(ls_bj_gubun) then
					/*	졸업	*/
//					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and & 
					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_exam_yn = 'Y' and  & 
						li_jungong >= 70 and li_gyoyang >= 30  and li_chidk >= 140 then
						ls_hapgyuk_yn	= '1'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
					/*	수료	*/	
					/*	미졸업	*/
					else
						ls_hapgyuk_yn	= '0'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
					end if
					
				/*	부전공 학생	*/
				elseif ls_bj_gubun = '2' then
					/*	졸업	*/
//					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and & 
					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_exam_yn = 'Y' and   & 
						li_jungong >= 70 and li_gyoyang >= 30 and li_bujun >=21  and li_chidk >= 140 then
						ls_hapgyuk_yn	= '1'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
					/*	수료	*/	
					/*	미졸업	*/
					else
						ls_hapgyuk_yn	= '0'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
					end if
				/*	복수전공 학생	*/
				elseif ls_bj_gubun = '1' then	
					/*	졸업	*/
//					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and & 
					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_exam_yn = 'Y' and  & 
						li_jungong >= 70 and li_gyoyang >= 30 and li_boksu >= 35  and li_chidk >= 140 then
						ls_hapgyuk_yn	= '1'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
					/*	수료	*/	
					/*	미졸업	*/
					else
						ls_hapgyuk_yn	= '0'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
					end if
				end if
					
					
			/*	입학년가 2002년이후  
				(교필/전필/선이수 모두 이수하고 전공학점 70이상, 교양학점 24이상, 취득학점이 140이상) */				
			else
				/*	부전공/복수전공없는 학생	*/
				if ls_bj_gubun = '' or isnull(ls_bj_gubun) then				
					/*	졸업	*/
//					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and & 
					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_exam_yn = 'Y' and  & 
						li_jungong >= 70 and li_gyoyang >= 24  and li_chidk >= 140 then
						ls_hapgyuk_yn	= '1'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
					/*	수료	*/	
					/*	미졸업	*/
					else
						ls_hapgyuk_yn	= '0'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
					end if
				/*	부전공 학생	*/
				elseif ls_bj_gubun = '2' then
					/*	졸업	*/
//					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and & 
					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_exam_yn = 'Y' and  & 
						li_jungong >= 70 and li_gyoyang >= 24  and li_bujun >= 21 and li_chidk >= 140 then
						ls_hapgyuk_yn	= '1'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
					/*	수료	*/	
					/*	미졸업	*/
					else
						ls_hapgyuk_yn	= '0'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
					end if	
				/*	복수전공 학생	*/
				elseif ls_bj_gubun = '1' then	
					/*	졸업	*/
//					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_sunisu_yn = 'Y' and & 
					if ls_gyopil_yabu = 'Y' and ls_junpil_yabu = 'Y'and ls_exam_yn = 'Y' and  & 
						li_jungong >= 70 and li_gyoyang >= 24  and li_boksu >= 35 and li_chidk >= 140 then
						ls_hapgyuk_yn	= '1'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '1'
					/*	수료	*/	
					/*	미졸업	*/
					else
						ls_hapgyuk_yn	= '0'		
						dw_main.object.jolup_sajung_hapgyuk_gubun[ll_row] = '0'
					end if
				end if
				
			end if
			
		end if
		
	next

	ll_rtn	= messagebox("완료", "졸업사정을 완료하였습니다" &
								+ "~r~n자료를 저장하시겠습니까?", question!, yesno!, 2)
	
	if ll_rtn	= 1 then
		
		ll_ans = dw_main.update()
			
		if ll_ans = -1 then
			rollback USING SQLCA ;
			MessageBox("저장실패","저장을 실패하였습니다.")
			return;
		else
			commit USING SQLCA ;
			MessageBox("저장성공","저장을 완료하였습니다.")
		end if
	end if

end if





end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hjj103a
integer x = 562
integer y = 40
integer width = 558
integer taborder = 30
boolean bringtotop = true
string btnname = "졸업사항부여..."
end type

event clicked;call super::clicked;string	ls_year		,&
			ls_junhugi

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_junhugi   = dw_con.Object.junhugi[1]

if isnull(ls_year) or	len(ls_year) < 4 then
	messagebox("확인", "학년도를 똑바로 입력하세요!")
	dw_con.Setfocus()
	dw_con.SetColumn("year")
	return
end if

openwithparm(w_hjj104pp, ls_year + ls_junhugi)
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type uo_3 from uo_imgbtn within w_hjj103a
integer x = 1175
integer y = 40
integer width = 357
integer taborder = 30
boolean bringtotop = true
string btnname = "자료이관"
end type

event clicked;call super::clicked;long		ll_count, ll_ans
string	ls_year, ls_junhugi, ls_jolupyn
int		li_hakjuk, li_hjmod, li_sugang, li_sungjukgye, li_sungjukgye_all, li_gajok, li_sinsang

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_junhugi   = dw_con.Object.junhugi[1]

if isnull(ls_year) or	len(ls_year) < 4 then
	messagebox("확인", "학년도를 똑바로 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
end if

ll_ans	= messagebox("확인", "졸업생 자료를 이관하시겠습니까?", &
							question!, yesno!, 2)

if ll_ans = 1 then
	/*	학적 자료이관	*/

	li_hakjuk	= wf_yebimove_hakjuk(ls_year, ls_junhugi)
//	messagebox("에러",sqlca.sqlerrtext)
	
	if li_hakjuk = 1 then
		UPDATE	HAKSA.JAEHAK_HAKJUK	JH
		SET		JH.JOLUP_YN	= 'N'
		WHERE		JH.HAKBUN	IN	(	SELECT	HAKBUN
											FROM		HAKSA.JOLUP_SAJUNG
											WHERE		HAPGYUK_GUBUN	= '0'	
										)
		USING SQLCA ;
		
		if sqlca.sqlcode = -1 then
			messagebox("실패", "미졸업자들의 학적 자료 변경을 실패하였습니다!")
		end if
	
	elseif li_hakjuk	= 0 then
		rollback USING SQLCA ;
		return
	end if
	
	/*	학적변동 자료이관		*/
	li_hjmod	= wf_yebimove_hjmod(ls_year, ls_junhugi)
	
	if li_hjmod	= 0 then
		rollback USING SQLCA ;
		return
	end if
	
	/*	수강 자료이관			*/
	li_sugang	= wf_yebimove_sugang(ls_year, ls_junhugi)
	
	if li_sugang	= 0 then
		rollback USING SQLCA ;
		return
	end if
	
	/*	성적계 자료이관		*/
	li_sungjukgye	= wf_yebimove_sungjukgye(ls_year, ls_junhugi)
	
	if li_sungjukgye	= 0 then
		rollback USING SQLCA ;
		return
	end if
	
	/*	가족 자료이관			*/
	
	/*	신상 자료이관			*/
	li_sinsang	= wf_yebimove_sinsang(ls_year, ls_junhugi)
	
	if li_sinsang	= 0 then
		rollback USING SQLCA ;
		return
	end if

//	if li_hakjuk = 1 and	li_hjmod	= 1 and li_sugang = 1 &
//	and li_sungjukgye = 1 and li_sungjukgye_all = 1 then
	if li_hakjuk = 1 and	li_hjmod	= 1 and li_sugang = 1 &
	and li_sungjukgye = 1 and li_sinsang = 1 then
	
		commit USING SQLCA ;
		messagebox("성공", "자료이관을 성공하였습니다!")
	else
		rollback USING SQLCA ;
		messagebox("실패", "자료이관을 실패하였습니다!")
	end if	
	
end if
end event

on uo_3.destroy
call uo_imgbtn::destroy
end on

type uo_4 from uo_imgbtn within w_hjj103a
integer x = 1605
integer y = 40
integer width = 539
integer taborder = 40
boolean bringtotop = true
string btnname = "최종자료이관"
end type

event clicked;call super::clicked;long		ll_count, ll_ans, ll_rtn
string	ls_year, ls_junhugi, ls_jolupyn, ls_jolup, ls_hakbun
int		li_hakjuk, li_hjmod, li_sugang, li_sungjukgye, li_sungjukgye_all, li_gajok, li_sinsang

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_junhugi   = dw_con.Object.junhugi[1]

SELECT 	JOLUP
INTO		:ls_jolup
FROM		HAKSA.HAKSA_ILJUNG
WHERE  	SIJUM_FLAG = 'Y'
USING SQLCA ;

if isnull(ls_year) or	len(ls_year) < 4 then
	messagebox("확인", "학년도를 똑바로 입력하세요!")
	dw_con.setfocus()
	dw_con.SetColumn("year")
	return
end if

ll_ans	= messagebox("확인", "졸업생 자료를 이관하시겠습니까?", &
							question!, yesno!, 2)

if ll_ans = 1 then
	
	DECLARE LC_DELETE CURSOR FOR
		SELECT 	HAKBUN
		FROM		HAKSA.JOLUP_HAKJUK
		WHERE	JOLUP_DATE = :ls_jolup
		USING SQLCA ;
	
	OPEN LC_DELETE ;	
			
	DO 
	FETCH LC_DELETE INTO	:ls_hakbun ;
	
		IF SQLCA.SQLCODE <> 0 THEN EXIT

//		DELETE 	HAKSA.JOLUP_HAKJUK
//		WHERE		HAKBUN = :ls_hakbun;
//		
//		DELETE 	HAKSA.JOLUP_HAKBYEN
//		WHERE		HAKBUN = :ls_hakbun;
//		
//		DELETE 	HAKSA.JOLUP_SUGANG
//		WHERE		HAKBUN = :ls_hakbun;
//		
//		DELETE 	HAKSA.JOLUP_SUNGJUKGYE
//		WHERE		HAKBUN = :ls_hakbun;
//		
//		DELETE 	HAKSA.JOLUP_SINSANG
//		WHERE		HAKBUN = :ls_hakbun;	
//					
	LOOP WHILE TRUE
	
	CLOSE LC_DELETE;
	
//	ll_rtn	= messagebox("완료", "기존자료를 삭제 하였습니다" &
//								+ "~r~n저장하시겠습니까?", question!, yesno!, 2)
	
	if ll_rtn = 1 then
		commit USING SQLCA ;
		messagebox("성공", "자료를 저장하였습니다")
	else
		rollback USING SQLCA ;
	end if

	/*	학적 자료이관			*/
	li_hakjuk	= wf_move_hakjuk(ls_year, ls_junhugi)
	
	if li_hakjuk = 1 then
		UPDATE	HAKSA.JAEHAK_HAKJUK	JH
		SET		JH.JOLUP_YN	= 'N'
		WHERE		JH.HAKBUN	IN	(	SELECT	HAKBUN
											FROM		HAKSA.JOLUP_SAJUNG
											WHERE		HAPGYUK_GUBUN	= '0')
		USING SQLCA ;
		
		if sqlca.sqlcode = -1 then
			messagebox("실패", "미졸업자들의 학적 자료 변경을 실패하였습니다!")
		end if
	
	elseif li_hakjuk	= 0 then
		rollback USING SQLCA ;
		return
	end if
	
	/*	학적변동 자료이관		*/
	li_hjmod	= wf_move_hjmod(ls_year, ls_junhugi)
	
	if li_hjmod	= 0 then
		rollback USING SQLCA ;
		return
	end if
	
	/*	수강 자료이관			*/
	li_sugang	= wf_move_sugang(ls_year, ls_junhugi)
	
	if li_sugang	= 0 then
		rollback USING SQLCA ;
		return
	end if
	
	/*	성적계 자료이관		*/
	li_sungjukgye	= wf_move_sungjukgye(ls_year, ls_junhugi)
	
	if li_sungjukgye	= 0 then
		rollback USING SQLCA ;
		return
	end if
	
	/*	가족 자료이관			*/
	
	/*	신상 자료이관			*/
	li_sinsang	= wf_move_sinsang(ls_year, ls_junhugi)

	if li_sinsang	= 0 then
		rollback USING SQLCA ;
		return
	end if	
	
	if li_hakjuk = 1 and	li_hjmod	= 1 and li_sugang = 1 &
	and li_sungjukgye = 1 and li_sinsang = 1 then
		commit USING SQLCA ;
		messagebox("성공", "자료이관을 성공하였습니다!")
	else
		rollback USING SQLCA ;
		messagebox("실패", "자료이관을 실패하였습니다!")
	end if	
	
end if
end event

on uo_4.destroy
call uo_imgbtn::destroy
end on

