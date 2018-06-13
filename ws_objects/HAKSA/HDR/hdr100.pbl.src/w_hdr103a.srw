$PBExportHeader$w_hdr103a.srw
$PBExportComments$[청운대]개별/일일/일괄등록금생성관리
forward
global type w_hdr103a from w_condition_window
end type
type dw_con from uo_dwfree within w_hdr103a
end type
type st_cnt from statictext within w_hdr103a
end type
type uo_1 from uo_imgbtn within w_hdr103a
end type
type uo_2 from uo_imgbtn within w_hdr103a
end type
type uo_3 from uo_imgbtn within w_hdr103a
end type
type dw_main from uo_dwfree within w_hdr103a
end type
end forward

global type w_hdr103a from w_condition_window
dw_con dw_con
st_cnt st_cnt
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
dw_main dw_main
end type
global w_hdr103a w_hdr103a

forward prototypes
public subroutine wf_chuga (string as_year, string as_hakgi, string as_hakbun)
end prototypes

public subroutine wf_chuga (string as_year, string as_hakgi, string as_hakbun);//string	ls_gwa, ls_hakyun, ls_janghak, ls_tyear, ls_thakgi
//long		ll_hakjum,	ll_iphak, ll_dungrok, ll_wonwoo, ll_janghak, ll_cnt
//int		li_rtn
//
////학사일정상의 년도 학기를 사용 장학을 가져온다.
//ls_tyear		= f_haksa_iljung_year()
//ls_thakgi	= f_haksa_iljung_hakgi()
//
//
//SELECT	GWA,
//			SU_HAKYUN
//INTO		:ls_gwa,
//			:ls_hakyun
//FROM		HAKSA.JAEHAK_HAKJUK
//WHERE		HAKBUN	=	:as_hakbun	
//;
//
//if sqlca.sqlcode <> 0 then
//	messagebox("오류","잘못된 학번입니다.")
//	return		
//end if
//
////----------------------------- 납입예정 금액을 가져온다.
//
//SELECT	COUNT(HAKBUN)
//INTO		:ll_cnt
//FROM		HAKSA.DUNGROK_GWANRI
//WHERE		HAKBUN	=	:as_hakbun
//AND		YEAR		=	:as_year	
//AND		HAKGI		=	:as_hakgi	;
//
////이전등록내역이 없는 사람은 최초생성임.
//IF ll_cnt = 0 THEN
//	li_rtn = uf_ilban_dungrok(as_year, as_hakgi, ls_hakyun, as_hakbun, ls_gwa)
//	
//ELSE
//			
//	//장학내역 가져오기
//	SELECT	JANGHAK_ID
//	INTO		:ls_janghak
//	FROM		HAKSA.JANGHAK_GWANRI
//	WHERE		HAKBUN	=	:as_hakbun
//	AND		YEAR		=	:ls_tyear	
//	AND		HAKGI		=	:ls_thakgi	;
//	
//	CHOOSE CASE ls_janghak
//		CASE 'I01','I11','O11' //성적장학A
//
//			li_rtn = uf_janghak_a(as_year, as_hakgi, ls_hakyun, as_hakbun, ls_gwa)
//		
//		CASE 'I02' //성적장학B
//		
//			li_rtn = uf_janghak_b(as_year, as_hakgi, ls_hakyun, as_hakbun, ls_gwa)
//	
//		CASE 'I03' //성적장학C
//
//			li_rtn = uf_janghak_c(as_year, as_hakgi, ls_hakyun, as_hakbun, ls_gwa)
//		
//		CASE 'I04' //성적장학D
//		
//			li_rtn = uf_janghak_d(as_year, as_hakgi, ls_hakyun, as_hakbun, ls_gwa)
//			
//		CASE ELSE //장학생이 아닌경우	
//			
//			li_rtn = uf_chuga_dungrok(as_year, as_hakgi, ls_hakyun, as_hakbun, ls_gwa)
//	END CHOOSE
//
//END IF
//
//if li_rtn = 0 then
//	commit ;
//	
//elseif li_rtn = 1 then
////	messagebox("확인","학점의 추가 또는 삭제가 이루어지지 않았습니다.")
//	
//elseif li_rtn = 2 then
//	rollback ;
//	
//end if
//	
end subroutine

