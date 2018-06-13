$PBExportHeader$w_hjj104pp.srw
$PBExportComments$[청운대]졸업사정(졸업사항부여)
forward
global type w_hjj104pp from window
end type
type cb_2 from commandbutton within w_hjj104pp
end type
type cb_1 from commandbutton within w_hjj104pp
end type
type sle_2 from singlelineedit within w_hjj104pp
end type
type sle_1 from singlelineedit within w_hjj104pp
end type
type em_1 from editmask within w_hjj104pp
end type
type st_3 from statictext within w_hjj104pp
end type
type st_2 from statictext within w_hjj104pp
end type
type st_1 from statictext within w_hjj104pp
end type
type gb_1 from groupbox within w_hjj104pp
end type
end forward

global type w_hjj104pp from window
integer width = 1033
integer height = 572
boolean titlebar = true
string title = "졸업사항"
boolean controlmenu = true
windowtype windowtype = response!
boolean center = true
cb_2 cb_2
cb_1 cb_1
sle_2 sle_2
sle_1 sle_1
em_1 em_1
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_hjj104pp w_hjj104pp

type variables
string	is_year		,&
			is_junhugi

end variables

on w_hjj104pp.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.em_1=create em_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.sle_2,&
this.sle_1,&
this.em_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_hjj104pp.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;//f_center_window(This)
string	ls_jolup

is_year		= mid(message.stringparm, 1, 4)
is_junhugi	= mid(message.stringparm, 5, 1)

sle_1.text	= "청운대" + is_year + "학"

select 	jolup
into		:ls_jolup
from		haksa.haksa_iljung
where		sijum_flag  = 'Y'
;

em_1.text = ls_jolup


end event

type cb_2 from commandbutton within w_hjj104pp
integer x = 507
integer y = 364
integer width = 265
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "취소"
boolean cancel = true
boolean default = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_hjj104pp
integer x = 192
integer y = 364
integer width = 265
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "확인"
end type

event clicked;string	ls_hakbun		,&
			ls_jol_ilja		,&
			ls_jol_count	,&
			ls_hakwi_name	,&
			ls_hakwi_ename	,&
			ls_hakwi_no		,&
			ls_jungseo		,&
			ls_junhugi

long		ll_ans			,&
			ll_rtn			,&
			ll_hakwi_no		,&
			ll_jungseo

if is_junhugi = '1' then
	ls_junhugi	= "전기졸업"
elseif is_junhugi = '2' then
	ls_junhugi	= "후기졸업"
end if

ll_ans	= messagebox("확인", is_year + " 학년도 " + ls_junhugi + " 예정자들의 " &
							+ "~r~n졸업사항을 부여하시겠습니까?", question!, yesno!, 2)

