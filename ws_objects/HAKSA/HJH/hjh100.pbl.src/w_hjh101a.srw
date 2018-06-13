$PBExportHeader$w_hjh101a.srw
$PBExportComments$[청운대]장학배정관리
forward
global type w_hjh101a from w_condition_window
end type
type st_5 from statictext within w_hjh101a
end type
type st_6 from statictext within w_hjh101a
end type
type dw_con from uo_dwfree within w_hjh101a
end type
type uo_1 from uo_imgbtn within w_hjh101a
end type
type uo_2 from uo_imgbtn within w_hjh101a
end type
type dw_2 from uo_dwfree within w_hjh101a
end type
type dw_main from uo_dwfree within w_hjh101a
end type
end forward

global type w_hjh101a from w_condition_window
st_5 st_5
st_6 st_6
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
dw_2 dw_2
dw_main dw_main
end type
global w_hjh101a w_hjh101a

forward prototypes
public function any uf_baejung90 (long as_inwon)
public function any uf_baejung80 (long as_inwon)
public function any uf_baejung70 (long as_inwon)
public function any uf_baejung120 (long as_inwon)
public function any uf_baejung130 (long as_inwon)
public function any uf_baejung180 (long as_inwon)
public function any uf_baejung160 (long as_inwon)
public function any uf_baejung60 (long as_inwon)
public function any uf_baejung40 (long as_inwon)
public function any uf_baejung30 (long as_inwon)
public function any uf_baejung110 (long as_inwon)
end prototypes

public function any uf_baejung90 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 68  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 3
	ll_woosu4 = 0
elseif as_inwon >= 54 and as_inwon <= 67 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon >= 45 and as_inwon <= 53 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 45 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung80 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 60  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 3
	ll_woosu4 = 0
elseif as_inwon >= 48 and as_inwon <= 59 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon >= 40 and as_inwon <= 47 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 40 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung70 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 53  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 3
	ll_woosu4 = 0
elseif as_inwon >= 42 and as_inwon <= 52 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon >= 35 and as_inwon <= 41 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 35 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung120 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 90  then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 72 and as_inwon <= 89 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 60 and as_inwon <= 71 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon < 60 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 2
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung130 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 98  then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 78 and as_inwon <= 97 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 65 and as_inwon <= 77 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon < 65 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 2
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung180 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 135  then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 7
	ll_woosu4 = 0
elseif as_inwon >= 108 and as_inwon <= 134 then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 5
	ll_woosu4 = 0
elseif as_inwon >= 90 and as_inwon <= 107 then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 3
	ll_woosu4 = 0
elseif as_inwon < 90 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 2
	ll_woosu4 = 2
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung160 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 120  then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 7
	ll_woosu4 = 0
elseif as_inwon >= 96 and as_inwon <= 119 then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 5
	ll_woosu4 = 0
elseif as_inwon >= 80 and as_inwon <= 95 then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 3
	ll_woosu4 = 0
elseif as_inwon < 80 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 2
	ll_woosu4 = 2
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung60 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 45  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon >= 36 and as_inwon <= 44 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 0
	ll_woosu4 = 0
elseif as_inwon >= 30 and as_inwon <= 35 then
	ll_woosu1 = 1
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 30 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung40 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 30  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon >= 24 and as_inwon <= 29 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 0
	ll_woosu4 = 0
elseif as_inwon >= 20 and as_inwon <= 23 then
	ll_woosu1 = 1
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 20 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung30 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 23  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon >= 18 and as_inwon <= 22 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 0
	ll_woosu4 = 0
elseif as_inwon >= 15 and as_inwon <= 17 then
	ll_woosu1 = 1
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 15 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung110 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 83  then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 66 and as_inwon <= 82 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 55 and as_inwon <= 65 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon < 55 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 2
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

on w_hjh101a.create
int iCurrent
call super::create
this.st_5=create st_5
this.st_6=create st_6
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_2=create dw_2
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_main
end on

