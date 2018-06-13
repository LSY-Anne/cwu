$PBExportHeader$w_hgj202a.srw
$PBExportComments$[청운대]이수예정대상자생성
forward
global type w_hgj202a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hgj202a
end type
type dw_con from uo_dwfree within w_hgj202a
end type
type uo_1 from uo_imgbtn within w_hgj202a
end type
type uo_2 from uo_imgbtn within w_hgj202a
end type
end forward

global type w_hgj202a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
end type
global w_hgj202a w_hgj202a

type variables

end variables

on w_hgj202a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.uo_2
end on

on w_hgj202a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event ue_retrieve;string	ls_year, ls_jaguk, ls_pyosi, ls_hakgwa
long ll_ans

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = func.of_nvl(dw_con.Object.pyosi_id[1], '%') + '%'
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'

if (trim(ls_year) = '' Or Isnull(ls_year)) or (trim(ls_jaguk) = '' Or Isnull(ls_jaguk)) then
	messagebox("확인","신청년도, 자격명을 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("jaguk_id")
	return	 -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_jaguk, ls_pyosi, ls_hakgwa)

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

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

ls_year	= f_haksa_iljung_year()

dw_con.Object.year[1]   = ls_year

end event

type ln_templeft from w_condition_window`ln_templeft within w_hgj202a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hgj202a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hgj202a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hgj202a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hgj202a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hgj202a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hgj202a
end type

type uc_insert from w_condition_window`uc_insert within w_hgj202a
end type

type uc_delete from w_condition_window`uc_delete within w_hgj202a
end type

type uc_save from w_condition_window`uc_save within w_hgj202a
end type

type uc_excel from w_condition_window`uc_excel within w_hgj202a
end type

type uc_print from w_condition_window`uc_print within w_hgj202a
end type

type st_line1 from w_condition_window`st_line1 within w_hgj202a
end type

type st_line2 from w_condition_window`st_line2 within w_hgj202a
end type

type st_line3 from w_condition_window`st_line3 within w_hgj202a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hgj202a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hgj202a
end type

type gb_1 from w_condition_window`gb_1 within w_hgj202a
integer height = 208
end type

