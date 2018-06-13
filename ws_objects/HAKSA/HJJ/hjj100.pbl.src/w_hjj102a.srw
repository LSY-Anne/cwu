$PBExportHeader$w_hjj102a.srw
$PBExportComments$[청운대]졸업성적계산
forward
global type w_hjj102a from w_condition_window
end type
type dw_main_1 from uo_input_dwc within w_hjj102a
end type
type st_4 from statictext within w_hjj102a
end type
type st_5 from statictext within w_hjj102a
end type
type dw_con from uo_dwfree within w_hjj102a
end type
type dw_main from uo_dwfree within w_hjj102a
end type
type uo_1 from uo_imgbtn within w_hjj102a
end type
type uo_2 from uo_imgbtn within w_hjj102a
end type
type uo_3 from uo_imgbtn within w_hjj102a
end type
end forward

global type w_hjj102a from w_condition_window
dw_main_1 dw_main_1
st_4 st_4
st_5 st_5
dw_con dw_con
dw_main dw_main
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
end type
global w_hjj102a w_hjj102a

forward prototypes
public function integer wf_check_pyunip (string as_hakbun, string as_gwa)
public function integer wf_check_gyohwan (string as_hakbun, string as_hakgwa, string as_hakyun)
public function integer wf_check_jungwa (string as_hakbun, string as_gwa)
public function integer wf_check (string as_hakbun, string as_gwa)
end prototypes

public function integer wf_check_pyunip (string as_hakbun, string as_gwa);string	ls_year, ls_gwa, ls_hakyun, ls_hakgi, ls_gwamok, ls_isu_id, ls_daeche, ls_flag,&
			ls_gwamok_seq, ls_daeche_seq, ls_iphak
string	ls_b_hakyun, ls_b_hakgi, ls_b_year
double	ld_jumsu
int		li_hakjum
			
ls_flag	= '0'

/*	필수체크 연도, 학년, 학기	*/
DECLARE CUR_HAKGI CURSOR FOR
	SELECT	SUNGJUKGYE.YEAR	,
				SUNGJUKGYE.HAKGI	,
				SUNGJUKGYE.HAKYUN	,
				SUBSTR(JAEHAK_HAKJUK.IPHAK_DATE, 1, 4)
	FROM		HAKSA.SUNGJUKGYE ,
				HAKSA.JAEHAK_HAKJUK
	WHERE		SUNGJUKGYE.HAKBUN = JAEHAK_HAKJUK.HAKBUN
	AND		SUNGJUKGYE.HAKBUN		= :as_hakbun
	AND		(	SUNGJUKGYE.INJUNG_YN	= 'Y'
		OR			SUNGJUKGYE.INJUNG_YN IS NULL
				)
   USING SQLCA ;

OPEN CUR_HAKGI;

do
	FETCH CUR_HAKGI	INTO	:ls_year, :ls_hakgi, :ls_hakyun, :ls_iphak;
	
	IF SQLCA.SQLCODE <> 0 THEN
		EXIT
	END IF

	SELECT	BOKHAK_HAKYUN,
				BOKHAK_HAKGI,
				MAX(SUBSTR(HJMOD_SIJUM,1 ,4))
	INTO		:ls_b_hakyun,
				:ls_b_hakgi,
				:ls_b_year				
	FROM		HAKSA.HAKJUKBYENDONG	
	WHERE		HAKBUN 			= :as_hakbun
	AND		HJMOD_ID 		= 'C'
	AND		BOKHAK_HAKYUN	= :ls_hakyun
	AND		BOKHAK_HAKGI	= :ls_hakgi
	GROUP BY BOKHAK_HAKYUN, 
				BOKHAK_HAKGI 
	USING SQLCA ;
		
	if SQLCA.SQLCODE = 0 then
		ls_flag = '1'
	elseif SQLCA.SQLCODE = -1 then
		rollback;
		return 1
	end if
	
	
	/*	필수과목	*/
	DECLARE CUR_GWAMOK CURSOR FOR
		SELECT DISTINCT	GAESUL_GWAMOK.GWAMOK_ID	,
								GAESUL_GWAMOK.GWAMOK_SEQ,
								GAESUL_GWAMOK.ISU_ID		,
								GAESUL_GWAMOK.HAKJUM
		FROM		HAKSA.GAESUL_GWAMOK
		WHERE		GAESUL_GWAMOK.YEAR		= decode(:ls_flag, '1', to_char(to_number(:ls_b_year) - to_number(:ls_hakyun) + 1) , :ls_iphak)
		AND		GAESUL_GWAMOK.HAKGI		= :ls_hakgi
		AND		GAESUL_GWAMOK.HAKYUN 	= :ls_hakyun
		AND		GAESUL_GWAMOK.GWA			= :as_gwa
		AND		GAESUL_GWAMOK.ISU_ID		= '30'
		USING SQLCA ;

	OPEN	CUR_GWAMOK;
	
	do
		FETCH CUR_GWAMOK	INTO	:ls_gwamok, :ls_gwamoK_seq, :ls_isu_id, :li_hakjum;
		
		IF SQLCA.SQLCODE <> 0 THEN
			EXIT
		END IF
		
		/*	수강확인	*/
		SELECT	SUGANG.JUMSU
		INTO		:ld_jumsu
		FROM		HAKSA.SUGANG
		WHERE 	( SUGANG.HAKBUN			= :as_hakbun 		)
		AND		( SUGANG.GWAMOK_ID 		= :ls_gwamok 		)
		AND		( SUGANG.GWAMOK_SEQ 		= :ls_gwamok_seq	) 
		AND		( SUGANG.SUNGJUK_INJUNG = 'Y' 				)
		AND		( SUGANG.HWANSAN_JUMSU <> 'F'			   	)
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			ls_flag = '1'
			
		/*	수강과목이 없을 경우, 대체과목 확인	*/
		elseif sqlca.sqlcode = 100 then
			
			DECLARE CUR_DAECHE_GWAMOK CURSOR FOR
				SELECT 	DAECHE_GWAMOK.GWAMOK_ID_AFTER,
							DAECHE_GWAMOK.GWAMOK_SEQ_AFTER
				FROM 		HAKSA.DAECHE_GWAMOK  
				WHERE 	( DAECHE_GWAMOK.GWAMOK_ID_BEFORE 	= :ls_gwamok 		) 
				AND		( DAECHE_GWAMOK.GWAMOK_SEQ_BEFORE 	= :ls_gwamok_seq	)
				USING SQLCA ;

				
			OPEN	CUR_DAECHE_GWAMOK;
			
			do
				FETCH CUR_DAECHE_GWAMOK	INTO	:ls_daeche, :ls_daeche_seq;
				
				IF SQLCA.SQLCODE <> 0 THEN
					EXIT
				END IF
				
				/*	수강확인	*/
				SELECT	SUGANG.JUMSU
				INTO		:ld_jumsu
				FROM		HAKSA.SUGANG
				WHERE 	( SUGANG.HAKBUN			= :as_hakbun 		)
				AND		( SUGANG.GWAMOK_ID 		= :ls_daeche 		)
				AND		( SUGANG.GWAMOK_SEQ 		= :ls_daeche_seq	)
				AND		( SUGANG.SUNGJUK_INJUNG = 'Y' 				)
       		    AND		( SUGANG.HWANSAN_JUMSU <> 'F'			   	)
				USING SQLCA ;
								
				if sqlca.sqlcode = 0 then
					ls_flag	= '1'
					exit
				
				elseif sqlca.sqlcode = 100 then
					ls_flag = '0'
				
				elseif sqlca.sqlcode = -1 then
					messagebox("확인", AS_HAKBUN + "학생의 대체과목 조회중 오류가 있습니다!")
				end if
				
			loop while true
			
			CLOSE	CUR_DAECHE_GWAMOK;
			
			/*	미이수 필수과목 insert	*/
			if ls_flag = '0' then
				INSERT INTO	HAKSA.MIISU_GWAMOK
				VALUES	(	:as_hakbun	,
								:ls_gwamok	,
								:ls_gwamoK_seq,
								:ls_year		,
								:ls_hakyun	,
								:ls_hakgi	,
								:ls_isu_id	,
								:li_hakjum		)
								USING SQLCA ;
			end if
			
		elseif sqlca.sqlcode = -1 then
			messagebox("확인", AS_HAKBUN + "학생의 미이수과목 입력중 오류가 있습니다!")
		end if
		
	loop while true
	
	CLOSE	CUR_GWAMOK;	
		
