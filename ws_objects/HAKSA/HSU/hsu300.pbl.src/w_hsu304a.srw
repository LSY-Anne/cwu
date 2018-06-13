$PBExportHeader$w_hsu304a.srw
$PBExportComments$[청운대]성적이관
forward
global type w_hsu304a from w_no_condition_window
end type
type st_2 from statictext within w_hsu304a
end type
type hpb_1 from hprogressbar within w_hsu304a
end type
type cb_2 from commandbutton within w_hsu304a
end type
type cb_3 from commandbutton within w_hsu304a
end type
type st_sangtae from statictext within w_hsu304a
end type
type cb_4 from commandbutton within w_hsu304a
end type
type cb_5 from commandbutton within w_hsu304a
end type
type dw_con from uo_dwfree within w_hsu304a
end type
end forward

global type w_hsu304a from w_no_condition_window
st_2 st_2
hpb_1 hpb_1
cb_2 cb_2
cb_3 cb_3
st_sangtae st_sangtae
cb_4 cb_4
cb_5 cb_5
dw_con dw_con
end type
global w_hsu304a w_hsu304a

on w_hsu304a.create
int iCurrent
call super::create
this.st_2=create st_2
this.hpb_1=create hpb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_sangtae=create st_sangtae
this.cb_4=create cb_4
this.cb_5=create cb_5
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.hpb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.st_sangtae
this.Control[iCurrent+6]=this.cb_4
this.Control[iCurrent+7]=this.cb_5
this.Control[iCurrent+8]=this.dw_con
end on

on w_hsu304a.destroy
call super::destroy
destroy(this.st_2)
destroy(this.hpb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_sangtae)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.dw_con)
end on

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_hsu304a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hsu304a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hsu304a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hsu304a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hsu304a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hsu304a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hsu304a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hsu304a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hsu304a
end type

type uc_save from w_no_condition_window`uc_save within w_hsu304a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hsu304a
end type

type uc_print from w_no_condition_window`uc_print within w_hsu304a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hsu304a
end type

type st_line2 from w_no_condition_window`st_line2 within w_hsu304a
end type

type st_line3 from w_no_condition_window`st_line3 within w_hsu304a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hsu304a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hsu304a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hsu304a
end type

type st_2 from statictext within w_hsu304a
integer x = 55
integer y = 296
integer width = 4379
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 32768
long backcolor = 12639424
string text = "성적이관(보관성적생성)"
alignment alignment = center!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_hsu304a
integer x = 914
integer y = 876
integer width = 2354
integer height = 96
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type cb_2 from commandbutton within w_hsu304a
integer x = 1733
integer y = 1188
integer width = 718
integer height = 184
integer taborder = 20
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "성적집계"
end type

event clicked;string	ls_year, ls_hakgi, ls_hakbun, ls_hakyun, ls_hakgwa
string	ls_gyunggo, ss_hakbun
long		ll_sungjuk, ll_tot, ll_sin_hakjum, ll_sin_gwamok, ll_pass_gwamok, ll_pass_hakjum, ll_f_cnt
long		ll_cnt, ll_g_cnt, ll_p_cnt, ll_nop_cnt
double	ld_pyen_tot, ld_pyen_avg, ld_hwan_tot, ld_hwan_avg

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  func.of_nvl(dw_con.Object.hakbun[1], '%')

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
		
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
		
end if

if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 성적집계를 하시겠습니까?", Question!, YesNo!, 2) = 2 then return

//기존자료 확인
select count(*)
into :ll_sungjuk
from haksa.sungjukgye
where year		= 		:ls_year		and
		hakgi		= 		:ls_hakgi 	and
		hakbun 	like 	:ss_hakbun
USING SQLCA ;

