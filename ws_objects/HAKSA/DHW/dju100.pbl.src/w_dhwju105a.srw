$PBExportHeader$w_dhwju105a.srw
$PBExportComments$[대학원졸업] 졸업사정대상자 선정
forward
global type w_dhwju105a from w_basewindow
end type
type st_cnt from statictext within w_dhwju105a
end type
type hpb_1 from hprogressbar within w_dhwju105a
end type
type cb_1 from commandbutton within w_dhwju105a
end type
type st_2 from statictext within w_dhwju105a
end type
type dw_con from uo_dwfree within w_dhwju105a
end type
end forward

global type w_dhwju105a from w_basewindow
st_cnt st_cnt
hpb_1 hpb_1
cb_1 cb_1
st_2 st_2
dw_con dw_con
end type
global w_dhwju105a w_dhwju105a

on w_dhwju105a.create
int iCurrent
call super::create
this.st_cnt=create st_cnt
this.hpb_1=create hpb_1
this.cb_1=create cb_1
this.st_2=create st_2
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_cnt
this.Control[iCurrent+2]=this.hpb_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_con
end on

on w_dhwju105a.destroy
call super::destroy
destroy(this.st_cnt)
destroy(this.hpb_1)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.dw_con)
end on

event open;call super::open;string	ls_hakgi, ls_year

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi 
end event

type ln_templeft from w_basewindow`ln_templeft within w_dhwju105a
end type

type ln_tempright from w_basewindow`ln_tempright within w_dhwju105a
end type

type ln_temptop from w_basewindow`ln_temptop within w_dhwju105a
end type

type ln_tempbuttom from w_basewindow`ln_tempbuttom within w_dhwju105a
end type

type ln_tempbutton from w_basewindow`ln_tempbutton within w_dhwju105a
end type

type ln_tempstart from w_basewindow`ln_tempstart within w_dhwju105a
end type

type uc_retrieve from w_basewindow`uc_retrieve within w_dhwju105a
end type

type uc_insert from w_basewindow`uc_insert within w_dhwju105a
end type

type uc_delete from w_basewindow`uc_delete within w_dhwju105a
end type

type uc_save from w_basewindow`uc_save within w_dhwju105a
end type

type uc_excel from w_basewindow`uc_excel within w_dhwju105a
end type

type uc_print from w_basewindow`uc_print within w_dhwju105a
end type

type st_line1 from w_basewindow`st_line1 within w_dhwju105a
end type

type st_line2 from w_basewindow`st_line2 within w_dhwju105a
end type

type st_line3 from w_basewindow`st_line3 within w_dhwju105a
end type

type uc_excelroad from w_basewindow`uc_excelroad within w_dhwju105a
end type