loop while true

CLOSE	CUR_HAKGI;

return 1
end function

public function integer wf_check_gyohwan (string as_hakbun, string as_hakgwa, string as_hakyun);string	ls_year		,&
			ls_hakgwa	,&
			ls_hakyun	,&
			ls_hakgi		,&
			ls_gwamok	,&
			ls_gwamok_seq,&
			ls_isu_id	,&
			ls_daeche	,&
			ls_daeche_seq,&
			ls_flag	
double	ld_jumsu
int		li_hakjum
			
ls_flag	= '0'

/*	필수체크 연도, 학년, 학기	*/
DECLARE CUR_HAKGI CURSOR FOR
	SELECT	SUNGJUKGYE.YEAR		,				
				SUNGJUKGYE.HAKGI
	FROM		HAKSA.SUNGJUKGYE
	WHERE		SUNGJUKGYE.HAKBUN		= :as_hakbun
	AND		SUNGJUKGYE.HAKYUN		= :as_hakyun
	AND		(SUNGJUKGYE.INJUNG_YN	= 'Y'
		OR		 SUNGJUKGYE.INJUNG_YN IS NULL
				)
   USING SQLCA ;

OPEN CUR_HAKGI;

do
	FETCH CUR_HAKGI	INTO	:ls_year		,&									
									:ls_hakgi
									;
	
	IF SQLCA.SQLCODE <> 0 THEN
		EXIT
	END IF
	
	/*	필수과목	*/
	DECLARE CUR_GWAMOK CURSOR FOR
		SELECT DISTINCT	GAESUL_GWAMOK.GWAMOK_ID	,
								GAESUL_GWAMOK.GWAMOK_SEQ,
								GAESUL_GWAMOK.ISU_ID		,
								GAESUL_GWAMOK.HAKJUM
		FROM		HAKSA.GAESUL_GWAMOK
		WHERE		GAESUL_GWAMOK.YEAR		= :ls_year
		AND		GAESUL_GWAMOK.HAKYUN		= to_char(to_number(:as_hakyun)-1)
		AND		GAESUL_GWAMOK.HAKGI		= :ls_hakgi
		AND		GAESUL_GWAMOK.GWA			= :as_hakgwa
		AND		GAESUL_GWAMOK.ISU_ID		IN ('10','20','22')
		USING SQLCA ;
		
	OPEN	CUR_GWAMOK;
	
	do
		FETCH CUR_GWAMOK	INTO	:ls_gwamok,:ls_gwamok_seq, :ls_isu_id, :li_hakjum;
		
		IF SQLCA.SQLCODE <> 0 THEN
			EXIT
		END IF
		
		/*	수강확인	*/
		SELECT	SUGANG.JUMSU
		INTO		:ld_jumsu
		FROM		HAKSA.SUGANG
		WHERE 	(	SUGANG.HAKBUN				= :as_hakbun 		)
		AND		(	SUGANG.GWAMOK_ID 			= :ls_gwamok 		)
		AND		(  SUGANG.GWAMOK_SEQ			= :ls_gwamok_seq	)
		AND		(	SUGANG.SUNGJUK_INJUNG 	= 'Y' 				)
		AND		(  SUGANG.HWANSAN_JUMSU   <>  'F'				)
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			ls_flag = '1'
			
		/*	수강과목이 없을 경우, 대체과목 확인	*/
		elseif sqlca.sqlcode = 100 then
			
			DECLARE CUR_DAECHE_GWAMOK CURSOR FOR
				SELECT 	DAECHE_GWAMOK.GWAMOK_ID_AFTER,
							DAECHE_GWAMOK.GWAMOK_SEQ_AFTER
				FROM 	HAKSA.DAECHE_GWAMOK  
				WHERE 	( DAECHE_GWAMOK.GWAMOK_ID_BEFORE = :ls_gwamok 		)
				AND		( DAECHE_GWAMOK.GWAMOK_SEQ_BEFORE = :ls_gwamok_seq	)
				USING SQLCA ;

				
			OPEN	CUR_DAECHE_GWAMOK;
			
			do
				FETCH CUR_DAECHE_GWAMOK	INTO	:ls_daeche, :ls_daeche_seq;
				
				IF SQLCA.SQLCODE <> 0 THEN
					EXIT
				END IF
				
				/*	수강확인	*/
				SELECT	SUGANG.JUMSU
				INTO		:ld_jumsu
				FROM		HAKSA.SUGANG
				WHERE 	(	SUGANG.HAKBUN				= :as_hakbun 		)
				AND		(	SUGANG.GWAMOK_ID 			= :ls_daeche 		)
				AND		( 	SUGANG.GWAMOK_SEQ			= :ls_daeche_seq	)
				AND		(	SUGANG.SUNGJUK_INJUNG 	= 'Y' 				)
		        AND		(  SUGANG.HWANSAN_JUMSU   <>  'F'				)
				USING SQLCA ;
								
				if sqlca.sqlcode = 0 then
					ls_flag	= '1'
					exit
				
				elseif sqlca.sqlcode = 100 then
					ls_flag = '0'
				
				elseif sqlca.sqlcode = -1 then
					messagebox("오류(교환학생)", AS_HAKBUN +  "교육과정 조회중 오류가 있습니다!")
				end if
				
			loop while true
			
			CLOSE	CUR_DAECHE_GWAMOK;
			
			/*	미이수 필수과목 insert	*/
			if ls_flag = '0' then
				INSERT INTO	HAKSA.MIISU_GWAMOK
				VALUES	(	:as_hakbun	,
								:ls_gwamok	,
								:ls_gwamok_seq,
								:ls_year		,
								:ls_hakyun	,
								:ls_hakgi	,
								:ls_isu_id	,
								:li_hakjum		)
								USING SQLCA ;
			end if
			
		elseif sqlca.sqlcode = -1 then
			messagebox("오류", "과목 조회중 오류가 있습니다!")
		end if
		
	loop while true
	
	CLOSE	CUR_GWAMOK;	
		
