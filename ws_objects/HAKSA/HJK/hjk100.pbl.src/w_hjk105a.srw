$PBExportHeader$w_hjk105a.srw
$PBExportComments$[청운대]반배정
forward
global type w_hjk105a from w_condition_window
end type
type st_3 from statictext within w_hjk105a
end type
type st_4 from statictext within w_hjk105a
end type
type cb_1 from commandbutton within w_hjk105a
end type
type dw_con from uo_dwfree within w_hjk105a
end type
end forward

global type w_hjk105a from w_condition_window
st_3 st_3
st_4 st_4
cb_1 cb_1
dw_con dw_con
end type
global w_hjk105a w_hjk105a

on w_hjk105a.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_4=create st_4
this.cb_1=create cb_1
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_con
end on

on w_hjk105a.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.dw_con)
end on

event open;call super::open;String ls_year

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

ls_year = func.of_get_sdate('YYYY')

dw_con.Object.year[1] = ls_year
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk105a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk105a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk105a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk105a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk105a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk105a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk105a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk105a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk105a
end type

type uc_save from w_condition_window`uc_save within w_hjk105a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk105a
end type

type uc_print from w_condition_window`uc_print within w_hjk105a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk105a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk105a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk105a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk105a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk105a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk105a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk105a
end type

type st_3 from statictext within w_hjk105a
integer x = 1289
integer y = 596
integer width = 1819
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12639424
string text = "신입생 반배정 일괄처리"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_hjk105a
integer x = 1289
integer y = 688
integer width = 1819
integer height = 852
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 32500968
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_hjk105a
integer x = 1861
integer y = 952
integer width = 704
integer height = 264
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "반배정"
end type

event clicked;string	ls_year,	ls_hakgwa, ls_gwa, ls_half, ls_hakgwa_start
int		li_count, li_min, li_max, li_half

dw_con.AcceptText()

//조회조건
ls_year		= dw_con.Object.year[1]
ls_gwa		= func.of_nvl(dw_con.Object.gwa[1], '%')

SELECT	COUNT(*)
INTO		:li_count
FROM		HAKSA.JUNGWON
WHERE		YEAR		= :ls_year
AND		GWA	LIKE :ls_hakgwa
USING SQLCA;

if li_count = 0 then
	messagebox('확인', '연도별 정원등록관리를 먼저 하세요!')
	return
end if

if messagebox('확인!', '신입생 반배정을 하시겠습니까?', question!, yesno!, 2) = 2 then return

setpointer(hourglass!)

DECLARE CUR_HAKGWA	CURSOR FOR

	SELECT	GWA
	FROM		HAKSA.JUNGWON
	WHERE		YEAR		= :ls_year
	AND		MOJIP_JUNGWON	>= 100
	AND		GWA	LIKE :ls_hakgwa
	USING SQLCA;
	
OPEN CUR_HAKGWA;

DO
	FETCH	CUR_HAKGWA INTO :ls_gwa	;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
//	SELECT	MIN(TO_NUMBER(SUBSTR(HAKBUN, 5, 4))),
//				MAX(TO_NUMBER(SUBSTR(HAKBUN, 5, 4)))
//	INTO		:li_min,
//				:li_max
//	FROM		HAKSA.JAEHAK_HAKJUK
//	WHERE		GWA	=	:ls_gwa
//	AND		SU_HAKYUN	=	'1'
//	AND		HAKBUN	LIKE :ls_year || '%'	;
	
//	ls_half	= string(round((li_max - li_min)/2, 0))
	
//	UPDATE	HAKSA.JAEHAK_HAKJUK
//	SET		BAN	= 'B'
//	WHERE		GWA	=	:ls_gwa
//	AND		SU_HAKYUN	=	'1'
//	AND		HAKBUN	>= :ls_year || ls_half	;
	
	UPDATE	HAKSA.JAEHAK_HAKJUK
	SET		BAN	= 'A'
	WHERE		GWA	=	:ls_gwa
	AND		SU_HAKYUN	=	'1'
	AND		HAKBUN	like :ls_year || '%'	
	USING SQLCA;

	SELECT	MIN(TO_NUMBER(SUBSTR(HAKBUN, 5, 4))) + 50,
				MIN(SUBSTR(HAKBUN, 5, 2))
	INTO		:li_min,
				:ls_hakgwa_start
	FROM		HAKSA.JAEHAK_HAKJUK
	WHERE		GWA	=	:ls_gwa
	AND		SU_HAKYUN	=	'1'
	AND		HAKBUN	LIKE :ls_year || '%'
	USING SQLCA;
	
	ls_half	= string(li_min)
	
	UPDATE	HAKSA.JAEHAK_HAKJUK
	SET		BAN	= 'B'
	WHERE		GWA	=	:ls_gwa
	AND		SU_HAKYUN	=	'1'
	AND		HAKBUN	>= :ls_year || :ls_half
	USING SQLCA;
	
LOOP WHILE TRUE

CLOSE	CUR_HAKGWA	;

COMMIT USING SQLCA;

MESSAGEBOX('확인', '반배정을 완료하였습니다')


	
	
end event

type dw_con from uo_dwfree within w_hjk105a
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk105a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

