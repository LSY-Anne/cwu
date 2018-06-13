$PBExportHeader$w_dhwsu204a.srw
$PBExportComments$[대학원수업] 성적사정및 보관용성적 생성
forward
global type w_dhwsu204a from w_basewindow
end type
type st_cnt from statictext within w_dhwsu204a
end type
type hpb_1 from hprogressbar within w_dhwsu204a
end type
type cb_2 from commandbutton within w_dhwsu204a
end type
type cb_1 from commandbutton within w_dhwsu204a
end type
type st_2 from statictext within w_dhwsu204a
end type
type dw_con from uo_dwfree within w_dhwsu204a
end type
end forward

global type w_dhwsu204a from w_basewindow
st_cnt st_cnt
hpb_1 hpb_1
cb_2 cb_2
cb_1 cb_1
st_2 st_2
dw_con dw_con
end type
global w_dhwsu204a w_dhwsu204a

on w_dhwsu204a.create
int iCurrent
call super::create
this.st_cnt=create st_cnt
this.hpb_1=create hpb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_cnt
this.Control[iCurrent+2]=this.hpb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_con
end on

on w_dhwsu204a.destroy
call super::destroy
destroy(this.st_cnt)
destroy(this.hpb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.dw_con)
end on

event open;call super::open;string	ls_hakgi, ls_year

//idw_print = dw_main

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

type ln_templeft from w_basewindow`ln_templeft within w_dhwsu204a
end type

type ln_tempright from w_basewindow`ln_tempright within w_dhwsu204a
end type

type ln_temptop from w_basewindow`ln_temptop within w_dhwsu204a
end type

type ln_tempbuttom from w_basewindow`ln_tempbuttom within w_dhwsu204a
end type

type ln_tempbutton from w_basewindow`ln_tempbutton within w_dhwsu204a
end type

type ln_tempstart from w_basewindow`ln_tempstart within w_dhwsu204a
end type

type uc_retrieve from w_basewindow`uc_retrieve within w_dhwsu204a
end type

type uc_insert from w_basewindow`uc_insert within w_dhwsu204a
end type

type uc_delete from w_basewindow`uc_delete within w_dhwsu204a
end type

type uc_save from w_basewindow`uc_save within w_dhwsu204a
end type

type uc_excel from w_basewindow`uc_excel within w_dhwsu204a
end type

type uc_print from w_basewindow`uc_print within w_dhwsu204a
end type

type st_line1 from w_basewindow`st_line1 within w_dhwsu204a
end type

type st_line2 from w_basewindow`st_line2 within w_dhwsu204a
end type

type st_line3 from w_basewindow`st_line3 within w_dhwsu204a
end type

type uc_excelroad from w_basewindow`uc_excelroad within w_dhwsu204a
end type