on w_hdr103a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.st_cnt=create st_cnt
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.st_cnt
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.uo_3
this.Control[iCurrent+6]=this.dw_main
end on

on w_hdr103a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.st_cnt)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.dw_main)
end on

event ue_retrieve;string ls_year, ls_hakgi, ls_hakbun
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun   	=	func.of_nvl(dw_con.Object.hakbun[1], '%')

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi)  then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun )

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1

end event

event open;call super::open;//idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
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

type ln_templeft from w_condition_window`ln_templeft within w_hdr103a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr103a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr103a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr103a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr103a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr103a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr103a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr103a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr103a
end type

type uc_save from w_condition_window`uc_save within w_hdr103a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr103a
end type

type uc_print from w_condition_window`uc_print within w_hdr103a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr103a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr103a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr103a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr103a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr103a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr103a
end type

type gb_2 from w_condition_window`gb_2 within w_hdr103a
end type

type dw_con from uo_dwfree within w_hdr103a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hdr102a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_cnt from statictext within w_hdr103a
integer x = 2350
integer y = 192
integer width = 544
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
long backcolor = 32500968
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_1 from uo_imgbtn within w_hdr103a
integer x = 471
integer y = 40
integer width = 457
integer taborder = 50
boolean bringtotop = true
string btnname = "어학연수생성"
end type

event clicked;call super::clicked;// 미국 어학연수 장학생의 등록금을 생성하여준다.
string	ls_year, ls_hakgi, ls_hakbun, ls_hakbun1, ls_gwa, ls_hakyun, &
			ls_janghak, ls_mod, ls_mod1, ls_gubun, ls_bujun, ls_tyear, ls_thakgi
long		ll_cnt

string	ls_hu_year, ls_hu_hakgi

//ls_tyear	 	= f_haksa_iljung_year()
//ls_thakgi	= f_haksa_iljung_hakgi()

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun   	=	dw_con.Object.hakbun[1]

if ls_hakbun = '' or isnull(ls_hakbun) then
	MESSAGEBOX("확인","등록금 생성할 학생의 학번을 입력하여 주십시요.")
	return
	dw_con.setfocus()
	dw_con.SetColumn("hakbun")
end if

