$PBExportHeader$w_dhwdr202a.srw
$PBExportComments$[대학원등록] 등록자료생성
forward
global type w_dhwdr202a from w_condition_window
end type
type dw_con from uo_dwfree within w_dhwdr202a
end type
type uo_1 from uo_imgbtn within w_dhwdr202a
end type
type dw_main from uo_dwfree within w_dhwdr202a
end type
end forward

global type w_dhwdr202a from w_condition_window
dw_con dw_con
uo_1 uo_1
dw_main dw_main
end type
global w_dhwdr202a w_dhwdr202a

forward prototypes
public subroutine wf_con_protect ()
end prototypes

public subroutine wf_con_protect ();// 계열, 학과, 전공 사용유무를 체크하여 protect한다.
// ls_chk1 : 계열, ls_chk2 : 학과, ls_chk3 : 전공
// Y: 사용, N: 미사용

String ls_chk1, ls_chk2, ls_chk3
Int      li_chk1, li_chk2, li_chk3

SELECT ETC_CD1, ETC_CD2, ETC_CD3
   INTO :ls_chk1, :ls_chk2, :ls_chk3
  FROM CDDB.KCH102D
 WHERE CODE_GB = 'DHW01'
 USING SQLCA ;
 
If  ls_chk1 = 'Y' Then
	li_chk1 = 0
Else
	li_chk1 = 1
End If

If  ls_chk2 = 'Y' Then
	li_chk2 = 0
Else
	li_chk2 = 1
End If

If  ls_chk3 = 'Y' Then
	li_chk3 = 0
Else
	li_chk3 = 1
End If
 
dw_con.Object.gyeyul_id.Protect = li_chk1
dw_con.Object.gwa.Protect        = li_chk2
dw_con.Object.jungong.Protect   = li_chk3

//dw_main.Object.d_hakjuk_gyeyul_id.Protect    = li_chk1
//dw_main.Object.d_hakjuk_gwa_id.Protect       = li_chk2
//dw_main.Object.d_hakjuk_jungong_id.Protect  = li_chk3
end subroutine

on w_dhwdr202a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.uo_1=create uo_1
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_main
end on

on w_dhwdr202a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_jungong, ls_gyeyul_id
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gyeyul_id =  func.of_nvl(dw_con.Object.gyeyul_id[1], '%')
ls_gwajung  =	func.of_nvl(dw_con.Object.gwajung[1], '%')
ls_hakgwa   =	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_jungong   =	func.of_nvl(dw_con.Object.jungong[1], '%')

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwajung, ls_gyeyul_id, ls_hakgwa, ls_jungong)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;string	ls_hakgi, ls_year
DataWindowChild ldwc_hjmod

idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi 

dw_con.getchild('jungong', ldwc_hjmod)
ldwc_hjmod.SetTransObject(sqlca)	
ldwc_hjmod.Retrieve('%')

end event

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwdr202a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwdr202a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwdr202a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwdr202a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwdr202a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwdr202a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwdr202a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwdr202a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwdr202a
end type

type uc_save from w_condition_window`uc_save within w_dhwdr202a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwdr202a
end type

type uc_print from w_condition_window`uc_print within w_dhwdr202a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwdr202a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwdr202a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwdr202a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwdr202a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwdr202a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwdr202a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwdr202a
end type

type dw_con from uo_dwfree within w_dhwdr202a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_dhwdr202a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gwa'
		DataWindowChild ldwc_hjmod

		This.getchild('jungong', ldwc_hjmod)
		ldwc_hjmod.SetTransObject(sqlca)	
		ldwc_hjmod.Retrieve(data)
		
End Choose
end event

type uo_1 from uo_imgbtn within w_dhwdr202a
integer x = 466
integer y = 40
integer width = 361
integer taborder = 40
boolean bringtotop = true
string btnname = "등록생성"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_janghak
string	ls_hajmod_sayu_id, ls_chk,   ls_hakbun_year
long		ll_hakjum,	ll_iphak, ll_dungrok, ll_wonwoo, ll_janghak, ll_cnt, li_cnt, ll_hakgi_dungrok

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

