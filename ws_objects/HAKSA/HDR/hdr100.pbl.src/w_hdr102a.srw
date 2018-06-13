$PBExportHeader$w_hdr102a.srw
$PBExportComments$[청운대]복학생등록금생성관리
forward
global type w_hdr102a from w_condition_window
end type
type dw_con from uo_dwfree within w_hdr102a
end type
type uo_1 from uo_imgbtn within w_hdr102a
end type
type dw_main from uo_dwfree within w_hdr102a
end type
end forward

global type w_hdr102a from w_condition_window
dw_con dw_con
uo_1 uo_1
dw_main dw_main
end type
global w_hdr102a w_hdr102a

on w_hdr102a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.uo_1=create uo_1
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_main
end on

on w_hdr102a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.dw_main)
end on

event ue_retrieve;string ls_year, ls_hakgi, ls_hakbun
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun   	=	func.of_nvl(dw_con.Object.hakbun[1], '%')

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi)  then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1

end event

event open;call super::open;//idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr102a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr102a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr102a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr102a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr102a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr102a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr102a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr102a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr102a
end type

type uc_save from w_condition_window`uc_save within w_hdr102a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr102a
end type

type uc_print from w_condition_window`uc_print within w_hdr102a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr102a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr102a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr102a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr102a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr102a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr102a
end type