type ln_dwcon from w_basewindow`ln_dwcon within w_dhwsu204a
end type

type st_cnt from statictext within w_dhwsu204a
integer x = 2601
integer y = 952
integer width = 457
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
long backcolor = 16777215
string text = "count"
alignment alignment = right!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_dhwsu204a
integer x = 1097
integer y = 1032
integer width = 1966
integer height = 84
unsignedinteger maxposition = 100
unsignedinteger position = 1
integer setstep = 10
end type

type cb_2 from commandbutton within w_dhwsu204a
integer x = 2670
integer y = 1256
integer width = 375
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "성적이관"
end type

event clicked;string ls_year, ls_hakgi, ls_hakbun
long ll_sugang

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'

if messagebox("확인",ls_year +"년도 "+ ls_hakgi + "학기 보관용 성적을 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return

//기존자료 확인
SELECT	COUNT(*)
INTO 		:ll_sugang
FROM		HAKSA.D_SUGANG
WHERE 	YEAR	= :ls_year
AND		HAKGI	= :ls_hakgi
AND		HAKBUN	like :ls_hakbun 
USING SQLCA ;

if ll_sugang > 0 then
	if messagebox("확인","기존 자료가 존재합니다.~r~n 삭제후 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	
	DELETE FROM HAKSA.D_SUGANG
	WHERE		YEAR	= :ls_year	
	AND		HAKGI	= :ls_hakgi
	AND		HAKBUN	like :ls_hakbun	
	USING SQLCA ;
			
	IF SQLCA.SQLCODE <> 0 THEN
		MESSAGEBOX("확인","자료삭제중 오류가 발생되었습니다.~R~N" + SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA ;
		RETURN
	END IF
end if

//자료생성
INSERT INTO HAKSA.D_SUGANG
(SELECT	A.HAKBUN			,
			A.YEAR			,
			A.HAKGI			,
			B.S_HAKGICHA	,
			A.GWAMOK_ID		,
			A.ISU_ID			,
			A.HAKJUM			,
			A.JUMSU			,
			A.PYENGJUM		,
			A.HWANSAN		,
			A.JESU_GUBUN	,
			A.JESU_YEAR		,
			A.JESU_HAKGI	,
			A.NONMUN_YN		,
			A.SUNGJUK_INJUNG	,
			:gs_empcode	,
			:gs_ip		,
			SYSDATE	,
			NULL		,
			NULL		,
			NULL
FROM		HAKSA.D_SUGANG_TRANS	A,
			HAKSA.D_HAKJUK			B
WHERE		A.HAKBUN				=	B.HAKBUN
AND		A.YEAR				= :ls_year
AND		A.HAKGI				= :ls_hakgi
AND		A.SUNGJUK_INJUNG	= '1'
AND		A.HAKBUN			like :ls_hakbun
) USING SQLCA ;

if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	messagebox("확인","성적이관이 완료되었습니다.")
else
	messagebox("오류","성적이관중 오류가 발생되었습니다. ~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	
end if
end event

type cb_1 from commandbutton within w_dhwsu204a
integer x = 2290
integer y = 1256
integer width = 375
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "성적사정"
end type

event clicked;string ls_year, ls_hakgi, ls_hakbun
double ld_pyen_tot, ld_pyen_avg, ld_hwan_tot, ld_hwan_avg
long ll_sin_hakjum, ll_sin_gwamok, ll_pass_hakjum, ll_pass_gwamok, ll_tot, ll_cnt, ll_sungjuk, ll_f_cnt, ll_input

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'

if messagebox("확인",ls_year +"년도 "+ ls_hakgi + "학기 성적사정을 실행하시겠습니까?", Question!, YesNo!, 2) = 2 then return

//기존자료 확인
SELECT	count(*)
INTO 		:ll_sungjuk
FROM		HAKSA.D_SUNGJUKGYE
WHERE		YEAR	= :ls_year
AND		HAKGI	= :ls_hakgi
AND		HAKBUN	like	:ls_hakbun
USING SQLCA ;

if ll_sungjuk > 0 then
	if messagebox("확인","기존 자료가 존재합니다.~r~n 삭제후 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	
	DELETE FROM	HAKSA.D_SUNGJUKGYE
	WHERE	YEAR	= :ls_year	AND
			HAKGI	= :ls_hakgi	AND
			HAKBUN	like	:ls_hakbun
	USING SQLCA ;
end if

Setpointer(HourGlass!)

//Progress Bar
SELECT	count( DISTINCT HAKBUN)
INTO 		:ll_tot
FROM		HAKSA.D_SUGANG_TRANS
WHERE		YEAR				= :ls_year
AND		HAKGI				= :ls_hakgi
AND		SUNGJUK_INJUNG	= '1' 
AND		HAKBUN	like	:ls_hakbun
USING SQLCA ;

//Progress Bar
hpb_1.SetRange(0 , ll_tot)
hpb_1.setstep = 1

//성적사정
DECLARE	CUR_SAJUNG	CURSOR FOR
SELECT	HAKBUN,
			COUNT(HAKBUN),
			SUM(HAKJUM),
			SUM(DECODE(HWANSAN, 'F', 0, 1)),
			SUM(DECODE(HWANSAN, 'F', 0, hakjum)),
			SUM(PYENGJUM),
			ROUND(SUM(PYENGJUM) / SUM(HAKJUM), 2),
			SUM(JUMSU * HAKJUM),
			ROUND(SUM(JUMSU * HAKJUM) / SUM(HAKJUM), 2) 
FROM		HAKSA.D_SUGANG_TRANS
WHERE 	YEAR				= :ls_year
AND		HAKGI				= :ls_hakgi
AND		SUNGJUK_INJUNG = '1'
AND		HAKBUN	like	:ls_hakbun
GROUP BY HAKBUN
USING SQLCA ;
		
OPEN CUR_SAJUNG ;
DO
	FETCH	CUR_SAJUNG
	INTO	:ls_hakbun,		:ll_sin_gwamok,	:ll_sin_hakjum,	:ll_pass_gwamok,	:ll_pass_hakjum, 
			:ld_pyen_tot,	:ld_pyen_avg,		:ld_hwan_tot,		:ld_hwan_avg ;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	INSERT INTO HAKSA.D_SUNGJUKGYE
	VALUES ( :ls_hakbun,			:ls_year,			:ls_hakgi,		:ll_sin_gwamok,	:ll_sin_hakjum,
				:ll_pass_gwamok,	:ll_pass_hakjum,	:ld_pyen_tot,	:ld_pyen_avg,		:ld_hwan_tot,
				:ld_hwan_avg,		'1',					:gs_empcode,	:gs_ip,
				SYSDATE,				NULL,					NULL,				NULL) USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","성적사정중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext )
		rollback USING SQLCA ;
		return
	end if
	
	//Progress Bar
	ll_cnt = ll_cnt + 1
	hpb_1.StepIt()
	st_cnt.text = string(ll_cnt) + ' / ' + string(ll_tot)	
	
LOOP WHILE TRUE
CLOSE CUR_SAJUNG ;

COMMIT USING SQLCA ;

Setpointer(Arrow!)
messagebox("확인","작업이 완료되었습니다.")
end event

type st_2 from statictext within w_dhwsu204a
integer x = 55
integer y = 292
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
string text = "성적사정 및 보관용성적 생성"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_dhwsu204a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwsu204a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