loop while true

CLOSE	CUR_HAKGI;

return 1

end function

public function integer wf_check_jungwa (string as_hakbun, string as_gwa);string	ls_year, ls_gwa, ls_hakyun, ls_hakgi, ls_gwamok, ls_isu_id, ls_daeche, ls_flag,&
			ls_gwamok_seq, ls_daeche_seq
string	ls_b_hakyun, ls_b_hakgi, ls_b_year
double	ld_jumsu
int		li_hakjum
			
ls_flag	= '0'

/*	필수체크 연도, 학년, 학기	*/
DECLARE CUR_HAKGI CURSOR FOR
	SELECT	SUNGJUKGYE.YEAR		,
				SUNGJUKGYE.HAKGI		,
				SUNGJUKGYE.HAKYUN
	FROM		HAKSA.SUNGJUKGYE
	WHERE		SUNGJUKGYE.HAKBUN		= :as_hakbun
	AND		SUNGJUKGYE.GWA			= :as_gwa
	AND		(SUNGJUKGYE.INJUNG_YN	= 'Y'
		OR		 SUNGJUKGYE.INJUNG_YN IS NULL)
    USING SQLCA ;

OPEN CUR_HAKGI;

do
	FETCH CUR_HAKGI	INTO	:ls_year, :ls_hakgi, :ls_hakyun;
	
	IF SQLCA.SQLCODE <> 0 THEN	EXIT
	
	SELECT	BOKHAK_HAKYUN,
				BOKHAK_HAKGI,
				MAX(SUBSTR(HJMOD_SIJUM,1 ,4))
	INTO		:ls_b_hakyun,
				:ls_b_hakgi,
				:ls_b_year				
	FROM		HAKSA.HAKJUKBYENDONG	
	WHERE		HAKBUN 			= :as_hakbun
	AND		HJMOD_ID 		= 'F'
	AND		BOKHAK_HAKYUN	= :ls_hakyun
	AND		BOKHAK_HAKGI	= :ls_hakgi
	GROUP BY BOKHAK_HAKYUN, 
				BOKHAK_HAKGI 
	USING SQLCA ;
		
	if SQLCA.SQLCODE = 0 then
		ls_flag = '1'
	elseif SQLCA.SQLCODE = -1 then
		rollback USING SQLCA ;
		return 1
	end if	
	
	/*	필수과목	*/
	DECLARE CUR_GWAMOK CURSOR FOR
		SELECT DISTINCT	GAESUL_GWAMOK.GWAMOK_ID	,
								GAESUL_GWAMOK.GWAMOK_SEQ,
								GAESUL_GWAMOK.ISU_ID		,
								GAESUL_GWAMOK.HAKJUM
		FROM		HAKSA.GAESUL_GWAMOK
