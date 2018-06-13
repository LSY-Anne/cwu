$PBExportHeader$w_hjk201a.srw
$PBExportComments$[청운대]학적변동사항관리
forward
global type w_hjk201a from w_condition_window
end type
type tab_1 from tab within w_hjk201a
end type
type tabpage_2 from userobject within tab_1
end type
type dw_huhak from uo_dwfree within tabpage_2
end type
type dw_2 from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_huhak dw_huhak
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_zip_gain from uo_dwfree within tabpage_3
end type
type dw_bokhak from uo_dwfree within tabpage_3
end type
type dw_3 from uo_dwfree within tabpage_3
end type
type st_7 from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_zip_gain dw_zip_gain
dw_bokhak dw_bokhak
dw_3 dw_3
st_7 st_7
end type
type tabpage_4 from userobject within tab_1
end type
type dw_jaejuk from uo_dwfree within tabpage_4
end type
type dw_4 from uo_dwfree within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_jaejuk dw_jaejuk
dw_4 dw_4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_taehak from uo_dwfree within tabpage_5
end type
type dw_5 from uo_dwfree within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_taehak dw_taehak
dw_5 dw_5
end type
type tabpage_6 from userobject within tab_1
end type
type dw_jungwa from uo_dwfree within tabpage_6
end type
type dw_6 from uo_dwfree within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_jungwa dw_jungwa
dw_6 dw_6
end type
type tabpage_7 from userobject within tab_1
end type
type dw_gyohwan from uo_dwfree within tabpage_7
end type
type dw_7 from uo_dwfree within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_gyohwan dw_gyohwan
dw_7 dw_7
end type
type tabpage_8 from userobject within tab_1
end type
type dw_jaeiphak from uo_dwfree within tabpage_8
end type
type dw_8 from uo_dwfree within tabpage_8
end type
type tabpage_8 from userobject within tab_1
dw_jaeiphak dw_jaeiphak
dw_8 dw_8
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from uo_dwfree within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tab_1 from tab within w_hjk201a
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_1 tabpage_1
end type
type st_1 from statictext within w_hjk201a
end type
type dw_dungrok from uo_input_dwc within w_hjk201a
end type
type dw_sungjuk from uo_input_dwc within w_hjk201a
end type
type st_2 from statictext within w_hjk201a
end type
type dw_iljung from uo_dddw_dwc within w_hjk201a
end type
type dw_con from uo_dwfree within w_hjk201a
end type
type uo_1 from uo_imgbtn within w_hjk201a
end type
type uo_2 from u_tab within w_hjk201a
end type
end forward

global type w_hjk201a from w_condition_window
tab_1 tab_1
st_1 st_1
dw_dungrok dw_dungrok
dw_sungjuk dw_sungjuk
st_2 st_2
dw_iljung dw_iljung
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
end type
global w_hjk201a w_hjk201a

type variables
string	is_hakbun
integer	ii_index, ii_save_flag
DataWindowChild	idwc_hjmodsayu
end variables

forward prototypes
public function integer uf_jungwa (string as_hakbun, string as_gwa)
public subroutine uf_sungjuk_injung (string as_hakbun, string as_injung, string as_jogi)
public function integer uf_jaeiphak (string as_hakbun)
end prototypes

public function integer uf_jungwa (string as_hakbun, string as_gwa);string	ls_year		,&
			ls_hakgwa	,&
			ls_hakgi		,&
			ls_gwamok	,&
			ls_isu_id
int		li_rtn

li_rtn = 1

/*	1학년 이수연도, 학기	*/
DECLARE CUR_HAKGI CURSOR FOR
	SELECT	SUNGJUKGYE.YEAR		,
				SUNGJUKGYE.HAKGI				
	FROM		HAKSA.SUNGJUKGYE
	WHERE		SUNGJUKGYE.HAKBUN		= :as_hakbun
	AND		SUNGJUKGYE.HAKYUN		= '1'
	AND		SUNGJUKGYE.INJUNG_YN	= 'Y'	
   USING SQLCA ;

OPEN CUR_HAKGI;

do
	FETCH CUR_HAKGI	INTO	:ls_year		,&
									:ls_hakgi
									;
	
	IF SQLCA.SQLCODE <> 0 THEN
		EXIT
	END IF
	
	
	DECLARE CUR_GWAMOK CURSOR FOR
		SELECT	GWAMOK_ID
		FROM		HAKSA.SUGANG
		WHERE		HAKBUN	= :as_hakbun
		AND		YEAR		= :ls_year
		AND		HAKGI		= :ls_hakgi
		USING SQLCA ;
		
	OPEN	CUR_GWAMOK;
	
	do
		FETCH CUR_GWAMOK	INTO	:ls_gwamok
										;
		
		IF SQLCA.SQLCODE <> 0 THEN
			EXIT
		END IF
		
		SELECT DISTINCT	GAESUL_GWAMOK.ISU_ID
		INTO		:ls_isu_id
		FROM		HAKSA.GAESUL_GWAMOK
		WHERE		GAESUL_GWAMOK.YEAR	= :ls_year
		AND		GAESUL_GWAMOK.GWA		= :as_gwa
		AND		GAESUL_GWAMOK.GWAMOK_ID	= :ls_gwamok
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			UPDATE	HAKSA.SUGANG
			SET		ISU_ID 		= :ls_isu_id
			WHERE		HAKBUN		= :as_hakbun
			AND		YEAR			= :ls_year
			AND		HAKGI			= :ls_hakgi
			AND		GWAMOK_ID	= :ls_gwamok
			USING SQLCA ;
			
			if sqlca.sqlcode = -1 then
				li_rtn = 0
				exit
			end if
				
			
		/*	개설과목이 없을 경우, 이수구분 = '기타'	*/
		elseif sqlca.sqlcode = 100 then
			UPDATE HAKSA.SUGANG
			SET		ISU_ID 		= '80'
			WHERE		HAKBUN		= :as_hakbun
			AND		YEAR			= :ls_year
			AND		HAKGI			= :ls_hakgi
			AND		GWAMOK_ID	= :ls_gwamok
			USING SQLCA ;
			
			if sqlca.sqlcode = -1 then
				li_rtn = 0
				exit
			end if
			
		end if		
		
	loop while true
	
	
	CLOSE	CUR_GWAMOK;	
	
//	/* 필수체크 = '0' */
//	UPDATE	HAKSA.SUNGJUKGYE
//	SET		SUNGJUKGYE.PILSU_CHECK = '0'
//	WHERE		SUNGJUKGYE.HAKBUN		= :as_hakbun
//	AND		SUNGJUKGYE.YEAR			= :ls_year
//	AND		SUNGJUKGYE.HAKGI			= :ls_hakgi
//	AND		SUNGJUKGYE.HAKYUN		= '1'
//	AND		SUNGJUKGYE.INJUNG_YN	= 'Y'
//   ;
//	
//	if sqlca.sqlcode = -1 then
//		li_rtn = 0
//		exit
//	end if
	
loop while true

CLOSE	CUR_HAKGI;

return li_rtn



end function

public subroutine uf_sungjuk_injung (string as_hakbun, string as_injung, string as_jogi);string	ls_hakgi, ls_year, ls_nyear
int		li_count	,&
			li_ans

/* 학사일정에 의한 학기 RETURN */
ls_year	= f_haksa_iljung_year()
ls_hakgi	= f_haksa_iljung_hakgi()

if as_injung = 'Y' then
	
	/* 다음학기 수강신청 내역 성적인정여부를 'N'으로 변환한다. */
	if ls_hakgi	= '1' then
		
		ls_nyear = ls_year
		
		SELECT	count(SUGANG_TRANS.HAKBUN)
		INTO		:li_count
		FROM		HAKSA.SUGANG_TRANS  
		WHERE		( SUGANG_TRANS.HAKBUN	= :as_hakbun)
		AND  		( SUGANG_TRANS.HAKGI		= '2'			)
		AND		( SUGANG_TRANS.YEAR		= :ls_nyear	)
		USING SQLCA ;
		
		if li_count > 0 then
//			li_ans	= messagebox("확인", as_hakbun + "학생의 다음 학기 수강신청이 되었습니다."  &
//							+ "~r~n성적인정여부를 불인정으로 처리하시겠습니까?", question!, yesno!, 2)
//		
//			if li_ans = 1 then
////		휴학하면 다음학기는 무조건 수강신청한근거 자료 불인정
				UPDATE 	HAKSA.SUGANG_TRANS  
     			SET 		SUNGJUK_INJUNG = 'N'  
				WHERE		( SUGANG_TRANS.HAKBUN	= :as_hakbun)
				AND  		( SUGANG_TRANS.HAKGI		= '2'			)
				AND		( SUGANG_TRANS.YEAR		= :ls_nyear	)
				USING SQLCA ;
				
				if sqlca.sqlcode = 0 then
//					messagebox("처리성공", "성적인정여부 설정을 처리하였습니다.")
				else
					messagebox("처리실패", "성적인정여부 설정에 실패하였습니다.")
					RETURN 
				end if
//			end if
			
			/* 다음학기 수강신청 내역에 포함된 학생의 인원수를 감소해줘야 한다. */
			UPDATE 	HAKSA.GAESUL_GWAMOK	A
			SET		SU_INWON	=	SU_INWON - 1 
			WHERE		( YEAR, HAKGI, GWA, HAKYUN, BAN, GWAMOK_ID, GWAMOK_SEQ, BUNBAN ) IN
						(	SELECT	YEAR, HAKGI, GWA, HAKYUN, BAN, GWAMOK_ID, GWAMOK_SEQ, BUNBAN
							FROM		HAKSA.SUGANG_TRANS	B
							WHERE		A.YEAR			=	B.YEAR
							AND		A.HAKGI			=	B.HAKGI
							AND		A.GWA				=	B.GWA
							AND		A.HAKYUN			=	B.HAKYUN
							AND		A.BAN				=	B.BAN
							AND		A.GWAMOK_ID		=	B.GWAMOK_ID
							AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
							AND		A.BUNBAN			=	B.BUNBAN
							AND		B.YEAR 			=	:ls_nyear	
							AND		B.HAKGI			=	'2'
							AND		B.HAKBUN			=	:as_hakbun	
						)
			USING SQLCA ;
			
			if sqlca.sqlcode = 0 then
//				messagebox("처리성공", "수강신청인원을 감소 처리를 하였습니다.")
			else
				messagebox("처리실패", "수강신청인원을 감소 처리를 실패하였습니다.")
				RETURN 
			end if
			
			
		end if
				
	elseif ls_hakgi = '2' then
		
		ls_nyear = string(long(ls_year) + 1,'0000')
		
		SELECT	count(SUGANG_TRANS.HAKBUN)
		INTO		:li_count
		FROM		HAKSA.SUGANG_TRANS  
		WHERE		( SUGANG_TRANS.HAKBUN	= :as_hakbun)
		AND  		( SUGANG_TRANS.HAKGI		= '1'			)
		AND		( SUGANG_TRANS.YEAR		= :ls_nyear	)
		USING SQLCA ;
		
		if li_count > 0 then
//			li_ans	= messagebox("확인", "다음 학기 수강신청이 되었습니다."  &
//							+ "~r~n성적인정여부를 불인정으로 처리하시겠습니까?", question!, yesno!, 2)
//		
//			if li_ans = 1 then
////		휴학하면 다음학기는 무조건 수강신청한근거 자료 불인정
				UPDATE 	HAKSA.SUGANG_TRANS  
     			SET 		SUNGJUK_INJUNG = 'N'  
				WHERE		( SUGANG_TRANS.HAKBUN	= :as_hakbun)
				AND  		( SUGANG_TRANS.HAKGI		= '1'			)
				AND		( SUGANG_TRANS.YEAR		= :ls_nyear	)
				USING SQLCA ;
				
				if sqlca.sqlcode = 0 then
//					messagebox("처리성공", "성적인정여부 설정을 처리하였습니다.")
				else
					messagebox("처리실패", "성적인정여부 설정을 실패하였습니다.")
					RETURN 
				end if
//			end if
			
			UPDATE 	HAKSA.GAESUL_GWAMOK	A
			SET		SU_INWON	=	SU_INWON - 1 
			WHERE		( YEAR, HAKGI, GWA, HAKYUN, BAN, GWAMOK_ID, GWAMOK_SEQ, BUNBAN ) IN
						(	SELECT	YEAR, HAKGI, GWA, HAKYUN, BAN, GWAMOK_ID, GWAMOK_SEQ, BUNBAN
							FROM		HAKSA.SUGANG_TRANS	B
							WHERE		A.YEAR			=	B.YEAR
							AND		A.HAKGI			=	B.HAKGI
							AND		A.GWA				=	B.GWA
							AND		A.HAKYUN			=	B.HAKYUN
							AND		A.BAN				=	B.BAN
							AND		A.GWAMOK_ID		=	B.GWAMOK_ID
							AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
							AND		A.BUNBAN			=	B.BUNBAN
							AND		B.YEAR 			=	:ls_nyear	
							AND		B.HAKGI			=	'1'
							AND		B.HAKBUN			=	:as_hakbun	
						)
			USING SQLCA ;
			if sqlca.sqlcode = 0 then
//				messagebox("처리성공", "수강신청인원을 감소 처리를 하였습니다.")
			else
				messagebox("처리실패", "수강신청인원을 감소 처리를 실패하였습니다.")
				RETURN 
			end if
			
		end if
		
	end if