on w_hjh101a.destroy
call super::destroy
destroy(this.st_5)
destroy(this.st_6)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_2)
destroy(this.dw_main)
end on

event ue_retrieve;integer		li_row
string	ls_year, ls_hakgi, ls_hakyun, ls_gwa, ls_sgwa, ls_tyear, ls_thakgi

//성적장학 대상자 선정
ls_tyear 	= f_haksa_iljung_year() 
ls_thakgi	= f_haksa_iljung_hakgi()

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]


if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "장학배정년도와 학기를 입력하세요!")
	return -1 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ls_gwa    	=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_sgwa		=  left(ls_gwa,3) + '%'
	
li_row = dw_main.retrieve(ls_year, ls_hakgi, ls_hakyun, ls_gwa)

dw_2.retrieve(ls_tyear, ls_thakgi, ls_hakyun, ls_sgwa)

if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
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

event ue_save;int	li_ans, li_hakseng_su

dw_main.AcceptText()

li_ans = dw_main.update()		//	자료의 저장

IF li_ans = -1  THEN
	ROLLBACK USING SQLCA;
	uf_messagebox(3)       	//	저장오류 메세지 출력

ELSE

	uf_messagebox(2)       //	저장확인 메세지 출력
END IF

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjh101a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh101a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh101a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh101a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh101a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh101a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh101a
end type

type uc_insert from w_condition_window`uc_insert within w_hjh101a
end type

type uc_delete from w_condition_window`uc_delete within w_hjh101a
end type

type uc_save from w_condition_window`uc_save within w_hjh101a
end type

type uc_excel from w_condition_window`uc_excel within w_hjh101a
end type

type uc_print from w_condition_window`uc_print within w_hjh101a
end type

type st_line1 from w_condition_window`st_line1 within w_hjh101a
end type

type st_line2 from w_condition_window`st_line2 within w_hjh101a
end type

type st_line3 from w_condition_window`st_line3 within w_hjh101a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh101a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh101a
end type

type gb_1 from w_condition_window`gb_1 within w_hjh101a
end type

type gb_2 from w_condition_window`gb_2 within w_hjh101a
end type

type st_5 from statictext within w_hjh101a
integer x = 55
integer y = 300
integer width = 1298
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 15793151
long backcolor = 8388736
string text = "학과별 성적장학대상자"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_6 from statictext within w_hjh101a
integer x = 1385
integer y = 300
integer width = 3049
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 15793151
long backcolor = 8388736
string text = "성적장학인원배정"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hjh101a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_hjh101a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjh101a
integer x = 581
integer y = 40
integer width = 475
integer taborder = 30
boolean bringtotop = true
string btnname = "성적장학사정"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string	ls_juya, ls_gwa, ls_hakbun, ls_hakyun, ls_hakgi, ls_year, ls_tyear, ls_thakgi
int		li_jungwon

setpointer(hourglass!)
dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

//성적계산상의 현년도 학기를 가져온다.
ls_tyear 	= f_haksa_iljung_year()
ls_thakgi	= f_haksa_iljung_hakgi()

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "장학배정년도와 학기를 입력하세요!")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ls_gwa	=	dw_con.getitemstring(1,"gwa") + '%'

//학과별 순위 SETTING
IF	ls_thakgi	=	'1' THEN 
	DECLARE	CUR_HAKGWA	CURSOR FOR
				SELECT	DISTINCT GWA,
							HAKYUN
				FROM		HAKSA.SUNGJUKGYE
				WHERE		F_CNT = 0
				AND		YEAR	=		:ls_tyear 
				AND		HAKGI	=		:ls_thakgi
				AND		GWA	like	:ls_gwa
				GROUP BY GWA,
							HAKYUN
			     USING SQLCA ;
				  
	OPEN CUR_HAKGWA	;