//		WHERE		GAESUL_GWAMOK.YEAR			= :ls_year
		WHERE		GAESUL_GWAMOK.YEAR			= decode(:ls_flag, '1', to_char(to_number(:ls_b_year) - to_number(:ls_hakyun) + 1) , :ls_year)
		AND		GAESUL_GWAMOK.HAKGI			= :ls_hakgi
		AND		GAESUL_GWAMOK.HAKYUN 		= :ls_hakyun
		AND		GAESUL_GWAMOK.GWA				= :as_gwa
		AND		GAESUL_GWAMOK.ISU_ID			= '30'
		AND		GAESUL_GWAMOK.PYEGANG_YN 	= 'N'
		USING SQLCA ;
		
	OPEN	CUR_GWAMOK;
	
	do
		FETCH CUR_GWAMOK	INTO	:ls_gwamok, :ls_gwamok_seq, :ls_isu_id, :li_hakjum;
		
		IF SQLCA.SQLCODE <> 0 THEN
			EXIT
		END IF
		
		/*	수강확인	*/
		SELECT	SUGANG.JUMSU
		INTO		:ld_jumsu
		FROM		HAKSA.SUGANG
		WHERE 	( SUGANG.HAKBUN			= :as_hakbun 		)
		AND		( SUGANG.GWAMOK_ID 		= :ls_gwamok 		)
		AND		( SUGANG.GWAMOK_SEQ		= :ls_gwamok_seq	)
		AND		( SUGANG.SUNGJUK_INJUNG = 'Y' 				)
		AND		( SUGANG.HWANSAN_JUMSU <> 'F'	    			)
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			ls_flag = '1'
			
		/*	수강과목이 없을 경우, 대체과목 확인	*/
		elseif sqlca.sqlcode = 100 then
			
			DECLARE CUR_DAECHE_GWAMOK CURSOR FOR
				SELECT 	DAECHE_GWAMOK.GWAMOK_ID_AFTER,
							DAECHE_GWAMOK.GWAMOK_SEQ_AFTER
				FROM 		HAKSA.DAECHE_GWAMOK  
				WHERE 	( DAECHE_GWAMOK.GWAMOK_ID_BEFORE = :ls_gwamok )
				AND		( DAECHE_GWAMOK.GWAMOK_SEQ_BEFORE = :ls_gwamok_seq)
				USING SQLCA ;

				
			OPEN	CUR_DAECHE_GWAMOK;
			
			do
				FETCH CUR_DAECHE_GWAMOK	INTO	:ls_daeche, :ls_daeche_seq;
				
				IF SQLCA.SQLCODE <> 0 THEN
					EXIT
				END IF
				
				/*	수강확인	*/
				SELECT	SUGANG.JUMSU
				INTO		:ld_jumsu
				FROM		HAKSA.SUGANG
				WHERE 	( SUGANG.HAKBUN			= :as_hakbun 		)
				AND		( SUGANG.GWAMOK_ID 		= :ls_daeche 		)
				AND		( SUGANG.GWAMOK_SEQ		= :ls_daeche_seq	)
				AND		( SUGANG.SUNGJUK_INJUNG	= 'Y' 				)
      	 	    AND		( SUGANG.HWANSAN_JUMSU <> 'F'				)
				USING SQLCA ;
								
				if sqlca.sqlcode = 0 then
					ls_flag	= '1'
					exit
				
				elseif sqlca.sqlcode = 100 then
					ls_flag = '0'
				
				elseif sqlca.sqlcode = -1 then
					messagebox("오류(전과학생)", AS_HAKBUN + "교육과정 조회중 오류가 있습니다!")
				end if
				
			loop while true
			
			CLOSE	CUR_DAECHE_GWAMOK;
			
			/*	미이수 필수과목 insert	*/
			if ls_flag = '0' then
				INSERT INTO	HAKSA.MIISU_GWAMOK
				VALUES	(	:as_hakbun	,
								:ls_gwamok	,
								:ls_gwamok_seq	,
								:ls_year		,
								:ls_hakyun	,
								:ls_hakgi	,
								:ls_isu_id	,
								:li_hakjum		)
								USING SQLCA ;
			end if
			
		elseif sqlca.sqlcode = -1 then
			messagebox("오류", "과목 조회중 오류가 있습니다!")
		end if
		
	loop while true
	
	CLOSE	CUR_GWAMOK;	
		
loop while true

CLOSE	CUR_HAKGI;

return 1

end function

public function integer wf_check (string as_hakbun, string as_gwa);string	ls_year, ls_gwa, ls_hakyun, ls_hakgi, ls_gwamok, ls_isu_id, ls_daeche, ls_flag,&
			ls_gwamok_seq, ls_daeche_seq, ls_iphak
string	ls_b_hakyun, ls_b_hakgi, ls_b_year
double	ld_jumsu
int		li_hakjum
			
ls_flag	= '0'

/*	필수체크 연도, 학년, 학기	*/
DECLARE CUR_HAKGI CURSOR FOR

	SELECT	SUNGJUKGYE.YEAR	,
				SUNGJUKGYE.HAKGI	,
				SUNGJUKGYE.HAKYUN	,
				SUBSTR(JAEHAK_HAKJUK.IPHAK_DATE, 1, 4)
	FROM		HAKSA.SUNGJUKGYE ,
				HAKSA.JAEHAK_HAKJUK
	WHERE	SUNGJUKGYE.HAKBUN = JAEHAK_HAKJUK.HAKBUN
	AND		SUNGJUKGYE.HAKBUN		= :as_hakbun
	AND		(	SUNGJUKGYE.INJUNG_YN	= 'Y'
		OR			SUNGJUKGYE.INJUNG_YN IS NULL
				)
   USING SQLCA ;

OPEN CUR_HAKGI;

do
	FETCH CUR_HAKGI	INTO	:ls_year, :ls_hakgi, :ls_hakyun, :ls_iphak;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	SELECT	BOKHAK_HAKYUN,
				BOKHAK_HAKGI,
				MAX(SUBSTR(HJMOD_SIJUM,1 ,4))
	INTO		:ls_b_hakyun,
				:ls_b_hakgi,
				:ls_b_year				
	FROM		HAKSA.HAKJUKBYENDONG	
	WHERE	HAKBUN 			= :as_hakbun
	AND		HJMOD_ID 		= 'C'
	AND		BOKHAK_HAKYUN	= :ls_hakyun
	AND		BOKHAK_HAKGI	= :ls_hakgi
	GROUP BY BOKHAK_HAKYUN, 
				BOKHAK_HAKGI 
	USING SQLCA ;
		
	if SQLCA.SQLCODE = 0 then
		ls_flag = '1'
	elseif SQLCA.SQLCODE = -1 then
		rollback;
		return 1
	end if
	
	SELECT	BOKHAK_HAKYUN,
				BOKHAK_HAKGI,
				MAX(SUBSTR(HJMOD_SIJUM,1 ,4))
	INTO		:ls_b_hakyun,
				:ls_b_hakgi,
				:ls_b_year				
	FROM		HAKSA.HAKJUKBYENDONG	
	WHERE	HAKBUN 			= :as_hakbun
	AND		HJMOD_ID 		= 'F'
	GROUP BY BOKHAK_HAKYUN, 
				BOKHAK_HAKGI
	USING SQLCA ;
		
	if SQLCA.SQLCODE = 0 then
		ls_flag = '2'
	elseif SQLCA.SQLCODE = -1 then
		rollback USING SQLCA ;
		return 1
	end if

	/*	필수과목	*/
	DECLARE CUR_GWAMOK CURSOR FOR
		