elseif as_injung = 'N' then
	
	if as_jogi = 'Y' then

		UPDATE 	HAKSA.SUGANG_TRANS  
		SET 		JOGI_YN = 'Y'
		WHERE		( SUGANG_TRANS.HAKBUN	= :as_hakbun	)
		AND		( SUGANG_TRANS.YEAR		= :ls_year		)
		AND  		( SUGANG_TRANS.HAKGI		= :ls_hakgi		)
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
//			messagebox("처리성공", "조기시험여부 설정을 처리하였습니다.")
		else
			messagebox("처리실패", "조기시험여부 설정을 실패하였습니다.")
		end if
		
	elseif as_jogi = 'N' then
		
		UPDATE 	HAKSA.SUGANG_TRANS  
		SET 		SUNGJUK_INJUNG = 'N'
		WHERE		( SUGANG_TRANS.HAKBUN	= :as_hakbun	)
		AND  		( SUGANG_TRANS.YEAR || (case when SUGANG_TRANS.HAKGI = '3' and sugang_trans.year = :ls_year then '0' else sugang_trans.hakgi end) >= :ls_year || :ls_hakgi )
//		AND		( SUGANG_TRANS.YEAR		= :ls_year		)
		;
		
		if sqlca.sqlcode = 0 then
//			messagebox("처리성공", "성적인정여부 설정을 처리하였습니다.")
		else
			messagebox("처리실패", "성적인정여부 설정에 실패하였습니다.")
		end if
		
	end if
				
end if
end subroutine

public function integer uf_jaeiphak (string as_hakbun);int	li_rtn

li_rtn = 1

// 2004.01.05 성적계의 경고 카운트만 0으로 처리한다
//UPDATE	HAKSA.SUNGJUKGYE
//SET		GYUNGGO_YN = '2',
//			GYUNGGO_CNT = 0
//WHERE		HAKBUN = :as_hakbun
//;

UPDATE	HAKSA.SUNGJUKGYE
SET		GYUNGGO_CNT = 0
WHERE		HAKBUN = :as_hakbun
USING SQLCA ;

if sqlca.sqlcode = -1 then
	li_rtn = 0
	
end if

return li_rtn
	
				
end function

on w_hjk201a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_1=create st_1
this.dw_dungrok=create dw_dungrok
this.dw_sungjuk=create dw_sungjuk
this.st_2=create st_2
this.dw_iljung=create dw_iljung
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_dungrok
this.Control[iCurrent+4]=this.dw_sungjuk
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_iljung
this.Control[iCurrent+7]=this.dw_con
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.uo_2
end on

on w_hjk201a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_1)
destroy(this.dw_dungrok)
destroy(this.dw_sungjuk)
destroy(this.st_2)
destroy(this.dw_iljung)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event ue_retrieve;
string	ls_hakbun	,&
			ls_hjmod		,&
			ls_sijum		,&
			ls_jongjum
int		li_ans

dw_con.AcceptText()

//조회조건
ls_hakbun	= func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'
ls_hjmod	     = func.of_nvl(dw_con.Object.hjmod_id[1], '%') + '%'
ls_sijum       = dw_con.Object.from_dt[1]
ls_jongjum   = dw_con.Object.to_dt[1]

CHOOSE CASE	ii_index
	CASE	8
		li_ans	= tab_1.tabpage_1.dw_1.retrieve(ls_hakbun, ls_hjmod, ls_sijum, ls_jongjum)
		
		if li_ans = 0 then
			uf_messagebox(7)
			
		elseif li_ans = -1 then
			uf_messagebox(8)
		end if
END CHOOSE

Return 1
end event

event ue_save;// ii_index = 8  : 학적변동내역조회
// ii_index = 1  : 휴학생관리
// ii_index = 2  : 복학생관리
// ii_index = 3  : 제적생관리
// ii_index = 4  : 퇴학생관리
// ii_index = 5  : 전과생관리
// ii_index = 6  : 교환학생관리
// ii_index = 7  : 재입학생관리

string	ls_hakbun, ls_hjmodsayu, ls_hjmod_date, ls_sungjuk_injung, ls_hakyun, ls_hakgi,&
			ls_hakgwa, ls_sayu, ls_sangtae, ls_jogi, ls_juya_gubun, 	ls_year,	ls_gwa,&
			ls_hname
int		li_ans		,&
			li_rtn

  if ii_save_flag	= 1 then	return -1

if messagebox("확인","학적변동 세부입력사항이 이상없습니까?", Question!, YesNo!, 2) = 2 then return 1

CHOOSE CASE	ii_index
	CASE	8
		
	CASE	1		/* 휴 학 */
		
		tab_1.tabpage_2.dw_2.AcceptText()
		
		li_ans	= tab_1.tabpage_2.dw_2.update()				/*	자료의 저장					*/
		
	
		IF li_ans = -1  THEN
			ROLLBACK USING SQLCA	;
			uf_messagebox(3)												/*	저장오류 메세지 출력		*/
			
		ELSE
			ls_hakbun			= tab_1.tabpage_2.dw_2.getitemstring(tab_1.tabpage_2.dw_2.getrow(), "hakbun"			)
			ls_hjmodsayu		= tab_1.tabpage_2.dw_2.getitemstring(tab_1.tabpage_2.dw_2.getrow(), "sayu_id"			)
			ls_hjmod_date		= tab_1.tabpage_2.dw_2.getitemstring(tab_1.tabpage_2.dw_2.getrow(), "hjmod_sijum"	)
			ls_sungjuk_injung	= tab_1.tabpage_2.dw_2.getitemstring(tab_1.tabpage_2.dw_2.getrow(), "sungjuk_injung")
			ls_jogi				= tab_1.tabpage_2.dw_2.getitemstring(tab_1.tabpage_2.dw_2.getrow(), "jogi_test"		)
//			ls_gwa            = tab_1.tabpage_2.dw_2.getitemstring(tab_1.tabpage_2.dw_2.getrow(), "jaehak_hakjuk_gwa")
			
			/* 수강트랜스 성적인정여부 체크 */
			uf_sungjuk_injung(ls_hakbun, ls_sungjuk_injung, ls_jogi)			
			
			SELECT	JAEHAK_HAKJUK.SANGTAE
			INTO		:ls_sangtae
			FROM		HAKSA.JAEHAK_HAKJUK  
			WHERE		JAEHAK_HAKJUK.HAKBUN	=	:ls_hakbun		
			;	
			
			if ls_sangtae = '02' then
				
				UPDATE	HAKSA.JAEHAK_HAKJUK  
				SET		SANGTAE				= '02'					,
							HJMOD_ID				= 'B'						,
							HJMOD_SAYU_ID		= :ls_hjmodsayu		,
							HJMOD_DATE			= :ls_hjmod_date
				WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
				USING SQLCA ;
			
				if sqlca.sqlcode <> -1 then
					COMMIT USING SQLCA ;
					messagebox("성공", "휴학처리가 성공하였습니다")
				else
					ROLLBACK USING SQLCA ;
					messagebox("실패", "휴학처리가 실패하였습니다")
				end if
				
			else
			
				UPDATE	HAKSA.JAEHAK_HAKJUK  
				SET		SANGTAE				= '02'					,
							HJMOD_ID				= 'B'						,
							HJMOD_SAYU_ID		= :ls_hjmodsayu		,
							HJMOD_DATE			= :ls_hjmod_date		,
							HUHAK_DATE			= :ls_hjmod_date
				WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
				USING SQLCA ;
				
				if sqlca.sqlcode <> -1 then
					COMMIT USING SQLCA ;
					messagebox("성공", "휴학처리가 성공하였습니다")
				else
					ROLLBACK USING SQLCA ;
					messagebox("실패", "휴학처리가 실패하였습니다")
				end if
			end if
			
			tab_1.tabpage_2.dw_huhak.retrieve(ls_hakbun)
			
			tab_1.event selectionchanged(1,1)
									
			ii_save_flag	=	1
		END IF
		
	CASE	2	/* 복 학 */

		tab_1.tabpage_3.dw_3.AcceptText()
		
		li_ans	= tab_1.tabpage_3.dw_3.update()			/*	자료의 저장					*/
		
		IF li_ans = -1  THEN
			ROLLBACK USING SQLCA;
			uf_messagebox(3)												/*	저장오류 메세지 출력		*/
			
		ELSE
			ls_hakbun		= tab_1.tabpage_3.dw_3.getitemstring(tab_1.tabpage_3.dw_3.getrow(), "hakbun"		)
			ls_hjmodsayu	= tab_1.tabpage_3.dw_3.getitemstring(tab_1.tabpage_3.dw_3.getrow(), "sayu_id"		)
			ls_hjmod_date	= tab_1.tabpage_3.dw_3.getitemstring(tab_1.tabpage_3.dw_3.getrow(), "hjmod_sijum")
			ls_hakyun		= tab_1.tabpage_3.dw_3.getitemstring(tab_1.tabpage_3.dw_3.getrow(), "su_hakyun"	)
			ls_hakgi			= tab_1.tabpage_3.dw_3.getitemstring(tab_1.tabpage_3.dw_3.getrow(), "hakgi"		)
			ls_year			= tab_1.tabpage_3.dw_3.getitemstring(tab_1.tabpage_3.dw_3.getrow(), "year"		)

			ls_gwa			= tab_1.tabpage_3.dw_bokhak.getitemstring(tab_1.tabpage_3.dw_bokhak.getrow(), "jaehak_hakjuk_gwa"		)
			ls_hname			= tab_1.tabpage_3.dw_bokhak.getitemstring(tab_1.tabpage_3.dw_bokhak.getrow(), "jaehak_hakjuk_hname"		)						

			UPDATE	HAKSA.JAEHAK_HAKJUK  
			SET		SU_HAKYUN		= :ls_hakyun			,
						HAKGI				= :ls_hakgi				,
						SANGTAE			= '01'					,
						HJMOD_ID			= 'C'						,
						HJMOD_SAYU_ID	= :ls_hjmodsayu		,
						HJMOD_DATE		= :ls_hjmod_date		,
						gwa            = :ls_gwa
			WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
			USING SQLCA ;
			
//			// 호텔관광학부로 2005년에 1학년으로 복학하는 사람부터 과를 바꿔 준다. BAB1 -> BAB0 
//			if ls_gwa = 'BAB1' and ls_hakyun = '1' then
//				UPDATE	HAKSA.JAEHAK_HAKJUK  
//				SET		GWA		= 'BAB0'
//				WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
//				;				
////			else
////				ROLLBACK USING SQLCA ;
////				uf_messagebox(3)		
//			end if
			
			// 복학자_LIST 테이블에 복학한사람 전부 넣은것
			// 복학자경우 휴학당시 등록모델정보를 가져 와야 하는데 학과코드가 변경자는 BOKHAKJA_LIST 테이블
			// 정보를 찾아와서 등록 모델 참조한다.
			INSERT INTO HAKSA.BOKHAKJA_LIST
					( 		YEAR,			HAKGI,		HAKBUN,			HNAME,			GWA, 
							WORKER, 						IPADDR,								WORK_DATE,
							JOB_UID,		JOB_ADD, 	JOB_DATE
					)  
			VALUES 
					( 		:ls_year,	:ls_hakgi,	:ls_hakbun, 	:ls_hname, 		:ls_gwa,
							:gs_empcode,	:gs_ip,		SYSDATE,
							NULL,			NULL,			NULL
					) USING SQLCA ;
					
			if sqlca.sqlcode <> -1 then
				COMMIT USING SQLCA ;
				messagebox("성공", "복학처리가 성공하였습니다")
			else
				ROLLBACK USING SQLCA ;
				messagebox("실패", "복학처리가 실패하였습니다")
			end if
						
			tab_1.tabpage_3.dw_bokhak.retrieve(ls_hakbun)
			
			tab_1.event selectionchanged(2,2)
			
			ii_save_flag	=	1
		END IF
		
	CASE	3		/* 제 적 */

		tab_1.tabpage_4.dw_4.AcceptText()
		
		li_ans	= tab_1.tabpage_4.dw_4.update()				/*	자료의 저장					*/
		
		IF li_ans = -1  THEN
			ROLLBACK USING SQLCA;
			uf_messagebox(3)											/*	저장오류 메세지 출력		*/
			
		ELSE
			ls_hakbun			= tab_1.tabpage_4.dw_4.getitemstring(tab_1.tabpage_4.dw_4.getrow(), "hakbun"			)
			ls_hjmodsayu		= tab_1.tabpage_4.dw_4.getitemstring(tab_1.tabpage_4.dw_4.getrow(), "sayu_id"			)
			ls_hjmod_date		= tab_1.tabpage_4.dw_4.getitemstring(tab_1.tabpage_4.dw_4.getrow(), "hjmod_sijum"	)
			ls_sungjuk_injung	= tab_1.tabpage_4.dw_4.getitemstring(tab_1.tabpage_4.dw_4.getrow(), "sungjuk_injung")
			ls_jogi				= tab_1.tabpage_4.dw_4.getitemstring(tab_1.tabpage_4.dw_4.getrow(), "jogi_test"		)
			
			/* 수강트랜스 성적인정여부 체크 */
			uf_sungjuk_injung(ls_hakbun, ls_sungjuk_injung, ls_jogi)
			
			UPDATE	HAKSA.JAEHAK_HAKJUK  
			SET		SANGTAE			= '03'					,
						HJMOD_ID			= 'D'						,
						HJMOD_SAYU_ID	= :ls_hjmodsayu		,
						HJMOD_DATE		= :ls_hjmod_date
			WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
			USING SQLCA ;
			
			if sqlca.sqlcode <> -1 then
				COMMIT USING SQLCA ;
				messagebox("성공", "제적처리가 성공하였습니다")
			else
				ROLLBACK USING SQLCA ;
				messagebox("실패", "제적처리가 실패하였습니다")
			end if
			
			tab_1.tabpage_4.dw_jaejuk.retrieve(ls_hakbun)
			
			tab_1.event selectionchanged(3,3)
			
			ii_save_flag	=	1
		END IF
		
	CASE	4		/* 퇴 학 */

		tab_1.tabpage_5.dw_5.AcceptText()
		
		li_ans	= tab_1.tabpage_5.dw_5.update()				/*	자료의 저장					*/
		
		IF li_ans = -1  THEN
			ROLLBACK USING SQLCA;
			uf_messagebox(3)												/*	저장오류 메세지 출력		*/
			
		ELSE
			ls_hakbun			= tab_1.tabpage_5.dw_5.getitemstring(tab_1.tabpage_5.dw_5.getrow(), "hakbun"			)
			ls_hjmodsayu		= tab_1.tabpage_5.dw_5.getitemstring(tab_1.tabpage_5.dw_5.getrow(), "sayu_id"			)
			ls_hjmod_date		= tab_1.tabpage_5.dw_5.getitemstring(tab_1.tabpage_5.dw_5.getrow(), "hjmod_sijum"	)
			ls_sungjuk_injung	= tab_1.tabpage_5.dw_5.getitemstring(tab_1.tabpage_5.dw_5.getrow(), "sungjuk_injung")
			ls_jogi				= tab_1.tabpage_5.dw_5.getitemstring(tab_1.tabpage_5.dw_5.getrow(), "jogi_test"		)
			
			/* 수강트랜스 성적인정여부 체크 */
			uf_sungjuk_injung(ls_hakbun, ls_sungjuk_injung, ls_jogi)
			
			UPDATE	HAKSA.JAEHAK_HAKJUK  
			SET		SANGTAE			= '03'					,
						HJMOD_ID			= 'E'						,
						HJMOD_SAYU_ID	= :ls_hjmodsayu		,
						HJMOD_DATE		= :ls_hjmod_date
			WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
			USING SQLCA ;
			
			if sqlca.sqlcode <> -1 then
				COMMIT USING SQLCA ;
				messagebox("성공", "퇴학처리가 성공하였습니다")
			else
				ROLLBACK USING SQLCA ;
				messagebox("실패", "퇴학처리가 실패하였습니다")
			end if			

			tab_1.tabpage_5.dw_taehak.retrieve(ls_hakbun)
			
			tab_1.event selectionchanged(4,4)
			
			ii_save_flag	=	1
		END IF
		
	CASE	5		/* 전 과 */

		tab_1.tabpage_6.dw_6.AcceptText()
		
		li_ans	= tab_1.tabpage_6.dw_6.update()				/*	자료의 저장					*/
		
		IF li_ans = -1  THEN
			ROLLBACK USING SQLCA;
			uf_messagebox(3)												/*	저장오류 메세지 출력		*/
			
		ELSE
			ls_hakbun			= tab_1.tabpage_6.dw_6.getitemstring(tab_1.tabpage_6.dw_6.getrow(), "hakbun"		)
			ls_hjmodsayu		= tab_1.tabpage_6.dw_6.getitemstring(tab_1.tabpage_6.dw_6.getrow(), "sayu_id"		)
			ls_hjmod_date		= tab_1.tabpage_6.dw_6.getitemstring(tab_1.tabpage_6.dw_6.getrow(), "hjmod_sijum")
			ls_hakgwa			= tab_1.tabpage_6.dw_6.getitemstring(tab_1.tabpage_6.dw_6.getrow(), "gwa"			)
			ls_juya_gubun     = mid(ls_hakgwa , 4, 1)
			if trim(ls_hakgwa) = '' then
				messagebox("입력오류", "전과 학과를 입력하세요")
				return -1
			end if
			