type gb_2 from w_condition_window`gb_2 within w_hdr102a
end type

type dw_con from uo_dwfree within w_hdr102a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_hdr102a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hdr102a
integer x = 599
integer y = 40
integer width = 686
integer taborder = 80
boolean bringtotop = true
string btnname = "복학생등록금생성"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_hakbun, ls_hakbun1, ls_gwa,	ls_hakyun, ls_janghak,&
			ls_tyear, ls_thakgi, ls_insang_yn, ls_injung, ls_gubun, ls_bujun, ls_drinjung
long		ll_cnt, ll_drhakjum, ll_realhakjum, ll_iphak, ll_dungrok, ll_haksengwhe, ll_album, ll_gyojae,&
			ll_memory, ll_dongchang, ll_real, ll_hakjum, ll_base, ll_a, ll_b, ll_c, ll_d, ll_janghak
long		ll_ihakjum, ll_bhakjum, ll_bdr, ll_realdungrok, ll_hdr
string	ls_chk, ls_hu_year, ls_hu_hakgi

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun   	=	func.of_nvl(dw_con.Object.hakbun[1], '%')

IF MESSAGEBOX("확인","복학생 등록금생성을 하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

SELECT HAKBUN
INTO	:ls_chk
FROM	HAKSA.DUNGROK_GWANRI
WHERE	YEAR		=		:ls_year
AND	HAKGI		=		:ls_hakgi
AND	HAKBUN	like	:ls_hakbun
AND	ROWNUM	=	1
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	MESSAGEBOX("확인","이미 자료가 생성되어 있습니다.")
	RETURN
END IF


DECLARE LC_BOKHAK_DUNGROK	CURSOR FOR
	SELECT	A.HAKBUN,
				A.GWA,
				A.SU_HAKYUN,
				A.JUNGONG_GUBUN,
				A.BUJUNGONG_ID
	FROM		HAKSA.JAEHAK_HAKJUK A,
				HAKSA.HAKJUKBYENDONG B
	WHERE		A.HAKBUN = B.HAKBUN
	AND		A.HJMOD_ID = B.HJMOD_ID
	AND		A.HJMOD_SAYU_ID = B.SAYU_ID
	AND		A.SANGTAE		=	'01'
	AND		A.HJMOD_ID 		=  'C'
	AND		B.YEAR 			= 	:ls_year
	AND		B.HAKGI 			= 	:ls_hakgi
	AND		A.HAKBUN			like :ls_hakbun
	USING SQLCA ;

OPEN LC_BOKHAK_DUNGROK	;
DO
FETCH LC_BOKHAK_DUNGROK INTO :ls_hakbun1, :ls_gwa, :ls_hakyun, :ls_gubun, :ls_bujun	;

	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
     //복수전공 및 부전공이 없는 학생 등록금 계산
	if ls_gubun = '0' or isnull(ls_gubun) or ls_gubun ='' then
				
		//1. 수강학점 가져오기
		SELECT	SUM(HAKJUM)
		INTO		:ll_ihakjum
		FROM		HAKSA.SUGANG_TRANS
		WHERE		HAKBUN	=	:ls_hakbun1
		AND		YEAR		=	:ls_year	
		AND		HAKGI		=	:ls_hakgi	
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			ll_hakjum = 0
			
		elseif sqlca.sqlcode = -1 then
			messagebox("오류","수강신청학점 계산중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if	
		
		//2. 등록금 계산(장학금은 바로 적용되지 않고, )
		SELECT	IPHAK,
					DUNGROK,
					HAKSENGWHE,
					ALBUM,
					GYOJAE,
					MEMORIAL,
					DONGCHANGWHE				
		INTO		:ll_iphak,
					:ll_dungrok,
					:ll_haksengwhe,
					:ll_album,
					:ll_gyojae,
					:ll_memory,
					:ll_dongchang
		FROM		HAKSA.DUNGROK_MODEL
		WHERE		YEAR		= :ls_year
		AND		HAKGI 	= :ls_hakgi
		AND		GWA		= :ls_gwa
		AND		HAKYUN 	= :ls_hakyun
		USING SQLCA ;

		if sqlca.sqlcode <> 0 then
			messagebox("오류","등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if	
		
	//복수전공인 학생 등록금 계산
	elseif ls_gubun  = '1' then
		
		//1. 수강학점 가져오기
		SELECT 	SUM(DECODE(ISU_ID, '60', HAKJUM, 0)) BOKSU_HAKJUM,
					SUM(DECODE(ISU_ID, '60',0, HAKJUM)) IABAN_HAKJUM
		INTO		:ll_bhakjum,
					:ll_ihakjum
		FROM		HAKSA.SUGANG_TRANS
		WHERE		HAKBUN 	= :ls_hakbun1
		AND		YEAR		= :ls_year
		AND		HAKGI		= :ls_hakgi
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			ll_hakjum = 0
			
		elseif sqlca.sqlcode = -1 then
			messagebox("오류","수강신청학점 계산중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if
		
		//2. 일반등록금 계산(장학금은 바로 적용되지 않고, )
		SELECT	IPHAK,
					DUNGROK,
					HAKSENGWHE,
					ALBUM,
					GYOJAE,
					MEMORIAL,
					DONGCHANGWHE				
		INTO		:ll_iphak,
					:ll_dungrok,
					:ll_haksengwhe,
					:ll_album,
					:ll_gyojae,
					:ll_memory,
					:ll_dongchang
		FROM		HAKSA.DUNGROK_MODEL
		WHERE		YEAR		= :ls_year
		AND		HAKGI 	= :ls_hakgi
		AND		GWA		= :ls_gwa
		AND		HAKYUN 	= :ls_hakyun
		USING SQLCA ;

		if sqlca.sqlcode <> 0 then
			messagebox("오류","등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if
		
		//3. 복수전공 등록금 계산
		SELECT	DUNGROK	
		INTO		:ll_bdr
		FROM		HAKSA.DUNGROK_MODEL
		WHERE		YEAR		= :ls_year
		AND		HAKGI 	= :ls_hakgi
		AND		GWA		= :ls_bujun
		AND		HAKYUN 	= :ls_hakyun
		USING SQLCA ;

		if sqlca.sqlcode <> 0 then
			messagebox("오류","등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if


	//부전공인 학생 등록금 계산	
	elseif ls_gubun = '2' then
		
		//1. 수강학점 가져오기
		SELECT 	SUM(DECODE(ISU_ID, '50', HAKJUM, 0)),
					SUM(DECODE(ISU_ID, '50', 0, HAKJUM))
		INTO		:ll_bhakjum,
					:ll_ihakjum
		FROM		HAKSA.SUGANG_TRANS
		WHERE		HAKBUN 	= :ls_hakbun1
		AND		YEAR		= :ls_year
		AND		HAKGI		= :ls_hakgi
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			ll_hakjum = 0
			
		elseif sqlca.sqlcode = -1 then
			messagebox("오류","수강신청학점 계산중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if	
		
		//2. 일반등록금 계산(장학금은 바로 적용되지 않고, )
		SELECT	IPHAK,
					DUNGROK,
					HAKSENGWHE,
					ALBUM,
					GYOJAE,
					MEMORIAL,
					DONGCHANGWHE				
		INTO		:ll_iphak,
					:ll_dungrok,
					:ll_haksengwhe,
					:ll_album,
					:ll_gyojae,
					:ll_memory,
					:ll_dongchang
		FROM		HAKSA.DUNGROK_MODEL
		WHERE	YEAR		= :ls_year
		AND		HAKGI 	= :ls_hakgi
		AND		GWA		= :ls_gwa
		AND		HAKYUN 	= :ls_hakyun
		USING SQLCA ;

		if sqlca.sqlcode <> 0 then
			messagebox("오류","등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if
		
		//3. 부전공 등록금 계산
		SELECT	DUNGROK	
		INTO		:ll_bdr
		FROM		HAKSA.DUNGROK_MODEL
		WHERE		YEAR		= :ls_year
		AND		HAKGI 	= :ls_hakgi
		AND		GWA		= :ls_bujun
		AND		HAKYUN 	= :ls_hakyun
		USING SQLCA ;

		if sqlca.sqlcode <> 0 then
			messagebox("오류","등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if
		
	end if
	

	//장학금 기준학점 변경시 이렇게 하세용.
	SELECT	nvl(GIJUN_HAKJUM,0),
				trunc(nvl((GIJUN_HAKJUM * DUNGROK),0), -2) ,
				trunc(nvl(((GIJUN_HAKJUM * DUNGROK) / 3) * 2,0), -2) ,
				trunc(nvl(((GIJUN_HAKJUM * DUNGROK) / 3) * 1,0), -2) ,
				500000
	INTO		:ll_base,
				:ll_a,
				:ll_b,
				:ll_c,
				:ll_d
	FROM		HAKSA.DUNGROK_MODEL
	WHERE   	YEAR 		= :ls_year
	AND		HAKGI 	= :ls_hakgi
	and		HAKYUN	= :ls_hakyun
	AND		GWA		= :ls_gwa
//	GROUP BY DUNGROK
	USING SQLCA ;

	if sqlca.sqlcode = -1 then
		messagebox("오류","장학기준금액 생성중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	end if

//--------------------------------------------------- 잔여등록금 여부 확인	----------------------------------------------------
	//1----- 복학전 등록잔여금 존재여부 가져오기
	SELECT 	DUNGROK_INJUNG,
				YEAR,
				HAKGI
	INTO		:ls_drinjung,
				:ls_hu_year,
				:ls_hu_hakgi
	FROM		HAKSA.HAKJUKBYENDONG
	WHERE   	HJMOD_SIJUM = (	SELECT	HUHAK_DATE
										FROM		HAKSA.JAEHAK_HAKJUK
										WHERE		HAKBUN = :ls_hakbun1	
									)
	AND		HAKBUN = :ls_hakbun1
	USING SQLCA ;
	
	if sqlca.sqlcode = -1 then
		messagebox("오류","복학전 등록잔여금여부 생성중 오류발생~r~n전산소에 문의하세요." + sqlca.sqlerrtext)
		return 
	end if		
		
	IF ls_drinjung	=	'Y' THEN

		//2--------4.1 복학전 등록학점 가져오기(복학전 학기를 우예 가져오나...?)
		SELECT	SUM(HAKJUM),
					MAX(WAN_YN)
		INTO		:ll_drhakjum,
					:ls_injung
		FROM	HAKSA.DUNGROK_GWANRI
		WHERE	YEAR	=	:ls_hu_year
		AND	HAKGI	=	:ls_hu_hakgi
		AND	HAKBUN = :ls_hakbun1	
		USING SQLCA ;
		
		if sqlca.sqlcode =	0	then
			if ls_injung = 'N' then
				messagebox("오류","복학전 잔여등록금 체크와 등록내역의 자료가 일치하지 않습니다.~r~n" + sqlca.sqlerrtext)
				return 
			end if
			
		else
			messagebox("오류","복학전 등록학점을 가져올 수 없습니다.~r~n" + sqlca.sqlerrtext)
			return 
						
		end if

		//3--------	복학전 해당년도, 학기, 학년, 학과의 학점당 등록금(환불을 위해서 필요함.)
		SELECT 	DUNGROK
		INTO		:ll_hdr
		FROM		HAKSA.DUNGROK_MODEL
		WHERE   	YEAR||HAKGI||HAKYUN||GWA = (	SELECT	MAX(A.YEAR||A.HAKGI||A.SU_HAKYUN||B.GWA)
															FROM	HAKSA.HAKJUKBYENDONG	A,
																	HAKSA.JAEHAK_HAKJUK	B
															WHERE	A.HAKBUN			=	B.HAKBUN
															AND	A.HJMOD_ID 	=	'B'
															AND	A.HAKBUN		=	:ls_hakbun1
															AND	A.YEAR		=	:ls_hu_year
															AND	A.HAKGI		=	:ls_hu_hakgi
														)
		USING SQLCA ;
		
		if sqlca.sqlcode = -1 then
			messagebox("오류","복학전 학점당 등록금 생성중 오류발생~r~n" + sqlca.sqlerrtext)
			return 
		end if
		
	END IF
	
	//---------------------------------------	잔여등록금 가져오기 끝.....-------------------------------

		
	//4_1. 복학전 장학 가져오기(같은 년도, 학기에 휴학이 여러개일 경우 최초 휴학일이 필요하지 않나....?)
	SELECT 	JANGHAK_ID
	INTO		:ls_janghak		
	FROM		HAKSA.JANGHAK_GWANRI
	WHERE   	YEAR	=	:ls_hu_year
	AND		HAKGI	=	:ls_hu_hakgi
	AND		JANGHAK_ID IN ('I01','I02','I03','I04','I11','O11')
	AND		HAKBUN = :ls_hakbun1	
	USING SQLCA ;
	
	if sqlca.sqlcode = -1 then
		messagebox("오류","복학전 장학생성중 오류발생~r~n" + sqlca.sqlerrtext)
		return 
	elseif sqlca.sqlcode = 100 then
		ls_janghak = ''
		
	end if
		
	//등록금 인정및 장학에 따른 실등록학점 및 등록금
	
	//등록잔여금 인정된 학생(ll_ihakjum:현재 학점, ll_drhakjum:복학전 학점, ll_hdr:복학전 학점당 등록금)
	if ls_drinjung = 'Y' and ls_janghak = '' then
		
		if ls_gubun = '0' or isnull(ls_gubun) or ls_gubun ='' then
			ll_realhakjum 		= ll_ihakjum - ll_drhakjum
			ll_hakjum			= ll_ihakjum
			
			if ll_realhakjum >= 0 then
				ll_realdungrok	= ll_realhakjum * ll_dungrok 
			else
				//환불
				ll_realdungrok = ll_realhakjum * ll_hdr
			end if
		elseif ls_gubun = '1' then
			ll_realhakjum 		= (ll_ihakjum + ll_bhakjum) - ll_drhakjum
			ll_hakjum			= (ll_ihakjum + ll_bhakjum)
			if ll_realhakjum 	>= 0 then
				ll_realdungrok	= ll_realhakjum * ll_dungrok 
				ll_realdungrok	= ((ll_ihakjum - ll_drhakjum) * ll_dungrok ) + (ll_bdr * ll_bhakjum)
			else
				ll_realdungrok = ll_realhakjum * ll_hdr
			end if
		elseif ls_gubun = '2' then
			ll_realhakjum 		= (ll_ihakjum + ll_bhakjum) - ll_drhakjum
			ll_hakjum			= (ll_ihakjum + ll_bhakjum)
			if ll_realhakjum 	>= 0 then
				ll_realdungrok	= ll_realhakjum * ll_dungrok 
				ll_realdungrok	= ((ll_ihakjum - ll_drhakjum) * ll_dungrok ) + (ll_bdr * ll_bhakjum)
			else
				ll_realdungrok = ll_realhakjum * ll_hdr
			end if
		end if
	
	elseif ls_drinjung = 'Y' and ls_janghak <> '' then
		
		if ls_gubun = '0' or isnull(ls_gubun) or ls_gubun ='' then
			ll_realhakjum 	= ll_ihakjum - ll_drhakjum
			ll_hakjum		= ll_ihakjum
			if ll_realhakjum >= 0 then
				ll_realdungrok	= ll_realhakjum * ll_dungrok 
			else
				ll_realdungrok = ll_realhakjum * ll_hdr
			end if
		elseif ls_gubun = '1' then
			ll_realhakjum 		= (ll_ihakjum + ll_bhakjum) - ll_drhakjum
			ll_hakjum			= (ll_ihakjum + ll_bhakjum)
			if ll_realhakjum 	>= 0 then
				ll_realdungrok	= ll_realhakjum * ll_dungrok 
				ll_realdungrok	= ((ll_ihakjum - ll_drhakjum) * ll_dungrok ) + (ll_bdr * ll_bhakjum)
			else
				ll_realdungrok = ll_realhakjum * ll_hdr
			end if
		elseif ls_gubun = '2' then
			ll_realhakjum 		= (ll_ihakjum + ll_bhakjum) - ll_drhakjum
			ll_hakjum			= (ll_ihakjum + ll_bhakjum)
			if ll_realhakjum 	>= 0 then
				ll_realdungrok	= ll_realhakjum * ll_dungrok 
				ll_realdungrok	= ((ll_ihakjum - ll_drhakjum) * ll_dungrok ) + (ll_bdr * ll_bhakjum)
			else
				ll_realdungrok = ll_realhakjum * ll_hdr
			end if
		end if
			
	elseif ls_drinjung = 'N' and ls_janghak = '' then
		
		if ls_gubun = '0' or isnull(ls_gubun) or ls_gubun ='' then
			ll_realhakjum 	= ll_ihakjum
			ll_hakjum		= ll_ihakjum 
			ll_realdungrok	= ll_realhakjum * ll_dungrok 
		elseif ls_gubun 	= '1' then
			ll_realhakjum 	= ll_ihakjum + ll_bhakjum
			ll_hakjum		= (ll_ihakjum + ll_bhakjum)
			ll_realdungrok	= (ll_ihakjum * ll_dungrok) + (ll_bhakjum * ll_bdr)
		elseif ls_gubun 	= '2' then
			ll_realhakjum 	= ll_ihakjum + ll_bhakjum
			ll_realdungrok	= (ll_ihakjum * ll_dungrok) + (ll_bhakjum * ll_bdr)
		end if
		
	elseif ls_drinjung = 'N' and ls_janghak <> '' then
		
		if ls_gubun = '0' or isnull(ls_gubun) or ls_gubun ='' then
			ll_realhakjum 	= ll_ihakjum
			ll_hakjum		= ll_ihakjum
			ll_realdungrok	= ll_realhakjum * ll_dungrok 
		elseif ls_gubun 	= '1' then
			ll_realhakjum	= ll_ihakjum + ll_bhakjum
			ll_hakjum		= (ll_ihakjum + ll_bhakjum)
			ll_realdungrok	= (ll_ihakjum * ll_dungrok) + (ll_bhakjum * ll_bdr)
		elseif ls_gubun 	= '2' then
			ll_realhakjum	= ll_ihakjum + ll_bhakjum
			ll_hakjum		= (ll_ihakjum + ll_bhakjum)
			ll_realdungrok	= (ll_ihakjum * ll_dungrok) + (ll_bhakjum * ll_bdr)
		end if
	end if
	
	//Table Insert
	INSERT INTO	HAKSA.DUNGROK_GWANRI
			(	HAKBUN,			YEAR,					HAKGI,				SU_HAKYUN,	CHASU,		HAKJUM,
				IPHAK,			DUNGROK,				HAKSENGWHE,			GYOJAE,		ALBUM,		MEMORIAL,	
				DONGCHANGWHE,	D_JANGHAK,			JANGHAK_ID,			WAN_YN,		DUNG_YN,		BUN_YN,			
				CHU_YN,			HWAN_YN,				DUNGROK_GUBUN,		WORKER,		IPADDR	)
	VALUES(	:ls_hakbun1,	:ls_year,			:ls_hakgi,			:ls_hakyun,	1,				:ll_hakjum,
				0,					:ll_realdungrok,	:ll_haksengwhe,	:ll_gyojae,	:ll_album,	:ll_memory,	
				:ll_dongchang,	'0',					:ls_janghak, 		'N',			'N',			'N',	
				'N',				'N',					'4',					:gs_empcode,	:gs_ip )	
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","등록내역 생성중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	end if
			
LOOP WHILE TRUE;
CLOSE LC_BOKHAK_DUNGROK ;

COMMIT USING SQLCA ;
MESSAGEBOX("확인","작업이 종료되었습니다.")


end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hdr102a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hdr102a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string	ls_year, ls_hakgi, ls_hakbun, ls_hname, ls_gwajung, ls_hakgwa, ls_jungong, ls_janghak
long		ll_hakjum,	ll_iphak, ll_dungrok, ll_wonwoo, ll_janghak, ll_cnt

CHOOSE CASE	DWO.NAME
	//학번이 입력되면 기본사항을 가져온다.
	CASE	'd_dungrok_wan_yn'
		
		dw_main.object.d_dungrok_iphak_n[row]			=	dw_main.object.d_dungrok_iphak[row]
		dw_main.object.d_dungrok_dungrok_n[row]		=	dw_main.object.d_dungrok_dungrok[row]
		dw_main.object.d_dungrok_haksengwhe_n[row]	=	dw_main.object.d_dungrok_haksengwhe[row]
		dw_main.object.d_dungrok_gyojae_n[row]			=	dw_main.object.d_dungrok_gyojae[row]
		dw_main.object.d_dungrok_memorial_n[row]		=	dw_main.object.d_dungrok_memorial[row]
		dw_main.object.d_dungrok_album_n[row]			=	dw_main.object.d_dungrok_album[row]
		dw_main.object.d_dungrok_dongchangwhe_n[row]	=	dw_main.object.d_dungrok_dongchangwhe[row]		
		dw_main.object.d_dungrok_bank_id[row]			=	'05'
		dw_main.object.d_dungrok_napbu_date[row]		=	string(date(f_sysdate()), 'yyyymmdd')
			
END CHOOSE


end event

event itemerror;call super::itemerror;return 2
end event