//		SELECT DISTINCT	GYOGWA_GWAJUNG.GWAMOK_ID,
//								GYOGWA_GWAJUNG.GWAMOK_SEQ,
//								GYOGWA_GWAJUNG.ISU_ID,
//								GYOGWA_GWAJUNG.HAKJUM
//		FROM		HAKSA.GYOGWA_GWAJUNG
//		WHERE		GYOGWA_GWAJUNG.YEAR			= decode(:ls_flag, '1', to_char(to_number(:ls_b_year) - to_number(:ls_hakyun) + 1) , '2', to_char(to_number(:ls_b_year) - to_number(:ls_hakyun)) , :ls_iphak)
//		AND		GYOGWA_GWAJUNG.HAKYUN		= :ls_hakyun
//		AND		GYOGWA_GWAJUNG.HAKGI			= :ls_hakgi
//		AND		GYOGWA_GWAJUNG.GWA			= :as_gwa
//		AND		GYOGWA_GWAJUNG.ISU_ID		IN ('11','21')
//		;		

		SELECT DISTINCT	A.GWAMOK_ID,
								A.GWAMOK_SEQ,
								A.ISU_ID,
								A.HAKJUM,
								B.PYEGANG_YN
		FROM		HAKSA.GYOGWA_GWAJUNG A,
					HAKSA.GAESUL_GWAMOK B
		WHERE		A.YEAR					= B.YEAR
		AND		A.HAKGI					= B.HAKGI
		AND		A.GWAMOK_ID				= B.GWAMOK_ID
		AND		A.GWAMOK_SEQ			= B.GWAMOK_SEQ
		AND		A.YEAR					= decode(:ls_flag, '1', to_char(to_number(:ls_b_year) - to_number(:ls_hakyun) + 1) , '2', to_char(to_number(:ls_b_year) - to_number(:ls_hakyun)) , :ls_iphak)
		AND		A.HAKYUN					= :ls_hakyun
		AND		A.HAKGI					= :ls_hakgi
		AND		A.GWA						= :as_gwa
		AND		A.ISU_ID				IN ('11','21')
		AND		NVL(B.PYEGANG_YN, 'N') 	= 'N'
		USING SQLCA ;
	
	OPEN	CUR_GWAMOK;
	
	do
		FETCH CUR_GWAMOK	INTO	:ls_gwamok, :ls_gwamok_seq, :ls_isu_id, :li_hakjum;

		IF SQLCA.SQLCODE <> 0 THEN
			EXIT
		END IF
		
		/*	수강확인	*/
		SELECT	SUGANG.JUMSU
		INTO		:ld_jumsu
		FROM		HAKSA.SUGANG
		WHERE 	( SUGANG.HAKBUN			= 	:as_hakbun 		)
		AND		( SUGANG.GWAMOK_ID 		= 	:ls_gwamok 		)
		AND		( SUGANG.GWAMOK_SEQ		= 	:ls_gwamok_seq	)
		AND		( SUGANG.SUNGJUK_INJUNG = 	'Y' 				)
		AND		( SUGANG.HWANSAN_JUMSU <>  'F'				)
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			ls_flag = '1'
			
		/*	수강과목이 없을 경우, 대체과목 확인	*/
		elseif sqlca.sqlcode = 100 then
			
			DECLARE CUR_DAECHE_GWAMOK CURSOR FOR
				SELECT 	DAECHE_GWAMOK.GWAMOK_ID_AFTER,
							DAECHE_GWAMOK.GWAMOK_SEQ_AFTER
				FROM 	HAKSA.DAECHE_GWAMOK  
				WHERE 	( DAECHE_GWAMOK.GWAMOK_ID_BEFORE = :ls_gwamok )
				AND		( DAECHE_GWAMOK.GWAMOK_SEQ_BEFORE = :ls_gwamok_seq)
				USING SQLCA ;

				
			OPEN	CUR_DAECHE_GWAMOK;
			
			do
				FETCH CUR_DAECHE_GWAMOK	INTO	:ls_daeche, :ls_daeche_seq;
				
				IF SQLCA.SQLCODE <> 0 THEN
					EXIT
				END IF
				
				/*	수강확인	*/
				SELECT	SUGANG.JUMSU
				INTO		:ld_jumsu
				FROM		HAKSA.SUGANG
				WHERE 	( SUGANG.HAKBUN			= :as_hakbun 		)
				AND		( SUGANG.GWAMOK_ID 		= :ls_daeche 		)
				AND		( SUGANG.GWAMOK_SEQ 		= :ls_daeche_seq	)
				AND		( SUGANG.SUNGJUK_INJUNG = 'Y' 				)
		        AND		( SUGANG.HWANSAN_JUMSU <>  'F'				)
				USING SQLCA ;
								
				if sqlca.sqlcode = 0 then
					ls_flag	= '1'
					exit
				
				elseif sqlca.sqlcode = 100 then
					ls_flag = '0'
					
				elseif sqlca.sqlcode = -1 then
					messagebox("오류", AS_HAKBUN + " 학생의 대체과목 조회중 오류가 있습니다!")
				end if
				
			loop while true
			
			CLOSE	CUR_DAECHE_GWAMOK;
			
			/*	미이수 필수과목 insert	*/
			if ls_flag = '0' then
				INSERT INTO	HAKSA.MIISU_GWAMOK
				VALUES	(	:as_hakbun	,
								:ls_gwamok	,
								:ls_gwamok_seq,
								decode(:ls_flag, '1', to_char(to_number(:ls_b_year) - to_number(:ls_hakyun) + 1) , '2', to_char(to_number(:ls_b_year) - to_number(:ls_hakyun)) , :ls_iphak)	,
								:ls_hakyun	,
								:ls_hakgi	,
								:ls_isu_id	,
								:li_hakjum		)
								USING SQLCA ;
			end if
			
		elseif sqlca.sqlcode = -1 then
			messagebox("오류(일반학생)", AS_HAKBUN + " 교육과정 조회중 오류가 있습니다!")
		end if
		
	loop while true
	
	CLOSE	CUR_GWAMOK;	
		
loop while true

CLOSE	CUR_HAKGI;

return 1
end function

on w_hjj102a.create
int iCurrent
call super::create
this.dw_main_1=create dw_main_1
this.st_4=create st_4
this.st_5=create st_5
this.dw_con=create dw_con
this.dw_main=create dw_main
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main_1
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.dw_con
this.Control[iCurrent+5]=this.dw_main
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.uo_3
end on