//			messagebox('ls_juya_gubun', ls_juya_gubun)
			
			UPDATE	HAKSA.JAEHAK_HAKJUK
			SET		GWA					= :ls_hakgwa			,
						SANGTAE				= '01'					,
						HJMOD_ID				= 'F'						,
						HJMOD_SAYU_ID		= :ls_hjmodsayu		,
						HJMOD_DATE			= :ls_hjmod_date
			WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
			USING SQLCA ;
			
			if sqlca.sqlcode <> -1 then
				COMMIT USING SQLCA ;
				messagebox("성공", "전과처리가 성공하였습니다")
			else
				ROLLBACK USING SQLCA ;
				messagebox("실패", "전과처리가 실패하였습니다")
			end if

			tab_1.tabpage_6.dw_jungwa.retrieve(ls_hakbun)
			
			tab_1.event selectionchanged(5,5)
			
			ii_save_flag	=	1
		END IF
		
	CASE	6		/* 교 환 */

		tab_1.tabpage_7.dw_7.AcceptText()
		
		li_ans	= tab_1.tabpage_7.dw_7.update()				/*	자료의 저장					*/
		
		IF li_ans = -1  THEN
			ROLLBACK USING SQLCA	;
			uf_messagebox(3)												/*	저장오류 메세지 출력		*/
			
		ELSE
			ls_hakbun			= tab_1.tabpage_7.dw_7.getitemstring(tab_1.tabpage_7.dw_7.getrow(), "hakbun"		)
			ls_hjmodsayu		= tab_1.tabpage_7.dw_7.getitemstring(tab_1.tabpage_7.dw_7.getrow(), "sayu_id"		)
			ls_hjmod_date		= tab_1.tabpage_7.dw_7.getitemstring(tab_1.tabpage_7.dw_7.getrow(), "hjmod_sijum")
						
			UPDATE	HAKSA.JAEHAK_HAKJUK  
			SET		HJMOD_ID			= 'H'						,
						HJMOD_SAYU_ID	= :ls_hjmodsayu		,
						HJMOD_DATE		= :ls_hjmod_date
			WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
			USING SQLCA ;
			
			if sqlca.sqlcode <> -1 then
				COMMIT USING SQLCA ;
				messagebox("성공", "교환학생처리가 성공하였습니다")
			else
				ROLLBACK USING SQLCA ;
				messagebox("실패", "교환학생처리가 실패하였습니다")
			end if			

			tab_1.tabpage_7.dw_gyohwan.retrieve(ls_hakbun)
			
			tab_1.event selectionchanged(6,6)
			
			ii_save_flag	=	1
		END IF
	
	CASE	7	/* 재 입 학 */

		tab_1.tabpage_8.dw_8.AcceptText()
		
		li_ans	= tab_1.tabpage_8.dw_8.update()			/*	자료의 저장					*/
		
		IF li_ans = -1  THEN
			ROLLBACK USING SQLCA;
			uf_messagebox(3)												/*	저장오류 메세지 출력		*/
			
		ELSE
			ls_hakbun		= tab_1.tabpage_8.dw_8.getitemstring(tab_1.tabpage_8.dw_8.getrow(), "hakbun"		)
			ls_hjmodsayu	= tab_1.tabpage_8.dw_8.getitemstring(tab_1.tabpage_8.dw_8.getrow(), "sayu_id"		)
			ls_hjmod_date	= tab_1.tabpage_8.dw_8.getitemstring(tab_1.tabpage_8.dw_8.getrow(), "hjmod_sijum")
			ls_hakyun		= tab_1.tabpage_8.dw_8.getitemstring(tab_1.tabpage_8.dw_8.getrow(), "su_hakyun"		)
			ls_hakgi			= tab_1.tabpage_8.dw_8.getitemstring(tab_1.tabpage_8.dw_8.getrow(), "hakgi"		)
			ls_gwa			= tab_1.tabpage_8.dw_jaeiphak.getitemstring(tab_1.tabpage_8.dw_jaeiphak.getrow(), "jaehak_hakjuk_gwa"		)
			UPDATE	HAKSA.JAEHAK_HAKJUK  
			SET		SU_HAKYUN			= :ls_hakyun			,
						HAKGI					= :ls_hakgi				,
						SANGTAE				= '01'					,
						HJMOD_ID				= 'I'						,
						HJMOD_SAYU_ID		= :ls_hjmodsayu		,
						HJMOD_DATE			= :ls_hjmod_date		,
						JAEIPHAK_DATE		= :ls_hjmod_date		,
						GYOJIK_YN			= 'N',												/*	교직과정 이수예정자 선발대상 제외	*/
						GWA               = :ls_gwa
			WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
			USING SQLCA ;
			
//			// 호텔관광학부로 2005년에 1학년으로 복학하는 사람부터 과를 바꿔 준다. BAB1 -> BAB0 
//			if ls_gwa = 'BAB1' and ls_hakyun = '1' then
//				UPDATE	HAKSA.JAEHAK_HAKJUK  
//				SET		GWA		= 'BAB0'
//				WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
//				;				
////			else
////				ROLLBACK USING SQLCA ;
////				uf_messagebox(3)		
//			end if
			
			if sqlca.sqlcode <> -1 then
				
				/*-------------------------------------------------------------------------------				
						제적시 재입학 할 경우
							성적계		==>  기존 학생의 SUNGJUKGYE 데이터의 학사경고를 모두 
							학사경고카은터를 0 으로 바꾸어주어야 한다. 
				
						처리하는 Script 필요
				----------------------------------------------------------------------------------*/
				li_rtn = uf_jaeiphak(ls_hakbun)
				
				if li_rtn = 1 then
					COMMIT USING SQLCA ;
					messagebox("성공", "재입학처리가 성공하였습니다")
				elseif li_rtn = 0 then
					ROLLBACK USING SQLCA ;
					messagebox("실패", "재입학처리가 실패하였습니다")
				end if
			end if

			tab_1.tabpage_8.dw_jaeiphak.retrieve(ls_hakbun)
			
			tab_1.event selectionchanged(7,7)
			
			ii_save_flag	=	1
		END IF

  END CHOOSE
end event

event ue_delete;string	ls_hakbun			,&
			ls_hjmod				,&
			ls_hjmodsayu		,&
			ls_hjmod_date		,&
			ls_hjmod_2			,&
			ls_hjmodsayu_2		,&
			ls_hjmod_date_2	,&
			ls_hjmod_3			,&
			ls_hjmodsayu_3		,&
			ls_hjmod_date_3	,&
			ls_sangtae			,&
			ls_iphak_date		,&
			ls_iphak_gwa		,&
			ls_year				,&
			ls_hakgi				,&
			ls_lase_sangtae	,&
			ls_iphak_gwa_juya_gubun
int	li_ans1	,&
		li_ans2	,&
		li_huhak_count
String   ls_begwa, ls_gwa

CHOOSE CASE	ii_index
	CASE 8
		li_ans1 = uf_messagebox(4)				/*	삭제확인 메세지 출력		*/
		
		if li_ans1 = 1 then
			
			/*-----------------------------------------------------------------------
					학적변동내역 삭제 => 최종학적변동만 삭제가능
			------------------------------------------------------------------------*/	
			ls_hakbun		= tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "hakjukbyendong_hakbun"		)
			
			ls_hjmod			= tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "hakjukbyendong_hjmod_id"	)
			ls_hjmodsayu	= tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "hakjukbyendong_sayu_id"		)
			ls_hjmod_date	= tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "hakjukbyendong_hjmod_sijum")
			ls_year			= tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "hakjukbyendong_year")
			ls_hakgi			= tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "hakjukbyendong_hakgi")			
         ls_begwa			= tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "hakjukbyendong_before_gwa")
         ls_gwa			= tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "jaehak_hakjuk_gwa")
 
 