ELSE
	DECLARE	CUR_HAKGWA1	CURSOR FOR
				SELECT	DISTINCT GWA,
							HAKYUN
				FROM		HAKSA.SUNGJUKGYE
				WHERE		F_CNT = 0
				AND		YEAR	=		:ls_tyear 
				AND		HAKGI	=		:ls_thakgi
				AND		GWA	like	:ls_gwa
				AND		HAKYUN	<>	'4'
				GROUP BY GWA,
							HAKYUN
			     USING SQLCA ;
	OPEN CUR_HAKGWA1	;	
END IF

DO
IF	ls_thakgi	=	'1' THEN 
	FETCH CUR_HAKGWA INTO 	:ls_gwa, :ls_hakyun	;
ELSE
	FETCH CUR_HAKGWA1 INTO 	:ls_gwa, :ls_hakyun	;
END IF
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	UPDATE	HAKSA.SUNGJUKGYE	M
	SET		M.JH_SUKCHA	=	(	SELECT	C.SUNWI
										FROM	(	SELECT	A.HAKBUN,
																RANK() OVER ( ORDER BY 		B.AVG_PYENGJUM DESC,
																									B.CHIDK_HAKJUM DESC,
																									C.TOT_JUMSU		DESC,
																									C.JENPIL 		DESC,
																									C.JENSEN 		DESC,
																									C.GOOYANG 		DESC  )AS SUNWI
													FROM		HAKSA.JAEHAK_HAKJUK	A,
																HAKSA.SUNGJUKGYE		B,		
																(	SELECT	A.YEAR,	
																				A.HAKGI,	
																				A.HAKBUN,
																				SUM(A.HAKJUM * A.JUMSU) TOT_JUMSU,
																				SUM(DECODE(A.ISU_ID, '21', A.HAKJUM * A.JUMSU, 0)) JENPIL,
																				SUM(DECODE(A.ISU_ID, '22', A.HAKJUM * A.JUMSU, 0))	JENSEN,
																				SUM(DECODE(SUBSTR(A.ISU_ID, 1, 1), '1', A.HAKJUM * A.JUMSU, 0)) GOOYANG,
																				SUM(DECODE(SUBSTR(ISU_ID, 1, 1), '2', A.HAKJUM, '5', A.HAKJUM, '6', A.HAKJUM, 0)) JUN_HAKJUM,
																				SUM(DECODE(A.HWANSAN_JUMSU,'W', 1, 0)) W_CNT
																	FROM 		HAKSA.SUGANG A
																	WHERE		A.YEAR		= :ls_tyear
																	AND		A.HAKGI 		= :ls_thakgi
																	AND		A.HAKYUN 	= :ls_hakyun
																	AND  		A.GWA 		= :ls_gwa
																	GROUP BY A.YEAR,	
																				A.HAKGI,	
																				A.HAKBUN) C,
																	(	SELECT 	Z.YEAR,
																					Z.HAKGI,
																					Z.GWA,
																					Z.HAKYUN,
																					SUM(Z.HAKJUM)/2 	GI_HAKJUM
																		FROM 		(	SELECT  	YEAR,
																									HAKGI,
																									GWA,
																									HAKYUN,
																									TMT_GWAMOK_ID,
																									HAKJUM			
																						FROM 		HAKSA.GAESUL_GWAMOK
																						WHERE		YEAR 		= :ls_tyear
																						AND 		HAKGI 	= :ls_thakgi
																						AND		HAKYUN 	= :ls_hakyun
																						AND  		GWA 		= :ls_gwa
																						AND		SUBSTR(ISU_ID, 1, 1) = '2'
																						AND		BAN	=	'A'
																						GROUP BY YEAR,
																									HAKGI,
																									GWA,
																									HAKYUN,
																									TMT_GWAMOK_ID,
																									HAKJUM) Z
																		GROUP BY Z.YEAR,
																					Z.HAKGI,
																					Z.GWA,
																					Z.HAKYUN) E 
													WHERE		A.HAKBUN			=	B.HAKBUN
													AND		B.HAKBUN			= 	C.HAKBUN 	
													AND		B.YEAR			= 	C.YEAR	
													AND 	  	B.HAKGI			= 	C.HAKGI
													AND		B.HAKBUN			= 	C.HAKBUN
													AND		B.YEAR 			= 	E.YEAR
													AND  		B.HAKGI 			= 	E.HAKGI
													AND		SUBSTR(B.GWA, 1, 3)			=	SUBSTR(E.GWA, 1, 3)
													AND		B.HAKYUN		=	E.HAKYUN
													AND		B.YEAR			=	:ls_tyear
													AND		B.HAKGI			=	:ls_thakgi
													AND		A.GWA				=	:ls_gwa
													AND		B.HAKYUN			=	:ls_hakyun
													AND		A.SANGTAE		IN ('01','02')
													AND		B.F_CNT			= 0
													AND		C.W_CNT			= 0
													AND		B.CHIDK_HAKJUM >= 17
													AND		B.AVG_PYENGJUM >= 3.0	
													AND		C.JUN_HAKJUM	>= E.GI_HAKJUM	)	C
										WHERE	C.HAKBUN	=	M.HAKBUN	
									)
	WHERE	M.YEAR		=	:ls_tyear
	AND	M.HAKGI		=	:ls_thakgi
	AND	M.GWA			=	:ls_gwa
	AND	M.HAKYUN		=	:ls_hakyun
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then		
		MESSAGEBOX('1', SQLCA.SQLERRTEXT)
		messagebox('확인!', '성적장학순위 SETTING에 실패하였습니다!')
		return
	end if
	
