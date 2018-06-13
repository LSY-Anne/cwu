$PBExportHeader$w_hgj301a.srw
$PBExportComments$[청운대]자격사정
forward
global type w_hgj301a from w_condition_window
end type
type dw_con from uo_dwfree within w_hgj301a
end type
type uo_1 from uo_imgbtn within w_hgj301a
end type
type uo_2 from uo_imgbtn within w_hgj301a
end type
type uo_3 from uo_imgbtn within w_hgj301a
end type
type uo_4 from uo_imgbtn within w_hgj301a
end type
type dw_main from uo_dwfree within w_hgj301a
end type
end forward

global type w_hgj301a from w_condition_window
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
uo_4 uo_4
dw_main dw_main
end type
global w_hgj301a w_hgj301a

type variables

end variables

on w_hgj301a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
this.uo_4=create uo_4
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.uo_3
this.Control[iCurrent+5]=this.uo_4
this.Control[iCurrent+6]=this.dw_main
end on

on w_hgj301a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.uo_4)
destroy(this.dw_main)
end on

event ue_retrieve;string	ls_year, ls_junhugi, ls_jaguk, ls_pyosi, ls_hakgwa
long ll_ans

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_junhugi   = dw_con.Object.junhugi[1]
ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = func.of_nvl(dw_con.Object.pyosi_id[1], '%') + '%'
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'

if (trim(ls_year) = '' Or Isnull(ls_year)) or (trim(ls_jaguk) = '' Or Isnull(ls_jaguk)) then
	messagebox("확인","사정년도, 자격명을 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("jaguk_id")
	return	 -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_junhugi, ls_jaguk, ls_pyosi, ls_hakgwa)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

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

type ln_templeft from w_condition_window`ln_templeft within w_hgj301a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hgj301a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hgj301a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hgj301a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hgj301a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hgj301a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hgj301a
end type

type uc_insert from w_condition_window`uc_insert within w_hgj301a
end type

type uc_delete from w_condition_window`uc_delete within w_hgj301a
end type

type uc_save from w_condition_window`uc_save within w_hgj301a
end type

type uc_excel from w_condition_window`uc_excel within w_hgj301a
end type

type uc_print from w_condition_window`uc_print within w_hgj301a
end type

type st_line1 from w_condition_window`st_line1 within w_hgj301a
end type

type st_line2 from w_condition_window`st_line2 within w_hgj301a
end type

type st_line3 from w_condition_window`st_line3 within w_hgj301a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hgj301a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hgj301a
end type

type gb_1 from w_condition_window`gb_1 within w_hgj301a
end type