//         IF ls_hjmod    = 'C' OR ls_hjmod    = 'I' THEN
//				UPDATE HAKSA.JAEHAK_HAKJUK  
//					SET GWA        = :ls_begwa
//				 WHERE HAKBUN     = :ls_hakbun ;
//			END IF
			
			SELECT	JAEHAK_HAKJUK.HJMOD_ID			,
						JAEHAK_HAKJUK.HJMOD_SAYU_ID 	,
						JAEHAK_HAKJUK.HJMOD_DATE		,
						JAEHAK_HAKJUK.SANGTAE			,
						JAEHAK_HAKJUK.IPHAK_DATE		,
						JAEHAK_HAKJUK.IPHAK_GWA
			INTO		:ls_hjmod_2				,
						:ls_hjmodsayu_2		,
						:ls_hjmod_date_2		,
						:ls_sangtae				,
						:ls_iphak_date			,
						:ls_iphak_gwa
			FROM		HAKSA.JAEHAK_HAKJUK  
			WHERE		JAEHAK_HAKJUK.HAKBUN	=	:ls_hakbun
			USING SQLCA ;
			
			ls_iphak_gwa_juya_gubun = mid(ls_iphak_gwa, 4, 1)
			
			if (ls_hjmod = ls_hjmod_2) and (ls_hjmodsayu = ls_hjmodsayu_2) and &
				(ls_hjmod_date = ls_hjmod_date_2) then	


				//각종학적변동자료 삭제시 JAEHAK_HAKJUK_DEL TABLE에 삽입
				INSERT INTO HAKSA.JAEHAK_HAKJUK_DEL
						( 		HAKBUN,		GWA,				YEAR,				HAKGI,		SANGTAE,
								HJMOD_ID,	SAYU_ID,			HJMOD_DATE,		
								WORKER, 							IPADDR,							WORK_DATE,
								JOB_UID,		JOB_ADD, 		JOB_DATE
						)  
				VALUES 
						( 		:ls_hakbun,	:ls_gwa,			:ls_year, 		:ls_hakgi, 	:ls_sangtae,
								:ls_hjmod,	:ls_hjmodsayu,	:ls_hjmod_date,
								:gs_empcode,		:gs_ip,		SYSDATE,
								NULL,			NULL,				NULL
						) USING SQLCA ;
						
				if sqlca.sqlcode = 0 then
					commit USING SQLCA ;				
				else
					rollback USING SQLCA ;
					messagebox("실패", "삽입 실패 하였습니다.")
					return
				end if	
			end if
					
			if (ls_hjmod = ls_hjmod_2) and (ls_hjmodsayu = ls_hjmodsayu_2) and &
				(ls_hjmod_date = ls_hjmod_date_2) then	
			
				tab_1.tabpage_1.dw_1.deleterow(0)            						/*	현재 행을 삭제				*/
				li_ans2 = tab_1.tabpage_1.dw_1.update()      						/*	삭제된 내용을 저장 		*/
				
				if li_ans2 = -1 then        
					ROLLBACK USING SQLCA;     
					uf_messagebox(6)          												/*	삭제오류 메세지 출력		*/
				
				else
					SELECT 	B.HJMOD_ID			,
								B.SAYU_ID		,
								B.HJMOD_SIJUM
					INTO		:ls_hjmod_3				,
								:ls_hjmodsayu_3		,
								:ls_hjmod_date_3
					FROM		HAKSA.HAKJUKBYENDONG B
					WHERE	B.HJMOD_SIJUM = (	SELECT	MAX(A.HJMOD_SIJUM)
														FROM		HAKSA.HAKJUKBYENDONG A
														WHERE		A.HAKBUN = :ls_hakbun
														AND		A.HAKBUN = B.HAKBUN
													 )
					AND		B.HAKBUN	= :ls_hakbun
					USING SQLCA ;
		
					if sqlca.sqlcode = 0 then
						CHOOSE CASE	ls_hjmod_3
							CASE	'A'	/* 입학		*/
								ls_sangtae	= '01'
							CASE	'B'	/* 휴학		*/
								ls_sangtae	= '02'
							CASE	'C'	/* 복학		*/
								ls_sangtae	= '01'
							CASE	'D'	/* 제적		*/
								ls_sangtae	= '03'
							CASE	'E'	/* 퇴학		*/
								ls_sangtae	= '03'
							CASE	'F'	/* 전과		*/
								ls_sangtae	= '01'
							CASE	'H'	/* 교환학생	*/
								if ls_sangtae = '06' then
									ls_sangtae	= '06'
								else
									ls_sangtae	= '01'
								end if
							CASE	'I'	/* 재입학	*/
								ls_sangtae	= '01'							
						END CHOOSE			
						
						if ls_hjmod = 'F' then
							
							/* 전과일때 학과까지 Update */
							UPDATE	HAKSA.JAEHAK_HAKJUK  
							SET		GWA				= :ls_iphak_gwa	,
										SANGTAE			= :ls_sangtae			,
										HJMOD_ID			= :ls_hjmod_3			,
										HJMOD_SAYU_ID	= :ls_hjmodsayu_3		,
										HJMOD_DATE		= :ls_hjmod_date_3	,
										JUYA_GUBUN		= :ls_iphak_gwa_juya_gubun
							WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
							;
							
							UPDATE HAKSA.SUGANG_TRANS  
							SET 	SUNGJUK_INJUNG = 'Y'  
							WHERE	YEAR 			=	:ls_year
							AND	HAKGI 		=	:ls_hakgi
							AND	HAKBUN		=	:ls_hakbun 
							USING SQLCA ;

						
						else
							UPDATE	HAKSA.JAEHAK_HAKJUK  
							SET		SANGTAE			= :ls_sangtae			,
										HJMOD_ID			= :ls_hjmod_3			,
										HJMOD_SAYU_ID	= :ls_hjmodsayu_3		,
										HJMOD_DATE		= :ls_hjmod_date_3
							WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
							USING SQLCA ;
							
							UPDATE HAKSA.SUGANG_TRANS  
							SET 	SUNGJUK_INJUNG = 'Y'  
							WHERE	YEAR 			=	:ls_year
							AND	HAKGI 		=	:ls_hakgi
							AND	HAKBUN		=	:ls_hakbun 
							USING SQLCA ;
					
						end if
						
						if sqlca.sqlcode = 0 then
							commit USING SQLCA ;
							messagebox("삭제완료", "자료가 삭제되었습니다." &
											 + "~n학년과 학기를 확인하세요!")						/*	삭제완료 메세지 출력		*/

									//	마지막으로 학적변동 학적 다 처리하고 학적테이블의 최초 휴학일을 셋팅 하는것
									// 1. 학적변동이 한번도 일어나지 않은 학생은 null로 처리
									//	2. 휴학이 한번이라도 일어나지 않은 학생도 null로 처리
									//	3. 휴학이 한번이라도 일어난 난 학생은 최초 휴학일로 처리	

									SELECT 	NVL(A.COUNT, 0)
									INTO		:li_huhak_count	
									FROM 		(	SELECT 	SUM(DECODE(HJMOD_ID, 'B', 1, 0)) COUNT
													FROM 		HAKSA.HAKJUKBYENDONG B
													WHERE		HAKBUN	=	:ls_hakbun) A
									USING SQLCA ;
							
//									SELECT 	COUNT(HAKBUN)
//									INTO		:li_huhak_count
//									FROM 		HAKSA.HAKJUKBYENDONG B
//									WHERE		HJMOD_ID	=	'B'
//									AND		HAKBUN	=	:ls_hakbun
//									;

									if li_huhak_count > 0 then 
									else
										UPDATE	HAKSA.JAEHAK_HAKJUK  
										SET		HUHAK_DATE		= null
										WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
										;
										
										if sqlca.sqlcode = 0 then
											commit USING SQLCA ;
					//						messagebox("최초휴학일 조정완료", "최초휴학일 조정완료 되었습니다.")						/*	삭제완료 메세지 출력		*/
											return
											
										else
											rollback USING SQLCA ;
											messagebox("최초휴학일 조정완료 실패", "최조휴학일 조정 실패 하였습니다.")
											return
										end if	
									
									end if	
							return
							
						else
							rollback USING SQLCA ;
							messagebox("확인", "학적변동내역은 삭제되었으나, 학적 UPDATE 실패"&
											+ "~n학적내용의 상태컬럼을 확인바랍니다")
							return
						end if
						
					elseif sqlca.sqlcode = 100 then
						if ls_sangtae = '06' then
							ls_sangtae	= '06'
						else
							ls_sangtae	= '01'
						end if
						
						UPDATE	HAKSA.JAEHAK_HAKJUK  
						SET		SANGTAE			= :ls_sangtae		,
									HJMOD_ID			= 'A'					,
									HJMOD_SAYU_ID	= 'A11'				,
									HJMOD_DATE		= :ls_iphak_date
						WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
						USING SQLCA ;
						
						UPDATE HAKSA.SUGANG_TRANS  
						SET 	SUNGJUK_INJUNG = 'Y'  
						WHERE	YEAR 			=	:ls_year
						AND	HAKGI 		=	:ls_hakgi
						AND	HAKBUN		=	:ls_hakbun 
						USING SQLCA ;
						
						if sqlca.sqlcode = 0 then
							commit USING SQLCA ;
							messagebox("삭제완료", "자료가 삭제되었습니다." &
											 + "~n학년과 학기를 확인하세요!")						/*	삭제완료 메세지 출력		*/

									//	마지막으로 학적변동 학적 다 처리하고 학적테이블의 최초 휴학일을 셋팅 하는것
									// 1. 학적변동이 한번도 일어나지 않은 학생은 null로 처리
									//	2. 휴학이 한번이라도 일어나지 않은 학생도 null로 처리
									//	3. 휴학이 한번이라도 일어난 난 학생은 최초 휴학일로 처리	
									
									SELECT 	NVL(A.COUNT, 0)
									INTO		:li_huhak_count	
									FROM 		(	SELECT 	SUM(DECODE(HJMOD_ID, 'B', 1, 0)) COUNT
													FROM 		HAKSA.HAKJUKBYENDONG B
													WHERE		HAKBUN	=	:ls_hakbun) A
									USING SQLCA ;
									
									if li_huhak_count > 0 then 
									else
										UPDATE	HAKSA.JAEHAK_HAKJUK  
										SET		HUHAK_DATE		= null
										WHERE		JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun   
										USING SQLCA ;
										
										if sqlca.sqlcode = 0 then
											commit USING SQLCA ;
					//						messagebox("최초휴학일 조정완료", "최초휴학일 조정완료 되었습니다.")						/*	삭제완료 메세지 출력		*/
											return
											
										else
											rollback USING SQLCA ;
											messagebox("최초휴학일 조정완료 실패", "최조휴학일 조정 실패 하였습니다.")
											return
										end if	
									
									end if
					
							return
							
						else
							rollback USING SQLCA ;
							messagebox("확인", "학적변동내역은 삭제되었으나, 학적 UPDATE 실패"&
											+ "~n학적내용의 상태컬럼을 확인바랍니다")
							return
						end if
					end if		
					
				end if
				
			else
				messagebox("확인","최종학적변동이 아니므로 삭제할 수 없습니다.")
				return
			end if
		end if
		
		tab_1.tabpage_1.dw_1.setfocus()
		
END CHOOSE
end event

event open;call super::open;Vector lvc_data

tab_1.tabpage_2.dw_2.SetTransObject(sqlca)
tab_1.tabpage_3.dw_3.SetTransObject(sqlca)
tab_1.tabpage_4.dw_4.SetTransObject(sqlca)
tab_1.tabpage_5.dw_5.SetTransObject(sqlca)
tab_1.tabpage_6.dw_6.SetTransObject(sqlca)
tab_1.tabpage_7.dw_7.SetTransObject(sqlca)
tab_1.tabpage_8.dw_8.SetTransObject(sqlca)

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')

tab_1.tabpage_2.dw_2.getchild('sayu_id',idwc_hjmodsayu)
idwc_hjmodsayu.settransobject(sqlca)	
idwc_hjmodsayu.retrieve('B')

tab_1.tabpage_3.dw_3.getchild('sayu_id',idwc_hjmodsayu)
idwc_hjmodsayu.settransobject(sqlca)
idwc_hjmodsayu.retrieve('C')

tab_1.tabpage_4.dw_4.getchild('sayu_id',idwc_hjmodsayu)
idwc_hjmodsayu.settransobject(sqlca)
idwc_hjmodsayu.retrieve('D')

tab_1.tabpage_5.dw_5.getchild('sayu_id',idwc_hjmodsayu)
idwc_hjmodsayu.settransobject(sqlca)
idwc_hjmodsayu.retrieve('E')

tab_1.tabpage_6.dw_6.getchild('sayu_id',idwc_hjmodsayu)
idwc_hjmodsayu.settransobject(sqlca)
idwc_hjmodsayu.retrieve('F')

tab_1.tabpage_7.dw_7.getchild('sayu_id',idwc_hjmodsayu)
idwc_hjmodsayu.settransobject(sqlca)
idwc_hjmodsayu.retrieve('H')

tab_1.tabpage_8.dw_8.getchild('sayu_id',idwc_hjmodsayu)
idwc_hjmodsayu.settransobject(sqlca)
idwc_hjmodsayu.retrieve('I')

// 제적-자퇴사유
lvc_data = Create Vector
lvc_data.setProperty('column1', 'drop_cd')  //업무구분
lvc_data.setProperty('key1', 'HJK01')

func.of_dddw( tab_1.tabpage_4.dw_4, lvc_data)
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk201a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk201a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk201a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk201a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk201a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk201a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk201a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk201a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk201a
boolean enabled = false
end type

type uc_save from w_condition_window`uc_save within w_hjk201a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk201a
end type

type uc_print from w_condition_window`uc_print within w_hjk201a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk201a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk201a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk201a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk201a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk201a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk201a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk201a
end type

type tab_1 from tab within w_hjk201a
integer x = 50
integer y = 312
integer width = 4384
integer height = 1948
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_1)
end on

event selectionchanged;long	ll_newrow

IF oldindex > 0 then
	control[oldindex].TabTextColor = RGB(0, 0, 0)
end IF

control[newindex].TabTextColor = RGB(0, 0, 255)	

ii_index	= newindex

