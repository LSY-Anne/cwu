$PBExportHeader$w_hsu102a.srw
$PBExportComments$[청운대]교과과정->개설과목 이관
forward
global type w_hsu102a from w_no_condition_window
end type
type st_2 from statictext within w_hsu102a
end type
type hpb_1 from hprogressbar within w_hsu102a
end type
type cb_1 from commandbutton within w_hsu102a
end type
type st_5 from statictext within w_hsu102a
end type
type dw_con from uo_dwfree within w_hsu102a
end type
end forward

global type w_hsu102a from w_no_condition_window
st_2 st_2
hpb_1 hpb_1
cb_1 cb_1
st_5 st_5
dw_con dw_con
end type
global w_hsu102a w_hsu102a

on w_hsu102a.create
int iCurrent
call super::create
this.st_2=create st_2
this.hpb_1=create hpb_1
this.cb_1=create cb_1
this.st_5=create st_5
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.hpb_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.dw_con
end on

on w_hsu102a.destroy
call super::destroy
destroy(this.st_2)
destroy(this.hpb_1)
destroy(this.cb_1)
destroy(this.st_5)
destroy(this.dw_con)
end on

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_hsu102a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hsu102a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hsu102a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hsu102a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hsu102a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hsu102a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hsu102a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hsu102a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hsu102a
end type

type uc_save from w_no_condition_window`uc_save within w_hsu102a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hsu102a
end type

type uc_print from w_no_condition_window`uc_print within w_hsu102a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hsu102a
end type

type st_line2 from w_no_condition_window`st_line2 within w_hsu102a
end type

type st_line3 from w_no_condition_window`st_line3 within w_hsu102a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hsu102a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hsu102a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hsu102a
end type

type st_2 from statictext within w_hsu102a
integer x = 59
integer y = 316
integer width = 4375
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 32500968
string text = "교과과정 => 개설과목 이관"
alignment alignment = center!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_hsu102a
integer x = 1280
integer y = 756
integer width = 2085
integer height = 96
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type cb_1 from commandbutton within w_hsu102a
integer x = 1865
integer y = 1008
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

event clicked;string	ls_year,     ls_su_hakyun, ls_hakgi,ls_gwa,  ls_jungong_id, ls_juya_gubun, ls_gwamok_id, ls_isu_id
string	ss_year,    ss_hakgi,        ss_su_hakyun,     ls_eachyn
long	ll_hakjum,  ll_sisu,           ll_sisu_iron,        ll_sisu_silsub,   ll_count, ll_cnt, ll_gwamok_seq, ll_for, ll_row

dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

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

//기존 자료가 존재하는지 확인
SELECT	COUNT(*)
INTO		:ll_row
FROM	HAKSA.GAESUL_GWAMOK
WHERE	YEAR	=	:ls_year
AND	HAKGI	=	:ls_hakgi	
AND   ROWNUM = 1
USING SQLCA ;

if	ll_row	>	0	then
	if messagebox("확인","기존 자료가 존재합니다.~r~n 삭제후 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	
	DELETE	FROM	HAKSA.GAESUL_GWAMOK
	WHERE		YEAR	=	:ls_year
	AND		HAKGI	=	:ls_hakgi
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("확인","기존 자료 삭제중 오류발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
end if

//Porgress Bar
SELECT 	count(*)
INTO		:ll_count
FROM 		HAKSA.GYOGWA_GWAJUNG
WHERE 	YEAR||HAKYUN  IN ( :ls_year||'1', TO_CHAR(:ls_year - 1)||'2', TO_CHAR(:ls_year - 2)||'3', TO_CHAR(:ls_year - 3)||'4')
AND		HAKGI	=	:ls_hakgi	
USING SQLCA ;

hpb_1.maxposition	=	ll_count

SetPointer(HourGlass!)

//Loop에서 4학년까지의 자료를 생성한다.
for	ll_for	=	1	to	4
	
	if	ll_for	=	1	then
		ss_year			=	string(long(ls_year)	)
		ss_su_hakyun	=	'1'
	elseif	ll_for =	2	then
		ss_year			=	string(long(ls_year)	-	1)
		ss_su_hakyun	=	'2'
	elseif	ll_for =	3	then
		ss_year			=	string(long(ls_year)	-	2)
		ss_su_hakyun	=	'3'
	elseif	ll_for =	4	then
		ss_year			=	string(long(ls_year)	-	3)
		ss_su_hakyun	=	'4'
	end if
	
	DECLARE GAESUL_CUR CURSOR FOR
 	SELECT 	HAKYUN,
	 			GWA,
				JUYA_GUBUN,
 				GWAMOK_ID,
				GWAMOK_SEQ,
				ISU_ID,
				NVL(HAKJUM, 0),
				NVL(SISU,0),
				NVL(SISU_IRON,0),
				NVL(SISU_SILSUB,0)
 	FROM 		HAKSA.GYOGWA_GWAJUNG
 	WHERE 	YEAR		= :ss_year
 	AND     	HAKGI		= :ls_hakgi
	AND		HAKYUN	= :ss_su_hakyun
	USING SQLCA ;

	OPEN 		GAESUL_CUR;
	DO
		FETCH 	GAESUL_CUR	INTO	:ls_su_hakyun,	:ls_gwa,		:ls_juya_gubun,	:ls_gwamok_id,	:ll_gwamok_seq,
											:ls_isu_id,		:ll_hakjum,	:ll_sisu,			:ll_sisu_iron,	:ll_sisu_silsub	;
						
			IF SQLCA.SQLCODE <> 0 THEN EXIT
			
			//개설과목 자료입력
			SELECT nvl(tmt_each_yn, 'N')
			  INTO :ls_eachyn
			  FROM haksa.isugubun_code
			 WHERE isu_id     = :ls_isu_id
			 USING SQLCA ;
			 
         IF sqlca.sqlnrows = 0 THEN
				ls_eachyn      = 'N'
			END IF
 			INSERT INTO HAKSA.GAESUL_GWAMOK
 						(	YEAR,					HAKGI,				GWA,					HAKYUN,			BAN,
						 	JUYA_GUBUN,			GWAMOK_ID,			GWAMOK_SEQ,			BUNBAN,			ISU_ID,
							HAKJUM,				SISU,					SISU_IRON,			SISU_SILSUB,	BAN_BUNHAP,	PYEGANG_YN,
							tmt_each_yn,      tmt_gwamok_id,    tmt_gwamok_seq)
			values	(	:ls_year,			:ls_hakgi,			:ls_gwa,				:ls_su_hakyun,	'A',
							:ls_juya_gubun,	:ls_gwamok_id,		:ll_gwamok_seq,	'00',				:ls_isu_id,
							:ll_hakjum,			:ll_sisu,			:ll_sisu_iron,		:ll_sisu_silsub, '0'	,		'N',
							:ls_eachyn,	      :ls_gwamok_id,		:ll_gwamok_seq)	USING SQLCA ;
			
			if sqlca.sqlcode <> 0 then 
				messagebox("오류","자료이관중 오류가 발생되었습니다~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return
			end if
			
			ll_cnt	=	ll_cnt	+	1
			hpb_1.position	=	ll_cnt
			
	LOOP WHILE TRUE;
	CLOSE GAESUL_CUR;
	
NEXT

COMMIT USING SQLCA ;
SetPointer(Arrow!)

messagebox("확인","이관 작업이 완료 되었습니다.")

end event

type st_5 from statictext within w_hsu102a
integer x = 978
integer y = 776
integer width = 279
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "처리경과"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hsu102a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsu102a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

