$PBExportHeader$w_dip420a.srw
$PBExportComments$[대학원입시]가상계좌일괄생성 및 부분생성
forward
global type w_dip420a from w_no_condition_window
end type
type st_2 from statictext within w_dip420a
end type
type hpb_1 from hprogressbar within w_dip420a
end type
type cb_2 from commandbutton within w_dip420a
end type
type cb_3 from commandbutton within w_dip420a
end type
type st_sangtae from statictext within w_dip420a
end type
type dw_con from uo_dwfree within w_dip420a
end type
end forward

global type w_dip420a from w_no_condition_window
st_2 st_2
hpb_1 hpb_1
cb_2 cb_2
cb_3 cb_3
st_sangtae st_sangtae
dw_con dw_con
end type
global w_dip420a w_dip420a

on w_dip420a.create
int iCurrent
call super::create
this.st_2=create st_2
this.hpb_1=create hpb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_sangtae=create st_sangtae
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.hpb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.st_sangtae
this.Control[iCurrent+6]=this.dw_con
end on

on w_dip420a.destroy
call super::destroy
destroy(this.st_2)
destroy(this.hpb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_sangtae)
destroy(this.dw_con)
end on

event open;call super::open;string	ls_hakgi, ls_year

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	NEXT_YEAR,      NEXT_HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi

end event

type ln_templeft from w_no_condition_window`ln_templeft within w_dip420a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_dip420a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_dip420a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_dip420a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_dip420a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_dip420a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_dip420a
end type

type uc_insert from w_no_condition_window`uc_insert within w_dip420a
end type

type uc_delete from w_no_condition_window`uc_delete within w_dip420a
end type

type uc_save from w_no_condition_window`uc_save within w_dip420a
end type

type uc_excel from w_no_condition_window`uc_excel within w_dip420a
end type

type uc_print from w_no_condition_window`uc_print within w_dip420a
end type

type st_line1 from w_no_condition_window`st_line1 within w_dip420a
end type

type st_line2 from w_no_condition_window`st_line2 within w_dip420a
end type

type st_line3 from w_no_condition_window`st_line3 within w_dip420a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_dip420a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_dip420a
end type

type gb_1 from w_no_condition_window`gb_1 within w_dip420a
end type

type st_2 from statictext within w_dip420a
integer x = 50
integer y = 288
integer width = 4384
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 12639424
string text = "가상계좌 생성관리"
alignment alignment = center!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_dip420a
integer x = 855
integer y = 948
integer width = 2354
integer height = 96
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type cb_2 from commandbutton within w_dip420a
integer x = 1673
integer y = 1304
integer width = 782
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "변동일이후  생성"
end type

