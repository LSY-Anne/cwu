$PBExportHeader$w_hdr101a.srw
$PBExportComments$[청운대]등록자료생성
forward
global type w_hdr101a from w_condition_window
end type
type dw_con from uo_dwfree within w_hdr101a
end type
type st_cnt from statictext within w_hdr101a
end type
type uo_1 from uo_imgbtn within w_hdr101a
end type
type uo_2 from uo_imgbtn within w_hdr101a
end type
type dw_main from uo_dwfree within w_hdr101a
end type
end forward

global type w_hdr101a from w_condition_window
dw_con dw_con
st_cnt st_cnt
uo_1 uo_1
uo_2 uo_2
dw_main dw_main
end type
global w_hdr101a w_hdr101a

on w_hdr101a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.st_cnt=create st_cnt
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.st_cnt
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.dw_main
end on

on w_hdr101a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.st_cnt)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_main)
end on

event ue_retrieve;string ls_year, ls_hakgi, ls_gwa
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa    	=	func.of_nvl(dw_con.Object.gwa[1], '%')

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;String ls_year, ls_hakgi

//idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr101a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr101a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr101a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr101a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr101a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr101a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr101a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr101a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr101a
end type

type uc_save from w_condition_window`uc_save within w_hdr101a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr101a
end type

type uc_print from w_condition_window`uc_print within w_hdr101a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr101a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr101a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr101a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr101a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr101a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr101a
integer height = 300
end type