SELECT COUNT(*)
INTO	:ll_cnt
FROM	HAKSA.D_DUNGROK
WHERE	YEAR	=	:ls_year
AND	HAKGI	=	:ls_hakgi	
USING SQLCA ;

if ll_cnt > 0 then
	if messagebox("확인",ls_year + "년도 " +  ls_hakgi + "학기 자료가 존재합니다.~r~n" + &
									"삭제후 다시 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	DELETE FROM HAKSA.D_DUNGROK
			WHERE	YEAR	=	:ls_year
			AND	HAKGI	=	:ls_hakgi	
	USING SQLCA ;
			
	if sqlca.sqlcode = 0 then
		commit USING SQLCA ;
	else
		messagebox("오류","이전자료 삭제중 오류 발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
	
end if

SetPointer(HourGlass!)

//등록금 생성 - 재입학생은 입학금을 책정

DECLARE CUR_DUNGROK	CURSOR FOR

SELECT	SUBSTR(A.HAKBUN, 3, 4),
             A.HAKBUN,
			A.GWAJUNG_ID,
			A.HJMOD_SAYU_ID,
			DECODE(A.HJMOD_SAYU_ID, 'A12', B.IPHAK, NULL),
			B.DUNGROK,
			B.HAKGI_DUNGROK,
			B.WONWOO,
			'0'	CHK				
//20090906  2009학년도 2학기부터 전부 학점제로 시행			
//			(	SELECT	'1'	CHK
//				FROM 		HAKSA.D_HAKJUK		C
//				WHERE		SUBSTR(C.HAKBUN, 3, 4) >= '2006'
//				AND		A.HAKBUN	=	C.HAKBUN
//				
//				UNION
//				
//				SELECT	'0'	CHK
//				FROM 		HAKSA.D_HAKJUK		C
//				WHERE		SUBSTR(C.HAKBUN, 3, 4) < '2006'
//				AND		A.HAKBUN	=	C.HAKBUN)

FROM	HAKSA.D_HAKJUK				A,
		HAKSA.D_DUNGROK_MODEL	B
WHERE	A.GWA_ID			=	B.GWA_ID
AND	A.JUNGONG_ID	=	B.JUNGONG_ID
AND	A.SANGTAE_ID	=	'01'
AND	B.YEAR			=	:ls_year
AND	B.HAKGI			=	:ls_hakgi
USING SQLCA ;

OPEN CUR_DUNGROK	;
DO
	FETCH CUR_DUNGROK INTO :ls_hakbun_year, :ls_hakbun, :ls_gwajung, :ls_hajmod_sayu_id, :ll_iphak, :ll_dungrok, :ll_hakgi_dungrok, :ll_wonwoo, :ls_chk	;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
//	IF ls_hajmod_sayu_id ='A12' then
		SELECT	COUNT(HAKBUN)
		INTO 	:li_cnt
		FROM	HAKSA.D_HAKBYEN A
		WHERE A.YEAR				=	:ls_year
		AND	A.HAKGI				=	:ls_hakgi
		AND	A.HAKBUN 			= 	:ls_hakbun
		AND	A.HJMOD_SAYU_ID 	= 	'A12'
		USING SQLCA ;
//	END IF	

	IF li_cnt = 0 THEN
		ll_iphak = 0
	END IF
	//1. 수강학점 가져오기
	SELECT	NVL(SUM(HAKJUM), 0)
	INTO	:ll_hakjum
	FROM	HAKSA.D_SUGANG_TRANS
	WHERE	HAKBUN	=	:ls_hakbun
	AND	YEAR		=	:ls_year	
	AND	HAKGI		=	:ls_hakgi	
	USING SQLCA ;
	
	//수강신청 하지 않은 학생은 원우회비도 0 원 처리
	if ll_hakjum = 0 then
		ll_wonwoo = 0
		
	end if

	//2. 장학내역 가져오기
	ls_janghak = '00'
	setnull(ll_janghak)
	
	SELECT	JANGHAK_ID
	INTO	:ls_janghak
	FROM	HAKSA.D_JANGHAK
	WHERE	HAKBUN	=	:ls_hakbun
	AND	YEAR		=	:ls_year	
	AND	HAKGI		=	:ls_hakgi	
	USING SQLCA ;
	
	//3. 등록금 계산(장학금은 바로 적용되지 않고, )
//	SELECT	IPHAK,
//				DUNGROK,
//				WONWOO
//	INTO	:ll_iphak,
//			:ll_dungrok,
//			:ll_wonwoo
//	FROM	HAKSA.D_DUNGROK_MODEL
//	WHERE	GWA_ID		=	:ls_hakgwa
//	AND	JUNGONG_ID	=	:ls_jungong	;
//	
//	if sqlca.sqlcode <> 0 then
//		messagebox("오류","등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
//		return
//	end if
	
//	if ls_chk	=	'1' then 		//2006학번 이상인자(학기제)
//		ll_dungrok = ll_hakgi_dungrok
//	elseif ls_chk	=	'0' then		//2005학번 이하인자(학점제)
//		if ls_gwajung = '1' then
//			ll_dungrok	=	ll_dungrok * ll_hakjum
//			
//		elseif ls_gwajung = '5' then
//			ll_dungrok	=	(ll_dungrok / 6) * ll_hakjum
//			
//		end if
//	end if		
	
	//4. 등록금에 따른 장학금 계산   
	if ls_janghak = '01' then
		//본교교직원일 경우 (백만원 이상 등록하면 백만원까지, 이하이면 30%만 장학지원)--- 삭제조항20090806
		//20090806  본교교직원 무조건 45% 수정
		//20100216	본교교직원 2010학번이상은 50%		
//		if ll_dungrok > 1000000 then
//			ll_janghak = 1000000
//			
//		else
		if ls_hakbun_year >= '2010' then
			ll_janghak = ll_dungrok * 0.5
		else			
			ll_janghak = ll_dungrok * 0.45
		end if
//		end if
		
	elseif ls_janghak = '02' then
		//혜전교직원일 경우 (신청학점이 3학점 초과일 경우 80만원까지 지원, 이하이면 30%만 지원)--- 삭제조항20090806
		//20090806  혜전교직원 무조건 40% 수정
		//20100216	혜전교직원 2010학번이상은 50%
//		if ll_hakjum > 3 then
//			ll_janghak = 800000
//			
//		else
		if ls_hakbun_year >= '2010' then
			ll_janghak = ll_dungrok * 0.5
		else			
			ll_janghak = ll_dungrok * 0.4
		end if
			
//		end if

		
	elseif ls_janghak	=	'03' then
		// 직장인일 경우(등록금의 30% 장학지원)
		ll_janghak = ll_dungrok * 0.3
		
	elseif ls_janghak	=	'04' then
		// 외국일 경우(100% 장학지원)
		ll_janghak = ll_dungrok
				
	end if
	
	//Table Insert
	INSERT INTO	HAKSA.D_DUNGROK
			(	HAKBUN,		YEAR,				HAKGI,		CHASU,		HAKJUM,
				IPHAK,		DUNGROK,			WONWOO,		D_JANGHAK,
				WAN_YN,		DUNG_YN,			BUN_YN,		CHU_YN,		HWAN_YN	)
	VALUES(	:ls_hakbun,	:ls_year,		:ls_hakgi,	1,				:ll_hakjum,
				:ll_iphak,	:ll_dungrok,	:ll_wonwoo,	:ll_janghak,
				'0',			'0',				'0',			'0',			'0'		) USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류",LS_HAKBUN + "등록내역 생성중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	end if
			
LOOP WHILE TRUE
CLOSE CUR_DUNGROK ;

COMMIT USING SQLCA ;

SetPointer(HourGlass!)
MESSAGEBOX("확인","작업이 종료되었습니다.")

end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_dhwdr202a
integer x = 55
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 20
string dataobject = "d_dhwdr202a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