type gb_2 from w_condition_window`gb_2 within w_hgj301a
end type

type dw_con from uo_dwfree within w_hgj301a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hgj301a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hgj301a
integer x = 215
integer y = 40
integer width = 517
integer taborder = 30
boolean bringtotop = true
string btnname = "사정대상자생성"
end type

event clicked;call super::clicked;string	ls_year, ls_junhugi, ls_junhugi_nm
int 	li_ans	,&
		li_count

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_junhugi   = dw_con.Object.junhugi[1]
If ls_junhugi = '1' Then
	ls_junhugi_nm = '전기'
Else
	ls_junhugi_nm = '후기'
End If

if trim(ls_year) = '' Or Isnull(ls_year) then
	messagebox("확인","선발년도를 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return	
end if

li_ans = messagebox("확인", ls_year + "학년도 "+ ls_junhugi_nm + " 교원자격 사정대상자를 생성하시겠습니까?"+&
							"~r~n졸업대상자가 생성되어있어야합니다.", question!, yesno!, 2)

if li_ans = 1 then
	
	SELECT COUNT(*)
	INTO		:li_count
	FROM		HAKSA.GJ_SAJUNG
	WHERE	YEAR = :ls_year
	AND		JUNHUGI = :ls_junhugi
	USING SQLCA ;
	
	if li_count > 0 then
		
		li_ans = messagebox("확인", "이미 생성된 자료가 있습니다" +&
								"~r~n기존 자료를 삭제하고 새로 생성하시겠습니까?", question!, yesno!, 2)
								
		if li_ans = 1 then
			
			DELETE FROM HAKSA.GJ_SAJUNG
			WHERE	YEAR = :ls_year
			AND	JUNHUGI = :ls_junhugi
			USING SQLCA ;
			
			if sqlca.sqlcode <>0 then
				messagebox("확인", "기존 자료 삭제를 실패하였습니다")
				return
			end if
			
		elseif li_ans = 2 then
			return
		end if
	end if	
	
	
	INSERT INTO	HAKSA.GJ_SAJUNG	(	SELECT	:ls_year					,
													:ls_junhugi						,
													A.HAKBUN		,
													A.JAGUK_ID	,
													A.PYOSI_ID	,
													0							,
													0							,
													0							,
													0.0						,
													0							,
													0.0						,
													A.SILSUP1				,
													A.SILSUP2				,
													NULL						,
													'N'						,
													NULL						,
													NULL						,
													NULL						,
													:gs_empCode,
													:gs_ip,
													SYSDATE					,
													:gs_empCode,
													:gs_ip,
													SYSDATE
										FROM		HAKSA.GJ_YEJUNGJA		A,
													HAKSA.JOLUP_SAJUNG	B
										WHERE	A.HAKBUN = B.HAKBUN
										AND	B.YEAR	= :ls_year
										AND	B.JUNHUGI	= :ls_junhugi
										AND	A.YEJUNG_YN = 'Y'
										AND	A.POGI_YN	= 'N'	) USING SQLCA ;
			
		
		
		if sqlca.sqlcode = 0 then
			li_ans = messagebox("확인", "자료이관을 성공하였습니다." +&
									"~r~n자료를 저장하시겠습니까?", question!, yesno!, 2)
									
			if li_ans = 1 then
				commit using sqlca;
				
			elseif li_ans = 2 then
				rollback using sqlca;
			end if
			
		else
			messagebox("확인", "자료이관을 실패하였습니다")
			return
		end if

elseif li_ans = 2 then
	return
end if
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hgj301a
integer x = 869
integer y = 40
integer width = 517
integer taborder = 40
boolean bringtotop = true
string btnname = "성적계산"
end type

event clicked;call super::clicked;/******************************
1. 교직학점, 교직성적 계산
2. 전공성적 계산
*******************************/
long		ll_row		,&
			ll_rowcount
int		li_ans
string	ls_hakbun	,&
			ls_gwamok	,&
			ls_gwamok_yn	,&
			ls_gwamok_gubun	,&
			ls_gwamok_sql
int		li_gwamok		,&
			li_gi_gwamok	,&
			li_gi_hakjum	,&
			li_hakjum_sql	,&
			li_gyojik		,&
			li_gyojik_hakjum	,&
			li_jungong			,&
			li_jungong_hakjum	,&
			li_silsup
double	ld_gyojik_tot	,&
			ld_gyojik_avg	,&
			ld_jungong_tot	,&
			ld_jungong_avg


ll_rowcount	= dw_main.rowcount()

if ll_rowcount < 1 then
	messagebox("확인", "교원자격 사정대상자를 조회하세요!")
	return
end if

li_ans = messagebox("확인", "교원자격 사정을 위한 성적을 계산하시겠습니까?", question!, yesno!, 2)

if li_ans = 1 then
	
	setpointer(hourglass!)
	
	for ll_row = 1 to ll_rowcount
				
		ls_hakbun = dw_main.getitemstring(ll_row, "gj_sajung_hakbun")
		
		//교직이수학점, 교직성적, 전공성적 계산		
		SELECT	SUM(DECODE(S.ISU_ID, '40', DECODE(S.HWANSAN_JUMSU, 'F', 0, S.HAKJUM), 0)) GYOJIK_ISU	,
					SUM(DECODE(S.ISU_ID, '40', S.HAKJUM		, 0))					GYOJIK_HAKJUM	,
					SUM(DECODE(S.ISU_ID, '40', S.JUMSU * S.HAKJUM	, 0))	GYOJIK_SUNGJUK	,
					SUM(DECODE(S.ISU_ID, '21', DECODE(S.HWANSAN_JUMSU, 'F', 0, S.HAKJUM),
												'22', DECODE(S.HWANSAN_JUMSU, 'F', 0, S.HAKJUM), 0))	JUNGONG_ISU	,
					SUM(DECODE(S.ISU_ID, '21', S.HAKJUM,
												'22', S.HAKJUM, 0))					JUNGONG_HAKJUM	,
					SUM(DECODE(S.ISU_ID, '21', S.JUMSU * S.HAKJUM	,
												'22', S.JUMSU * S.HAKJUM	, 0)) JUNGONG_SUNGJUK
		INTO		:li_gyojik			,
					:li_gyojik_hakjum	,
					:ld_gyojik_tot		,
					:li_jungong			,
					:li_jungong_hakjum	,
					:ld_jungong_tot					
		FROM		HAKSA.SUGANG	S
		WHERE		S.HAKBUN	= :ls_hakbun
		AND		S.SUNGJUK_INJUNG	= 'Y'
		GROUP BY S.HAKBUN
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then			
			
			if li_gyojik_hakjum = 0 then
				li_gyojik_hakjum = 1
			end if
			
			if li_jungong_hakjum = 0 then
				li_jungong_hakjum = 1
			end if
			
			ld_gyojik_avg	= ROUND(ld_gyojik_tot/li_gyojik_hakjum		, 1)
			ld_jungong_avg	= ROUND(ld_jungong_tot/li_jungong_hakjum	, 1)
			
			dw_main.setitem(ll_row, "gj_sajung_gyojik_hakjum", li_gyojik)
			dw_main.setitem(ll_row, "gj_sajung_gyojik_sungjuk", ld_gyojik_avg)
			dw_main.setitem(ll_row, "gj_sajung_jungong_hakjum", li_jungong)
			dw_main.setitem(ll_row, "gj_sajung_jungong_sungjuk", ld_jungong_avg)
		
		elseif sqlca.sqlcode = -1 then
			messagebox("오류", "성적계산을 실패하였습니다!")
			return			
		end if
			
		//기본이수과목수, 기본이수학점 계산
		SELECT	COUNT(A.GWAMOK_ID)	GWAMOKSU,
					SUM(B.HAKJUM)			HAKJUM
		INTO		:li_gi_gwamok,
					:li_gi_hakjum
		FROM		HAKSA.GJ_GIBON_GWAMOK	A,
					HAKSA.SUGANG			B
		WHERE		A.YEAR_FROM <= SUBSTR(:ls_hakbun, 1, 4)
		AND		(	A.YEAR_TO	 IS NULL
		OR			A.YEAR_TO	>= SUBSTR(:ls_hakbun, 1, 4) )
		AND		A.GWAMOK_ID		= B.GWAMOK_ID
		AND		A.GWAMOK_SEQ	= B.GWAMOK_SEQ
		AND		B.HAKBUN			= :ls_hakbun
		AND		B.SUNGJUK_INJUNG	= 'Y'
		AND		B.HWANSAN_JUMSU	<> 'F'
		GROUP BY B.HAKBUN	
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			li_gi_hakjum = 0
			li_gi_gwamok = 0
		end if
		
		dw_main.setitem(ll_row, "gj_sajung_gibon_hakjum", li_gi_hakjum)
		dw_main.setitem(ll_row, "gj_sajung_gibon_gwamoksu", li_gi_gwamok)
		
				
		//실습여부 체크
//		SELECT 	COUNT(HAKBUN)
//		INTO		:li_silsup
//		FROM		GJ_SILSUP
//		WHERE		HAKBUN = :ls_hakbun
//		AND		SIJUM IS NOT NULL
//		;
//		
//		if li_silsup > 0 then
//			dw_main.setitem(ll_row, "gj_sajung_silsup_yn", '1')
//		else
//			dw_main.setitem(ll_row, "gj_sajung_silsup_yn", '0')
//		end if
		
		
		
	next	
	
	li_ans	= messagebox("완료", "성적계산을 완료하였습니다" +&
								"~r~n자료를 저장하시겠습니까?", question!, yesno!, 2)
								
	if li_ans = 1 then
		
		dw_main.accepttext()
		
		li_ans = dw_main.update()
				
		IF li_ans = -1  THEN
			ROLLBACK USING SQLCA;
			messagebox('확인','저장을 실패하였습니다!')
		
		ELSE
			COMMIT USING SQLCA;
			messagebox('확인','저장을 완료하였습니다!')
		END IF
		
	elseif li_ans = 2 then
		rollback using sqlca;
	end if
	
elseif li_ans = 2 then
	return
end if
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type uo_3 from uo_imgbtn within w_hgj301a
integer x = 1413
integer y = 40
integer width = 517
integer taborder = 50
boolean bringtotop = true
string btnname = "자격사정"
end type

event clicked;call super::clicked;int		li_ans
long		ll_row		,&
			ll_rowcount	,&
			ll_count
string	ls_hakbun		,&
			ls_gibon_yn		,&
			ls_silsup_yn	,&
			ls_silsup2_yn	,&
			ls_silsup		,&
			ls_silsup2		,&
			ls_hapgyuk_yn	,&
			ls_iphak_gubun
int		li_isu_hakjum	,&
			li_isu_gwamok	,&
			li_gyo_hakjum	,&
			li_jun_hakjum	,&
			li_hakjum		,&
			li_gwamok		,&
			li_gyojik		,&
			li_jungong
double	ld_gyo_sungjuk	,&
			ld_jun_sungjuk	,&
			ld_sungjuk_1	,&
			ld_sungjuk_2

string	ls_year, ls_junhugi, ls_jaguk, ls_pyosi, ls_hakgwa

ll_rowcount	= dw_main.rowcount()

if ll_rowcount < 1 then
	messagebox("확인", "교원자격 사정대상자를 조회하세요!")
	return
end if

li_ans = messagebox("확인", "교원자격 사정을 진행하시겠습니까?", question!, yesno!, 2)

if li_ans = 1 then
	
	setpointer(hourglass!)
	
	for ll_row = 1 to ll_rowcount
		
		ls_hapgyuk_yn = 'N'
		
		ls_hakbun	= dw_main.getitemstring(ll_row, "gj_sajung_hakbun")
		ls_year		= dw_main.getitemstring(ll_row, "gj_sajung_year")
		ls_junhugi	= dw_main.getitemstring(ll_row, "gj_sajung_junhugi")
		ls_jaguk		= dw_main.getitemstring(ll_row, "gj_sajung_jaguk_id")
		ls_pyosi		= dw_main.getitemstring(ll_row, "gj_sajung_pyosi_id")
		ls_hakgwa	= dw_main.getitemstring(ll_row, "jaehak_hakjuk_gwa")
		ls_iphak_gubun	= dw_main.getitemstring(ll_row, "jaehak_hakjuk_iphak_gubun")
		
		li_isu_hakjum	= dw_main.getitemnumber(ll_row, "gj_sajung_gibon_hakjum"		)
		li_isu_gwamok	= dw_main.getitemnumber(ll_row, "gj_sajung_gibon_gwamoksu"		)
		li_gyo_hakjum	= dw_main.getitemnumber(ll_row, "gj_sajung_gyojik_hakjum"	)
		ld_gyo_sungjuk = dw_main.getitemnumber(ll_row, "gj_sajung_gyojik_sungjuk"	)
		li_jun_hakjum	= dw_main.getitemnumber(ll_row, "gj_sajung_jungong_hakjum"	)
		ld_jun_sungjuk = dw_main.getitemnumber(ll_row, "gj_sajung_jungong_sungjuk"	)
		ls_silsup_yn	= dw_main.getitemstring(ll_row, "gj_sajung_silsup_yn"			)
		ls_silsup2_yn	= dw_main.getitemstring(ll_row, "gj_sajung_silsup2_yn"		)
		
		//사정기준
		SELECT	GIBON_GWAMOKSU	,
					GIBON_HAKJUM	,
					GYOJIK_HAKJUM	,
					GYOJIK_SUNGJUK	,
					JUNGONG_HAKJUM	,
					JUNGONG_SUNGJUK,
					SILSUP_YN		,
					SILSUP2_YN
		INTO		:li_gwamok		,
					:li_hakjum		,					
					:li_gyojik		,
					:ld_sungjuk_1	,
					:li_jungong		,
					:ld_sungjuk_2	,
					:ls_silsup		,
					:ls_silsup2
		FROM		HAKSA.GJ_GIJUN
		WHERE		YEAR_SIJUM >= SUBSTR(:ls_hakbun, 1, 4)
		AND	(	YEAR_JONGJUM	 IS NULL
		OR			YEAR_JONGJUM	<= SUBSTR(:ls_hakbun, 1, 4) )
		AND		JAGUK_ID = :ls_jaguk
		AND		PYOSI_ID = :ls_pyosi
		AND		GWA			= :ls_hakgwa
		USING SQLCA ;

		if sqlca.sqlcode <> 0 then
			messagebox("확인", "사정기준 조회를 실패하였습니다!")
			return
		end if
		
		//편입생 교직이수학점 6학점 제외
		if ls_iphak_gubun = '04' then
			li_gyojik	= li_gyojik - 6
		end if
		
		
		//졸업가능여부 조회
		
		SELECT	COUNT(HAKBUN)
		INTO		:ll_count
		FROM		HAKSA.JOLUP_SAJUNG
		WHERE		HAKBUN	= :ls_hakbun
		AND		YEAR		= :ls_year
		AND		JUNHUGI  = :ls_junhugi
		AND		HAPGYUK_GUBUN = '1'
		USING SQLCA ;
		
		if sqlca.sqlcode = -1 then
			messagebox("확인", "졸업사정결과 조회를 실패하였습니다!")
			return
		end if
		
		if li_isu_hakjum < li_hakjum or li_isu_gwamok < li_gwamok or &
			li_gyo_hakjum < li_gyojik or li_jun_hakjum < li_jungong or &
			ld_gyo_sungjuk < ld_sungjuk_1 or ld_jun_sungjuk < ld_sungjuk_2 or &
			(ls_silsup = 'Y' and ls_silsup_yn = 'N') or (ls_silsup2 = 'Y' and ls_silsup2_yn = 'N') or ll_count = 0 then
			
			ls_hapgyuk_yn = 'N'
			
		else			
			ls_hapgyuk_yn = 'Y'
		end if
		
		dw_main.setitem(ll_row, "gj_sajung_hapgyuk_yn", ls_hapgyuk_yn)
		
	next
	
	li_ans	= messagebox("완료", "교원자격 사정을 완료하였습니다" +&
								"~r~n자료를 저장하시겠습니까?", question!, yesno!, 2)
								
	if li_ans = 1 then
		
		dw_main.accepttext()
		
		li_ans = dw_main.update()
				
		IF li_ans = -1  THEN
			ROLLBACK USING SQLCA;
			messagebox('확인','저장을 실패하였습니다!')
		
		ELSE
			COMMIT USING SQLCA;
			messagebox('확인','저장을 완료하였습니다!')
		END IF
		
	elseif li_ans = 2 then
		rollback using sqlca;
	end if
	
else
	return
end if

end event

on uo_3.destroy
call uo_imgbtn::destroy
end on

type uo_4 from uo_imgbtn within w_hgj301a
integer x = 1961
integer y = 40
integer width = 517
integer taborder = 60
boolean bringtotop = true
string btnname = "자격사항부여..."
end type

event clicked;call super::clicked;int	li_ans	,&
		li_jungseo_no
long	ll_row		,&
		ll_rowcount
string	ls_hapgyuk_yn	,&
			ls_musihumil	,&
			ls_balgupil		,&
			ls_jungseo		,&
			ls_gigwan		,&
			ls_yesno

s_jaguk_sahang s_jaguk

ll_rowcount	= dw_main.rowcount()

if ll_rowcount < 1 then
	messagebox("확인", "교원자격 사정대상자를 조회하세요!")	
	return
end if

if messagebox("확인", "선택한 교원자격 사항을 부여하시겠습니까?", question!, yesno!, 2) = 2 then return

openwithparm(w_hgj301pp, s_jaguk)

s_jaguk = message.powerobjectparm

ls_yesno		= s_jaguk.yesno

if ls_yesno = '0' then return 

ls_musihumil = s_jaguk.musihumil
ls_balgupil = s_jaguk.balgupil
ls_gigwan	= s_jaguk.gigwan

SELECT	MAX(NVL(TO_NUMBER(JUNG_NO), 0)) + 1					
INTO		:li_jungseo_no
FROM		HAKSA.GJ_SAJUNG
USING SQLCA ;

if sqlca.sqlcode = 100 then
	li_jungseo_no = 1
end if

setpointer(hourglass!)

for ll_row = 1 to ll_rowcount
	ls_hapgyuk_yn = dw_main.object.gj_sajung_hapgyuk_yn[ll_row]
	
	if s_jaguk.musihum_yn = 'Y' then
		dw_main.setitem(ll_row, "gj_sajung_musihumil", ls_musihumil)
	end if
	
	if s_jaguk.jung_yn = 'Y' and ls_hapgyuk_yn = 'Y' then
		ls_jungseo	= string(li_jungseo_no)
		dw_main.setitem(ll_row, "gj_sajung_jung_no", ls_jungseo)
		li_jungseo_no++
		
		dw_main.setitem(ll_row, "gj_sajung_gigwan_name", ls_gigwan)
	end if
	
	if s_jaguk.balgup_yn = 'Y' and ls_hapgyuk_yn = 'Y' then
		dw_main.setitem(ll_row, "gj_sajung_balgupil", ls_balgupil)
	end if
	
next	

li_ans	= messagebox("완료", "성적계산을 완료하였습니다" +&
							"~r~n자료를 저장하시겠습니까?", question!, yesno!, 2)
							
if li_ans = 1 then
	
	dw_main.accepttext()
	
	li_ans = dw_main.update()
			
	IF li_ans = -1  THEN
		ROLLBACK USING SQLCA;
		messagebox('확인','저장을 실패하였습니다!')
	
	ELSE
		COMMIT USING SQLCA;
		messagebox('확인','저장을 완료하였습니다!')
	END IF
	
elseif li_ans = 2 then
	rollback using sqlca;
end if



end event

on uo_4.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hgj301a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hgj301a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string	ls_hakbun, ls_hname, ls_hakgwa, ls_iphak_gubun, ls_year_sql

CHOOSE CASE dwo.name
	CASE 'hakbun'
				
		//편입생여부
		SELECT	A.HNAME,	A.GWA, A.IPHAK_GUBUN
		INTO		:ls_hname, :ls_hakgwa, :ls_iphak_gubun
		FROM		HAKSA.JAEHAK_HAKJUK	A
		WHERE	A.HAKBUN	= :data
		USING SQLCA ;
		
		if ls_iphak_gubun = '04' then
			this.object.jaehak_hakjuk_hname[row]	= ls_hname
			this.object.jaehak_hakjuk_gwa[row]		= ls_hakgwa
			this.object.jaehak_hakjuk_iphak_gubun[row]	= ls_iphak_gubun
		else
			messagebox('확인!', '편입생 교직이수예정자 입력만 가능합니다!')
			this.object.hakbun[row] = ''
			return 1
		end if
		
		//기 신청여부
		SELECT	YEAR
		INTO		:ls_year_sql
		FROM		HAKSA.GJ_SINCHUNG
		WHERE		HAKBUN	= :data
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			messagebox('확인!', ls_year_sql + '년도에 교원자격을 신청하였습니다!')
			this.object.hakbun[row] = ''
			return 1
		end if		
		
END CHOOSE

end event

event itemerror;call super::itemerror;return 2
end event