type gb_2 from w_condition_window`gb_2 within w_hgj202a
integer y = 336
integer height = 88
end type

type dw_main from uo_input_dwc within w_hgj202a
integer x = 50
integer y = 456
integer width = 4384
integer height = 1804
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hgj202a"
end type

event itemchanged;string	ls_hakbun, ls_hname, ls_hakgwa, ls_iphak_gubun, ls_year_sql

CHOOSE CASE dwo.name
	CASE 'hakbun'
				
		//편입생여부
		SELECT	A.HNAME,	A.GWA, A.IPHAK_GUBUN
		INTO		:ls_hname, :ls_hakgwa, :ls_iphak_gubun
		FROM		HAKSA.JAEHAK_HAKJUK	A
		WHERE		A.HAKBUN	= :data
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

type dw_con from uo_dwfree within w_hgj202a
integer x = 50
integer y = 164
integer width = 4384
integer height = 284
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hgj202a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hgj202a
integer x = 325
integer y = 40
integer width = 649
integer taborder = 20
boolean bringtotop = true
string btnname = "선발대상자생성"
end type

event clicked;call super::clicked;string 	ls_year, ls_jaguk, ls_pyosi, ls_hakgwa, ls_hakyun, ls_hakbun
long		ll_ans
int		li_count

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = dw_con.Object.pyosi_id[1]
ls_hakgwa	= dw_con.Object.gwa[1]
ls_hakyun	= dw_con.Object.hakyun[1]

if trim(ls_year) = '' or trim(ls_jaguk) = '' or trim(ls_pyosi) = '' or trim(ls_hakgwa) = '' then
	messagebox("확인","신청년도, 자격명, 표시과목, 학과를 입력하세요!")
	return	
end if

if messagebox('확인','이수예정자 선발 대상자를 '+&
					'~r~n생성하시겠습니까?',question!,yesno!,2)=2 then return
					
SELECT	COUNT(A.HAKBUN)
INTO		:ll_ans
FROM		HAKSA.GJ_YEJUNGJA		A,
			HAKSA.JAEHAK_HAKJUK	B
WHERE		A.HAKBUN	= B.HAKBUN
AND		A.YEAR	= :ls_year
AND		A.JAGUK_ID	= :ls_jaguk
AND		A.PYOSI_ID	= :ls_pyosi
AND		B.GWA		= :ls_hakgwa
USING SQLCA ;

if ll_ans > 0 then
	if messagebox('확인','이미 자료가 생성되었습니다'+&
					'~r~n삭제후 재생성하시겠습니까?',question!,yesno!,2) = 2 then return
	
	DELETE FROM HAKSA.GJ_YEJUNGJA	A
	WHERE		A.YEAR	= :ls_year
	AND		A.JAGUK_ID	= :ls_jaguk
	AND		A.PYOSI_ID	= :ls_pyosi
	AND		A.HAKBUN		IN	(	SELECT	HAKBUN
										FROM		HAKSA.JAEHAK_HAKJUK
										WHERE		GWA = :ls_hakgwa	)
	USING SQLCA ;
										
	if sqlca.sqlcode <> 0 then
		messagebox('확인','자료삭제 중 오류가 발생하였습니다!')
		return
	end if
end if

DECLARE CUR_HAKBUN	CURSOR FOR
SELECT	A.HAKBUN
FROM		HAKSA.GJ_SINCHUNG		A,
			HAKSA.JAEHAK_HAKJUK	B
WHERE		A.HAKBUN	= B.HAKBUN
AND		A.JAGUK_ID	= :ls_jaguk
AND		A.PYOSI_ID	= :ls_pyosi
AND		B.GWA			= :ls_hakgwa
AND		B.DR_HAKYUN	= :ls_hakyun
AND		A.SUNBAL_YN	= 'Y'
AND		B.SANGTAE = '01'	
USING SQLCA ;

OPEN CUR_HAKBUN	;

DO
	FETCH	CUR_HAKBUN	INTO	:ls_hakbun	;
	
	IF SQLCA.SQLCODE <> 0 THEN
		EXIT
	END IF
	
	//기 예정자여부
	SELECT	COUNT(HAKBUN)
	INTO		:li_count
	FROM		HAKSA.GJ_YEJUNGJA
	WHERE		HAKBUN	= :ls_hakbun
	USING SQLCA ;
	
	if li_count > 0 then
		continue
	end if
	
	INSERT	INTO HAKSA.GJ_YEJUNGJA (	YEAR, JAGUK_ID, PYOSI_ID, HAKBUN	)
	VALUES	(:ls_year, :ls_jaguk, :ls_pyosi, :ls_hakbun	) USING SQLCA ;

	if sqlca.sqlcode <> 0 then
		rollback USING SQLCA ;
		messagebox('확인','자료생성 중 오류가 발생하였습니다!')
		return
	end if
LOOP WHILE TRUE

CLOSE CUR_HAKBUN;

COMMIT USING SQLCA ;

MESSAGEBOX('확인','대상자 생성을 완료하였습니다!')



end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hgj202a
integer x = 1102
integer y = 40
integer width = 457
integer taborder = 30
boolean bringtotop = true
string btnname = "성적계산"
end type

event clicked;call super::clicked;string	ls_year, ls_jaguk, ls_pyosi, ls_hakgwa
string	ls_hakbun,   ls_hakyun,   ls_hakgi
double	ld_pyungjum, ld_siljum
long 		ll_chidk, ll_ans

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_jaguk	    = func.of_nvl(dw_con.Object.jaguk_id[1], '%') + '%'
ls_pyosi	    = func.of_nvl(dw_con.Object.pyosi_id[1], '%') + '%'
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_hakyun	= dw_con.Object.hakyun1[1]
ls_hakgi  	= dw_con.Object.hakgi[1]

if trim(ls_year) = '' Or Isnull(ls_year) then
	messagebox("확인","선발년도를 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return	
end if

if isnull(ls_hakyun) OR trim(ls_hakyun) = '' then
	messagebox("확인","성적계산기준 학년을 선택하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("hakyun1")
	return	
end if

if isnull(ls_hakgi) OR trim(ls_hakgi) = '' then
	messagebox("확인","성적계산기준 학기를 선택하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return	
end if

if messagebox('확인','교직신청자의 성적계산을 '&
					+ '~r~n실행 하시겠습니까?',question!,yesno!,2)=2 then return

DECLARE CUR_HAKBUN	CURSOR FOR
	SELECT	B.HAKBUN
	FROM		HAKSA.JAEHAK_HAKJUK	A,
				HAKSA.GJ_YEJUNGJA		B
	WHERE		A.HAKBUN	= B.HAKBUN
	AND		B.YEAR	= :ls_year
	AND		B.JAGUK_ID	LIKE	:ls_jaguk
	AND		B.PYOSI_ID	LIKE	:ls_pyosi
	AND		A.GWA			LIKE	:ls_hakgwa
	AND		A.IPHAK_GUBUN	<> '04'
	USING SQLCA ;
	
OPEN	CUR_HAKBUN;

DO
	FETCH CUR_HAKBUN	INTO	:ls_hakbun	;
	
	IF SQLCA.SQLCODE <> 0 THEN
		EXIT
	END IF
	
	//평점평균, 실점합
	SELECT	ROUND(SUM(PYENGJUM * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, HAKJUM)), 2) ,
				ROUND(SUM(JUMSU * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, HAKJUM)), 2),
				SUM(DECODE(HWANSAN_JUMSU, 'F', 0, HAKJUM))
	INTO		:ld_pyungjum	,
				:ld_siljum		,
				:ll_chidk
	FROM 		HAKSA.SUGANG
//	WHERE 	HAKYUN		IN	('1', '2', '3')
   WHERE    HAKYUN || HAKGI  <= :ls_hakyun || :ls_hakgi
	AND		HAKBUN 			   = :ls_hakbun
	AND		SUNGJUK_INJUNG    = 'Y'
	AND      HAKGI            IN('1', '2')
	AND      nvl(hakyun, ' ') <> ' '
	GROUP BY HAKBUN
	USING SQLCA ;
	
	UPDATE	HAKSA.GJ_YEJUNGJA
	SET		PYUNGJUM		= :ld_pyungjum,
				SILJUM		= :ld_siljum,
				CHIDK			= :ll_chidk
	WHERE		HAKBUN		= :ls_hakbun
	USING SQLCA ;
	
	IF SQLCA.SQLCODE <> 0 THEN
		ROLLBACK USING SQLCA ;
		MESSAGEBOX('확인','성적계산을 실패하였습니다!')
		return
	END IF
	
	ld_pyungjum = 0
	ld_siljum = 0
	ll_chidk = 0
	
LOOP WHILE TRUE

CLOSE CUR_HAKBUN;

COMMIT USING SQLCA ;

MESSAGEBOX('확인','성적계산을 완료하였습니다!')
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