CHOOSE CASE ii_index

	CASE	1	/* 휴학 */
		
		tab_1.tabpage_2.dw_2.setredraw(false)
		tab_1.tabpage_2.dw_huhak.setredraw(false)
		uo_1.visible = false
		
		tab_1.tabpage_2.dw_2.reset()
		tab_1.tabpage_2.dw_huhak.reset()
		
		ll_newrow	= tab_1.tabpage_2.dw_2.InsertRow(0)		/*	데이타윈도우의 마지막 행에 추가			*/
		
		if ll_newrow <> -1 then
			tab_1.tabpage_2.dw_2.ScrollToRow(ll_newrow)		/*	추가된 행에 스크롤							*/
			tab_1.tabpage_2.dw_2.setcolumn(1)              	/*	추가된 행의 첫번째 컬럼에 커서 위치		*/
			tab_1.tabpage_2.dw_2.setfocus()                	/*	dw_main 포커스 이동							*/
			
			//tab_1.tabpage_2.dw_huhak.setitem(ll_newrow, "hjmod_sijum", string(today(), 'yyyymmdd'))
			
			tab_1.tabpage_2.dw_2.setredraw(true)
			tab_1.tabpage_2.dw_huhak.setredraw(true)
				
			/*-----------------------------------------------------
								휴학관련 변동 사유 RETRIEVE
			------------------------------------------------------*/			
			tab_1.tabpage_2.dw_2.getchild('sayu_id',idwc_hjmodsayu)
			idwc_hjmodsayu.settransobject(sqlca)
			idwc_hjmodsayu.retrieve('B')			
		end if
		
	CASE	2	/* 복학 */
		uo_1.visible = false
		tab_1.tabpage_3.dw_3.setredraw(false)
		tab_1.tabpage_3.dw_bokhak.setredraw(false)
				
		tab_1.tabpage_3.dw_3.reset()
		tab_1.tabpage_3.dw_bokhak.reset()
		tab_1.tabpage_3.dw_zip_gain.reset()
		
		ll_newrow	= tab_1.tabpage_3.dw_3.InsertRow(0)			/*	데이타윈도우의 마지막 행에 추가			*/
		
		if ll_newrow <> -1 then
			tab_1.tabpage_3.dw_3.ScrollToRow(ll_newrow)			/*	추가된 행에 스크롤							*/
			tab_1.tabpage_3.dw_3.setcolumn(1)              		/*	추가된 행의 첫번째 컬럼에 커서 위치		*/
			tab_1.tabpage_3.dw_3.setfocus()                		/*	dw_main 포커스 이동							*/
			
			//tab_1.tabpage_3.dw_bokhak.setitem(ll_newrow, "hjmod_sijum", string(today(), 'yyyymmdd'))
			
			tab_1.tabpage_3.dw_3.setredraw(true)
			tab_1.tabpage_3.dw_bokhak.setredraw(true)
			
			/*-----------------------------------------------------
								복학관련 변동 사유 RETRIEVE
			------------------------------------------------------*/			
			tab_1.tabpage_3.dw_3.getchild('sayu_id',idwc_hjmodsayu)
			idwc_hjmodsayu.settransobject(sqlca)
			idwc_hjmodsayu.retrieve('C')			
		end if
		
	CASE	3	/* 제적 */
		uo_1.visible = true
		tab_1.tabpage_4.dw_4.setredraw(false)
		tab_1.tabpage_4.dw_jaejuk.setredraw(false)
		
		tab_1.tabpage_4.dw_4.reset()
		tab_1.tabpage_4.dw_jaejuk.reset()
		
		ll_newrow	= tab_1.tabpage_4.dw_4.InsertRow(0)		/*	데이타윈도우의 마지막 행에 추가			*/
		
		if ll_newrow <> -1 then
			tab_1.tabpage_4.dw_4.ScrollToRow(ll_newrow)		/*	추가된 행에 스크롤							*/
			tab_1.tabpage_4.dw_4.setcolumn(1)              	/*	추가된 행의 첫번째 컬럼에 커서 위치		*/
			tab_1.tabpage_4.dw_4.setfocus()                	/*	dw_main 포커스 이동							*/
			
			//tab_1.tabpage_4.dw_jejuk.setitem(ll_newrow, "hjmod_sijum", string(today(), 'yyyymmdd'))
			
			tab_1.tabpage_4.dw_4.setredraw(true)
			tab_1.tabpage_4.dw_jaejuk.setredraw(true)
			
			/*-----------------------------------------------------
								제적관련 변동 사유 RETRIEVE
			------------------------------------------------------*/			
			tab_1.tabpage_4.dw_4.getchild('sayu_id',idwc_hjmodsayu)
			idwc_hjmodsayu.settransobject(sqlca)
			idwc_hjmodsayu.retrieve('D')			
		end if
		
	CASE	4	/* 퇴학 */
		uo_1.visible = false
		tab_1.tabpage_5.dw_5.setredraw(false)
		tab_1.tabpage_5.dw_taehak.setredraw(false)
		
		tab_1.tabpage_5.dw_5.reset()
		tab_1.tabpage_5.dw_taehak.reset()
		
		ll_newrow	= tab_1.tabpage_5.dw_5.InsertRow(0)		/*	데이타윈도우의 마지막 행에 추가			*/
		
		if ll_newrow <> -1 then
			tab_1.tabpage_5.dw_5.ScrollToRow(ll_newrow)		/*	추가된 행에 스크롤							*/
			tab_1.tabpage_5.dw_5.setcolumn(1)              	/*	추가된 행의 첫번째 컬럼에 커서 위치		*/
			tab_1.tabpage_5.dw_5.setfocus()                	/*	dw_main 포커스 이동							*/
			
			//tab_1.tabpage_5.dw_toihak.setitem(ll_newrow, "hjmod_sijum", string(today(), 'yyyymmdd'))
			
			tab_1.tabpage_5.dw_5.setredraw(true)
			tab_1.tabpage_5.dw_taehak.setredraw(true)
			
			/*-----------------------------------------------------
								퇴학관련 변동 사유 RETRIEVE
			------------------------------------------------------*/			
			tab_1.tabpage_5.dw_5.getchild('sayu_id',idwc_hjmodsayu)
			idwc_hjmodsayu.settransobject(sqlca)
			idwc_hjmodsayu.retrieve('E')			
		end if
		
	CASE	5	/* 전과 */
		uo_1.visible = false
		tab_1.tabpage_6.dw_6.setredraw(false)
		tab_1.tabpage_6.dw_jungwa.setredraw(false)
		
		tab_1.tabpage_6.dw_6.reset()
		tab_1.tabpage_6.dw_jungwa.reset()
		
		ll_newrow	= tab_1.tabpage_6.dw_6.InsertRow(0)		/*	데이타윈도우의 마지막 행에 추가			*/
		
		if ll_newrow <> -1 then
			tab_1.tabpage_6.dw_6.ScrollToRow(ll_newrow)		/*	추가된 행에 스크롤							*/
			tab_1.tabpage_6.dw_6.setcolumn(1)              	/*	추가된 행의 첫번째 컬럼에 커서 위치		*/
			tab_1.tabpage_6.dw_6.setfocus()                	/*	dw_main 포커스 이동							*/
			
			//tab_1.tabpage_6.dw_jungwa.setitem(ll_newrow, "hjmod_sijum", string(today(), 'yyyymmdd'))
			
			tab_1.tabpage_6.dw_6.setredraw(true)
			tab_1.tabpage_6.dw_jungwa.setredraw(true)
			
			/*-----------------------------------------------------
								전과관련 변동 사유 RETRIEVE
			------------------------------------------------------*/			
			tab_1.tabpage_6.dw_6.getchild('sayu_id',idwc_hjmodsayu)
			idwc_hjmodsayu.settransobject(sqlca)
			idwc_hjmodsayu.retrieve('F')			
		end if
		
	CASE	6	/* 교환 */
		uo_1.visible = false
		tab_1.tabpage_7.dw_7.setredraw(false)
		tab_1.tabpage_7.dw_gyohwan.setredraw(false)
		
		tab_1.tabpage_7.dw_7.reset()
		tab_1.tabpage_7.dw_gyohwan.reset()
		
		ll_newrow	= tab_1.tabpage_7.dw_7.InsertRow(0)		/*	데이타윈도우의 마지막 행에 추가			*/
		
		if ll_newrow <> -1 then
			tab_1.tabpage_7.dw_7.ScrollToRow(ll_newrow)		/*	추가된 행에 스크롤							*/
			tab_1.tabpage_7.dw_7.setcolumn(1)              	/*	추가된 행의 첫번째 컬럼에 커서 위치		*/
			tab_1.tabpage_7.dw_7.setfocus()                	/*	dw_main 포커스 이동							*/
			
			//tab_1.tabpage_7.dw_gyohwan.setitem(ll_newrow, "hjmod_sijum", string(today(), 'yyyymmdd'))
			
			tab_1.tabpage_7.dw_7.setredraw(true)
			tab_1.tabpage_7.dw_gyohwan.setredraw(true)
			
			/*-----------------------------------------------------
								교환관련 변동 사유 RETRIEVE
			------------------------------------------------------*/			
			tab_1.tabpage_7.dw_7.getchild('sayu_id',idwc_hjmodsayu)
			idwc_hjmodsayu.settransobject(sqlca)
			idwc_hjmodsayu.retrieve('H')			
		end if
		
	CASE	7	/* 재입학 */
		uo_1.visible = false
		tab_1.tabpage_8.dw_8.setredraw(false)
		tab_1.tabpage_8.dw_jaeiphak.setredraw(false)
		
		tab_1.tabpage_8.dw_8.reset()
		tab_1.tabpage_8.dw_jaeiphak.reset()
		
		ll_newrow	= tab_1.tabpage_8.dw_8.InsertRow(0)		/*	데이타윈도우의 마지막 행에 추가			*/
		
		if ll_newrow <> -1 then
			tab_1.tabpage_8.dw_8.ScrollToRow(ll_newrow)		/*	추가된 행에 스크롤							*/
			tab_1.tabpage_8.dw_8.setcolumn(1)              	/*	추가된 행의 첫번째 컬럼에 커서 위치		*/
			tab_1.tabpage_8.dw_8.setfocus()                	/*	dw_main 포커스 이동							*/
			
			//tab_1.tabpage_8.dw_jaeiphak.setitem(ll_newrow, "hjmod_sijum", string(today(), 'yyyymmdd'))
			
			tab_1.tabpage_8.dw_8.setredraw(true)
			tab_1.tabpage_8.dw_jaeiphak.setredraw(true)
			
			/*-----------------------------------------------------
								재입학관련 변동 사유 RETRIEVE
			------------------------------------------------------*/			
			tab_1.tabpage_8.dw_8.getchild('sayu_id',idwc_hjmodsayu)
			idwc_hjmodsayu.settransobject(sqlca)
			idwc_hjmodsayu.retrieve('I')			
		end if
	CASE	8
		uo_1.visible = false
END CHOOSE
end event

event selectionchanging;int 	li_oldindex	,&
		li_rtn

string	ls_pass

dw_con.AcceptText()

CHOOSE CASE li_oldindex
	CASE 1
		iw_window		= parent
		idw_datawindow	= tab_1.tabpage_2.dw_2
		
		li_rtn = f_save_before_search(iw_window, idw_datawindow)
	CASE 2
		iw_window		= parent
		idw_datawindow	= tab_1.tabpage_3.dw_3
		
		li_rtn = f_save_before_search(iw_window, idw_datawindow)
	CASE 3
		iw_window		= parent
		idw_datawindow	= tab_1.tabpage_4.dw_4
		
		li_rtn = f_save_before_search(iw_window, idw_datawindow)
	CASE 4
		iw_window		= parent
		idw_datawindow	= tab_1.tabpage_5.dw_5
		
		li_rtn = f_save_before_search(iw_window, idw_datawindow)
	CASE 5
		iw_window		= parent
		idw_datawindow	= tab_1.tabpage_6.dw_6
		
		li_rtn = f_save_before_search(iw_window, idw_datawindow)
	CASE 6
		iw_window		= parent
		idw_datawindow	= tab_1.tabpage_7.dw_7
		
		li_rtn = f_save_before_search(iw_window, idw_datawindow)
	CASE 7
		iw_window		= parent
		idw_datawindow	= tab_1.tabpage_8.dw_8
		
		li_rtn = f_save_before_search(iw_window, idw_datawindow)
END CHOOSE

if li_rtn = 1 then
	this.triggerevent("ue_save")
elseif li_rtn = 3 then
	return 
end if

ii_index	= newindex

CHOOSE CASE	ii_index		
	CASE 8
		//삭제는 비밀번호를 입력해야 가능
		//비밀번호는 시스템 날짜(달,일,년)
		
		ls_pass = dw_con.Object.password[1]
		
		if ls_pass = '' Or Isnull( ls_pass) then
			messagebox("확인","Password를 입력하세요.")
			return
		end if
		
		if string(f_sysdate(), 'MMDDYYYY') <> ls_pass then
			messagebox("오류","Password가 일치하지 않습니다.")
			dw_con.Object.password[1] = ''
			dw_con.setfocus()
		     dw_con.SetColumn("password")
			return
		end if
			
		
		dw_iljung.visible		= FALSE
		
		st_1.visible			= FALSE
		st_2.visible			= FALSE
		
		dw_dungrok.visible	= FALSE
		dw_sungjuk.visible	= FALSE
		
		//메뉴를 컨트롤한다.
//		wf_setmenu('RETRIEVE', 	TRUE)
//		wf_setmenu('INSERT', 	FALSE)
//		wf_setmenu('DELETE', 	TRUE)
//		wf_setmenu('SAVE', 		TRUE)
//		wf_setmenu('PRINT', 		FALSE)
         uc_delete.Enabled = True
		
	CASE 1 
		dw_iljung.visible		= TRUE
		
		st_1.visible			= TRUE
		st_2.visible			= TRUE
		
		dw_dungrok.reset()
		dw_sungjuk.reset()
		
		dw_dungrok.visible	= TRUE
		dw_sungjuk.visible	= TRUE
		
		//메뉴를 컨트롤한다.
//		wf_setmenu('RETRIEVE', 	TRUE)
//		wf_setmenu('INSERT', 	FALSE)
//		wf_setmenu('DELETE', 	FALSE)
//		wf_setmenu('SAVE', 		TRUE)
//		wf_setmenu('PRINT', 		FALSE)
         uc_delete.Enabled = False
		
	CASE 2 
		dw_iljung.visible		= TRUE
		
		st_1.visible			= TRUE
		st_2.visible			= FALSE
		
		dw_dungrok.reset()
		dw_sungjuk.reset()
		
		dw_dungrok.visible	= TRUE
		dw_sungjuk.visible	= FALSE
		
		//메뉴를 컨트롤한다.
//		wf_setmenu('RETRIEVE', 	TRUE)
//		wf_setmenu('INSERT', 	FALSE)
//		wf_setmenu('DELETE', 	FALSE)
//		wf_setmenu('SAVE', 		TRUE)
//		wf_setmenu('PRINT', 		FALSE)
         uc_delete.Enabled = False
		
	CASE 3 to 7 
		dw_iljung.visible		= TRUE
		
		st_1.visible			= TRUE
		st_2.visible			= TRUE
		
		dw_dungrok.reset()
		dw_sungjuk.reset()
		
		dw_dungrok.visible	= TRUE
		dw_sungjuk.visible	= TRUE
		
		//메뉴를 컨트롤한다.
//		wf_setmenu('RETRIEVE', 	TRUE)
//		wf_setmenu('INSERT', 	FALSE)
//		wf_setmenu('DELETE', 	FALSE)
//		wf_setmenu('SAVE', 		TRUE)
//		wf_setmenu('PRINT', 		FALSE)
         uc_delete.Enabled = False
		
END CHOOSE
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "휴 학"
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_huhak dw_huhak
dw_2 dw_2
end type

on tabpage_2.create
this.dw_huhak=create dw_huhak
this.dw_2=create dw_2
this.Control[]={this.dw_huhak,&
this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_huhak)
destroy(this.dw_2)
end on

type dw_huhak from uo_dwfree within tabpage_2
integer x = 1038
integer y = 12
integer width = 3287
integer height = 1096
integer taborder = 61
string dataobject = "d_hjk201q_2"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.settransobject(sqlca)
end event