LOOP WHILE TRUE;

IF	ls_thakgi	=	'1' THEN 
	CLOSE CUR_HAKGWA ;
ELSE
	CLOSE CUR_HAKGWA1 ;
END IF

COMMIT USING SQLCA	;

MESSAGEBOX('확인', '석차계산을 완료하였습니다!')

setpointer(Arrow!)
end event

type uo_2 from uo_imgbtn within w_hjh101a
integer x = 1207
integer y = 40
integer width = 475
integer taborder = 40
boolean bringtotop = true
string btnname = "장학인원배정"
end type

event clicked;call super::clicked;string	ls_year, ls_hakyun, ls_hakgi, ls_gwa, ls_dyear, ls_dhakgi, ls_dsu
string 	ls_hakgwa, ls_drhakyun
long		ll_jungwon, ll_inwon, ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4, ll_tot 
long		ll_rtn[]
integer	li_cnt, li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "장학배정년도와 학기를 입력하세요!")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ls_gwa	=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
	
//기존생성된 장학인원배정내역을 삭제할지 물어본다.

SELECT 	COUNT(*)
INTO		:li_cnt
FROM		HAKSA.JANGHAK_BAEJUNG
WHERE		YEAR 		= :ls_year
AND		HAKGI		= :ls_hakgi
AND		HAKYUN	like :ls_hakyun
AND		GWA		like :ls_gwa
USING SQLCA ;

IF li_cnt >0 then
	li_ans = messagebox( '확인', "장학인원 배정자료가 존재합니다. 기존자료를 삭제 하시겠습니까?",Exclamation!, OKCancel!, 1)

	IF li_ans = 1 THEN
		DELETE FROM HAKSA.JANGHAK_BAEJUNG
		WHERE		YEAR 		= :ls_year
		AND		HAKGI		= :ls_hakgi
		AND		HAKYUN	like :ls_hakyun
		AND		GWA		like :ls_gwa
		USING SQLCA ;
		
		COMMIT USING SQLCA ;
	ELSE
		RETURN	
	END IF
END IF

messagebox( '확인', "장학인원 배정을 수행합니다!", Information!, Ok!)

setpointer(hourglass!)