if ll_ans = 1 then
	
	setpointer(hourglass!)
	
	ls_jol_ilja = string(date(em_1.text), 'yyyymmdd')
	
	/*	전기졸업	*/
	if is_junhugi	= '1' then
		
		SELECT	TO_CHAR(MAX(TO_NUMBER(JOLUP_COUNT)) + 1)		,
					1														,
					MAX(TO_NUMBER(JUNG_NO)) + 1					
		INTO		:ls_jol_count	,
					:ll_hakwi_no	,
					:ll_jungseo
		FROM		HAKSA.JOLUP_HAKJUK
		;		
		
	elseif is_junhugi	= '2' then
		SELECT	JOLUP_COUNT										,
					MAX(TO_NUMBER(substr(HAKWI_NO,length(HAKWI_NO) - 2,3))) + 1				,
					MAX(TO_NUMBER(JUNG_NO)) + 1
		INTO		:ls_jol_count	,
					:ll_hakwi_no	,
					:ll_jungseo
		FROM		HAKSA.JOLUP_HAKJUK
		WHERE		to_char(to_number(SUBSTR(JOLUP_DATE, 1, 4)) -1) = :is_year
		GROUP BY JOLUP_COUNT
		;
	end if
	
	DECLARE CUR_JOLUP_SAHANG	CURSOR FOR

	SELECT	A.HAKBUN
	FROM		HAKSA.JAEHAK_HAKJUK	A	,
				HAKSA.JOLUP_SAJUNG	B	,
				HAKSA.GWA_SYM 			C 
	WHERE		A.GWA					=	C.GWA
	AND		A.HAKBUN				= B.HAKBUN
	AND		B.YEAR				= :is_year
	AND		B.JUNHUGI			= :is_junhugi
	AND		B.HAPGYUK_GUBUN	= '1'
	ORDER BY	C.ORDER_SEQ		ASC,
				A.HAKBUN
				;
	
	OPEN	CUR_JOLUP_SAHANG;
	
	DO
		FETCH	CUR_JOLUP_SAHANG	INTO	:ls_hakbun	;
		
		IF SQLCA.SQLCODE <> 0 THEN EXIT
		
		ls_hakwi_no	= sle_1.text + string(ll_hakwi_no, '000')
		ls_jungseo	= string(ll_jungseo, '00000')		
			
		SELECT  	C.FNAME,
					C.ENAME
		into		:ls_hakwi_name,
					:ls_hakwi_ename
		FROM 		HAKSA.JAEHAK_HAKJUK A,
					CDDB.KCH003M B,
					CDDB.KCH001M C
		WHERE  	B.GWA = A.GWA
		AND		B.HAKWI_CODE = C.CODE
		AND		C.TYPE_GUBUN = 'comm'
		AND		C.TYPE = 'hakwi_code'	
		AND		C.CODE not in '0'
		AND		A.HAKBUN = :ls_hakbun
		;
				
				
		UPDATE	HAKSA.JOLUP_SAJUNG
		SET		JOLUP_DATE		= :ls_jol_ilja		,
					JOLUP_COUNT		= :ls_jol_count	,
					HAKWI_NO			= :ls_hakwi_no		,
					HAKWI_NAME		= :ls_hakwi_name	,
					JOLUP_JUNG_NO	= :ls_jungseo
		WHERE		HAKBUN			= :ls_hakbun
		;
		
		UPDATE	HAKSA.JAEHAK_HAKJUK
		SET		JOLUP_DATE		= :ls_jol_ilja		,
					JOLUP_COUNT		= :ls_jol_count	,
					HAKWI_NO			= :ls_hakwi_no		,
					HAKWI_NAME		= :ls_hakwi_name	,
					HAKWI_ENAME		= :ls_hakwi_ename ,
					JUNG_NO			= :ls_jungseo
		WHERE		HAKBUN			= :ls_hakbun
		;
		
		ll_hakwi_no	= ll_hakwi_no	+ 1
		ll_jungseo	= ll_jungseo	+ 1
		
	LOOP WHILE TRUE
	
	CLOSE	CUR_JOLUP_SAHANG	;
	
	ll_rtn	= messagebox("확인", "졸업사항부여를 완료하였습니다" &
								+ "~r~n자료를 저장하시겠습니까?", question!, yesno!, 2)
	
	if ll_rtn = 1 then
		commit;
		messagebox("확인", "저장완료!")
	elseif ll_rtn = 2 then
		rollback;
	end if
	
	close(parent)
	
end if
end event

type sle_2 from singlelineedit within w_hjj104pp
integer x = 398
integer y = 244
integer width = 530
integer height = 72
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_hjj104pp
integer x = 398
integer y = 148
integer width = 530
integer height = 72
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type em_1 from editmask within w_hjj104pp
integer x = 398
integer y = 52
integer width = 421
integer height = 72
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy.mm.dd"
boolean spin = true
double increment = 1
end type

type st_3 from statictext within w_hjj104pp
integer x = 32
integer y = 260
integer width = 357
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
string text = "수료증서명 :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_hjj104pp
integer x = 32
integer y = 160
integer width = 357
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
string text = "학위등록명 :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_hjj104pp
integer x = 55
integer y = 60
integer width = 334
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
string text = "졸업일자 :"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hjj104pp
integer x = 14
integer width = 969
integer height = 344
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
end type