type dw_2 from uo_dwfree within tabpage_2
integer y = 12
integer width = 1019
integer height = 1096
integer taborder = 61
string dataobject = "d_hjk202a_1"
boolean livescroll = false
end type

event constructor;call super::constructor;//This.Settransobject(sqlca)

func.of_design_dw(dw_2)


end event

event itemchanged;call super::itemchanged;string	ls_hakbun, ls_hakyun, ls_hakgi, ls_year, ls_tukgi, ls_ilja, ls_churiilja, ls_sangtae, &
			ls_sayu, ls_sayu1, ls_nyear, ls_nhakgi, ls_hakbun1, ls_wan, ls_byear, ls_chk
int 		li_row, li_ans, li_cnt, li_cnt1, li_row1

ls_year		= f_haksa_iljung_year()
ls_hakgi		= f_haksa_iljung_hakgi()

CHOOSE CASE	dwo.name
	CASE	"hakbun"
		
		SELECT	to_char(sysdate,'yyyymmdd') 
		INTO		:ls_churiilja
		FROM		dual;
		
		tab_1.tabpage_2.dw_2.accepttext()
		
		ls_hakbun	= data
		
		li_row		= tab_1.tabpage_2.dw_huhak.retrieve(ls_hakbun)

		if li_row = 0 then
			messagebox("입력오류","존재하지 않는 학번입니다."&
							+ "~n학번을 확인하세요!")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
		
		dw_dungrok.retrieve(ls_hakbun)
		dw_sungjuk.retrieve(ls_hakbun)		
		
      SELECT nvl(wan_yn, 'N')
		  INTO :ls_chk
		  FROM haksa.dungrok_gwanri
		 WHERE year    = :ls_year
		   AND hakgi   = :ls_hakgi
			AND hakbun  = :ls_hakbun;
		IF sqlca.sqlnrows = 0 THEN
			ls_chk         = 'N'
		END IF
		
		SELECT	COUNT(A.HAKBUN)
		INTO		:li_cnt1
		FROM		HAKSA.JAEHAK_HAKJUK A,
					HAKSA.HAKJUKBYENDONG B
		WHERE		A.HAKBUN 	= B.HAKBUN
		AND		A.HJMOD_ID 	= B.HJMOD_ID
		AND		A.HAKBUN		=	:ls_hakbun
		AND		B.HJMOD_SIJUM = :ls_churiilja
		;
		
		if li_cnt1 >= 1 then
			messagebox('확인',"오늘 학적변경된 학생입니다.")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
		
			str_parms str_balgup
			str_balgup.s[1] 	= ls_hakbun
			
			openwithparm(w_hjk202pp,str_balgup)
			
			ii_save_flag	= 0
			
			ls_hakyun   = dw_huhak.object.jaehak_hakjuk_su_hakyun[1]

			tab_1.tabpage_2.dw_2.setitem(row, "hjmod_id"		, 'B'			)
			tab_1.tabpage_2.dw_2.setitem(row, "hjmod_sijum"	, ls_churiilja	)
			tab_1.tabpage_2.dw_2.setitem(row, "year"			, ls_year	)
			tab_1.tabpage_2.dw_2.setitem(row, "su_hakyun"	, ls_hakyun	)
			tab_1.tabpage_2.dw_2.setitem(row, "hakgi"			, ls_hakgi	)
			tab_1.tabpage_2.dw_2.setitem(row, "jupsu_ilja"	, ls_churiilja	)
			
			tab_1.tabpage_2.dw_2.setitem(row, "jogi_test"	, 'N'	)
			tab_1.tabpage_2.dw_2.setitem(row, "sungjuk_injung"	, 'N'	)
			tab_1.tabpage_2.dw_2.setitem(row, "dungrok_injung"	, ls_chk	)
									
	CASE 	"sayu_id"
	
			ls_sayu	= data
			
			SELECT	JAEHAK_HAKJUK.HJMOD_SAYU_ID
			INTO		:ls_sayu1
			FROM		HAKSA.JAEHAK_HAKJUK  
			WHERE		JAEHAK_HAKJUK.HAKBUN	=	:ls_hakbun		
			;
		
		if sqlca.sqlcode = 0 then	
			if ls_sayu = ls_sayu1 then
				messagebox("확인","휴학한 사유가 동일합니다."&
								+"~휴학 사유를 확인하세요!")
				this.selecttext(3, len(this.gettext()))
				return 1
			end if
		end if
			
		if ls_sayu = 'B13' then
			
			ls_byear = string(long(ls_year) + 3, '0000')
			tab_1.tabpage_2.dw_2.setitem(row, "bokhak_year"	, ls_byear	)
			tab_1.tabpage_2.dw_2.setitem(row, "bokhak_hakgi"	, ls_hakgi	)
		else
			ls_byear = string(long(ls_year) + 1, '0000')
			tab_1.tabpage_2.dw_2.setitem(row, "bokhak_year"	, ls_byear	)
			tab_1.tabpage_2.dw_2.setitem(row, "bokhak_hakgi"	, ls_hakgi	)
		end if
		
	CASE	"hjmod_sijum"
		
		tab_1.tabpage_2.dw_2.accepttext()
		
		if dw_huhak.Find("hakjukbyendong_hjmod_sijum = '" + data + "'" , &
				1, dw_huhak.RowCount()) > 0 then
			MessageBox("입력오류", "해당일자에 학적변동을 하였습니다.")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
				
		//3분의 2선 전에 휴학자의 성적 인정구분 Setting
		SELECT	SUUP2_3,
					NEXT_YEAR,
					NEXT_HAKGI
		INTO		:ls_ilja,
					:ls_nyear,
					:ls_nhakgi
		FROM		HAKSA.HAKSA_ILJUNG
		WHERE		SIJUM_FLAG = 'Y'
		;
		
		if ls_ilja > data then
			tab_1.tabpage_2.dw_2.setitem(row, "sungjuk_injung", 'N')
			//등록금을 낸 휴학자의 등록금 인정구분 Setting
			tab_1.tabpage_2.dw_2.setitem(row, "dungrok_injung", 'Y')
		else
			//등록금을 낸 휴학자의 등록금 잔여구분 Setting
			SELECT 	HAKBUN,
						MAX(WAN_YN)
			INTO 		:ls_hakbun1,
						:ls_wan
			FROM		HAKSA.DUNGROK_GWANRI
			WHERE		YEAR	= :ls_nyear
			AND		HAKGI = :ls_nhakgi
			AND		HAKBUN = :ls_hakbun
			GROUP BY HAKBUN
			;
			
			if sqlca.sqlcode = 0 and ls_wan = 'Y' then
				tab_1.tabpage_2.dw_2.setitem(row, "year"			, ls_nyear	)
				tab_1.tabpage_2.dw_2.setitem(row, "hakgi"			, ls_nhakgi	)
				tab_1.tabpage_2.dw_2.setitem(row, "sungjuk_injung", 'N')
				tab_1.tabpage_2.dw_2.setitem(row, "dungrok_injung", 'Y')	
			elseif sqlca.sqlcode = 0 and ls_wan = 'N' then
				tab_1.tabpage_2.dw_2.setitem(row, "sungjuk_injung", 'Y')
				tab_1.tabpage_2.dw_2.setitem(row, "dungrok_injung", 'N')
			else
				tab_1.tabpage_2.dw_2.setitem(row, "sungjuk_injung", 'Y')
				tab_1.tabpage_2.dw_2.setitem(row, "dungrok_injung", 'N')
			end if
		end if				
		
END CHOOSE
end event

event itemerror;call super::itemerror;return 2
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "복 학"
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_zip_gain dw_zip_gain
dw_bokhak dw_bokhak
dw_3 dw_3
st_7 st_7
end type

on tabpage_3.create
this.dw_zip_gain=create dw_zip_gain
this.dw_bokhak=create dw_bokhak
this.dw_3=create dw_3
this.st_7=create st_7
this.Control[]={this.dw_zip_gain,&
this.dw_bokhak,&
this.dw_3,&
this.st_7}
end on

on tabpage_3.destroy
destroy(this.dw_zip_gain)
destroy(this.dw_bokhak)
destroy(this.dw_3)
destroy(this.st_7)
end on

type dw_zip_gain from uo_dwfree within tabpage_3
integer x = 2263
integer y = 1204
integer width = 2066
integer height = 624
integer taborder = 21
string dataobject = "d_hjk203a_2"
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;string	ls_param		,&
			ls_zip_id	,&
			ls_addr
blob		b_total_pic	,&
			b_pic
int		li_ans		,&
			li_rtn		,&
			li_filenum	,&
			li_len
string 	ls_path		,&
			ls_filename	,&
			ls_extension,&
			ls_filter
long 		ll_filelen	,&
			ll_loop		,&
			ll_count
CHOOSE CASE dwo.name
			
	CASE	'b_1'
		Open(w_zipcode)
		
		ls_param	= Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		dw_zip_gain.setitem(row, "zip_id"	, ls_zip_id)
		dw_zip_gain.setitem(row, "addr"	, ls_addr)
		
		dw_zip_gain.setcolumn("addr")
		//Keyboard입력을 동적으로 사용(글로벌함수)
		//SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"
//		Keybd_event( 35, 1, 0, 0 ) //End Key를 친것과 같음..커서를 주소 맨 마지막에 보낼려고
		
	CASE 'b_2'
		Open(w_zipcode)
		
		ls_param	= Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		dw_zip_gain.setitem(row, "bo_zip_id"	, ls_zip_id)
		dw_zip_gain.setitem(row, "bo_addr"	, ls_addr)
		
		dw_zip_gain.setcolumn("bo_addr")
		//Keyboard입력을 동적으로 사용(글로벌함수)
		//SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"
//		Keybd_event( 35, 1, 0, 0 ) //End Key를 친것과 같음..커서를 주소 맨 마지막에 보낼려고
END CHOOSE
								
end event

event constructor;call super::constructor;This.Settransobject(sqlca)

func.of_design_dw(dw_zip_gain)
end event

type dw_bokhak from uo_dwfree within tabpage_3
integer x = 1038
integer y = 12
integer width = 3291
integer height = 1092
integer taborder = 21
string dataobject = "d_hjk201q_2"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.Settransobject(sqlca)
end event

type dw_3 from uo_dwfree within tabpage_3
integer y = 12
integer width = 1019
integer height = 1092
integer taborder = 21
string dataobject = "d_hjk203a_1"
boolean livescroll = false
end type

event constructor;call super::constructor;//This.Settransobject(sqlca)

func.of_design_dw(dw_3)


end event

event itemchanged;call super::itemchanged;string	ls_hakbun, ls_year, ls_sangtae, ls_bokhak_hakyun, ls_bokhak_hakgi, ls_churiilja,&
			ls_syn, ls_dyn, ls_iyn
int 		li_row, li_ans, li_hakjum, li_cnt1
String   ls_gwa, ls_hakyun

CHOOSE CASE	dwo.name
		
	CASE	"hakbun"
		
		SELECT	to_char(sysdate,'yyyymmdd') 
		INTO		:ls_churiilja
		FROM		dual;
		
		tab_1.tabpage_3.dw_3.accepttext()
		
		ls_hakbun	= data
		
		li_row		= tab_1.tabpage_3.dw_bokhak.retrieve(ls_hakbun)
		
		if li_row = 0 then
			messagebox("입력오류","존재하지 않는 학번입니다."&
							+ "~n학번을 확인하세요!")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
		
		dw_dungrok.retrieve(ls_hakbun)
		dw_sungjuk.retrieve(ls_hakbun)
		
		SELECT	COUNT(A.HAKBUN)
		INTO		:li_cnt1
		FROM		HAKSA.JAEHAK_HAKJUK A,
					HAKSA.HAKJUKBYENDONG B
		WHERE		A.HAKBUN 	= B.HAKBUN
		AND		A.HJMOD_ID 	= B.HJMOD_ID
		AND		A.HAKBUN		=	:ls_hakbun
		AND		B.HJMOD_SIJUM = :ls_churiilja
		;
		
		if li_cnt1 >= 1 then
			messagebox('확인',"오늘 변동처리된 학생입니다.")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
		
		li_ans = tab_1.tabpage_3.dw_zip_gain.retrieve(ls_hakbun)
		
		if li_ans > 0 then
			messagebox("주소확인","주소를 확인하여 주십시요!")
			tab_1.tabpage_3.dw_zip_gain.setfocus()
		end if

		SELECT	A.SANGTAE
		INTO		:ls_sangtae
		FROM		HAKSA.JAEHAK_HAKJUK A
		WHERE		A.HAKBUN	=	:ls_hakbun
		;	
		
		if ls_sangtae <> '02' then
			messagebox("확인","휴학생이 아닙니다."&
							+"~학번을 확인하세요!")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if	
		
		ii_save_flag	= 0
		
		ls_year				= f_haksa_iljung_year()
		ls_bokhak_hakgi 	= f_haksa_iljung_hakgi()
		ls_bokhak_hakyun   = dw_bokhak.object.jaehak_hakjuk_su_hakyun[1]
		
		tab_1.tabpage_3.dw_3.setitem(row, "hjmod_id"				, 'C'						)
		tab_1.tabpage_3.dw_3.setitem(row, "hjmod_sijum"			, ls_churiilja			)
		tab_1.tabpage_3.dw_3.setitem(row, "year"					, ls_year				)
		tab_1.tabpage_3.dw_3.setitem(row, "su_hakyun"			, ls_bokhak_hakyun	)
		tab_1.tabpage_3.dw_3.setitem(row, "hakgi"					, ls_bokhak_hakgi	)
		tab_1.tabpage_3.dw_3.setitem(row, "jupsu_ilja"			, ls_churiilja			)
		
		SELECT gwa
		  INTO :ls_gwa
		  FROM haksa.jaehak_hakjuk
		 WHERE hakbun      = :ls_hakbun;