DECLARE LC_BAEJUNG CURSOR FOR
	SELECT 	A.GWA,
				A.SU_HAKYUN,
				A.INWONSU,
				B.IPHAK_JUNGWON
	FROM		(	SELECT	C.GWA,
								C.SU_HAKYUN,
								COUNT(C.HAKBUN) INWONSU
					FROM		HAKSA.JAEHAK_HAKJUK C
					WHERE		C.SANGTAE 	= '01'
					GROUP BY C.GWA,
								C.SU_HAKYUN
				) A,
				(	SELECT	D.GWA,
								DECODE( D.YEAR, to_char(SYSDATE, 'YYYY'), '1', TO_CHAR((to_char(SYSDATE, 'YYYY') - 1)), '2',
								TO_CHAR((to_char(SYSDATE, 'YYYY') - 2)), '3', TO_CHAR((to_char(SYSDATE, 'YYYY') -3)), '4', '0') HAKYUN,
								D.IPHAK_JUNGWON
					FROM		HAKSA.JUNGWON D
				) B
	WHERE		A.GWA = B.GWA(+)
	AND		A.SU_HAKYUN = B.HAKYUN(+)
	AND		A.GWA LIKE :ls_gwa
	USING SQLCA ;
	
OPEN LC_BAEJUNG;
DO
FETCH LC_BAEJUNG INTO :ls_hakgwa, :ls_drhakyun, :ll_inwon, :ll_jungwon ;

	IF sqlca.sqlcode <> 0 THEN EXIT
	
	str_parms str_baejung
	str_baejung = Message.PowerObjectParm
	
	CHOOSE CASE ll_jungwon
			
		CASE 30
			str_baejung = uf_baejung30(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)
		CASE 40
			str_baejung = uf_baejung40(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)
		CASE 60
			str_baejung = uf_baejung60(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)
		CASE 70
			str_baejung = uf_baejung70(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)
		CASE 80
			str_baejung = uf_baejung80(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)
		CASE 90
			str_baejung = uf_baejung90(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)	
		CASE 110
			str_baejung = uf_baejung110(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)
		CASE 120
			str_baejung = uf_baejung120(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)
		CASE 130
			str_baejung = uf_baejung130(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)	
		CASE 160
			str_baejung = uf_baejung160(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)
		CASE 180
			str_baejung = uf_baejung180(ll_inwon)

			ll_woosu1 	= str_baejung.l[1]
			ll_woosu2 	= str_baejung.l[2]
			ll_woosu3	= str_baejung.l[3]
			ll_woosu4	= str_baejung.l[4]
			ll_tot		= (ll_woosu1 + ll_woosu2 + ll_woosu3 + ll_woosu4)
		CASE ELSE
			ll_woosu1 	= 0
			ll_woosu2 	= 0
			ll_woosu3	= 0
			ll_woosu4	= 0
			ll_tot		= 0
	END CHOOSE
	
  INSERT INTO "HAKSA"."JANGHAK_BAEJUNG"  
		(	"YEAR",   
			"HAKYUN",   
			"HAKGI",   
			"GWA",   
			"WOOSU_A",   
			"WOOSU_B",   
			"WOOSU_C",   
			"WOOSU_D",  
			"HAKSENG_SU" )  
  VALUES ( :ls_year,   
			  :ls_drhakyun,   
			  :ls_hakgi,   
			  :ls_hakgwa,   
			  :ll_woosu1,   
			  :ll_woosu2,   
			  :ll_woosu3,   
			  :ll_woosu4,
			  :ll_tot )  USING SQLCA ;

LOOP WHILE TRUE;

CLOSE LC_BAEJUNG;

commit USING SQLCA ;

Messagebox("확인", "장학인원배정 완료", Information!, Ok!)	
setpointer(ARROW!)	
	
parent.triggerevent("ue_retrieve")
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type dw_2 from uo_dwfree within w_hjh101a
integer x = 55
integer y = 380
integer width = 1298
integer height = 1884
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hjh101a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hjh101a
integer x = 1385
integer y = 380
integer width = 3049
integer height = 1884
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hjh101a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
if dwo.name = 'woosu_a' or dwo.name = 'woosu_b' or dwo.name = 'woosu_c' or dwo.name = 'woosu_d' then
	this.setitem(row, 'hakseng_su', this.getitemnumber(row, 'su'))
end if

end event