on w_hjj102a.destroy
call super::destroy
destroy(this.dw_main_1)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
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

//idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

ls_year	= f_haksa_iljung_year()

dw_con.Object.year[1]  = ls_year

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjj102a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjj102a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjj102a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjj102a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjj102a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjj102a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjj102a
end type

type uc_insert from w_condition_window`uc_insert within w_hjj102a
end type

type uc_delete from w_condition_window`uc_delete within w_hjj102a
end type

type uc_save from w_condition_window`uc_save within w_hjj102a
end type

type uc_excel from w_condition_window`uc_excel within w_hjj102a
end type

type uc_print from w_condition_window`uc_print within w_hjj102a
end type

type st_line1 from w_condition_window`st_line1 within w_hjj102a
end type

type st_line2 from w_condition_window`st_line2 within w_hjj102a
end type

type st_line3 from w_condition_window`st_line3 within w_hjj102a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjj102a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjj102a
end type

type gb_1 from w_condition_window`gb_1 within w_hjj102a
end type

type gb_2 from w_condition_window`gb_2 within w_hjj102a
end type

type dw_main_1 from uo_input_dwc within w_hjj102a
boolean visible = false
integer x = 421
integer y = 1372
integer width = 2967
integer height = 520
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_hjj102a_2"
end type

type st_4 from statictext within w_hjj102a
integer x = 439
integer y = 40
integer width = 293
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
boolean focusrectangle = false
end type

type st_5 from statictext within w_hjj102a
integer x = 187
integer y = 40
integer width = 242
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "진행율 :"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hjj102a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 170
boolean bringtotop = true
string dataobject = "d_hjj102a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hjj102a
integer x = 50
integer y = 308
integer width = 4384
integer height = 1956
integer taborder = 180
string dataobject = "d_hjj102a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjj102a
integer x = 814
integer y = 40
integer width = 370
integer taborder = 80
boolean bringtotop = true
string btnname = "성적계산"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;long		ll_count, ll_row, ll_ans, ll_rtn
string	ls_year, ls_junhugi, ls_jolupyn, ls_hakbun, ls_gyojik_yn
double	ld_pjum_avg, ld_chidk, ld_jungong, ld_gyoyang, ld_gyoyang_sum, ld_gyojik,&
			ld_bujun, ld_boksu, ld_gongtong

ll_count = dw_main.rowcount()

if ll_count = 0 then
	messagebox("확인", "조회된 자료가 없습니다. " &
				+ "~r~n 성적이 계산 될 졸업예정자를 조회하세요!")
	return
end if

ll_ans	= messagebox("성적계산", "졸업예정자의 성적을 계산하시겠습니까?", question!, yesno!, 2)

if ll_ans = 1 then

	/*==========================================================================================
		성적계산 ; VIEW_SUNGJUKGYE_ALL + JAEHAK_HAKJUK.INJUNG_HAKJUM => 졸업사정 테이블에 UPDATE
	===========================================================================================*/
	for ll_row = 1 to ll_count
		
		SETPOINTER(HOURGLASS!)
		
		ls_hakbun 		= dw_main.getitemstring(ll_row, "jolup_sajung_hakbun")
		ls_gyojik_yn 	= dw_main.getitemstring(ll_row, "jolup_sajung_gyojik_yn")
		
		SELECT	A.PYENGJUM_AVG							,
					A.CHIDK + NVL(B.INJUNG_HAKJUM, 0),
					A.GYO_PIL + A.GYO_SUN				,
					A.JUN_PIL + A.JUN_SUN 				,
					A.GONG_PIL + A.GONG_SUN 			,
					A.BU_JUN,
					A.BOKSU_JUN,
					A.GYOJIK
		INTO		:ld_pjum_avg		,
					:ld_chidk			,
					:ld_gyoyang			,
					:ld_jungong			,
					:ld_gongtong		,
					:ld_bujun			,
					:ld_boksu			,
					:ld_gyojik			
		FROM		HAKSA.VIEW_SUNGJUKGYE_ALL	A	,
					(	SELECT 	HAKBUN,
									INJUNG_HAKJUM
						FROM		HAKSA.JAEHAK_HAKJUK
					) B
		WHERE	A.HAKBUN	= B.HAKBUN(+)
		AND		A.HAKBUN	= :ls_hakbun
		USING SQLCA ;

		if sqlca.sqlcode = 0 then
			
			if ls_gyojik_yn = 'Y' and ld_gyojik >= 0 and ld_gyojik <= 8 then
				ld_gyoyang_sum = ld_gyoyang + ld_gyojik
			elseif ls_gyojik_yn = 'Y' and ld_gyojik > 8 then
				ld_gyoyang_sum = ld_gyoyang + 8
			elseif ls_gyojik_yn	= 'N' then
				ld_gyoyang_sum = ld_gyoyang
			end if
						
			dw_main.setitem(ll_row, "jolup_sajung_pyengjum_avg"	, ld_pjum_avg		)
			dw_main.setitem(ll_row, "jolup_sajung_chidk_total"		, ld_chidk			)
			dw_main.setitem(ll_row, "jolup_sajung_jungong"			, ld_jungong		)
			dw_main.setitem(ll_row, "jolup_sajung_gongtong"			, ld_gongtong		)			
			dw_main.setitem(ll_row, "jolup_sajung_gyoyang"			, ld_gyoyang_sum	)
			dw_main.setitem(ll_row, "jolup_sajung_bu_jungong"		, ld_bujun			)
			dw_main.setitem(ll_row, "jolup_sajung_boksu_jungong"	, ld_boksu			)
		else
			messagebox("오류", "성적계산을 실패하였습니다!" + sqlca.sqlerrtext)
			return
		end if
	next
	
	ll_rtn	= messagebox("완료", "성적계산을 완료하였습니다." &
								+ "~r~n자료를 저장하시겠습니까?", question!, yesno!, 2)
	
	if ll_rtn = 1 then
		dw_main.accepttext()
			
		ll_ans = dw_main.update()
		
		IF ll_ans = -1  THEN
			ROLLBACK USING SQLCA;
			messagebox("저장오류", "성적계산 결과를 저장하는데 실패하였습니다!")
		
		ELSE
			COMMIT USING SQLCA;
			messagebox("성공", "저장을 완료하였습니다!")
		END IF
	end if
	