//		tab_1.tabpage_3.dw_3.SetItem(row, 'before_gwa', ls_gwa)
		ls_gwa   = uf_hakgwa_chk(ls_year, ls_hakbun, ls_bokhak_hakyun)
		dw_bokhak.object.jaehak_hakjuk_gwa[1] = ls_gwa

	CASE	"hjmod_sijum"
		
		tab_1.tabpage_3.dw_3.accepttext()
		
		if dw_bokhak.Find("hakjukbyendong_hjmod_sijum = '" + data + "'" , &
				1, dw_bokhak.RowCount()) > 0 then
			MessageBox("입력오류", "해당일자에 학적변동을 하였습니다.")
			this.selecttext(4, len(this.gettext()))
			return 1
		end if
	CASE 'year'
		ls_hakbun   = tab_1.tabpage_3.dw_3.GetItemString(row, 'hakbun')
		ls_year     = data
		ls_hakyun   = tab_1.tabpage_3.dw_3.GetItemString(row, 'su_hakyun')
		SELECT gwa
		  INTO :ls_gwa
		  FROM haksa.jaehak_hakjuk
		 WHERE hakbun      = :ls_hakbun;
//		tab_1.tabpage_3.dw_3.SetItem(row, 'before_gwa', ls_gwa)
		ls_gwa   = uf_hakgwa_chk(ls_year, ls_hakbun, ls_hakyun)
		dw_bokhak.object.jaehak_hakjuk_gwa[1] = ls_gwa
	CASE 'su_hakyun'
		ls_hakbun   = tab_1.tabpage_3.dw_3.GetItemString(row, 'hakbun')
		ls_year     = tab_1.tabpage_3.dw_3.GetItemString(row, 'year')
		ls_hakyun   = data
		SELECT gwa
		  INTO :ls_gwa
		  FROM haksa.jaehak_hakjuk
		 WHERE hakbun      = :ls_hakbun;
//		tab_1.tabpage_3.dw_3.SetItem(row, 'before_gwa', ls_gwa)
		ls_gwa   = uf_hakgwa_chk(ls_year, ls_hakbun, ls_hakyun)
		dw_bokhak.object.jaehak_hakjuk_gwa[1] = ls_gwa
END CHOOSE
end event

event itemerror;call super::itemerror;return 2
end event

type st_7 from statictext within tabpage_3
integer x = 2263
integer y = 1124
integer width = 2066
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 8388736
string text = "주소변경"
boolean border = true
boolean focusrectangle = false
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "제 적"
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_jaejuk dw_jaejuk
dw_4 dw_4
end type

on tabpage_4.create
this.dw_jaejuk=create dw_jaejuk
this.dw_4=create dw_4
this.Control[]={this.dw_jaejuk,&
this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_jaejuk)
destroy(this.dw_4)
end on

type dw_jaejuk from uo_dwfree within tabpage_4
integer x = 1038
integer y = 12
integer width = 3291
integer height = 1096
integer taborder = 30
string dataobject = "d_hjk201q_2"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.Settransobject(sqlca)
end event

type dw_4 from uo_dwfree within tabpage_4
integer y = 12
integer width = 1019
integer height = 1096
integer taborder = 21
string dataobject = "d_hjk204a_1"
boolean livescroll = false
end type

event constructor;call super::constructor;//This.Settransobject(sqlca)

func.of_design_dw(dw_4)


end event

event itemchanged;call super::itemchanged;string	ls_hakbun	,&
			ls_hakyun	,&
			ls_hakgi		,&
			ls_year		,&
			ls_ilja		,&
			ls_churiilja
int 		li_row, li_cnt1

CHOOSE CASE	dwo.name
	CASE	"hakbun"
		
		SELECT	to_char(sysdate,'yyyymmdd') 
		INTO		:ls_churiilja
		FROM		dual;
		
		tab_1.tabpage_4.dw_4.accepttext()
		
		ls_hakbun	= tab_1.tabpage_4.dw_4.getitemstring(row, "hakbun")
		
		li_row		= tab_1.tabpage_4.dw_jaejuk.retrieve(ls_hakbun)
		
		if li_row = 0 then
			messagebox("입력오류","존재하지 않는 학번입니다."&
							+ "~n학번을 확인하세요!")
			this.selecttext(1, len(this.gettext()))				
			return 1
		end if
		
		dw_dungrok.retrieve(ls_hakbun)
		dw_sungjuk.retrieve(ls_hakbun)
		
		SELECT	COUNT(A.HAKBUN)
		INTO		:li_cnt1
		FROM		HAKSA.JAEHAK_HAKJUK A,
					HAKSA.HAKJUKBYENDONG B
		WHERE		A.HAKBUN 	= B.HAKBUN
		AND		A.HJMOD_ID 	= B.HJMOD_ID
		AND		A.HAKBUN		=	:ls_hakbun
		AND		B.HJMOD_SIJUM = :ls_churiilja
		;
		
		if li_cnt1 >= 1 then
			messagebox('확인',"오늘 변동처리된 학생입니다.")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
		
		str_parms str_balgup
		str_balgup.s[1] 	= ls_hakbun
		
		openwithparm(w_hjk202pp,str_balgup)
		
		SELECT	JAEHAK_HAKJUK.SU_HAKYUN	 
		INTO		:ls_hakyun 
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE		JAEHAK_HAKJUK.HAKBUN	=	:ls_hakbun
		;
		
		if sqlca.sqlcode = 0 then
			
			ii_save_flag	= 0
			
			ls_year	= f_haksa_iljung_year()
			ls_hakgi	= f_haksa_iljung_hakgi()
			
			tab_1.tabpage_4.dw_4.setitem(row, "hjmod_id"		, 'D'			)
			tab_1.tabpage_4.dw_4.setitem(row, "hjmod_sijum"	, ls_churiilja	)
			tab_1.tabpage_4.dw_4.setitem(row, "year"			, ls_year	)
			tab_1.tabpage_4.dw_4.setitem(row, "su_hakyun"	, ls_hakyun	)
			tab_1.tabpage_4.dw_4.setitem(row, "hakgi"			, ls_hakgi	)
			tab_1.tabpage_4.dw_4.setitem(row, "jupsu_ilja"	, ls_churiilja	)
			
			tab_1.tabpage_4.dw_4.setitem(row, "jogi_test"	, 'N'	)
			tab_1.tabpage_4.dw_4.setitem(row, "sungjuk_injung"	, 'N'	)
			tab_1.tabpage_4.dw_4.setitem(row, "dungrok_injung"	, 'N'	)
			
		else
			messagebox("조회실패", "학적 조회 실패!")
			return 1
		end if
		
	CASE	"hjmod_sijum"
		
		tab_1.tabpage_4.dw_4.accepttext()
		
		if dw_jaejuk.Find("hakjukbyendong_hjmod_sijum = '" + data + "'" , &
				1, dw_jaejuk.RowCount()) > 0 then
			MessageBox("입력오류", "해당일자에 학적변동을 하였습니다.")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
		
		//3분의 2선 전에 제적자의 성적 인정구분 Setting
		SELECT	SUUP2_3
		INTO		:ls_ilja
		FROM		HAKSA.HAKSA_ILJUNG
		WHERE		SIJUM_FLAG = 'Y'
		;
				
		if ls_ilja > data then
			tab_1.tabpage_4.dw_4.setitem(row, "sungjuk_injung", 'N')
		else
			tab_1.tabpage_4.dw_4.setitem(row, "sungjuk_injung", 'Y')
		end if
		
	Case 'sayu_id'
		If data <> 'D19' Then
			This.Post SetITem( row, "drop_cd", "")
			This.Post SetITem( row, "drop_remark", "")
		End If
			
END CHOOSE
end event

event itemerror;call super::itemerror;return 2
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "퇴 학"
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_taehak dw_taehak
dw_5 dw_5
end type

on tabpage_5.create
this.dw_taehak=create dw_taehak
this.dw_5=create dw_5
this.Control[]={this.dw_taehak,&
this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_taehak)
destroy(this.dw_5)
end on

type dw_taehak from uo_dwfree within tabpage_5
integer x = 1038
integer y = 12
integer width = 3287
integer height = 1092
integer taborder = 21
string dataobject = "d_hjk201q_2"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.Settransobject(sqlca)
end event

type dw_5 from uo_dwfree within tabpage_5
integer y = 12
integer width = 1019
integer height = 1092
integer taborder = 21
string dataobject = "d_hjk205a_1"
boolean livescroll = false
end type

event constructor;call super::constructor;//This.Settransobject(sqlca)

func.of_design_dw(dw_5)


end event

event itemchanged;call super::itemchanged;string	ls_hakbun	,&
			ls_hakyun	,&
			ls_hakgi		,&
			ls_year		,&
			ls_ilja		,&
			ls_churiilja
int 		li_row

CHOOSE CASE	dwo.name
	CASE	"hakbun"
		
		SELECT	to_char(sysdate,'yyyymmdd') 
		INTO		:ls_churiilja
		FROM		dual;
		
		tab_1.tabpage_5.dw_5.accepttext()
		
		ls_hakbun	= tab_1.tabpage_5.dw_5.getitemstring(row, "hakbun")
		
		li_row		= tab_1.tabpage_5.dw_taehak.retrieve(ls_hakbun)
		
		if li_row = 0 then
			messagebox("입력오류","존재하지 않는 학번입니다."&
							+ "~n학번을 확인하세요!")
			this.selecttext(1, len(this.gettext()))				
			return 1
		end if
		
		str_parms str_balgup
		str_balgup.s[1] 	= ls_hakbun
		
		openwithparm(w_hjk202pp,str_balgup)	
		
		dw_dungrok.retrieve(ls_hakbun)
		dw_sungjuk.retrieve(ls_hakbun)
		
		SELECT	JAEHAK_HAKJUK.SU_HAKYUN	
		INTO		:ls_hakyun
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE		JAEHAK_HAKJUK.HAKBUN	=	:ls_hakbun
		;
		
		if sqlca.sqlcode = 0 then
			
			ii_save_flag	= 0
			
			ls_year	= f_haksa_iljung_year()
			ls_hakgi = f_haksa_iljung_hakgi()
			
			tab_1.tabpage_5.dw_5.setitem(row, "hjmod_id"		, 'E'			)
			tab_1.tabpage_5.dw_5.setitem(row, "hjmod_sijum"	, ls_churiilja	)
			tab_1.tabpage_5.dw_5.setitem(row, "year"			, ls_year	)
			tab_1.tabpage_5.dw_5.setitem(row, "su_hakyun"	, ls_hakyun	)
			tab_1.tabpage_5.dw_5.setitem(row, "hakgi"			, ls_hakgi	)
			tab_1.tabpage_5.dw_5.setitem(row, "jupsu_ilja"	, ls_churiilja	)
			
			tab_1.tabpage_5.dw_5.setitem(row, "jogi_test"	, 'N'	)
			tab_1.tabpage_5.dw_5.setitem(row, "sungjuk_injung"	, 'N'	)
			tab_1.tabpage_5.dw_5.setitem(row, "dungrok_injung"	, 'N'	)
			
		else
			messagebox("조회실패", "학적 조회 실패!")
			return 1
		end if
		
	CASE	"hjmod_sijum"
		
		tab_1.tabpage_5.dw_5.accepttext()
		
		if dw_taehak.Find("hakjukbyendong_hjmod_sijum = '" + data + "'" , &
				1, dw_taehak.RowCount()) > 0 then
			MessageBox("입력오류", "해당일자에 학적변동을 하였습니다.")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
		
		//3분의 2선 전에 퇴학자의 성적 인정구분 Setting
		SELECT	SUUP2_3
		INTO		:ls_ilja
		FROM		HAKSA.HAKSA_ILJUNG
		WHERE		SIJUM_FLAG = 'Y'
		;
		
		if ls_ilja > data then
			tab_1.tabpage_5.dw_5.setitem(row, "sungjuk_injung", '0')
		else
			tab_1.tabpage_5.dw_5.setitem(row, "sungjuk_injung", '1')
		end if	
		
END CHOOSE
end event

event itemerror;call super::itemerror;return 2
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "전 과"
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_jungwa dw_jungwa
dw_6 dw_6
end type

on tabpage_6.create
this.dw_jungwa=create dw_jungwa
this.dw_6=create dw_6
this.Control[]={this.dw_jungwa,&
this.dw_6}
end on

on tabpage_6.destroy
destroy(this.dw_jungwa)
destroy(this.dw_6)
end on

type dw_jungwa from uo_dwfree within tabpage_6
integer x = 1042
integer y = 12
integer width = 3287
integer height = 1096
integer taborder = 61
string dataobject = "d_hjk201q_2"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.Settransobject(sqlca)
end event

type dw_6 from uo_dwfree within tabpage_6
integer y = 12
integer width = 1019
integer height = 1096
integer taborder = 21
string dataobject = "d_hjk206a_1"
boolean livescroll = false
end type

event constructor;call super::constructor;//This.Settransobject(sqlca)

func.of_design_dw(dw_6)

end event

event itemchanged;call super::itemchanged;string	ls_hakbun	,&
			ls_hakyun	,&
			ls_hakgi		,&
			ls_year		,&
			ls_hakgwa	,&
			ls_churiilja,&
			ls_ilja
int 		li_row