IF MESSAGEBOX("확인", ls_hakbun + "학생의 미국 어학연수 장학생등록금을 생성 하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

//기존에 등록금은 살아 있는 상태에서 미국 어학연수(4~6학점) 만 다시 생성 한다.

DELETE FROM	HAKSA.DUNGROK_GWANRI
WHERE		YEAR 		= :ls_year
AND		HAKGI		= :ls_hakgi
AND		HAKBUN	= :ls_hakbun
AND		WAN_YN 	= 'N'
AND		DUNG_YN 	= 'N'
AND		BUN_YN	= 'N'
USING SQLCA ;

IF sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	return
ELSE 
	COMMIT USING SQLCA ;
END IF

setpointer(hourglass!)

DECLARE LC_DUNGROK	CURSOR FOR
	SELECT	A.HAKBUN,
				A.GWA,
				A.SU_HAKYUN,
				A.JUNGONG_GUBUN,
				A.BUJUNGONG_ID,
				A.HJMOD_ID,
				B.JANGHAK_ID
	FROM		HAKSA.JAEHAK_HAKJUK A,
				HAKSA.JANGHAK_GWANRI B
	WHERE		A.HAKBUN			=	B.HAKBUN
	AND		B.JANGHAK_ID	=	'I18'
	AND		B.YEAR 			=  :ls_year
	AND		B.HAKGI 			=  :ls_hakgi
	AND		B.HAKBUN			=	:ls_hakbun
	USING SQLCA ;

OPEN LC_DUNGROK	;
DO
FETCH LC_DUNGROK INTO :ls_hakbun1, :ls_gwa, :ls_hakyun, :ls_gubun, :ls_bujun, :ls_mod, :ls_janghak	;

IF SQLCA.SQLCODE <> 0 THEN EXIT

	uf_janghak_study(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
	
LOOP WHILE TRUE

CLOSE LC_DUNGROK ;
COMMIT USING SQLCA ;

messagebox('완료',ls_hakbun + "학번의 등록금을 생성하였습니다.")

setpointer(arrow!)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hdr103a
integer x = 1070
integer y = 40
integer width = 457
integer taborder = 50
boolean bringtotop = true
string btnname = "개별생성"
end type

event clicked;call super::clicked;// 매일 신규생성되는 학생의 등록금을 생성하여준다.
string	ls_year, ls_hakgi, ls_hakbun, ls_hakbun1, ls_gwa, ls_hakyun, ls_hjmod_date,&
			ls_janghak, ls_mod, ls_mod1, ls_gubun, ls_bujun, ls_tyear, ls_thakgi
long		ll_cnt, ll_max_chasu, ll_count

string	ls_hu_year, ls_hu_hakgi, ls_pre_year, ls_pre_hakgi, ls_chk

//ls_tyear	 	= f_haksa_iljung_year()
//ls_thakgi	= f_haksa_iljung_hakgi()

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun   	=	dw_con.Object.hakbun[1]

if ls_hakbun = '' or isnull(ls_hakbun) then
	MESSAGEBOX("확인","등록금 생성할 학생의 학번을 입력하여 주십시요.")
	return
	dw_con.setfocus()
	dw_con.SetColumn("hakbun")
end if

IF MESSAGEBOX("확인", ls_hakbun + "학생의 등록금을 생성 하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

DELETE FROM	HAKSA.DUNGROK_GWANRI
WHERE		YEAR 		= :ls_year
AND		HAKGI		= :ls_hakgi
AND		HAKBUN	= :ls_hakbun
AND		WAN_YN 	= 'N'
AND		DUNG_YN 	= 'N'
AND		BUN_YN	= 'N'
USING SQLCA ;

IF sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	return
ELSE 
	COMMIT;
END IF

setpointer(hourglass!)

DECLARE LC_DUNGROK	CURSOR FOR
	SELECT	HAKBUN,
				GWA,
				SU_HAKYUN,
				JUNGONG_GUBUN,
				BUJUNGONG_ID,
				HJMOD_ID,
				SUBSTR(HJMOD_DATE, 1, 4)
	FROM		HAKSA.JAEHAK_HAKJUK
	WHERE		SANGTAE	=	'01'
	AND		HAKBUN 	=  :ls_hakbun
	USING SQLCA ;

OPEN LC_DUNGROK	;
DO
FETCH LC_DUNGROK INTO :ls_hakbun1, :ls_gwa, :ls_hakyun, :ls_gubun, :ls_bujun, :ls_mod, :ls_hjmod_date	;

IF SQLCA.SQLCODE <> 0 THEN EXIT


   /* 학기제, 학점제 적용 구분 체크 */
	ls_chk    = uf_hakgi_chk(ls_year, ls_hakgi, ls_hakbun)
	
	IF ls_chk = 'NO' THEN
		rollback USING SQLCA ;
		return
	END IF
	
	if (ls_mod = 'C' or ls_mod = 'I')  and  ls_hjmod_date >= '2005' then
	// 호텔관광학부로 2005년에 1학년으로 복학하는 사람부터 과를 바꿔 준다. BAB1 -> BAB0 
		if ls_gwa = 'BAB0' and ls_hakyun = '1' then
			ls_gwa = 'BAB1'
		end if
	end if


	//개인의 조회년도 학기의 최종학적변동을 찾아온다.
	SELECT	HJMOD_ID,
				YEAR,
				HAKGI
	INTO		:ls_mod1,
				:ls_pre_year,
				:ls_pre_hakgi
	FROM		HAKSA.HAKJUKBYENDONG
	WHERE		YEAR  	= :ls_year
	AND		HAKGI 	= :ls_hakgi
	AND		HAKBUN 	= :ls_hakbun1
	AND		HJMOD_ID = :ls_mod
	USING SQLCA ;
	
	if sqlca.sqlcode = -1 then
		messagebox('확인', ls_hakbun + "학생의 최종학적변동 오류가 발생하였습니다.")
		return
	elseif sqlca.sqlcode = 100 then
		ls_mod1 = ''
	end if
	
	//현재 년도 학기에 재입학여부 체크
	SELECT	count(*)
	INTO		:ll_count
	FROM		HAKSA.HAKJUKBYENDONG
	WHERE		YEAR  	= :ls_year
	AND		HAKGI 	= :ls_hakgi
	AND		HAKBUN 	= :ls_hakbun1
	AND		HJMOD_ID = 'I'
	USING SQLCA ;
		
	//개인의 올해 이전 등록내역 찾아온다.
	SELECT	COUNT(HAKBUN)
	INTO		:ll_cnt
	FROM		HAKSA.DUNGROK_GWANRI
	WHERE		HAKBUN	=	:ls_hakbun1
	AND		YEAR		=	:ls_year
	AND		HAKGI		=	:ls_hakgi
	AND		CHASU		=	1
	USING SQLCA ;


	//재학인 경우(전과생 포함)
	IF ls_mod1 = '' or ls_mod1 = 'F' then
		
		//이전등록내역이 없는 사람은 최초생성임.
		if ll_cnt = 0  or isnull(ll_cnt) then
			// 학적변동에 재입학이 있는 경우
			if ll_count > 0 then
				uf_jaeiphakilban_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa)
			else
				uf_ilban_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
			end if
		else

			IF ls_chk    = 'Y' then  /* 아래의 처리는 수강 추가 및 취소에 대한 차액계산이므로 학기제 적용대상은 처리하지 않는다 */

			   uf_ilban_dungrok1(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
				
			ELSE
				
				//장학내역 가져오기
				SELECT	JANGHAK_ID
				INTO		:ls_janghak
				FROM		HAKSA.JANGHAK_GWANRI
				WHERE		HAKBUN	=	:ls_hakbun
				AND		YEAR		=	:ls_year	
				AND		HAKGI		=	:ls_hakgi
//				AND		JANGHAK_ID IN ('I01','I02','I03','I04','I11','O11','O02','O33','O34')
				AND		JANGHAK_ID IN ('I01','I02','I03','I04','I11','O11','O02')
				USING SQLCA ;

				IF SQLCA.SQLCODE = -1 THEN
					RETURN 
				ELSE
			
					CHOOSE CASE ls_janghak
						CASE 'I11','O11','O02' //보훈
	
							uf_janghak_bohun(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)

						CASE 'I01' //과수석
							
							uf_janghak_a(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
						
						CASE 'I02' //성적장학A
						
							uf_janghak_b(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
					
						CASE 'I03' //성적장학B
				
							uf_janghak_c(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
						
						CASE 'I04' //성적장학C
						
							uf_janghak_d(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
							
						CASE ELSE //장학생이 아닌경우	
							
							uf_chuga_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
					END CHOOSE
				END IF
			END IF
		end if
	
	//복학인경우
	ELSEIF ls_mod1 = 'C' then


		//이전등록내역이 없는 사람은 최초생성임.
		if ll_cnt = 0  or isnull(ll_cnt) then 

			uf_bohakilban_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)

		else
			IF ls_chk    = 'Y' then  /* 아래의 처리는 수강 추가 및 취소에 대한 차액계산이므로 학기제 적용대상은 처리하지 않는다 */
			ELSE
				

				//최초 휴학 년도,  학기
				SELECT 	YEAR,
							HAKGI
				INTO		:ls_hu_year,
							:ls_hu_hakgi
				FROM		HAKSA.HAKJUKBYENDONG
				WHERE   	HJMOD_SIJUM = (	SELECT	HUHAK_DATE
													FROM		HAKSA.JAEHAK_HAKJUK
													WHERE		HAKBUN = :ls_hakbun1
												)
				AND		HAKBUN = :ls_hakbun	
				USING SQLCA ;
							
				//4. 복학전 등록학점 및 장학 가져오기
				SELECT 	JANGHAK_ID
				INTO		:ls_janghak		
				FROM		HAKSA.JANGHAK_GWANRI
				WHERE   	YEAR	=	:ls_hu_year
				AND		HAKGI	=	:ls_hu_hakgi
				AND		HAKBUN = :ls_hakbun
//				AND		JANGHAK_ID IN ('I01','I02','I03','I04','I11','O11','O02') 
				AND		JANGHAK_ID IN ('I11','O01','O02') 
				USING SQLCA ;
								
				// 국가 보훈 장학생이 추가로 수강신청했를경우				
				SELECT 	NVL(MAX(CHASU), 0)
				INTO		:ll_max_chasu
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR 		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN 	= 'Y'
				AND		DUNG_YN 	= 'Y'
				USING SQLCA ;
	
								
				// 휴학당시에 장학생이 등록안했을경우 현재는 장학생이 아닌경우로 처리
				if	ls_year = ls_pre_year and ls_hakgi = ls_pre_hakgi and ls_janghak <> ''  and ll_max_chasu = 0 then
					ls_janghak	= ''
				end if				
										
				IF SQLCA.SQLCODE = -1 THEN
					RETURN 
				ELSE
									
					CHOOSE CASE ls_janghak
						CASE 'I11','O11','O02' //보훈
	
							uf_janghak_bohun(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
							
						CASE 'I01'//성적장학A
				
							uf_janghak_a(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
						
						CASE 'I02' //성적장학B
						
							uf_janghak_b(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
					
						CASE 'I03' //성적장학C
				
							uf_janghak_c(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
						
						CASE 'I04' //성적장학D
						
							uf_janghak_d(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
							
						CASE ELSE //장학생이 아닌경우	
//							messagebox('국가보혼아님',ls_hakbun)
							uf_chuga_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
					END CHOOSE
				END IF
			END IF
		end if
		
	//재입학인경우	
	ELSEIF ls_mod1 = 'I' then

		//이전등록내역이 없는 사람은 최초생성임.
		if ll_cnt = 0  or isnull(ll_cnt) then 
			uf_jaeiphakilban_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa)
		else
			IF ls_chk    = 'Y' then  /* 아래의 처리는 수강 추가 및 취소에 대한 차액계산이므로 학기제 적용대상은 처리하지 않는다 */
			ELSE
				
				uf_chuga_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
			END IF
		end if
		
	END IF
LOOP WHILE TRUE

CLOSE LC_DUNGROK ;
COMMIT USING SQLCA ;

messagebox('완료',ls_hakbun + "학번의 등록금을 생성하였습니다.")
setpointer(arrow!)
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type uo_3 from uo_imgbtn within w_hdr103a
integer x = 1536
integer y = 40
integer width = 457
integer taborder = 60
boolean bringtotop = true
string btnname = "일괄생성"
end type

event clicked;call super::clicked;// 매일 신규생성되는 학생의 등록금을 생성하여준다.
string	ls_year, ls_hakgi, ls_hakbun, ls_gwa, ls_hakyun, ls_hjmod_date,&
			ls_janghak, ls_mod, ls_mod1, ls_gubun, ls_bujun, ls_tyear, ls_thakgi
long		ll_cnt, i, ll_tot, ll_max_chasu, ll_count

string	ls_hu_year, ls_hu_hakgi, ls_pre_year, ls_pre_hakgi, ls_chk

integer	li_rtn

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

IF MESSAGEBOX("확인", ls_hakbun + "학생의 등록금을 생성 하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

DELETE FROM	HAKSA.DUNGROK_GWANRI
WHERE		YEAR 		= :ls_year
AND		HAKGI		= :ls_hakgi
AND		WAN_YN 	= 'N'
AND		DUNG_YN 	= 'N'
AND		BUN_YN	= 'N'
USING SQLCA ;

IF sqlca.sqlcode <> 0 then
	MESSAGEBOX("오류","미납자료 삭제중 오류발생~r~n" + SQLCA.SQLERRTEXT)
	rollback USING SQLCA ;
	return

END IF

SELECT	COUNT(HAKBUN)
INTO	:ll_tot
FROM	HAKSA.JAEHAK_HAKJUK
WHERE	SANGTAE	=	'01'
USING SQLCA ;

setpointer(hourglass!)

DECLARE LC_DUNGROK	CURSOR FOR
	SELECT	HAKBUN,
				GWA,
				SU_HAKYUN,
				JUNGONG_GUBUN,
				BUJUNGONG_ID,
				HJMOD_ID,
				SUBSTR(HJMOD_DATE, 1, 4)
	FROM		HAKSA.JAEHAK_HAKJUK
	WHERE		SANGTAE	=	'01'
	USING SQLCA ;

OPEN LC_DUNGROK	;
DO
FETCH LC_DUNGROK INTO :ls_hakbun, :ls_gwa, :ls_hakyun, :ls_gubun, :ls_bujun, :ls_mod, :ls_hjmod_date		;

IF SQLCA.SQLCODE <> 0 THEN EXIT


   /* 학기제, 학점제 적용 구분 체크 */
	ls_chk    = uf_hakgi_chk(ls_year, ls_hakgi, ls_hakbun)

	IF ls_chk = 'NO' THEN
		rollback USING SQLCA ;
		return
	END IF
	
	if (ls_mod = 'C' or ls_mod = 'I')  and  ls_hjmod_date >= '2005' then
	// 호텔관광학부로 2005년에 1학년으로 복학하는 사람부터 과를 바꿔 준다. BAB1 -> BAB0 
		if ls_gwa = 'BAB0' and ls_hakyun = '1' then
			ls_gwa = 'BAB1'
		end if
	end if
	
	
	//장학 초기화
	ls_janghak = ''
	
	//개인의 조회년도 학기의 최종학적변동을 찾아온다.
	SELECT	HJMOD_ID,
				YEAR,
				HAKGI
	INTO		:ls_mod1,
				:ls_pre_year,
				:ls_pre_hakgi
	FROM		HAKSA.HAKJUKBYENDONG
	WHERE		YEAR  	= :ls_year
	AND		HAKGI 	= :ls_hakgi
	AND		HAKBUN 	= :ls_hakbun
	AND		HJMOD_ID = :ls_mod
	AND		HJMOD_SIJUM	=	(	SELECT 	MAX(HJMOD_SIJUM)
										FROM		HAKSA.HAKJUKBYENDONG
										WHERE		YEAR  	= :ls_year
										AND		HAKGI 	= :ls_hakgi
										AND		HAKBUN 	= :ls_hakbun
										AND		HJMOD_ID = :ls_mod		)
	USING SQLCA ;
	
	if sqlca.sqlcode = -1 then
		messagebox('확인', ls_hakbun + "학생의 최종학적변동 오류가 발생하였습니다.")
		return
		
	elseif sqlca.sqlcode = 100 then
		ls_mod1 = ''
		
	end if

	//현재 년도 학기에 재입학여부 체크
	SELECT	count(*)
	INTO		:ll_count
	FROM		HAKSA.HAKJUKBYENDONG
	WHERE		YEAR  	= :ls_year
	AND		HAKGI 	= :ls_hakgi
	AND		HAKBUN 	= :ls_hakbun
	AND		HJMOD_ID = 'I'
	USING SQLCA ;
	
	//개인의 올해 이전 등록내역 찾아온다.
	SELECT	COUNT(HAKBUN)
	INTO		:ll_cnt
	FROM		HAKSA.DUNGROK_GWANRI
	WHERE		HAKBUN	=	:ls_hakbun
	AND		YEAR		=	:ls_year
	AND		HAKGI		=	:ls_hakgi
	AND		CHASU		=	1
	USING SQLCA ;
	
	//재학인 경우(전과생 포함)
	IF ls_mod1 = '' or ls_mod1 = 'F' then
		
		//이전등록내역이 없는 사람은 최초생성임.
		if ll_cnt = 0  or isnull(ll_cnt) then 
			// 학적변동에 재입학이 있는 경우
			if ll_count > 0 then
				uf_jaeiphakilban_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa)
			else
				uf_ilban_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
			end if
			
		else
			
			IF ls_chk    = 'Y' then  /* 아래의 처리는 수강 추가 및 취소에 대한 차액계산이므로 학기제 적용대상은 처리하지 않는다 */
			   li_rtn = uf_ilban_dungrok1(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
			ELSE
				

				//장학내역 가져오기
				SELECT	JANGHAK_ID
				INTO		:ls_janghak
				FROM		HAKSA.JANGHAK_GWANRI
				WHERE		HAKBUN	=	:ls_hakbun
				AND		YEAR		=	:ls_year	
				AND		HAKGI		=	:ls_hakgi
				AND		JANGHAK_ID IN ('I01','I02','I03','I04','I11','O11','O02')
				USING SQLCA ;
							
				IF SQLCA.SQLCODE = -1 THEN
					RETURN 
				ELSE
	
					CHOOSE CASE ls_janghak
						CASE 'I11','O11','O02' //보훈
				
							li_rtn = uf_janghak_bohun(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
							
						CASE 'I01' //과수석
				
							li_rtn = uf_janghak_a(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
						
						CASE 'I02' //성적장학A
						
							li_rtn = uf_janghak_b(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
					
						CASE 'I03' //성적장학B
				
							li_rtn = uf_janghak_c(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
						
						CASE 'I04' //성적장학C
						
							li_rtn = uf_janghak_d(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
							
						CASE ELSE //장학생이 아닌경우
							
							li_rtn = uf_chuga_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
							
					END CHOOSE
				END IF
			END IF
		end if
	
	//복학인경우
	ELSEIF ls_mod1 = 'C' then
				
		//이전등록내역이 없는 사람은 최초생성임.
		if ll_cnt = 0  or isnull(ll_cnt) then 
			li_rtn = uf_bohakilban_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
			
		else
			IF ls_chk    = 'Y' then  /* 아래의 처리는 수강 추가 및 취소에 대한 차액계산이므로 학기제 적용대상은 처리하지 않는다 */
			ELSE
				

				//최초 휴학 년도,  학기
				SELECT 	YEAR,
							HAKGI
				INTO		:ls_hu_year,
							:ls_hu_hakgi
				FROM		HAKSA.HAKJUKBYENDONG
				WHERE   	HJMOD_SIJUM = (	SELECT	HUHAK_DATE
													FROM		HAKSA.JAEHAK_HAKJUK
													WHERE		HAKBUN = :ls_hakbun
												)
				AND		HAKBUN = :ls_hakbun	
				USING SQLCA ;
							
				//4. 복학전 등록학점 및 장학 가져오기
				SELECT 	JANGHAK_ID
				INTO		:ls_janghak		
				FROM		HAKSA.JANGHAK_GWANRI
				WHERE   	YEAR	=	:ls_hu_year
				AND		HAKGI	=	:ls_hu_hakgi
				AND		HAKBUN = :ls_hakbun
//				AND		JANGHAK_ID IN ('I01','I02','I03','I04','I11','O11','O02') 
				AND		JANGHAK_ID IN ('I11','O01','O02') 
				USING SQLCA ;
	
								
				// 국가 보훈 장학생이 추가로 수강신청했를경우				
				SELECT 	NVL(MAX(CHASU), 0)
				INTO		:ll_max_chasu
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR 		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN 	= 'Y'
				AND		DUNG_YN 	= 'Y'
				USING SQLCA ;
	
								
				// 휴학당시에 장학생이 등록안했을경우 현재는 장학생이 아닌경우로 처리
				if	ls_year = ls_pre_year and ls_hakgi = ls_pre_hakgi and ls_janghak <> ''  and ll_max_chasu = 0 then			
					ls_janghak	= ''
				end if				
				
				
				IF SQLCA.SQLCODE = -1 THEN
					RETURN 
				ELSE
					
					CHOOSE CASE ls_janghak
						CASE 'I11','O11','O02' //국가보훈
				
							li_rtn = uf_janghak_bohun(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
							
						CASE 'I01'//성적장학A
				
							li_rtn = uf_janghak_a(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
						
						CASE 'I02' //성적장학B
						
							li_rtn = uf_janghak_b(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
					
						CASE 'I03' //성적장학C
				
							li_rtn = uf_janghak_c(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
						
						CASE 'I04' //성적장학D
						
							li_rtn = uf_janghak_d(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
							
						CASE ELSE //장학생이 아닌경우	
							
							li_rtn = uf_chuga_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
							
					END CHOOSE
				END IF
			END IF
		end if
		
	//재입학인경우	
	ELSEIF ls_mod1 = 'I' then

		//이전등록내역이 없는 사람은 최초생성임.
		if ll_cnt = 0  or isnull(ll_cnt) then
			
			li_rtn = uf_jaeiphakilban_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa)
			
		else
			IF ls_chk    = 'Y' then  /* 아래의 처리는 수강 추가 및 취소에 대한 차액계산이므로 학기제 적용대상은 처리하지 않는다 */
			ELSE
				
				li_rtn = uf_chuga_dungrok(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_gubun, ls_bujun)
			END IF
			
		end if
		
	END IF
	
	if li_rtn = 2 then
		messagebox("오류",ls_hakbun + "생성중 오류가 발생하여 작업을 중단합니다.")
		rollback USING SQLCA ;
		return
	end if
	
	i = i + 1
	
	st_cnt.text = string(i) + '/' + string(ll_tot)
	
LOOP WHILE TRUE

CLOSE LC_DUNGROK 	;
COMMIT USING SQLCA ;

messagebox('완료', "등록금 일괄생성처리가 완료 되었습니다.")

st_cnt.text = ''

setpointer(arrow!)
end event

on uo_3.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hdr103a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hdr103a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string	ls_year, ls_hakgi, ls_hakbun, ls_hname, ls_gwajung, ls_hakgwa, ls_jungong, ls_janghak
long		ll_hakjum,	ll_iphak, ll_dungrok, ll_wonwoo, ll_janghak, ll_cnt

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

CHOOSE CASE	DWO.NAME
	//학번이 입력되면 기본사항을 가져온다.
	CASE	'd_dungrok_wan_yn'
		
		dw_main.object.d_dungrok_iphak_n[row]			=	dw_main.object.d_dungrok_iphak[row]
		dw_main.object.d_dungrok_dungrok_n[row]		=	dw_main.object.d_dungrok_dungrok[row]
		dw_main.object.d_dungrok_haksengwhe_n[row]	=	dw_main.object.d_dungrok_haksengwhe[row]
		dw_main.object.d_dungrok_gyojae_n[row]			=	dw_main.object.d_dungrok_gyojae[row]
		dw_main.object.d_dungrok_memorial_n[row]		=	dw_main.object.d_dungrok_memorial[row]
		dw_main.object.d_dungrok_album_n[row]			=	dw_main.object.d_dungrok_album[row]
		dw_main.object.d_dungrok_dongchangwhe_n[row]	=	dw_main.object.d_dungrok_dongchangwhe[row]		
		dw_main.object.d_dungrok_bank_id[row]			=	'05'
		dw_main.object.d_dungrok_napbu_date[row]		=	string(date(f_sysdate()), 'yyyymmdd')
			
END CHOOSE


end event

event itemerror;call super::itemerror;return 2
end event