elseif ll_ans = 2 then
	return
end if

	

end event

type uo_2 from uo_imgbtn within w_hjj102a
integer x = 1257
integer y = 40
integer width = 393
integer taborder = 90
boolean bringtotop = true
string btnname = "석차생성"
end type

on uo_2.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string	ls_year, ls_gwa, ls_junhugi, ls_gwa_sql, ls_junhugi_nm
string	ls_birthday
long		ll_ans, ll_rtn
long		ll_sukcha, ll_level, ll_row
double 	ld_pyungjum_avg, ld_pyungjum_tot, ld_siljum_avg, ld_chidk

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_gwa    	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_junhugi   = dw_con.Object.junhugi[1]
If ls_junhugi = '1' Then
	ls_junhugi_nm = '전기졸업'
Else
	ls_junhugi_nm = '후기졸업'
End If

ll_ans	= messagebox("확인", ls_year + " 학년도 " + ls_junhugi_nm + " 예정자들의 석차계산을 하시겠습니까?",&
								question!, yesno!, 2)

if ll_ans = 1 then
	
	setpointer(hourglass!)
	
	/*	전기졸업예정자	*/
	if ls_junhugi = '1' then
		/*==========================================
		               석차계산	
			단, 후기졸업은 석차계산을 하지 않는다.
		============================================*/
		if ls_gwa = '' or isnull(ls_gwa) then
			DECLARE cur_sukcha	 CURSOR FOR
			
				SELECT 	JOLUP_SAJUNG.GWA
				FROM		HAKSA.JOLUP_SAJUNG
				WHERE	JOLUP_SAJUNG.YEAR			= :ls_year
				AND		JOLUP_SAJUNG.JUNHUGI		= :ls_junhugi
				GROUP BY	JOLUP_SAJUNG.GWA
				USING SQLCA ;
			
			OPEN cur_sukcha ;	
			
			do 
				FETCH cur_sukcha 		INTO	:ls_gwa_sql;
				
				IF SQLCA.SQLCODE <> 0 THEN
					EXIT
				END IF
				
				ll_row	= dw_main_1.retrieve(ls_year, ls_junhugi, ls_gwa_sql)
				
				ld_pyungjum_avg	= 0
				ld_pyungjum_tot	= 0
				ld_siljum_avg		= 0
				ld_chidk				= 0
				ls_birthday			= ''
				ll_sukcha			= 1
				
				for ll_level = 1 to ll_row
					
					//동점자 처리
					if not (ld_pyungjum_avg = dw_main_1.object.view_sungjukgye_all_pyengjum_avg[ll_level] &
						and ld_pyungjum_tot 	= dw_main_1.object.view_sungjukgye_all_pyengjum_tot[ll_level] &
						and ld_siljum_avg 	= dw_main_1.object.view_sungjukgye_all_siljum_avg[ll_level] &
						and ld_chidk         = dw_main_1.object.view_sungjukgye_all_chidk[ll_level] &
						and ls_birthday      = left( trim(dw_main_1.object.jaehak_hakjuk_jumin_no[ll_level]) , 6)) then
						
						ll_sukcha = ll_level
						
					end if
			
					//석차를 설정한다.
					dw_main_1.SetItem(ll_level, "jolup_sajung_jolup_sukcha", ll_sukcha)
					
					//동점자 처리를 위한 변수들의 값을 설정한다.
					ld_pyungjum_avg 	= dw_main_1.object.view_sungjukgye_all_pyengjum_avg[ll_level]
					ld_pyungjum_tot 	= dw_main_1.object.view_sungjukgye_all_pyengjum_tot[ll_level]
					ld_siljum_avg 		= dw_main_1.object.view_sungjukgye_all_siljum_avg[ll_level]
					ld_chidk         	= dw_main_1.object.view_sungjukgye_all_chidk[ll_level]
					ls_birthday      	= left( trim(dw_main_1.object.jaehak_hakjuk_jumin_no[ll_level]) , 6)
					
					ll_ans = dw_main_1.update()
			
					if ll_ans = -1 then
						rollback USING SQLCA ;
						MessageBox("에러","석차 생성 하는중 에러가 발생했습니다.")
						return ;				
					end if
			
				next				
				
				loop while true
			
			CLOSE cur_sukcha;
			
			ll_rtn	= messagebox("완료", "석차계산을 완료하였습니다" &
										+ "~r~n저장하시겠습니까?", question!, yesno!, 2)
			
			if ll_rtn = 1 then
				commit USING SQLCA ;
				messagebox("성공", "자료를 저장하였습니다")
			else
				rollback USING SQLCA ;
			end if
				
				
		//학과별
		else
			
			ll_row	= dw_main_1.retrieve(ls_year, ls_junhugi, ls_gwa)
				
			ld_pyungjum_avg	= 0
			ld_pyungjum_tot	= 0
			ld_siljum_avg		= 0
			ld_chidk				= 0
			ls_birthday			= ''
			ll_sukcha			= 1
			
			for ll_level = 1 to ll_row
				
				//동점자 처리
				if not (ld_pyungjum_avg = dw_main_1.object.view_sungjukgye_all_pyengjum_avg[ll_level] &
					and ld_pyungjum_tot 	= dw_main_1.object.view_sungjukgye_all_pyengjum_tot[ll_level] &
					and ld_siljum_avg 	= dw_main_1.object.view_sungjukgye_all_siljum_avg[ll_level] &
					and ld_chidk         = dw_main_1.object.view_sungjukgye_all_chidk[ll_level] &
					and ls_birthday      = left( trim(dw_main_1.object.jaehak_hakjuk_jumin_no[ll_level]) , 6)) then
					
					ll_sukcha = ll_level
					
				end if
		
				//석차를 설정한다.
				dw_main_1.SetItem(ll_level, "jolup_sajung_jolup_sukcha", ll_sukcha)
				
				//동점자 처리를 위한 변수들의 값을 설정한다.
				ld_pyungjum_avg 	= dw_main_1.object.view_sungjukgye_all_pyengjum_avg[ll_level]
				ld_pyungjum_tot 	= dw_main_1.object.view_sungjukgye_all_pyengjum_tot[ll_level]
				ld_siljum_avg 		= dw_main_1.object.view_sungjukgye_all_siljum_avg[ll_level]
				ld_chidk         	= dw_main_1.object.view_sungjukgye_all_chidk[ll_level]
				ls_birthday      	= left( trim(dw_main_1.object.jaehak_hakjuk_jumin_no[ll_level]) , 6)
										
			next	
			
			ll_rtn	= messagebox("완료", "석차계산을 완료하였습니다" &
										+ "~r~n저장하시겠습니까?", question!, yesno!, 2)
			
			if ll_rtn = 1 then
				
				ll_ans = dw_main_1.update()
		
				if ll_ans = -1 then
					rollback USING SQLCA ;
					messagebox("실패", "자료 저장을 실패하였습니다")
				else
					commit USING SQLCA ;
					messagebox("성공", "자료를 저장하였습니다")
				end if				
			end if			
			
		end if		
		
	/*	후기졸업예정자	*/	
	elseif ls_junhugi = '2' then
		/*	사정	*/
		messagebox("확인", "후기졸업자는 석차계산을 하지 않습니다.!")
		return
	end if
	
