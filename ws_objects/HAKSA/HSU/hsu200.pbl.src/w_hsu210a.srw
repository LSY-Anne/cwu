$PBExportHeader$w_hsu210a.srw
$PBExportComments$[청운대]수강신청일괄생성(신,편,재학생_산업체위탁)
forward
global type w_hsu210a from w_no_condition_window
end type
type st_2 from statictext within w_hsu210a
end type
type cb_1 from commandbutton within w_hsu210a
end type
type dw_con from uo_dwfree within w_hsu210a
end type
end forward

global type w_hsu210a from w_no_condition_window
st_2 st_2
cb_1 cb_1
dw_con dw_con
end type
global w_hsu210a w_hsu210a

on w_hsu210a.create
int iCurrent
call super::create
this.st_2=create st_2
this.cb_1=create cb_1
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_con
end on

on w_hsu210a.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.dw_con)
end on

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_hsu210a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hsu210a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hsu210a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hsu210a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hsu210a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hsu210a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hsu210a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hsu210a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hsu210a
end type

type uc_save from w_no_condition_window`uc_save within w_hsu210a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hsu210a
end type

type uc_print from w_no_condition_window`uc_print within w_hsu210a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hsu210a
end type

type st_line2 from w_no_condition_window`st_line2 within w_hsu210a
end type

type st_line3 from w_no_condition_window`st_line3 within w_hsu210a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hsu210a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hsu210a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hsu210a
end type

type st_2 from statictext within w_hsu210a
integer x = 55
integer y = 292
integer width = 4379
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
string text = "수강신청 일괄 생성(산업체위탁)"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_hsu210a
integer x = 1819
integer y = 920
integer width = 718
integer height = 184
integer taborder = 60
boolean bringtotop = true
integer textsize = -18
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생성"
end type

event clicked;string	ls_year, ls_hakgi, ls_gwa, ls_iphak_gubun, ls_hakbun, ls_gubun
integer	ll_cnt

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun    =  func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_gubun     =	dw_con.Object.gubun[1]

//신편입구분.
if ls_gubun = '1' Then		//산업체위탁이면서 신입생
	ls_iphak_gubun	=	'A11'
	
elseif  ls_gubun = '2' Then		//산업체위탁이면서 편입생
	ls_iphak_gubun	=	'A12'
	
//elseif rb_3.checked = true then	//산업체위탁이면서 재학생
//	if	mid(ls_gwa, 1, 4) <> 'A' or isnull(ls_gwa) then
//		messagebox('확인', '산업체 위탁 학과만 가능합니다')
//		em_1.SetFocus()
//		return
//	end if
//elseif rb_4.checked = true then	
//	ls_iphak_gubun	=	'%'			//산업체위탁이면서 개인별
//
end if

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

SetPointer(HourGlass!)
if ls_gubun = '1' or ls_gubun = '2' then //산업체위탁 신,편입생
	
		//수강신청시 년도 학기에 해당자료유무검색
		SELECT	COUNT(B.HAKBUN)
		INTO		:ll_cnt
		FROM		HAKSA.JAEHAK_HAKJUK	A,
					HAKSA.SUGANG_TRANS B
		WHERE		A.HAKBUN	=	B.HAKBUN
		AND		SUBSTR(A.GWA, 4, 1) 	=	'A'
		AND		SUBSTR(A.IPHAK_DATE, 1, 4)	=	:ls_year
		AND		B.YEAR	=	:ls_year
		AND		B.HAKGI	=	:ls_hakgi	
		AND		A.HJMOD_SAYU_ID	=	:ls_iphak_gubun
		USING SQLCA ;
		
		if ll_cnt > 0 then
			messagebox("확인",ls_year + "년도 " +  ls_hakgi + "학기 산업체위탁 수강자료가 존재합니다.~r~n" + sqlca.sqlerrtext)
		     rollback USING SQLCA ;
		end if