event clicked;//
////검색조건
//string	ls_year, ls_hakgi, ls_hakjukbyendong
//string	ls_chk, ll_count
//
//long	ll_cnt, ll_rtn
//
//
//	
//ls_year		=	em_1.text
//ls_hakgi		=	ddlb_1.text
//ls_hakjukbyendong	=	sle_1.text + '%'
//
//if	ls_year = "" or isnull(ls_year) then
//	uf_messagebox(12)
//	em_1.SetFocus()
//	return
//		
//elseif ls_hakgi = "" or isnull(ls_hakgi) then
//	uf_messagebox(14)
//	ddlb_1.SetFocus()
//	return
//	
//elseif ls_hakjukbyendong = "" or isnull(ls_hakjukbyendong) then
//	uf_messagebox(14)
//	ddlb_1.SetFocus()
//	return		
//end if
//
//if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 가상계좌를 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
//
//SELECT  	HAKBUN
//INTO		:ls_chk
//FROM  	HAKSA.GASANG
//WHERE		YEAR		=	:ls_year
//AND		HAKGI		=	:ls_hakgi
//AND		HAKBUN	in	(	SELECT 	HAKBUN
//								FROM 		JAEHAK_HAKJUK
//								WHERE		HJMOD_ID	IN ('C', 'I')
//								AND		HJMOD_DATE >= :ls_hakjukbyendong)
//AND		ROWNUM	=	1	;
//
//if sqlca.sqlcode = 0 then
//
//	if messagebox("확인","이미 자료가 존재합니다! ~r~n 삭제후 재생성하시겠습니까?", Question!, YesNo!,2) = 2 then return
//	
//	DELETE 	FROM HAKSA.GASANG
//	WHERE		YEAR		=	:ls_year
//	AND		HAKGI		=	:ls_hakgi
//	AND		HAKBUN	in	(	SELECT 	HAKBUN
//									FROM 		JAEHAK_HAKJUK
//									WHERE		HJMOD_ID	IN ('C', 'I')
//									AND		HJMOD_DATE >= :ls_hakjukbyendong) ;
//		
//	if sqlca.sqlcode <> 0 then
//		messagebox("오류","이전자료 삭제중 오류발생~r~n" + sqlca.sqlerrtext)
//		rollback ;
//		return
//	end if
//		
//end if		
//
////Progress Bar Setting
//SELECT	COUNT(HAKBUN)
//INTO		:ll_count
//FROM		HAKSA.DUNGROK_GWANRI
//WHERE		YEAR		=		:ls_year
//AND		HAKGI		=		:ls_hakgi
//AND		HAKBUN	in	(	SELECT 	HAKBUN
//								FROM 		JAEHAK_HAKJUK
//								WHERE		HJMOD_ID	IN ('C', 'I')
//								AND		HJMOD_DATE >= :ls_hakjukbyendong);
//
//st_sangtae.text = '가상계좌 일괄생성중...' 
////messagebox('ll_count', ll_count)
//
//SetPointer(HourGlass!)
//
//
//////전체 및 처리건수 확인==========================
////SELECT  count(*)
////INTO   :ll_p_cnt
////FROM   IP_WONSEO
////WHERE  JONGBYUL_CODE = :ls_jongbyul
//////AND   HAPGYUK_GUBUN = :ls_hapgyuk 
////;
////
////ls_p_cnt = string(ll_p_cnt) 
//////================================================
////
//
//INSERT 	INTO HAKSA.GASANG
//SELECT	A.YEAR,
//			A.HAKGI,
//			A.HAKBUN,
//			B.GASANG_NO,
//			:gstru_uid_uname.uid,
//			:gstru_uid_uname.address,
//			SYSDATE,
//			NULL,
//			NULL,
//			NULL			
//FROM 		( 	SELECT 	A.YEAR,
//							A.HAKGI,
//							A.HAKBUN,
//							ROWNUM RN
//				FROM 		HAKSA.DUNGROK_GWANRI		A,
//							HAKSA.JAEHAK_HAKJUK		B
//				WHERE		A.HAKBUN		=	B.HAKBUN
//				AND		A.YEAR		=		:ls_year
//				AND		A.HAKGI		=		:ls_hakgi	
////				AND		B.SANGTAE	=	'01'
//				AND		B.HJMOD_ID	IN ('C', 'I')
//				AND		B.HJMOD_DATE >= :ls_hakjukbyendong		
//				AND		A.WAN_YN = 'N'
//				ORDER BY A.HAKBUN ) A,
//			(	SELECT  	GASANG_NO,
//	 						ROWNUM 	RN
//				FROM   	HAKSA.GASANG_GWANRI
//				WHERE  	GUBUN = '1'
//				AND	  	ORDER_SEQ > ( 	SELECT	NVL(MAX(A.ORDER_SEQ), 0)
//												FROM 		HAKSA.GASANG_GWANRI 	A,
//															HAKSA.GASANG			B
//												WHERE		A.GASANG_NO	=	B.GASANG_NO)
//				ORDER BY ORDER_SEQ ) B
//WHERE		A.RN	=B.RN
//ORDER BY A.HAKBUN
//;
//
//if sqlca.sqlcode <> 0 then
// rollback;
// messagebox('가상계좌입력 오류!', '일괄처리를 실패하였습니다!', exclamation!)
// RETURN
//END IF
//
//COMMIT USING SQLCA;
//MESSAGEBOX('확인!', '일괄처리를 완료하였습니다.( 처리건수: ' + ll_count + '건 )')
//
//SetPointer(Arrow!)
//st_sangtae.text = ''
end event