else
	messagebox("확인", "후기졸업자는 석차계산을 하지 않습니다.!")
	return
end if
end event

type uo_3 from uo_imgbtn within w_hjj102a
integer x = 1728
integer y = 40
integer width = 512
integer taborder = 100
boolean bringtotop = true
string btnname = "필수과목체크"
end type

event clicked;call super::clicked;long		ll_count, ll_ans, ll_row, ll_rtn
string	ls_hakbun, ls_gwa, ls_iphak_gubun, ls_gyohwan_hakyun, ls_jungwa

ll_count = dw_main.rowcount()

if ll_count = 0 then
	messagebox("확인", "조회된 자료가 없습니다. " &
				+ "~r~n 필수과목 체크 할 졸업예정자를 조회하세요!")
	return
end if

ll_ans	= messagebox("필수과목체크", "졸업예정자의 미취득 필수과목 자료를 생성하시겠습니까?", question!, yesno!, 2)

if ll_ans = 1 then
	
	for ll_row = 1 to ll_count
		
		SETPOINTER(HOURGLASS!)
		
		st_4.text = string(ll_row) + "/" + string(ll_count)
		
		
		ls_hakbun = dw_main.getitemstring( ll_row, "jolup_sajung_hakbun" )
		ls_gwa = dw_main.getitemstring( ll_row, "jolup_sajung_gwa" )
		
		/*	미취득 필수과목 내역 삭제	*/
		DELETE FROM HAKSA.MIISU_GWAMOK
		WHERE	HAKBUN	= :ls_hakbun
		USING SQLCA ;
				
		/*	편입생(입학한 년도 이후의 필수과목) 여부	*/
		SELECT	IPHAK_GUBUN
		INTO		:ls_iphak_gubun
		FROM		HAKSA.JAEHAK_HAKJUK
		WHERE		HAKBUN = :ls_hakbun
		USING SQLCA ;
		
		if ls_iphak_gubun = '04' then
			//편입생 선이수 과목 이수여부 체크
			wf_check_pyunip(ls_hakbun, ls_gwa)		
		end if	
		
//		//편입생,전과, 교환학생이 아닌 순수 학생의 이수여부체크
//		SELECT	DISTINCT A.HAKBUN,
//					A.IPHAK_GUBUN
//		FROM		HAKSA.JAEHAK_HAKJUK A,
//					(	SELECT	HAKBUN,
//									BEFORE_GWA
//						FROM		HAKSA.HAKJUKBYENDONG  
//						WHERE		HAKJUKBYENDONG.HJMOD_ID <> 'F'
//					)B
//		
//		WHERE		A.HAKBUN = B.HAKBUN(+)
//		AND		A.IPHAK_GUBUN IN ('01','02','03')
//		AND		A.HAKBUN ='99121036'		
		
		/*	전과(1학년 전공필수 이수) 여부	*/
		SELECT	BEFORE_GWA
		INTO 		:ls_jungwa
		FROM		HAKSA.HAKJUKBYENDONG  
		WHERE 	( HAKJUKBYENDONG.HAKBUN = :ls_hakbun )
		AND		( HAKJUKBYENDONG.HJMOD_ID = 'F' )
		USING SQLCA ;
		
		if SQLCA.SQLCODE = 0 then
			//전과생의 선이수 과목 이수여부 체크
			wf_check_jungwa(ls_hakbun, ls_jungwa)		
		end if
		
		/*	교환학생(필수과목) 여부	*/
		SELECT	SUBSTR(HAKJUKBYENDONG.SAYU_ID, 3, 1)
		INTO 		:ls_gyohwan_hakyun
		FROM		HAKSA.HAKJUKBYENDONG  
		WHERE 	( HAKJUKBYENDONG.HAKBUN = :ls_hakbun )
		AND		( HAKJUKBYENDONG.HJMOD_ID = 'H' )
		AND		( HAKJUKBYENDONG.SAYU_ID IN ('H11', 'H12', 'H13', 'H14'))
		USING SQLCA ;
		
		choose case ls_gyohwan_hakyun
			case '1'
				wf_check_gyohwan(ls_hakbun, ls_gwa, '2')
			case '2'
				wf_check_gyohwan(ls_hakbun, ls_gwa, '3')
			case '3'
				wf_check_gyohwan(ls_hakbun, ls_gwa, '4')			
		end choose
				
		/*	전체 필수과목 이수여부 체크	*/
		wf_check(ls_hakbun, ls_gwa)	
		
	next
	
	ll_rtn	= messagebox("완료", "필수과목 체크를 완료하였습니다." &
								+ "~r~n자료를 저장하시겠습니까?", question!, yesno!, 2)
	
	if ll_rtn = 1 then
		COMMIT USING SQLCA;
		messagebox("성공", "저장을 완료하였습니다!")
		
	else
		ROLLBACK USING SQLCA;		
	end if
	
elseif ll_ans = 2 then
	return
end if

	

end event

on uo_3.destroy
call uo_imgbtn::destroy
end on