type ln_dwcon from w_basewindow`ln_dwcon within w_dhwju105a
end type

type st_cnt from statictext within w_dhwju105a
integer x = 2528
integer y = 880
integer width = 457
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 80269524
string text = "count"
alignment alignment = right!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_dhwju105a
integer x = 1024
integer y = 948
integer width = 1966
integer height = 84
unsignedinteger maxposition = 100
unsignedinteger position = 1
integer setstep = 10
end type

type cb_1 from commandbutton within w_dhwju105a
integer x = 2624
integer y = 1172
integer width = 357
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생 성"
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// - 졸업사정대상자를 생성한다.
//   1. 석사는 4학기 이상 등록자
//   2. 학적상태가 재학이거나 수료인자.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_hname, ls_hakgi_text
string ls_jonghap, ls_nonmun
double ld_pyengjum
long	ll_jol_hakjum, ll_isu_hakjum, ll_pilsu_hakjum, ll_sunsu_hakjum, ll_non_hakjum
long	ll_trans, ll_tot, ll_cnt, ls_injung_hakjum

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","학기를 선택하세요")
	return
end if

if messagebox("확인",ls_year +"년도 "+ ls_hakgi + "학기 졸업사정대상자를 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return

//기존자료 확인
SELECT	COUNT(*)
INTO	:ll_trans
FROM	HAKSA.D_JOLUP_SAJUNG
WHERE	YEAR	= :ls_year
AND	HAKGI	= :ls_hakgi 
USING SQLCA ;

if ll_trans > 0 then
	if messagebox("확인","기존 자료가 존재합니다.~r~n 삭제후 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	DELETE FROM	HAKSA.D_JOLUP_SAJUNG
			WHERE	YEAR	= :ls_year
			AND	HAKGI	= :ls_hakgi
			USING SQLCA ;
end if

Setpointer(HourGlass!)

//Progress Bar
SELECT	COUNT(*)
INTO	:ll_tot
FROM	HAKSA.D_HAKJUK
WHERE SANGTAE_ID	IN	('01', '05')
AND	(( GWAJUNG_ID	= 	'1'	AND	S_HAKGICHA >= '4' )	OR
		 ( GWAJUNG_ID	=	'5'	AND	S_HAKGICHA >= '2' ))
USING SQLCA ;

hpb_1.MaxPosition = ll_tot

//졸업사정대상자 생성(재학생/수료생)
//학번, 과정, 종합시험을 가져온다.
DECLARE CUR_TRANS CURSOR FOR
SELECT	HAKBUN,
			HNAME,
			GWAJUNG_ID,
			DECODE(JONGHAP_DATE, NULL, '0', '1')
FROM	HAKSA.D_HAKJUK
WHERE SANGTAE_ID	IN	('01', '05')
AND	(( GWAJUNG_ID	= 	'1'	AND	S_HAKGICHA >= '4' )	OR
		 ( GWAJUNG_ID	=	'5'	AND	S_HAKGICHA >= '2' ))
USING SQLCA ;
		
OPEN CUR_TRANS ;
DO
	FETCH	CUR_TRANS	INTO	:ls_hakbun, :ls_hname, :ls_gwajung, :ls_jonghap ;
		
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	//1. 각대학원별 졸업가능 학점.
	if ls_gwajung = '1' then
		ll_jol_hakjum = 30
	elseif ls_gwajung = '5' then
		ll_jol_hakjum = 12
	end if
		
	//2. 이수학점, 평점평균을 가져온다. (필수)
	SELECT	SUM(HAKJUM),
				SUM(DECODE(ISU_ID, '1', HAKJUM, '3', HAKJUM, 0)),
				ROUND(SUM(PYENGJUM) / SUM(HAKJUM), 2)
	INTO	:ll_isu_hakjum, 
			:ll_pilsu_hakjum,
			:ld_pyengjum			
	FROM	HAKSA.D_SUGANG
	WHERE	HWANSAN			<> 'F'
	AND	SUNGJUK_INJUNG	= '1'
	AND	HAKBUN			= :ls_hakbun 
	GROUP BY HAKBUN
	USING SQLCA ;
	
	//3. 선수학점을 가져온다.(ll_sunsu_hakjum)
	SELECT	SUM(HAKJUM)
	INTO	:ll_sunsu_hakjum
	FROM	HAKSA.D_SUNSU
	WHERE	HAKBUN	=	:ls_hakbun
	GROUP BY HAKBUN
	USING SQLCA ;

	//4. 논문심사 결과를 가져온다.
	SELECT	DECODE(A.PANJUNG, '1', '1', '0')
	INTO	:ls_nonmun
	FROM	HAKSA.D_NONMUN A,
			HAKSA.D_HAKJUK B
	WHERE	A.HAKBUN	(+)=	B.HAKBUN
	AND	A.HAKBUN	= :ls_hakbun 
	USING SQLCA ;
	
	//5. 인정학점을 가져온다.	
	SELECT	NVL(INJUNG_HAKJUM, 0) INJUNG_HAKJUM
	INTO		:ls_injung_hakjum
	FROM 		HAKSA.D_HAKJUK
	WHERE		HAKBUN			= :ls_hakbun
	USING SQLCA ;
	
	ll_isu_hakjum	=	ll_isu_hakjum + ls_injung_hakjum
	
	//이수학점이 졸업학점보다 많으면 특별학점을 계산 
	if ll_isu_hakjum > ll_jol_hakjum then
		ll_non_hakjum	=	ll_isu_hakjum - ll_jol_hakjum
		
	else
		ll_non_hakjum	=	0
		
	end if
	
	
	//5. D_JOLUP_SAJUNG생성.(ll_non_hakjum학점에 대한 내역을 가져와야 함.)
	INSERT INTO HAKSA.D_JOLUP_SAJUNG
	VALUES ( :ls_hakbun,			:ls_year,			:ls_hakgi,			:ls_hname,			:ls_gwajung,
				:ll_jol_hakjum,	:ll_isu_hakjum,	:ll_pilsu_hakjum,	:ll_sunsu_hakjum,	:ld_pyengjum,
				:ll_non_hakjum,	:ls_jonghap,		:ls_nonmun,			NULL,
				NULL,					NULL,					NULL,					NULL,
				NULL,					NULL) USING SQLCA ;
		
	if sqlca.sqlcode <> 0 then
		messagebox("오류",ls_hakbun + " 학번 작업중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
	
	//Progress Bar
	ll_cnt = ll_cnt + 1
	hpb_1.Position = ll_cnt
	st_cnt.text = string(ll_cnt) + ' / ' + string(ll_tot)	
	
LOOP WHILE TRUE
CLOSE CUR_TRANS ;

COMMIT USING SQLCA ;

Setpointer(Arrow!)
messagebox("확인","작업이 완료되었습니다.")

end event

type st_2 from statictext within w_dhwju105a
integer x = 55
integer y = 300
integer width = 4379
integer height = 100
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 32500968
string text = "졸업사정대상자 생성"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_dhwju105a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwju105a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