type cb_3 from commandbutton within w_dip420a
integer x = 859
integer y = 1304
integer width = 626
integer height = 132
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "최초 생성"
end type

event clicked;//검색조건
string	ls_year, ls_hakgi, ls_hakjukbyendong, ls_mojip_id, ls_hap
string	ls_chk, ll_count,  ls_suhum
long	ll_cnt, ll_rtn

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_mojip_id 	=	dw_con.Object.mojip_id[1]
ls_hap 	    =	dw_con.Object.hap_id[1]
ls_suhum 	=	func.of_nvl(dw_con.Object.suhum_no[1], '%') + '%'

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
end if

if ls_mojip_id = ''  or Isnull(ls_mojip_id) then
	messagebox("확인","모집구분을 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("mojip_id")
	return -1
end if

if ls_hap = ''  or Isnull(ls_hap) then
	messagebox("확인","합격구분을 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hap_id")
	return -1
end if

if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 가상계좌를 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return

SELECT  	SUHUM_NO
INTO		:ls_chk
FROM  	DIPSI.DI_GASANG
WHERE		YEAR		=	:ls_year
AND		HAKGI		=	:ls_hakgi
AND		MOJIP_ID	=	:ls_mojip_id
AND		HAP_ID	=	:ls_hap
AND		SUHUM_NO	like :ls_suhum
AND		ROWNUM	=	1
USING SQLCA ;

if sqlca.sqlcode = 0 then

	if messagebox("확인","이미 자료가 존재합니다! ~r~n 삭제후 재생성하시겠습니까?", Question!, YesNo!,2) = 2 then return
	
	DELETE	FROM 		DIPSI.DI_GASANG
	WHERE		YEAR		=	:ls_year
	AND		HAKGI		=	:ls_hakgi
	AND		MOJIP_ID	=	:ls_mojip_id
	AND		HAP_ID	=	:ls_hap 
	AND		SUHUM_NO	like :ls_suhum
	USING SQLCA ;
		
	if sqlca.sqlcode <> 0 then
		messagebox("오류","이전자료 삭제중 오류발생~r~n" + sqlca.sqlerrtext)
		rollback ;
		return
	end if
		
end if		

//Progress Bar Setting
SELECT	COUNT(SUHUM_NO)
INTO		:ll_count
FROM		DIPSI.DI_WONSEO
WHERE		YEAR		=	:ls_year
AND		HAKGI		=	:ls_hakgi
AND		MOJIP_ID	=	:ls_mojip_id
AND		HAP_ID	=	:ls_hap 
AND		SUHUM_NO	like :ls_suhum
USING SQLCA ;

st_sangtae.text = '가상계좌 일괄생성중...'

SetPointer(HourGlass!)


////전체 및 처리건수 확인==========================
//SELECT  count(*)
//INTO   :ll_p_cnt
//FROM   IP_WONSEO
//WHERE  JONGBYUL_CODE = :ls_jongbyul
////AND   HAPGYUK_GUBUN = :ls_hapgyuk 
//;
//
//ls_p_cnt = string(ll_p_cnt) 
////================================================
//

INSERT 	INTO DIPSI.DI_GASANG
SELECT	A.YEAR,
			A.HAKGI,
			A.MOJIP_ID,
			A.HAP_ID,
			A.SUHUM_NO,
			B.GASANG_NO,
			:gs_empcode,
			:gs_ip,
			SYSDATE,
			NULL,
			NULL,
			NULL			
FROM 		( 	SELECT 	YEAR,
							HAKGI,
							MOJIP_ID,
							HAP_ID,
							SUHUM_NO,
							ROWNUM RN
				FROM 		DIPSI.DI_WONSEO
				WHERE		YEAR		=	:ls_year
				AND		HAKGI		=	:ls_hakgi
				AND		MOJIP_ID	=	:ls_mojip_id
				AND		HAP_ID	=	:ls_hap	
				AND		SUHUM_NO	like :ls_suhum				
				ORDER BY SUHUM_NO ) A,
			(	SELECT  	GASANG_NO,
	 						ROWNUM 	RN
				FROM   	HAKSA.GASANG_GWANRI
				WHERE  	GUBUN = '8'
				AND	  	ORDER_SEQ > ( 	SELECT	NVL(MAX(A.ORDER_SEQ), 0)
												FROM 		HAKSA.GASANG_GWANRI 	A,
															DIPSI.DI_GASANG		B
												WHERE		A.GASANG_NO	=	B.GASANG_NO
												AND		B.YEAR		=	:ls_year
												AND		B.HAKGI		=	:ls_hakgi)
				ORDER BY ORDER_SEQ ) B
WHERE		A.RN	=B.RN
ORDER BY A.SUHUM_NO
USING SQLCA ;


if sqlca.sqlcode <> 0 then
 rollback USING SQLCA ;
 messagebox('가상계좌입력 오류!', '일괄처리를 실패하였습니다!', exclamation!)
 RETURN
END IF

COMMIT USING SQLCA;
MESSAGEBOX('확인!', '일괄처리를 완료하였습니다.( 처리건수: ' + ll_count + '건 )')

SetPointer(Arrow!)
st_sangtae.text = ''


//
//
//
//
//
////재수강 자료를 먼저 처리한다.
//DECLARE CUR_IKWAN CURSOR FOR
//SELECT	A.HAKBUN,
//			A.GWAMOK_ID,
//			A.GWAMOK_SEQ,
//			A.JESU_YEAR,
//			A.JESU_HAKGI,
//			A.JESU_GWAMOK_ID,
//			A.JESU_GWAMOK_SEQ,
//			A.JUMSU,
//			DECODE(A.HWANSAN_JUMSU, 'A+', 9, 'A', 8, 'B+', 7, 'B', 6, 'C+', 5, 'C', 4, 'D+', 3, 'D', 2, 'F', 1, 0),
//			C.TMT_EACH_YN
//FROM		HAKSA.SUGANG_TRANS A,
//			HAKSA.GAESUL_GWAMOK	C
//WHERE		A.YEAR		=	C.YEAR
//AND		A.HAKGI		=	C.HAKGI
//AND		A.GWA			=	C.GWA
//AND		A.GWAMOK_ID	=	C.GWAMOK_ID
//AND		A.GWAMOK_SEQ=	C.GWAMOK_SEQ
//AND		A.YEAR		=		:ls_year
//AND		A.HAKGI		=		:ls_hakgi
//AND		A.HAKBUN	LIKE	:ls_hakbun
//AND		A.SUNGJUK_INJUNG	=	'Y'
//AND		A.JESU_YEAR	IS NOT NULL
//ORDER BY A.HAKBUN	;
//
//OPEN CUR_IKWAN ;
//DO
//	FETCH CUR_IKWAN INTO :as_hakbun, :as_gwamok, :ai_seq, :as_jesu_year, :as_jesu_hakgi, :as_jesu_gwamok, :ai_jesu_seq, :ai_jumsu, :ai_hwansan_jumsu, :as_tmt_each_yn ;
//
//	IF SQLCA.SQLCODE = -1 THEN
//		MESSAGEBOX("오류", "재수강 계산중 오류발생~r~n" + SQLCA.SQLERRTEXT)
//		ROLLBACK ;
//		RETURN
//		
//	ELSEIF SQLCA.SQLCODE = 100 THEN
//		EXIT
//	END IF
//	
//	//---------------------	재수강 계산
//	//재수강 성적 가져오기
//	SELECT	JUMSU,
//				DECODE(HWANSAN_JUMSU, 'A+', 9, 'A', 8, 'B+', 7, 'B', 6, 'C+', 5, 'C', 4, 'D+', 3, 'D', 2, 'F', 1, 0)
//	INTO		:li_jumsu,
//				:li_hwansan_jumsu
//	FROM		HAKSA.SUGANG
//	WHERE		HAKBUN		=	:as_hakbun
//	AND		YEAR			=	:as_jesu_year
//	AND		HAKGI			=	:as_jesu_hakgi
//	AND		GWAMOK_ID	=	:as_jesu_gwamok
//	AND		GWAMOK_SEQ	=	:ai_jesu_seq	;
//	
//	if sqlca.sqlcode <> 0 then
//		messagebox("오류",as_hakbun + "처리중 오류 발생(재수강성적 가져오기)~r~n" + sqlca.sqlerrtext)
//		rollback ;
//		return
//	end if
//	
//	//재수강점수와 현재 점수비교
//	//현재 환산점수가 이전환산점수보다 높으면  update  2006.11.23
//	//현재 점수가 이전점수보다 높으면  update
//	IF as_tmt_each_yn = 'Y' then	//상대평가일경우
//		IF ai_hwansan_jumsu > li_hwansan_jumsu THEN
//			UPDATE	HAKSA.SUGANG
//			SET	SUNGJUK_INJUNG	=	'N'
//			WHERE	HAKBUN		=	:as_hakbun
//			AND	YEAR			=	:as_jesu_year
//			AND	HAKGI			=	:as_jesu_hakgi
//			AND	GWAMOK_ID	=	:as_jesu_gwamok
//			AND	GWAMOK_SEQ	=	:ai_jesu_seq	;
//			
//			if sqlca.sqlcode <> 0 then
//				messagebox("오류",as_hakbun + "처리중 오류 발생(이전SUGANG 처리)~r~n" + sqlca.sqlerrtext)
//				rollback ;
//				return
//			end if		
//		END IF
//	ELSE
//		IF ai_jumsu > li_jumsu THEN
//			
//			//이전성적의 성적인정을 'N'으로 UPDATE
//			UPDATE	HAKSA.SUGANG
//			SET	SUNGJUK_INJUNG	=	'N'
//			WHERE	HAKBUN		=	:as_hakbun
//			AND	YEAR			=	:as_jesu_year
//			AND	HAKGI			=	:as_jesu_hakgi
//			AND	GWAMOK_ID	=	:as_jesu_gwamok
//			AND	GWAMOK_SEQ	=	:ai_jesu_seq	;
//			
//			if sqlca.sqlcode <> 0 then
//				messagebox("오류",as_hakbun + "처리중 오류 발생(이전SUGANG 처리)~r~n" + sqlca.sqlerrtext)
//				rollback ;
//				return
//			end if		
//
//		END IF
//	END IF	
//	
//	//Progress Bar
//	ll_cnt = ll_cnt + 1
//	hpb_1.Position = ll_cnt
//	
//	
//LOOP WHILE TRUE
//CLOSE CUR_IKWAN ;
//
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
//				NVL(A.JUMSU_1, 0),
//				NVL(A.JUMSU_2, 0),
//				NVL(A.JUMSU_3, 0),
//				NVL(A.JUMSU_4, 0),
//				NVL(A.JUMSU_5, 0),
//				NVL(A.JUMSU, 0),
//				NVL(A.HWANSAN_JUMSU, 'F'),
//				NVL(A.PYENGJUM, 0),
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
//				NULL,
//				A.ISU_ID
//	FROM	HAKSA.SUGANG_TRANS	A,
//			HAKSA.JAEHAK_HAKJUK	B
//	WHERE	A.HAKBUN				=	B.HAKBUN
//	AND	A.YEAR				=	:ls_year
//	AND	A.HAKGI				=	:ls_hakgi
//	AND	A.HAKBUN				LIKE	:ls_hakbun
//	AND	(A.SUNGJUK_INJUNG	=	'Y'
//	OR		A.HWANSAN_JUMSU	=	'W')
//	AND	A.HAKJUM				> 0
//)	;
//
//IF SQLCA.SQLCODE = 0 THEN
//	COMMIT ;
//	MESSAGEBOX("확인","성적이관이 완료되었습니다.")
//	
//ELSE
//	MESSAGEBOX("오류","성적이관중 오류가 발생되었습니다.~r~n" + SQLCA.SQLERRTEXT)
//	ROLLBACK ;
//	
//END IF
//
//SetPointer(Arrow!)
//st_sangtae.text = ''

end event

type st_sangtae from statictext within w_dip420a
integer x = 1257
integer y = 852
integer width = 1650
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
long backcolor = 16777215
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_dip420a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dip420a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