//수강신청 시작
INSERT INTO HAKSA.SUGANG_TRANS
(	SELECT	A.HAKBUN,
				B.YEAR,
				B.HAKGI,
				B.GWA,
				B.HAKYUN,
				B.BAN,
				B.GWAMOK_ID,
				B.GWAMOK_SEQ,
				MIN(B.BUNBAN),
				B.ISU_ID,
				B.HAKJUM,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				'Y',
				'0',
				NULL,
				NULL,
				NULL,
				NULL,
				:gs_empcode,
				:gs_ip,
				SYSDATE,
				NULL,
				NULL,
				NULL
	FROM		HAKSA.JAEHAK_HAKJUK	A,
				HAKSA.GAESUL_GWAMOK	B
	WHERE		A.GWA			=	B.GWA
	AND		A.SU_HAKYUN	=	B.HAKYUN
	AND		A.BAN			=	B.BAN
	AND		SUBSTR(A.GWA, 4, 1) 	=	'A'		//산업체위탁 학과만 가능
	AND		SUBSTR(A.IPHAK_DATE, 1, 4)  =	:ls_year
	AND		A.HJMOD_SAYU_ID	=	:ls_iphak_gubun
	AND		A.GWA				like	:ls_gwa
	AND		B.YEAR				=	:ls_year
	AND		B.HAKGI				=	:ls_hakgi
	AND		B.HAKJUM				> 0	
	GROUP BY A.HAKBUN,
				B.YEAR,
				B.HAKGI,
				B.GWA,
				B.HAKYUN,
				B.BAN,
				B.GWAMOK_ID,
				B.GWAMOK_SEQ,
				B.ISU_ID,
				B.HAKJUM
)	USING SQLCA ;