type gb_2 from w_condition_window`gb_2 within w_hdr101a
end type

type dw_con from uo_dwfree within w_hdr101a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_hdr101a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_cnt from statictext within w_hdr101a
integer x = 2953
integer y = 188
integer width = 530
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
long backcolor = 32500968
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_1 from uo_imgbtn within w_hdr101a
integer x = 521
integer y = 40
integer width = 457
integer taborder = 20
boolean bringtotop = true
string btnname = "등록자료생성"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_hakbun, ls_gwa, ls_hakyun, ls_hjmod_date,&
			ls_janghak, ls_drhakyun, ls_hakgwa, ls_gubun, ls_bujun, 	ls_hjmod_id
long		ll_bhakjum, ll_ihakjum, ll_bdr
long		ll_iphak, ll_dungrok, ll_janghak, ll_janghak_iphak, ll_cnt
long		ll_haksengwhe, ll_album, ll_gyojae, ll_dongchang, ll_memory
long		ll_base, ll_a, ll_b, ll_c, ll_d, ll_e
long		i, ll_tot
long		ll_gitagum, ll_gitagum_iphak
String   ls_chk
Double   ldb_hakjum,  ll_hakjum

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakgwa  	=	func.of_nvl(dw_con.Object.gwa[1], '%')

//등록생성년도 학기에 해당자료유무검색
SELECT	COUNT(*)
INTO		:ll_cnt
FROM		HAKSA.DUNGROK_GWANRI
WHERE		YEAR	=	:ls_year
AND		HAKGI	=	:ls_hakgi	
USING SQLCA ;

if ll_cnt > 0 then
	if messagebox("확인",ls_year + "년도 " +  ls_hakgi + "학기 자료가 존재합니다.~r~n" + &
									"삭제후 다시 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
									
	DELETE FROM HAKSA.DUNGROK_GWANRI
	WHERE	YEAR	=	:ls_year
	AND	HAKGI	=	:ls_hakgi
	AND	(	SU_HAKYUN 	<> '1'
		OR		HAKGI 		<> '1'
		)
	USING SQLCA ;
			
	if sqlca.sqlcode = 0 then
		commit USING SQLCA ;
	else
		messagebox("오류","이전자료 삭제중 오류 발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
	
end if

SELECT	COUNT(HAKBUN)
INTO	:ll_tot
FROM	HAKSA.JAEHAK_HAKJUK
WHERE	SANGTAE	=	'01'	;

setpointer(hourglass!)

DECLARE LC_DUNGROK	CURSOR FOR
	SELECT	HAKBUN,
				GWA,
				SU_HAKYUN,
				DR_HAKYUN,
				JUNGONG_GUBUN,
				BUJUNGONG_ID,
				HJMOD_ID,
				SUBSTR(HJMOD_DATE, 1, 4)
	FROM		HAKSA.JAEHAK_HAKJUK
	WHERE		SANGTAE	=	'01'	
	and		GWA like :ls_hakgwa
	USING SQLCA ;

OPEN LC_DUNGROK	;
DO
	FETCH LC_DUNGROK INTO :ls_hakbun, :ls_gwa, :ls_hakyun, :ls_drhakyun, :ls_gubun, :ls_bujun, :ls_hjmod_id, :ls_hjmod_date;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	ll_hakjum = 0


   /* 학기제, 학점제 적용 구분 체크 (토마토) */
	ls_chk    = uf_hakgi_chk(ls_year, ls_hakgi, ls_hakbun)

	IF ls_chk = 'NO' THEN
		rollback USING SQLCA ;
		return
	END IF

//	if (ls_hjmod_id = 'C' or ls_hjmod_id = 'I')  and  ls_hjmod_date >= '2005' then
//	// 호텔관광학부로 2005년에 1학년으로 복학하는 사람부터 과를 바꿔 준다. BAB1 -> BAB0 
//		if ls_gwa = 'BAB0' and ls_hakyun = '1' then
//			ls_gwa = 'BAB1'
//		end if
//	end if
	
	//복수전공 및 부전공이 없는 학생 등록금 계산
	if ls_gubun = '0' or isnull(ls_gubun) or ls_gubun ='' then
				
		//1. 수강학점 가져오기
		SELECT	SUM(HAKJUM)
		INTO		:ll_ihakjum
		FROM		HAKSA.SUGANG_TRANS
		WHERE		HAKBUN	=	:ls_hakbun
		AND		YEAR		=	:ls_year	
		AND		HAKGI		=	:ls_hakgi	
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			ll_ihakjum = 0
			
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
			messagebox("오류", ls_gwa + ' ' + ls_hakyun + ' ' +"등록금계산 등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if	
		
		ll_hakjum 	= ll_ihakjum
		ll_dungrok 	= ll_dungrok * ll_hakjum
	
	
	//복수전공인 학생 등록금 계산
	elseif ls_gubun  = '1' then
		
		//1. 수강학점 가져오기
		SELECT 	SUM(DECODE(ISU_ID, '60', HAKJUM, 0)) BOKSU_HAKJUM,
					SUM(DECODE(ISU_ID, '60',0, HAKJUM)) IABAN_HAKJUM
		INTO		:ll_bhakjum,
					:ll_ihakjum
		FROM		HAKSA.SUGANG_TRANS
		WHERE		HAKBUN = :ls_hakbun
		AND		YEAR	= :ls_year
		AND		HAKGI	= :ls_hakgi
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			ll_ihakjum = 0
			ll_bhakjum = 0
			
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
			messagebox("오류","일반등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
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
			messagebox("오류","복수등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if
		
		ll_hakjum = ll_ihakjum + ll_bhakjum
		ll_dungrok = (ll_dungrok * ll_ihakjum) + (ll_bdr * ll_bhakjum)


	//부전공인 학생 등록금 계산	
	elseif ls_gubun = '2' then
		
		//1. 수강학점 가져오기
		SELECT 	SUM(DECODE(ISU_ID, '50', HAKJUM, 0)) BUJUN_HAKJUM,
					SUM(DECODE(ISU_ID, '50', 0, HAKJUM)) IABAN_HAKJUM
		INTO		:ll_bhakjum,
					:ll_ihakjum
		FROM		HAKSA.SUGANG_TRANS
		WHERE		HAKBUN = :ls_hakbun
		AND		YEAR	= :ls_year
		AND		HAKGI	= :ls_hakgi
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			ll_ihakjum = 0
			ll_bhakjum = 0
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
			messagebox("오류","일반등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
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
			messagebox("오류","부전등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
			return
		end if

		ll_hakjum = ll_ihakjum + ll_bhakjum
		ll_dungrok = (ll_dungrok * ll_ihakjum) + (ll_bdr * ll_bhakjum)
		
	end if

/* 학기제 등록금 적용(토마토시스템) */
   IF ls_chk     = 'Y' THEN
		SELECT nvl(tmt_hakgi_dungrok, 0)
		  INTO :ll_dungrok
		  FROM haksa.dungrok_model
		 WHERE YEAR       = :ls_year
		   AND HAKGI      = :ls_hakgi
			AND GWA        = :ls_gwa
			AND HAKYUN     = :ls_hakyun
		 USING SQLCA ;
		 
		IF sqlca.sqlnrows = 0 THEN
			ll_dungrok     = 0
		END IF
		IF ll_dungrok     = 0 THEN
			messagebox("알림", ls_gwa + '과의 ' + ls_hakyun + '학년의 학기제 등록금이 생성되지 않았으니 확인바랍니다.')
			rollback USING SQLCA ;
			return
		END IF
	END IF



	//4. 장학내역 및 외국인 장학생 등록금 및 입학금 가져오기
	//   --2008학년도 2학기부터 적용 
   //   혜전대학출신(편입)2009학년편입자부터 I15
	//   산업체 위탁I60, 산업체 특별I61, 지방대인문계열A(전액)O33, 기초생활034, 글로벌장학I62, 지방대인문계열B(80%)O36
	SELECT	JANGHAK_ID,
				GITAGUM,
				GITAGUM_IPHAK
	INTO		:ls_janghak,
				:ll_gitagum, 
				:ll_gitagum_iphak
	FROM		HAKSA.JANGHAK_GWANRI
	WHERE		HAKBUN	=	:ls_hakbun
	AND		YEAR		=	:ls_year	
	AND		HAKGI		=	:ls_hakgi	
	AND		JANGHAK_ID IN ( 'I01', 'I02', 'I03', 'I04', 'I11', 'I15', 'O11', 'O02', 'I29', 'I50', 'I51', 'I54', 'I55', 'I60', 'I61', 'I62', 'O33', 'O34', 'O36')
	USING SQLCA ;
		
	if sqlca.sqlcode = -1 then
		messagebox("오류", ls_hakbun +"장학내역 생성중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	end if
	

   IF ls_chk       = 'Y' THEN
		//장학금 기준학점 변경시 이렇게 하세용.
		SELECT	nvl(tmt_GIJUN_HAKJUM,0),
					trunc(nvl(tmt_hakgi_dungrok,0), -2) ,
					trunc(nvl((tmt_hakgi_dungrok / 3) * 2,0), -2) ,
					trunc(nvl((tmt_hakgi_dungrok / 3) * 1,0), -2) ,
					800000
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
	     USING SQLCA ;
		  
	ELSE
		//장학금 기준학점 변경시 이렇게 하세용.
		SELECT	nvl(GIJUN_HAKJUM,0),
					trunc(nvl((GIJUN_HAKJUM * DUNGROK),0), -2) ,
					trunc(nvl(((GIJUN_HAKJUM * DUNGROK) / 3) * 2,0), -2) ,
					trunc(nvl(((GIJUN_HAKJUM * DUNGROK) / 3) * 1,0), -2) ,
					800000
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
	    USING SQLCA ;
		 
	END IF
	
	if sqlca.sqlcode = -1 then
		messagebox("오류","장학기준금액 생성중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	end if


	//6. 등록금에 따른 장학금 계산
	IF ls_janghak = 'I50' or ls_janghak = 'I51' OR ls_janghak = 'I54' THEN
		//입학성적 장학생('전액면제')
		ll_janghak = ll_dungrok
	ELSEIF ls_janghak = 'I55' THEN
		//입학성적 장학생('1,000,000만원면제')
		ll_janghak = 1000000


	elseif ls_janghak = 'I11' or ls_janghak = 'O11' then
		//교내보훈장학, 교외 보훈장학(등록금전액면제)
		ll_janghak = ll_dungrok	

	elseif ls_janghak = 'I62' or ls_janghak = 'O33' then
		//글로벌,					국가장학금(인문사회계)	
		ll_janghak = ll_dungrok			
				
	elseif ls_janghak = 'O02'  or ls_janghak = 'O36'  then 
		
		//제대군인보훈장학(등록금/2면제)국가장학금(이공계_등록금)(등록금전액면제)
		ll_janghak = ll_dungrok	/ 2

		
	elseif ls_janghak = 'I01' then 
		
		//성적장학A(과수석장학)(등록금면제) 
		if ll_hakjum >= ll_base then
			ll_janghak = ll_a	
		else
			if ll_dungrok > ll_a then
				ll_janghak = ll_a
			else
				ll_janghak = ll_dungrok	
			end if
		end if
		
	elseif ls_janghak = 'I02' then
		
		//성적장학B(등록금의 2/3면제)
		if ll_hakjum >= ll_base then
			ll_janghak = ll_b
		else
			if ll_dungrok > ll_b then
				ll_janghak = ll_b
			else
//				ll_janghak = ll_dungrok * 0.67
//				ll_janghak = truncate(((ll_dungrok / 3) * 2) / 100, 0) * 100
				ll_janghak = ll_dungrok
			end if
		end if
		
	elseif ls_janghak	=	'I03' then
		
		//성적장학C(등록금의 1/3면제)
		if ll_hakjum >= ll_base then
			ll_janghak = ll_c
		else
			if ll_dungrok > ll_c then
				ll_janghak = ll_c
			else
//				ll_janghak = ll_dungrok * 0.33
//				ll_janghak = truncate(((ll_dungrok / 3) * 1) / 100, 0) * 100
				ll_janghak = ll_dungrok
			end if
		end if
		
	elseif ls_janghak	=	'I04' then
		
		//성적장학D(80만원면제)
		if ll_dungrok > ll_d then
			ll_janghak = ll_d
		else
			ll_janghak = ll_dungrok 
		end if
		
	elseif ls_janghak = 'I29' OR ls_janghak = 'I60' OR ls_janghak = 'I61' OR ls_janghak = 'O34' OR ls_janghak = 'I15'then 
		//산업체 위탁, 산업체 특별, 기초생활도 포함
		//외국인유학생장학금(등록테이블의 GITAGUM, GITAGUM_IPHAK을 가져다 setting)
		//											 등록금   입학금
		ll_janghak 			= ll_gitagum
		ll_janghak_iphak	= ll_gitagum_iphak
		
	else
		ll_janghak = 0	
	end if



	//Table Insert
	INSERT INTO	HAKSA.DUNGROK_GWANRI
			(	HAKBUN,		YEAR,				HAKGI,				SU_HAKYUN,			CHASU,		
				HAKJUM,		IPHAK,			DUNGROK,				HAKSENGWHE,			GYOJAE,		
				ALBUM,		MEMORIAL,		DONGCHANGWHE,		I_JANGHAK, 			D_JANGHAK,
				JANGHAK_ID,	WAN_YN,			DUNG_YN,				BUN_YN,				CHU_YN,
				HWAN_YN,		DUNGROK_GUBUN,	WORKER,										IPADDR	)
	VALUES(	:ls_hakbun,	:ls_year,		:ls_hakgi,			:ls_hakyun,			1,				
				:ll_hakjum,	0,					:ll_dungrok,		:ll_haksengwhe,	:ll_gyojae,	
				:ll_album,	:ll_memory,		:ll_dongchang,		:ll_janghak_iphak,:ll_janghak,
				:ls_janghak,'N',				'N',					'N',					'N',
				'N',			'1',				:gs_empcode,		:gs_ip )	
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","등록내역 생성중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	end if
	
	ls_janghak = ''
	
	i = i + 1
	
	st_cnt.text = string(i) + '/' + string(ll_tot)
	
LOOP WHILE TRUE;
CLOSE LC_DUNGROK ;

COMMIT USING SQLCA ;

MESSAGEBOX("확인","작업이 종료되었습니다.")
setpointer(arrow!)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hdr101a
integer x = 1029
integer y = 40
integer width = 727
integer taborder = 20
boolean bringtotop = true
string btnname = "학기제수강신청학점적용"
end type

event clicked;call super::clicked;string	ls_year,     ls_hakgi,   ls_hakbun,   ls_gwa,   ls_chk,    ls_hakgwa
Long     ll_cnt,      ll_totcnt
Double   ldb_hakjum,  ll_hakjum

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakgwa  	=	func.of_nvl(dw_con.Object.gwa[1], '%')

//등록생성년도 학기에 해당자료유무검색
SELECT nvl(count(*), 0)
  INTO :ll_cnt
  FROM haksa.dungrok_gwanri
 WHERE year    = :ls_year
   AND hakgi   = :ls_hakgi
 USING SQLCA ;
 
IF ll_cnt      = 0 THEN
	messagebox("확인", ls_year + "년도 " +  ls_hakgi + "학기 자료가 없으니 확인바랍니다.")
	return
END IF

setpointer(hourglass!)

ll_totcnt     = 0
DECLARE cur_1  CURSOR FOR

  SELECT a.hakbun
    FROM haksa.dungrok_gwanri a, haksa.jaehak_hakjuk b
	WHERE a.year     = :ls_year
	  AND a.hakgi    = :ls_hakgi
	  AND a.hakbun   = b.hakbun
	  AND b.gwa   like :ls_hakgwa
	USING SQLCA ;

 OPEN   cur_1;
 DO WHILE(TRUE)
 FETCH cur_1 INTO  :ls_hakbun ;
 IF SQLCA.SQLCODE  <> 0 THEN  EXIT
 
    ls_chk    = uf_hakgi_chk(ls_year, ls_hakgi, ls_hakbun)

	 IF ls_chk = 'Y' THEN

		 SELECT nvl(SUM(HAKJUM), 0)
		   INTO :ll_hakjum
		   FROM HAKSA.SUGANG_TRANS
		  WHERE HAKBUN	   = :ls_hakbun
		    AND YEAR      = :ls_year	
		    AND HAKGI     = :ls_hakgi
		  USING SQLCA ;
			 
		 UPDATE haksa.dungrok_gwanri
		    SET hakjum    = :ll_hakjum,
			      job_uid     = :gs_empcode,
				  job_add   = :gs_ip,
				  job_date  = sysdate
		  WHERE hakbun    = :ls_hakbun
		    AND year      = :ls_year
			 AND hakgi     = :ls_hakgi
//			 AND chasu     = 1
			 AND WAN_YN		=	'Y'
			 AND DUNGROK	> 0
		 USING SQLCA ;
			 
		 ll_totcnt        = ll_totcnt + 1

	 END IF

Loop
Close  Cur_1;


COMMIT USING SQLCA ;

MESSAGEBOX("확인","총 " + string(ll_totcnt) + "건의 작업이 종료되었습니다.")
setpointer(arrow!)
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hdr101a
integer x = 55
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hdr101a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