if ll_sungjuk > 0 then
	if messagebox("확인","기존 자료가 존재합니다.~r~n 삭제후 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	
	delete from haksa.sungjukgye
	where year		= 		:ls_year		and
			hakgi		= 		:ls_hakgi	and
			hakbun 	like 	:ss_hakbun
	USING SQLCA ;
			
	if sqlca.sqlcode <> 0 then
		messagebox("오류","기존자료 삭제중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	else
		commit USING SQLCA ;
	end if
end if

Setpointer(HourGlass!)

//Progress Bar
select	count( distinct hakbun)
into :ll_tot
from haksa.sugang_trans
where year				= 		:ls_year		and
		hakgi				= 		:ls_hakgi 	and
		hakbun 			like 	:ss_hakbun	and
		sungjuk_injung	= 'Y'
USING SQLCA ;

hpb_1.MaxPosition = ll_tot

st_sangtae.text = '성적집계중...'

//성적계산(학번, 신청과목수, 신청학점, 취득과목수, 취득학점, F학점수, 평점총점, 평점평균, 총점, 총점평균)
DECLARE cur_sajung CURSOR FOR
// 기존 자료
//	SELECT	HAKBUN,
//				COUNT(GWAMOK_ID),
//				SUM(DECODE(HWANSAN_JUMSU, 'W', 0, HAKJUM)),
//				SUM(DECODE(HWANSAN_JUMSU, 'F', 0, 'W', 0, 1)),
//				SUM(DECODE(HWANSAN_JUMSU, 'F', 0, 'W', 0, HAKJUM)),
//				SUM(DECODE(HWANSAN_JUMSU, 'F', 1, 0)),
//				NVL(SUM(PYENGJUM * HAKJUM), 0) ,
//				NVL(ROUND(SUM(PYENGJUM * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, 'W', 0,HAKJUM)), 2), 0) ,
//				NVL(SUM(JUMSU), 0),
//				NVL(DECODE(SUM(DECODE(HWANSAN_JUMSU, 'P', 0, JUMSU * HAKJUM)), 0 , 0, (ROUND(SUM(DECODE(HWANSAN_JUMSU, 'P', 0, JUMSU * HAKJUM)) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, 'W', 0, HAKJUM)), 2))), 0)
//	FROM 		HAKSA.SUGANG
//	WHERE 	YEAR				= 		:ls_year		and
//				HAKGI				= 		:ls_hakgi	and
//				HAKBUN 			like 	:ss_hakbun	
////				SUNGJUK_INJUNG = 'Y'
//	GROUP BY HAKBUN	;

	SELECT	A.HAKBUN,
				COUNT(A.GWAMOK_ID),
				SUM(DECODE(A.HWANSAN_JUMSU, 'W', 0, A.HAKJUM)),
				SUM(DECODE(A.HWANSAN_JUMSU, 'F', 0, 'W', 0, 1)),
				SUM(DECODE(A.HWANSAN_JUMSU, 'F', 0, 'W', 0, A.HAKJUM)),
				SUM(DECODE(A.HWANSAN_JUMSU, 'F', 1, 0)),
				SUM(DECODE(B.PASS_GUBUN, 'Y', 1, 0)),
				SUM(DECODE(B.PASS_GUBUN, 'Y', 0, 1)),
				NVL(SUM(A.PYENGJUM * A.HAKJUM), 0) ,
				DECODE(SUM(NVL(A.PYENGJUM, 0) * NVL(A.HAKJUM, 0)), 0, 0, NVL(ROUND(SUM(NVL(A.PYENGJUM, 0) * NVL(A.HAKJUM, 0)) / SUM(DECODE(A.HWANSAN_JUMSU, 'W', 0, 'P', 0, DECODE(B.PASS_GUBUN, 'Y', 0, NVL(A.HAKJUM, 0)))), 2), 0)),
				NVL(SUM(A.JUMSU), 0),
				NVL(DECODE(SUM(DECODE(B.PASS_GUBUN, 'Y', 0, A.JUMSU * A.HAKJUM)), 0 , 0, (ROUND(SUM(DECODE(B.PASS_GUBUN, 'Y', 0, A.JUMSU * A.HAKJUM)) / SUM(DECODE(A.HWANSAN_JUMSU, 'W', 0,  'P', 0, DECODE(B.PASS_GUBUN, 'Y', 0, NVL(A.HAKJUM, 0)))), 2))), 0)
	FROM 		HAKSA.SUGANG A, HAKSA.GWAMOK_CODE B
	WHERE 	A.GWAMOK_ID		=		B.GWAMOK_ID
	AND		A.GWAMOK_SEQ	=		B.GWAMOK_SEQ
	AND	 	A.YEAR			= 		:ls_year		
	and		A.HAKGI			= 		:ls_hakgi	
	and		A.HAKBUN 		like 	:ss_hakbun	
//				SUNGJUK_INJUNG = 'Y'
	GROUP BY A.HAKBUN	
	USING SQLCA ;

OPEN cur_sajung ;
DO
	FETCH cur_sajung
	INTO	:ls_hakbun,		:ll_sin_gwamok,	:ll_sin_hakjum,	:ll_pass_gwamok,	:ll_pass_hakjum, 
			:ll_f_cnt,		:ll_p_cnt,			:ll_nop_cnt,		:ld_pyen_tot,		:ld_pyen_avg,
			:ld_hwan_tot,	:ld_hwan_avg ;
	
	if sqlca.sqlcode <> 0 then exit 

	//학사경고횟수 초기화
	ll_g_cnt = 0	
	
	//학적학년과 학과를 가져온다.
	SELECT	DR_HAKYUN,
				GWA
	INTO		:ls_hakyun,
				:ls_hakgwa
	FROM		HAKSA.JAEHAK_HAKJUK
	WHERE		HAKBUN	=	:ls_hakbun
	USING SQLCA ;

	//학사경고 및 학사경고 연속구하기(학사경고는 '1', 아니면 '0')
	//학점이 1.5 미만이라고 pass과목만 신청한경우는 학고 아님
	if	ll_p_cnt >= 1  and ll_nop_cnt = 0 then
		ls_gyunggo = '0'
		ll_g_cnt = 0

	elseif ld_pyen_avg < 1.5 then
				ls_gyunggo = '1'
				
				SELECT	NVL(GYUNGGO_CNT, 0)
				INTO		:ll_g_cnt
				FROM		HAKSA.SUNGJUKGYE
				WHERE		YEAR||HAKGI	=	(	SELECT	MAX(YEAR||HAKGI)
													FROM		HAKSA.SUNGJUKGYE
													WHERE		HAKBUN	=	:ls_hakbun)	
				AND		HAKBUN	=	:ls_hakbun
				USING SQLCA ;

				ll_g_cnt = ll_g_cnt + 1
				
			else
				ls_gyunggo = '0'
				ll_g_cnt = 0
				
	end if
	
	//자료 Insert
	insert into haksa.sungjukgye
	values ( :ls_hakbun,			:ls_year,			:ls_hakgi,			:ls_hakyun,			:ls_hakgwa,
				:ll_sin_gwamok,	:ll_sin_hakjum,	:ll_pass_gwamok,	:ll_pass_hakjum,	:ll_f_cnt,	
				:ld_pyen_tot,		:ld_pyen_avg,		:ld_hwan_tot,		:ld_hwan_avg,		null,
				null,					:ls_gyunggo,		:ll_g_cnt,			'Y', 					'0',
				:gs_empcode,   	:gs_ip,	SYSDATE,
				null,	null,	null ) USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","성적사정중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext )
		rollback USING SQLCA ;
		return
	end if
	
	//Progress Bar
	ll_cnt = ll_cnt + 1
	hpb_1.Position = ll_cnt
	
LOOP WHILE TRUE
CLOSE cur_sajung ;

COMMIT USING SQLCA ;

Setpointer(Arrow!)
messagebox("확인","작업이 완료되었습니다.")
st_sangtae.text = ''
end event

type cb_3 from commandbutton within w_hsu304a
integer x = 919
integer y = 1188
integer width = 718
integer height = 184
integer taborder = 10
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "이관"
end type

event clicked;
//검색조건
string	ls_year, ls_hakgi, ls_hakbun
string	ls_chk

//cursor에서 받아올 변수
string	as_hakbun, as_gwamok, as_jesu_year, as_jesu_hakgi, as_jesu_gwamok, as_tmt_each_yn
integer	ai_seq,	ai_jesu_seq,	ai_jumsu,   ai_hwansan_jumsu

//비교할 변수
integer	li_jumsu

integer	li_sin_gwamok, li_sin_hakjum, li_chi_gwamok, li_chi_hakjum, li_f_gwamok, li_hwansan_jumsu
double	ld_pyen_sum,	ld_pyen_avg,	ld_hwan_sum,	ld_hwan_avg

//progress Bar
long	ll_count, ll_cnt

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  func.of_nvl(dw_con.Object.hakbun[1], '%')

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
		
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
		
end if

if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 자료를 이관하시겠습니까?", Question!, YesNo!, 2) = 2 then return

SELECT  HAKBUN
INTO	:ls_chk
FROM  HAKSA.SUGANG
WHERE	YEAR		=		:ls_year
AND	HAKGI		=		:ls_hakgi
AND	HAKBUN	like	:ls_hakbun
AND	ROWNUM	=	1
USING SQLCA ;

if sqlca.sqlcode = 0 then

	if messagebox("확인","이미 자료가 존재합니다! ~r~n 삭제후 재생성하시겠습니까?", Question!, YesNo!,2) = 2 then return
	
	DELETE FROM HAKSA.SUGANG
	WHERE	YEAR		=		:ls_year
	AND	HAKGI		=		:ls_hakgi
	AND	HAKBUN	like	:ls_hakbun 
	USING SQLCA ;
		
	if sqlca.sqlcode <> 0 then
		messagebox("오류","이전자료 삭제중 오류발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
		
end if		

//Progress Bar Setting
SELECT	COUNT(HAKBUN)
INTO	:ll_count
FROM	HAKSA.SUGANG_TRANS
WHERE	YEAR		=		:ls_year
AND	HAKGI		=		:ls_hakgi
AND	HAKBUN	LIKE	:ls_hakbun
AND	SUNGJUK_INJUNG	=	'Y'
AND	JESU_YEAR	IS NOT NULL
USING SQLCA ;

hpb_1.MaxPosition = ll_count

st_sangtae.text = '재수강자료 처리중...'

SetPointer(HourGlass!)

//재수강 자료를 먼저 처리한다.
DECLARE CUR_IKWAN CURSOR FOR
SELECT	A.HAKBUN,
			A.GWAMOK_ID,
			A.GWAMOK_SEQ,
			A.JESU_YEAR,
			A.JESU_HAKGI,
			A.JESU_GWAMOK_ID,
			A.JESU_GWAMOK_SEQ,
			A.JUMSU,
			DECODE(A.HWANSAN_JUMSU, 'A+', 9, 'A', 8, 'B+', 7, 'B', 6, 'C+', 5, 'C', 4, 'D+', 3, 'D', 2, 'F', 1, 0),
			C.TMT_EACH_YN
FROM		HAKSA.SUGANG_TRANS A,
			HAKSA.GAESUL_GWAMOK	C
WHERE		A.YEAR		=	C.YEAR
AND		A.HAKGI		=	C.HAKGI
AND		A.GWA			=	C.GWA
AND		A.GWAMOK_ID	=	C.GWAMOK_ID
AND		A.GWAMOK_SEQ=	C.GWAMOK_SEQ
AND		A.YEAR		=		:ls_year
AND		A.HAKGI		=		:ls_hakgi
AND		A.HAKBUN	LIKE	:ls_hakbun
AND		A.SUNGJUK_INJUNG	=	'Y'
AND		A.JESU_YEAR	IS NOT NULL
ORDER BY A.HAKBUN	
USING SQLCA ;

OPEN CUR_IKWAN ;
DO
	FETCH CUR_IKWAN INTO :as_hakbun, :as_gwamok, :ai_seq, :as_jesu_year, :as_jesu_hakgi, :as_jesu_gwamok, :ai_jesu_seq, :ai_jumsu, :ai_hwansan_jumsu, :as_tmt_each_yn ;

	IF SQLCA.SQLCODE = -1 THEN
		MESSAGEBOX("오류", "재수강 계산중 오류발생~r~n" + SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA ;
		RETURN
		
	ELSEIF SQLCA.SQLCODE = 100 THEN
		EXIT
	END IF
	
	//---------------------	재수강 계산
	//재수강 성적 가져오기
	SELECT	JUMSU,
				DECODE(HWANSAN_JUMSU, 'A+', 9, 'A', 8, 'B+', 7, 'B', 6, 'C+', 5, 'C', 4, 'D+', 3, 'D', 2, 'F', 1, 0)
	INTO		:li_jumsu,
				:li_hwansan_jumsu
	FROM		HAKSA.SUGANG
	WHERE		HAKBUN		=	:as_hakbun
	AND		YEAR			=	:as_jesu_year
	AND		HAKGI			=	:as_jesu_hakgi
	AND		GWAMOK_ID	=	:as_jesu_gwamok
	AND		GWAMOK_SEQ	=	:ai_jesu_seq
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류",as_hakbun + "처리중 오류 발생(재수강성적 가져오기)~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
	
	//재수강점수와 현재 점수비교
	//현재 환산점수가 이전환산점수보다 높으면  update  2006.11.23
	//현재 점수가 이전점수보다 높으면  update
	IF as_tmt_each_yn = 'Y' then	//상대평가일경우
		IF ai_hwansan_jumsu > li_hwansan_jumsu THEN
			UPDATE	HAKSA.SUGANG
			SET	SUNGJUK_INJUNG	=	'N'
			WHERE	HAKBUN		=	:as_hakbun
			AND	YEAR			=	:as_jesu_year
			AND	HAKGI			=	:as_jesu_hakgi
			AND	GWAMOK_ID	=	:as_jesu_gwamok
			AND	GWAMOK_SEQ	=	:ai_jesu_seq
			USING SQLCA ;
			
			if sqlca.sqlcode <> 0 then
				messagebox("오류",as_hakbun + "처리중 오류 발생(이전SUGANG 처리)~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return
			end if		
		END IF
	ELSE
		IF ai_jumsu > li_jumsu THEN
			
			//이전성적의 성적인정을 'N'으로 UPDATE
			UPDATE	HAKSA.SUGANG
			SET	SUNGJUK_INJUNG	=	'N'
			WHERE	HAKBUN		=	:as_hakbun
			AND	YEAR			=	:as_jesu_year
			AND	HAKGI			=	:as_jesu_hakgi
			AND	GWAMOK_ID	=	:as_jesu_gwamok
			AND	GWAMOK_SEQ	=	:ai_jesu_seq
			USING SQLCA ;
			
			if sqlca.sqlcode <> 0 then
				messagebox("오류",as_hakbun + "처리중 오류 발생(이전SUGANG 처리)~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return
			end if		
			
		END IF
	END IF	
	
	//Progress Bar
	ll_cnt = ll_cnt + 1
	hpb_1.Position = ll_cnt
	
	
LOOP WHILE TRUE
CLOSE CUR_IKWAN ;

st_sangtae.text = '성적 이관중...'

//재수강처리가 완료되면 일괄 UPDATE	
INSERT INTO HAKSA.SUGANG
(	SELECT	A.HAKBUN,
				A.YEAR,
				A.HAKGI,
				B.DR_HAKYUN,
				B.GWA,
				A.GWAMOK_ID,
				A.GWAMOK_SEQ,
				A.ISU_ID,
				A.HAKJUM,
				NVL(A.JUMSU_1, 0),
				NVL(A.JUMSU_2, 0),
				NVL(A.JUMSU_3, 0),
				NVL(A.JUMSU_4, 0),
				NVL(A.JUMSU_5, 0),
				NVL(A.JUMSU, 0),
				NVL(A.HWANSAN_JUMSU, 'F'),
				NVL(A.PYENGJUM, 0),
				A.SUNGJUK_INJUNG,
				A.JESU_YEAR,
				A.JESU_HAKGI,
				A.JESU_GWAMOK_ID,
				A.JESU_GWAMOK_SEQ,
				'0',
				:gs_empcode,
				:gs_ip,
				SYSDATE,
				NULL,
				NULL,
				NULL,
				A.ISU_ID
	FROM	HAKSA.SUGANG_TRANS	A,
			HAKSA.JAEHAK_HAKJUK	B
	WHERE	A.HAKBUN				=	B.HAKBUN
	AND	A.YEAR				=	:ls_year
	AND	A.HAKGI				=	:ls_hakgi
	AND	A.HAKBUN				LIKE	:ls_hakbun
	AND	(A.SUNGJUK_INJUNG	=	'Y'
	OR		A.HWANSAN_JUMSU	=	'W')
	AND	A.HAKJUM				> 0
)	USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	COMMIT USING SQLCA ;
	MESSAGEBOX("확인","성적이관이 완료되었습니다.")
	
ELSE
	MESSAGEBOX("오류","성적이관중 오류가 발생되었습니다.~r~n" + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA ;
	
END IF

SetPointer(Arrow!)
st_sangtae.text = ''

end event

type st_sangtae from statictext within w_hsu304a
integer x = 1317
integer y = 768
integer width = 1650
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 31112622
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_hsu304a
integer x = 2546
integer y = 1184
integer width = 718
integer height = 184
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "BAL_YN=> ~'1~'"
end type

event clicked;
//검색조건
string	ls_year, ls_hakgi, ls_hakbun
string	ls_chk

//cursor에서 받아올 변수
string	as_hakbun, as_gwamok, as_jesu_year, as_jesu_hakgi, as_jesu_gwamok
integer	ai_seq,	ai_jesu_seq,	ai_jumsu

//비교할 변수
integer	li_jumsu

integer	li_sin_gwamok, li_sin_hakjum, li_chi_gwamok, li_chi_hakjum, li_f_gwamok
double	ld_pyen_sum,	ld_pyen_avg,	ld_hwan_sum,	ld_hwan_avg

//progress Bar
long	ll_count, ll_cnt

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  func.of_nvl(dw_con.Object.hakbun[1], '%')

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
		
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
		
end if

if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 성적증명서발급Flag를 1로 바꾸시겠습니까?", Question!, YesNo!, 2) = 2 then return

//Progress Bar Setting
SELECT	COUNT(HAKBUN)
INTO	:ll_count
FROM	HAKSA.SUGANG_TRANS
WHERE	YEAR		=		:ls_year
AND	HAKGI		=		:ls_hakgi
AND	HAKBUN	LIKE	:ls_hakbun
AND	SUNGJUK_INJUNG	=	'Y'
USING SQLCA ;

hpb_1.MaxPosition = ll_count

st_sangtae.text = '자료 처리중...'

SetPointer(HourGlass!)


UPDATE	HAKSA.SUGANG
SET		BAL_YN		=	'1'
WHERE		YEAR		=		:ls_year
AND		HAKGI		=		:ls_hakgi
AND		HAKBUN	LIKE	:ls_hakbun;

UPDATE	HAKSA.SUNGJUKGYE
SET		BAL_YN		=	'1'
WHERE		YEAR		=		:ls_year
AND		HAKGI		=		:ls_hakgi
AND		HAKBUN	LIKE	:ls_hakbun
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	COMMIT USING SQLCA ;
	MESSAGEBOX("확인","성적증명서발급Flag를 1로 완료되었습니다.")
	
ELSE
	MESSAGEBOX("오류","성적증명서발급Flag를 바꾸는중 오류가 발생되었습니다.~r~n" + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA ;
	
END IF

SetPointer(Arrow!)
st_sangtae.text = ''

end event

type cb_5 from commandbutton within w_hsu304a
integer x = 919
integer y = 1472
integer width = 718
integer height = 184
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "성적사정 이후 이관만"
end type

event clicked;
//검색조건
string	ls_year, ls_hakgi, ls_hakbun
string	ls_chk

//cursor에서 받아올 변수
string	as_hakbun, as_gwamok, as_jesu_year, as_jesu_hakgi, as_jesu_gwamok, as_tmt_each_yn
integer	ai_seq,	ai_jesu_seq,	ai_jumsu,   ai_hwansan_jumsu

//비교할 변수
integer	li_jumsu

integer	li_sin_gwamok, li_sin_hakjum, li_chi_gwamok, li_chi_hakjum, li_f_gwamok, li_hwansan_jumsu
double	ld_pyen_sum,	ld_pyen_avg,	ld_hwan_sum,	ld_hwan_avg

//progress Bar
long	ll_count, ll_cnt

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  func.of_nvl(dw_con.Object.hakbun[1], '%')

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
		
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
		
end if

if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 자료를 처리하시겠습니까?", Question!, YesNo!, 2) = 2 then return

SELECT  HAKBUN
INTO	:ls_chk
FROM  HAKSA.SUGANG
WHERE	YEAR		=		:ls_year
AND	HAKGI		=		:ls_hakgi
AND	HAKBUN	like	:ls_hakbun
AND	ROWNUM	=	1
USING SQLCA ;

//if sqlca.sqlcode = 0 then
//
//	if messagebox("확인","이미 자료가 존재합니다! ~r~n 삭제후 재생성하시겠습니까?", Question!, YesNo!,2) = 2 then return
//	
//	DELETE FROM HAKSA.SUGANG
//	WHERE	YEAR		=		:ls_year
//	AND	HAKGI		=		:ls_hakgi
//	AND	HAKBUN	like	:ls_hakbun ;
//		
//	if sqlca.sqlcode <> 0 then
//		messagebox("오류","이전자료 삭제중 오류발생~r~n" + sqlca.sqlerrtext)
//		rollback ;
//		return
//	end if
//		
//end if		

//Progress Bar Setting
SELECT	COUNT(HAKBUN)
INTO	:ll_count
FROM	HAKSA.SUGANG_TRANS
WHERE	YEAR		=		:ls_year
AND	HAKGI		=		:ls_hakgi
AND	HAKBUN	LIKE	:ls_hakbun
AND	SUNGJUK_INJUNG	=	'Y'
AND	JESU_YEAR	IS NOT NULL
AND	HWANSAN_JUMSU <> 'P'
USING SQLCA ;

hpb_1.MaxPosition = ll_count

st_sangtae.text = '성적처리 처리중...'

SetPointer(HourGlass!)

//재수강 자료를 먼저 처리한다.
DECLARE CUR_IKWAN CURSOR FOR
SELECT	A.HAKBUN,
			A.GWAMOK_ID,
			A.GWAMOK_SEQ,
			A.JESU_YEAR,
			A.JESU_HAKGI,
			A.JESU_GWAMOK_ID,
			A.JESU_GWAMOK_SEQ,
			A.JUMSU,
			DECODE(A.HWANSAN_JUMSU, 'A+', 9, 'A', 8, 'B+', 7, 'B', 6, 'C+', 5, 'C', 4, 'D+', 3, 'D', 2, 'F', 1, 0),
			C.TMT_EACH_YN
FROM		HAKSA.SUGANG_TRANS A,
			HAKSA.JAEHAK_HAKJUK B,
			HAKSA.GAESUL_GWAMOK	C
WHERE		A.HAKBUN		=	B.HAKBUN
AND		A.YEAR		=	C.YEAR
AND		A.HAKGI		=	C.HAKGI
AND		A.GWA			=	C.GWA
AND		A.GWAMOK_ID	=	C.GWAMOK_ID
AND		A.GWAMOK_SEQ=	C.GWAMOK_SEQ
AND		A.YEAR		=	:ls_year
AND		A.HAKGI		=	:ls_hakgi
AND		A.HAKBUN		LIKE	:ls_hakbun
AND		A.SUNGJUK_INJUNG	=	'Y'
AND		A.JESU_YEAR	IS NOT NULL
AND		A.HWANSAN_JUMSU <> 'P'
ORDER BY A.HAKBUN	
USING SQLCA ;

OPEN CUR_IKWAN ;
DO
	FETCH CUR_IKWAN INTO :as_hakbun, :as_gwamok, :ai_seq, :as_jesu_year, :as_jesu_hakgi, :as_jesu_gwamok, :ai_jesu_seq, :ai_jumsu, :ai_hwansan_jumsu, :as_tmt_each_yn ;

	IF SQLCA.SQLCODE = -1 THEN
		MESSAGEBOX("오류", "재수강 계산중 오류발생~r~n" + SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA ;
		RETURN
		
	ELSEIF SQLCA.SQLCODE = 100 THEN
		EXIT
	END IF
	
	//---------------------	재수강 계산
	//재수강 성적 가져오기
	SELECT	JUMSU,
				DECODE(HWANSAN_JUMSU, 'A+', 9, 'A', 8, 'B+', 7, 'B', 6, 'C+', 5, 'C', 4, 'D+', 3, 'D', 2, 'F', 1, 0)
	INTO		:li_jumsu,
				:li_hwansan_jumsu
	FROM		HAKSA.SUGANG
	WHERE		HAKBUN		=	:as_hakbun
	AND		YEAR			=	:as_jesu_year
	AND		HAKGI			=	:as_jesu_hakgi
	AND		GWAMOK_ID	=	:as_jesu_gwamok
	AND		GWAMOK_SEQ	=	:ai_jesu_seq
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류",as_hakbun + "처리중 오류 발생(재수강성적 가져오기)~r~n" + sqlca.sqlerrtext)
	
		rollback USING SQLCA ;
		return
	end if
	
	//재수강점수와 현재 점수비교
	//현재 환산점수가 이전환산점수보다 높으면  update  2006.11.23
	//현재 점수가 이전점수보다 높으면  update
	IF as_tmt_each_yn = 'Y' then	//상대평가일경우
		IF ai_hwansan_jumsu > li_hwansan_jumsu THEN
			
			//이전성적의 성적인정을 'N'으로 UPDATE
			UPDATE	HAKSA.SUGANG
			SET	SUNGJUK_INJUNG	=	'N'
			WHERE	HAKBUN		=	:as_hakbun
			AND	YEAR			=	:as_jesu_year
			AND	HAKGI			=	:as_jesu_hakgi
			AND	GWAMOK_ID	=	:as_jesu_gwamok
			AND	GWAMOK_SEQ	=	:ai_jesu_seq
			USING SQLCA ;
			
			if sqlca.sqlcode <> 0 then
				messagebox("오류",as_hakbun + "처리중 오류 발생(이전SUGANG 처리)~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return
			end if		
		ELSE		
			//현재환산점수가 이전환산점수보다 낮으면 - 현재환산점수의 성적인정을 'N'으로 UPDATE
			//원래는 위처럼 처리를 해야 하는데 처리 안하고 성적증명서에서만 처리 2003.07.04
			UPDATE	HAKSA.SUGANG
			SET	SUNGJUK_INJUNG	=	'N'
			WHERE	HAKBUN		=	:as_hakbun
			AND	YEAR			=	:ls_year
			AND	HAKGI			=	:ls_hakgi	
			AND	GWAMOK_ID	=	:as_gwamok
			AND	GWAMOK_SEQ	=	:ai_seq
			USING SQLCA ;
			
				if sqlca.sqlcode <> 0 then
					messagebox("오류",as_hakbun + "처리중 오류 발생(현재 성적 처리)~r~n" + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					return
				end if				
		END IF
	ELSE		//절대평가일경우
		IF ai_jumsu > li_jumsu THEN
			
			//이전성적의 성적인정을 'N'으로 UPDATE
			UPDATE	HAKSA.SUGANG
			SET	SUNGJUK_INJUNG	=	'N'
			WHERE	HAKBUN		=	:as_hakbun
			AND	YEAR			=	:as_jesu_year
			AND	HAKGI			=	:as_jesu_hakgi
			AND	GWAMOK_ID	=	:as_jesu_gwamok
			AND	GWAMOK_SEQ	=	:ai_jesu_seq
			USING SQLCA ;
			
			if sqlca.sqlcode <> 0 then
				messagebox("오류",as_hakbun + "처리중 오류 발생(이전SUGANG 처리)~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return
			end if		
		ELSE		
			//현재점수가 이전점수보다 낮으면 - 현재점수의 성적인정을 'N'으로 UPDATE
			//원래는 위처럼 처리를 해야 하는데 처리 안하고 성적증명서에서만 처리 2003.07.04
			UPDATE	HAKSA.SUGANG
			SET	SUNGJUK_INJUNG	=	'N'
			WHERE	HAKBUN		=	:as_hakbun
			AND	YEAR			=	:ls_year
			AND	HAKGI			=	:ls_hakgi	
			AND	GWAMOK_ID	=	:as_gwamok
			AND	GWAMOK_SEQ	=	:ai_seq
			USING SQLCA ;
			
				if sqlca.sqlcode <> 0 then
					messagebox("오류",as_hakbun + "처리중 오류 발생(현재 성적 처리)~r~n" + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					return
				end if				
		END IF
	END IF
	//Progress Bar
	ll_cnt = ll_cnt + 1
	hpb_1.Position = ll_cnt
	
	
LOOP WHILE TRUE
CLOSE CUR_IKWAN ;

//st_sangtae.text = '성적 이관중...'
//
////재수강처리가 완료되면 일괄 UPDATE	
//INSERT INTO HAKSA.SUGANG
//(	SELECT	A.HAKBUN,
//				A.YEAR,
//				A.HAKGI,
//				B.DR_HAKYUN,
//				B.GWA,
//				A.GWAMOK_ID,
//				A.GWAMOK_SEQ,
//				A.ISU_ID,
//				A.HAKJUM,
//				A.JUMSU_1,
//				A.JUMSU_2,
//				A.JUMSU_3,
//				A.JUMSU_4,
//				A.JUMSU_5,
//				A.JUMSU,
//				A.HWANSAN_JUMSU,
//				A.PYENGJUM,
//				A.SUNGJUK_INJUNG,
//				A.JESU_YEAR,
//				A.JESU_HAKGI,
//				A.JESU_GWAMOK_ID,
//				A.JESU_GWAMOK_SEQ,
//				'0',
//				:gstru_uid_uname.uid,
//				:gstru_uid_uname.address,
//				SYSDATE,
//				NULL,
//				NULL,
//				NULL
//	FROM	HAKSA.SUGANG_TRANS	A,
//			HAKSA.JAEHAK_HAKJUK	B
//	WHERE	A.HAKBUN				=	B.HAKBUN
//	AND	A.YEAR				=	:ls_year
//	AND	A.HAKGI				=	:ls_hakgi
//	AND	A.HAKBUN				LIKE	:ls_hakbun
//	AND	(A.SUNGJUK_INJUNG	=	'Y'
//	OR		A.HWANSAN_JUMSU	=	'W'
//	OR		A.JESU_YEAR       > '1994')
//	AND	A.HAKJUM				> 0
//)	;
//
IF SQLCA.SQLCODE = 0 THEN
	COMMIT USING SQLCA ;
	MESSAGEBOX("확인","성적처리가 완료되었습니다.")
	
ELSE
	MESSAGEBOX("오류","성적처리중 오류가 발생되었습니다.~r~n" + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA ;
	
END IF

SetPointer(Arrow!)
st_sangtae.text = ''

end event

type dw_con from uo_dwfree within w_hsu304a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsu303a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