elseif	ls_gubun = '3'  then //산업체위탁 재학생 생성
	

		//수강신청시 년도 학기에 해당자료유무검색
		SELECT	COUNT(B.HAKBUN)
		INTO		:ll_cnt
		FROM		HAKSA.JAEHAK_HAKJUK	A,
					HAKSA.SUGANG_TRANS B
		WHERE		A.HAKBUN	=	B.HAKBUN
		AND		SUBSTR(A.GWA, 4, 1) 	=	'A'
		AND		SUBSTR(A.IPHAK_DATE, 1, 4)	<>	:ls_year
		AND		B.YEAR	=	:ls_year
		AND		B.HAKGI	=	:ls_hakgi	
		AND		A.HJMOD_SAYU_ID	=	:ls_iphak_gubun
		AND		A.GWA		like	:ls_gwa
		USING SQLCA ;
		
		
		if ll_cnt > 0 then
			if messagebox("확인",ls_year + "년도 " +  ls_hakgi + "학기 산업체위탁 수강자료가 존재합니다.~r~n" + &
							"삭제후 다시 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
											
			DELETE
			FROM 		HAKSA.SUGANG_TRANS
			WHERE		YEAR	=	:ls_year
			AND		HAKGI	=	:ls_hakgi
			AND		HAKBUN	=	(	SELECT 	HAKBUN
											FROM 		HAKSA.JAEHAK_HAKJUK
											WHERE		SUBSTR(GWA, 4, 1) 	=	'A'
											AND		SUBSTR(IPHAK_DATE, 1, 4)	<>	:ls_year
											AND		HJMOD_SAYU_ID	=	:ls_iphak_gubun
											AND		GWA		like	:ls_gwa)
			USING SQLCA ;
					
			if sqlca.sqlcode = 0 then
				commit USING SQLCA ;
			else
				messagebox("오류","이전자료 삭제중 오류 발생~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return
			end if			
		end if
	
//수강신청 시작
INSERT INTO HAKSA.SUGANG_TRANS
(	SELECT	A.HAKBUN,
				B.YEAR,
				B.HAKGI,
				B.GWA,
				B.HAKYUN,
				B.BAN,
				B.GWAMOK_ID,
				B.GWAMOK_SEQ,
				MIN(B.BUNBAN),
				B.ISU_ID,
				B.HAKJUM,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				'Y',
				'0',
				NULL,
				NULL,
				NULL,
				NULL,
				:gs_empcode,
				:gs_ip,
				SYSDATE,
				NULL,
				NULL,
				NULL
	FROM		HAKSA.JAEHAK_HAKJUK	A,
				HAKSA.GAESUL_GWAMOK	B
	WHERE		A.GWA			=	B.GWA
	AND		A.SU_HAKYUN	=	B.HAKYUN
	AND		A.BAN			=	B.BAN
	AND		SUBSTR(A.IPHAK_DATE, 1, 4)	<>	:ls_year
	AND		A.IPHAK_JUNHYUNG	=	'17'       	//입학전형이 산업체위탁
	AND		SUBSTR(A.GWA, 4, 1) 	=	'A'		//산업체위탁 학과만 가능
	AND		A.GWA				like	:ls_gwa
	AND		B.YEAR				=	:ls_year
	AND		B.HAKGI				=	:ls_hakgi
	AND		B.HAKJUM				> 0	
	GROUP BY A.HAKBUN,
				B.YEAR,
				B.HAKGI,
				B.GWA,
				B.HAKYUN,
				B.BAN,
				B.GWAMOK_ID,
				B.GWAMOK_SEQ,
				B.ISU_ID,
				B.HAKJUM		
)	USING SQLCA ;

elseif ls_gubun = '4' then //산업체위탁 개인별 생성
	

		//수강신청시 년도 학기에 해당자료유무검색
		SELECT	COUNT(B.HAKBUN)
		INTO		:ll_cnt
		FROM		HAKSA.JAEHAK_HAKJUK	A,
					HAKSA.SUGANG_TRANS B
		WHERE		A.HAKBUN	=	B.HAKBUN
		AND		SUBSTR(A.GWA, 4, 1) 	=	'A'
		AND		SUBSTR(A.IPHAK_DATE, 1, 4)	=	:ls_year
		AND		B.YEAR	=	:ls_year
		AND		B.HAKGI	=	:ls_hakgi	
		AND		A.HJMOD_SAYU_ID	=	:ls_iphak_gubun
		AND		A.HAKBUN	=	:ls_hakbun
		USING SQLCA ;
		
		
		if ll_cnt > 0 then
			if messagebox("확인",ls_year + "년도 " +  ls_hakgi + "학기 산업체위탁 수강자료가 존재합니다.~r~n" + &
							"삭제후 다시 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
											
			DELETE
			FROM 		HAKSA.SUGANG_TRANS
			WHERE		YEAR	=	:ls_year
			AND		HAKGI	=	:ls_hakgi
			AND		HAKBUN	=	(	SELECT 	HAKBUN
											FROM 		HAKSA.JAEHAK_HAKJUK
											WHERE		SUBSTR(GWA, 4, 1) 	=	'A'
											AND		SUBSTR(IPHAK_DATE, 1, 4)	<>	:ls_year
											AND		HJMOD_SAYU_ID	=	:ls_iphak_gubun
											AND		HAKBUN	=	:ls_hakbun)
			USING SQLCA ;
					
			if sqlca.sqlcode = 0 then
				commit USING SQLCA ;
			else
				messagebox("오류","이전자료 삭제중 오류 발생~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return
			end if			
		end if
	
//수강신청 시작
INSERT INTO HAKSA.SUGANG_TRANS
(	SELECT	A.HAKBUN,
				B.YEAR,
				B.HAKGI,
				B.GWA,
				B.HAKYUN,
				B.BAN,
				B.GWAMOK_ID,
				B.GWAMOK_SEQ,
				MIN(B.BUNBAN),
				B.ISU_ID,
				B.HAKJUM,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				'Y',
				'0',
				NULL,
				NULL,
				NULL,
				NULL,
				:gs_empcode,
				:gs_ip,
				SYSDATE,
				NULL,
				NULL,
				NULL
	FROM		HAKSA.JAEHAK_HAKJUK	A,
				HAKSA.GAESUL_GWAMOK	B
	WHERE		A.GWA			=	B.GWA
	AND		A.SU_HAKYUN	=	B.HAKYUN
	AND		A.BAN			=	B.BAN
	AND		SUBSTR(A.IPHAK_DATE, 1, 4)	<>	:ls_year
	AND		A.IPHAK_JUNHYUNG	=	'17'       	//입학전형이 산업체위탁
	AND		SUBSTR(A.GWA, 4, 1) 	=	'A'		//산업체위탁 학과만 가능
	AND		B.YEAR				=	:ls_year
	AND		B.HAKGI				=	:ls_hakgi
	AND		A.HAKBUN				=	:ls_hakbun
	AND		B.HAKJUM				> 0	
	GROUP BY A.HAKBUN,
				B.YEAR,
				B.HAKGI,
				B.GWA,
				B.HAKYUN,
				B.BAN,
				B.GWAMOK_ID,
				B.GWAMOK_SEQ,
				B.ISU_ID,
				B.HAKJUM		
)	USING SQLCA ;
end if

SetPointer(Arrow!)

if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	messagebox("확인","작업이 완료되었습니다.")
	
else
	messagebox("오류","수강신청중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	
end if

end event

type dw_con from uo_dwfree within w_hsu210a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsu210a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