CHOOSE CASE	dwo.name
	CASE	"hakbun"
		
		SELECT	to_char(sysdate,'yyyymmdd') 
		INTO		:ls_churiilja
		FROM		dual;
		
		tab_1.tabpage_6.dw_6.accepttext()
		
		ls_hakbun	= tab_1.tabpage_6.dw_6.getitemstring(row, "hakbun")
		
		li_row		= tab_1.tabpage_6.dw_jungwa.retrieve(ls_hakbun)
		
		if li_row = 0 then
			messagebox("입력오류","존재하지 않는 학번입니다."&
							+ "~n학번을 확인하세요!")
			this.selecttext(1, len(this.gettext()))							
			return 1
		end if
		
		dw_dungrok.retrieve(ls_hakbun)
		dw_sungjuk.retrieve(ls_hakbun)
		
		SELECT	JAEHAK_HAKJUK.SU_HAKYUN	
		INTO		:ls_hakyun	
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE		JAEHAK_HAKJUK.HAKBUN	=	:ls_hakbun
		;
		
		if sqlca.sqlcode = 0 then
			
			ii_save_flag	= 0
			
			ls_year	= f_haksa_iljung_year()
			ls_hakgi	= f_haksa_iljung_hakgi()
			
			tab_1.tabpage_6.dw_6.setitem(row, "hjmod_id"			, 'F'			)
			tab_1.tabpage_6.dw_6.setitem(row, "hjmod_sijum"		, ls_churiilja	)
			tab_1.tabpage_6.dw_6.setitem(row, "year"				, ls_year	)
			tab_1.tabpage_6.dw_6.setitem(row, "su_hakyun"		, ls_hakyun	)
			tab_1.tabpage_6.dw_6.setitem(row, "hakgi"				, ls_hakgi	)
			tab_1.tabpage_6.dw_6.setitem(row, "jupsu_ilja"		, ls_churiilja	)
			
		else
			messagebox("조회실패", "학적 조회 실패!")
			return 1
		end if
		
	CASE "gwa"
		
		tab_1.tabpage_6.dw_6.accepttext()
		
		ls_hakgwa = dw_jungwa.object.jaehak_hakjuk_gwa[1]
		tab_1.tabpage_6.dw_6.setitem(row, "before_gwa", ls_hakgwa)
		
	CASE	"hjmod_sijum"
		
		tab_1.tabpage_6.dw_6.accepttext()
		
		if dw_jungwa.Find("hakjukbyendong_hjmod_sijum = '" + data + "'" , &
				1, dw_jungwa.RowCount()) > 0 then
			MessageBox("입력오류", "해당일자에 학적변동을 하였습니다.")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
		
		//3분의 2선 전에 전과자의 성적 인정구분 Setting
		SELECT	SUUP2_3
		INTO		:ls_ilja
		FROM		HAKSA.HAKSA_ILJUNG
		WHERE		SIJUM_FLAG = 'Y'
		;
		
		if ls_ilja > data then
			tab_1.tabpage_6.dw_6.setitem(row, "sungjuk_injung", '0')
		else
			tab_1.tabpage_6.dw_6.setitem(row, "sungjuk_injung", '1')
		end if			
		
END CHOOSE
end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "교 환"
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_gyohwan dw_gyohwan
dw_7 dw_7
end type

on tabpage_7.create
this.dw_gyohwan=create dw_gyohwan
this.dw_7=create dw_7
this.Control[]={this.dw_gyohwan,&
this.dw_7}
end on

on tabpage_7.destroy
destroy(this.dw_gyohwan)
destroy(this.dw_7)
end on

type dw_gyohwan from uo_dwfree within tabpage_7
integer x = 1042
integer y = 12
integer width = 3287
integer height = 1096
integer taborder = 71
string dataobject = "d_hjk201q_2"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.Settransobject(sqlca)
end event

type dw_7 from uo_dwfree within tabpage_7
integer y = 12
integer width = 1019
integer height = 1096
integer taborder = 71
string dataobject = "d_hjk207a_1"
boolean livescroll = false
end type

event constructor;call super::constructor;//This.Settransobject(sqlca)

func.of_design_dw(dw_7)
	
end event

event itemchanged;call super::itemchanged;string	ls_hakbun	,&
			ls_hakyun	,&
			ls_hakgi		,&
			ls_year		,&
			ls_churiilja,&
			ls_ilja
int 		li_row

CHOOSE CASE	dwo.name
	CASE	"hakbun"
		
		SELECT	to_char(sysdate,'yyyymmdd') 
		INTO		:ls_churiilja
		FROM		dual;
		
		tab_1.tabpage_7.dw_7.accepttext()
		
		ls_hakbun	= tab_1.tabpage_7.dw_7.getitemstring(row, "hakbun")
		
		li_row		= tab_1.tabpage_7.dw_gyohwan.retrieve(ls_hakbun)
		
		if li_row = 0 then
			messagebox("입력오류","존재하지 않는 학번입니다."&
							+ "~n학번을 확인하세요!")
			this.selecttext(1, len(this.gettext()))							
			return 1
		end if
		
		dw_dungrok.retrieve(ls_hakbun)
		dw_sungjuk.retrieve(ls_hakbun)
		
		SELECT	JAEHAK_HAKJUK.SU_HAKYUN 
		INTO		:ls_hakyun	 
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE		JAEHAK_HAKJUK.HAKBUN	=	:ls_hakbun
		;
		
		if sqlca.sqlcode = 0 then
			
			ii_save_flag	= 0
			
			ls_year	= f_haksa_iljung_year()
			ls_hakgi = f_haksa_iljung_hakgi()
			
			tab_1.tabpage_7.dw_7.setitem(row, "hjmod_id"		, 'H'				)
			tab_1.tabpage_7.dw_7.setitem(row, "hjmod_sijum"	, ls_churiilja	)
			tab_1.tabpage_7.dw_7.setitem(row, "year"			, ls_year		)
			tab_1.tabpage_7.dw_7.setitem(row, "su_hakyun"	, ls_hakyun		)
			tab_1.tabpage_7.dw_7.setitem(row, "hakgi"			, ls_hakgi		)
			tab_1.tabpage_7.dw_7.setitem(row, "jupsu_ilja"	, ls_churiilja	)		
		
		else
			messagebox("조회실패", "학적 조회 실패!")
			return 1
		end if
		
	CASE	"hjmod_sijum"
		
		tab_1.tabpage_7.dw_7.accepttext()
		
		if dw_gyohwan.Find("hakjukbyendong_hjmod_sijum = '" + data + "'" , &
				1, dw_gyohwan.RowCount()) > 0 then
			MessageBox("입력오류", "해당일자에 학적변동을 하였습니다.")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
		
		//3분의 2선 전에 교환학생의 성적 인정구분 Setting
		SELECT	SUUP2_3
		INTO		:ls_ilja
		FROM		HAKSA.HAKSA_ILJUNG
		WHERE		SIJUM_FLAG = 'Y'
		;
		
		if ls_ilja > data then
			tab_1.tabpage_7.dw_7.setitem(row, "sungjuk_injung", '0')
		else
			tab_1.tabpage_7.dw_7.setitem(row, "sungjuk_injung", '1')
		end if			
		
END CHOOSE
end event

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "재입학"
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_jaeiphak dw_jaeiphak
dw_8 dw_8
end type

on tabpage_8.create
this.dw_jaeiphak=create dw_jaeiphak
this.dw_8=create dw_8
this.Control[]={this.dw_jaeiphak,&
this.dw_8}
end on

on tabpage_8.destroy
destroy(this.dw_jaeiphak)
destroy(this.dw_8)
end on

type dw_jaeiphak from uo_dwfree within tabpage_8
integer x = 1042
integer y = 12
integer width = 3287
integer height = 1096
integer taborder = 61
string dataobject = "d_hjk201q_2"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.Settransobject(sqlca)
end event

type dw_8 from uo_dwfree within tabpage_8
integer y = 12
integer width = 1019
integer height = 1096
integer taborder = 71
string dataobject = "d_hjk208a_1"
boolean livescroll = false
end type

event constructor;call super::constructor;//This.Settransobject(sqlca)

func.of_design_dw(dw_8)
			
end event

event itemchanged;call super::itemchanged;string	ls_hakbun			,&
			ls_year				,&
			ls_jaeiphak_hakyun	,&
			ls_jaeiphak_hakgi		,&
			ls_sangtae			,&
			ls_churiilja
int 		li_row
String   ls_hakyun, ls_gwa

CHOOSE CASE	dwo.name
	CASE	"hakbun"
		
		SELECT	to_char(sysdate,'yyyymmdd') 
		INTO		:ls_churiilja
		FROM		dual;
		
		tab_1.tabpage_8.dw_8.accepttext()
		
		ls_hakbun	= tab_1.tabpage_8.dw_8.getitemstring(row, "hakbun")
		
		li_row		= tab_1.tabpage_8.dw_jaeiphak.retrieve(ls_hakbun)
		
		if li_row = 0 then
			messagebox("입력오류","존재하지 않는 학번입니다."&
							+ "~n학번을 확인하세요!")
			this.selecttext(1, len(this.gettext()))							
			return 1
		end if
		
		dw_dungrok.retrieve(ls_hakbun)
		dw_sungjuk.retrieve(ls_hakbun)
		
		SELECT	JAEHAK_HAKJUK.SANGTAE
		INTO		:ls_sangtae 
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE		JAEHAK_HAKJUK.HAKBUN	=	:ls_hakbun
		;
		
		if sqlca.sqlcode = 0 then	
			if ls_sangtae <> '03' then
				messagebox("확인","제적생이 아닙니다."&
								+"~학번을 확인하세요!")
				this.selecttext(1, len(this.gettext()))								
				return 1 
			end if
		
			ii_save_flag	= 0
					
			ls_year	= f_haksa_iljung_year()			
			ls_jaeiphak_hakgi		= f_haksa_iljung_hakgi()

			tab_1.tabpage_8.dw_8.setitem(row, "hjmod_id"		, 'I'							)
			tab_1.tabpage_8.dw_8.setitem(row, "hjmod_sijum"	, ls_churiilja				)
			tab_1.tabpage_8.dw_8.setitem(row, "year"			, ls_year					)
			tab_1.tabpage_8.dw_8.setitem(row, "su_hakyun"	, ''							)
			tab_1.tabpage_8.dw_8.setitem(row, "hakgi"			, ls_jaeiphak_hakgi		)
			tab_1.tabpage_8.dw_8.setitem(row, "jupsu_ilja"	, ls_churiilja				)
			
		else
			messagebox("조회실패", "학적조회 실패!")
			return 1
		end if
		
	CASE	"hjmod_sijum"
		
		tab_1.tabpage_8.dw_8.accepttext()		
		
		if dw_jaeiphak.Find("hakjukbyendong_hjmod_sijum = '" + data + "'" , &
				1, dw_jaeiphak.RowCount()) > 0 then
			MessageBox("입력오류", "해당일자에 학적변동을 하였습니다.")
			this.selecttext(1, len(this.gettext()))
			return 1
		end if
	CASE 'year'
		ls_hakbun   = tab_1.tabpage_8.dw_8.GetItemString(row, 'hakbun')
		ls_year     = data
		ls_hakyun   = tab_1.tabpage_8.dw_8.GetItemString(row, 'su_hakyun')
		SELECT gwa
		  INTO :ls_gwa
		  FROM haksa.jaehak_hakjuk
		 WHERE hakbun      = :ls_hakbun;
		tab_1.tabpage_8.dw_8.SetItem(row, 'before_gwa', ls_gwa)
		ls_gwa   = uf_hakgwa_chk(ls_year, ls_hakbun, ls_hakyun)
		dw_jaeiphak.object.jaehak_hakjuk_gwa[1] = ls_gwa
	CASE 'su_hakyun'
		ls_hakbun   = tab_1.tabpage_8.dw_8.GetItemString(row, 'hakbun')
		ls_year     = tab_1.tabpage_8.dw_8.GetItemString(row, 'year')
		ls_hakyun   = data
		SELECT gwa
		  INTO :ls_gwa
		  FROM haksa.jaehak_hakjuk
		 WHERE hakbun      = :ls_hakbun;
		tab_1.tabpage_8.dw_8.SetItem(row, 'before_gwa', ls_gwa)
		ls_gwa   = uf_hakgwa_chk(ls_year, ls_hakbun, ls_hakyun)
		dw_jaeiphak.object.jaehak_hakjuk_gwa[1] = ls_gwa
END CHOOSE
end event

event itemerror;call super::itemerror;return 2
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "변동내역삭제"
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from uo_dwfree within tabpage_1
integer x = 5
integer y = 8
integer width = 4325
integer height = 1784
integer taborder = 30
string dataobject = "d_hjk201a_1"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.Settransobject(sqlca)
end event

type st_1 from statictext within w_hjk201a
integer x = 59
integer y = 1540
integer width = 2254
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 8388736
string text = "등록내역"
boolean border = true
boolean focusrectangle = false
end type

type dw_dungrok from uo_input_dwc within w_hjk201a
integer x = 59
integer y = 1616
integer width = 2254
integer height = 628
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_hjk210p_1"
boolean border = true
end type

type dw_sungjuk from uo_input_dwc within w_hjk201a
boolean visible = false
integer x = 2331
integer y = 1616
integer width = 2066
integer height = 628
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_hjk210p_2"
boolean border = true
end type

type st_2 from statictext within w_hjk201a
boolean visible = false
integer x = 2331
integer y = 1540
integer width = 2066
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 8388736
string text = "성적내역"
boolean border = true
boolean focusrectangle = false
end type

type dw_iljung from uo_dddw_dwc within w_hjk201a
boolean visible = false
integer x = 50
integer y = 84
integer width = 3095
integer height = 200
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjk201q_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.retrieve()
end event

type dw_con from uo_dwfree within w_hjk201a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 30
string dataobject = "d_hjk201a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjk201a
event destroy ( )
boolean visible = false
integer x = 3616
integer y = 312
integer width = 599
integer taborder = 30
boolean bringtotop = true
string btnname = "학사제적처리"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;open(w_hjk201pp)
end event

type uo_2 from u_tab within w_hjk201a
integer x = 425
integer y = 268
integer height = 160
integer taborder = 30
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_2.destroy
call u_tab::destroy
end on

