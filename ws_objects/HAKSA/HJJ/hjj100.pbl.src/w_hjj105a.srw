$PBExportHeader$w_hjj105a.srw
$PBExportComments$[청운대]종합시험관리
forward
global type w_hjj105a from w_condition_window
end type
type dw_con from uo_dwfree within w_hjj105a
end type
type dw_main from uo_dwfree within w_hjj105a
end type
type uo_1 from uo_imgbtn within w_hjj105a
end type
end forward

global type w_hjj105a from w_condition_window
dw_con dw_con
dw_main dw_main
uo_1 uo_1
end type
global w_hjj105a w_hjj105a

on w_hjj105a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.uo_1
end on

on w_hjj105a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.uo_1)
end on

event ue_retrieve;string	ls_hakgwa	,&
			ls_year
int		li_row	,&
			li_rtn

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'

li_row		= dw_main.retrieve(ls_hakgwa, ls_year)

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1
end event

event ue_insert;long	ll_newrow

ll_newrow	= dw_main.InsertRow(0)		/*	데이타윈도우의 마지막 행에 추가			*/

if ll_newrow <> -1 then
     dw_main.ScrollToRow(ll_newrow)		/*	추가된 행에 스크롤							*/
	dw_main.setcolumn(1)              	/*	추가된 행의 첫번째 컬럼에 커서 위치		*/
	dw_main.setfocus()                	/*	dw_main 포커스 이동							*/
end if
end event

event ue_delete;int	li_ans1	,&
		li_ans2

li_ans1 = uf_messagebox(4)				/*	삭제확인 메세지 출력		*/

if li_ans1 = 1 then
	dw_main.deleterow(0)            	/*	현재 행을 삭제				*/
	li_ans2 = dw_main.update()      	/*	삭제된 내용을 저장 		*/
	
	if li_ans2 = -1 then        
		ROLLBACK USING SQLCA;     
		uf_messagebox(6)          		/*	삭제오류 메세지 출력		*/
	
	else
      COMMIT USING SQLCA;		  
		uf_messagebox(5)          		/*	삭제완료 메세지 출력		*/
	end if
end if

dw_main.setfocus()
end event

event ue_save;int		li_ans

dw_main.AcceptText()

li_ans = dw_main.update()				/*	자료의 저장				*/

IF li_ans = -1  THEN
	ROLLBACK USING SQLCA;
	uf_messagebox(3)            		/*	저장오류 메세지 출력	*/

ELSE
	
	COMMIT USING SQLCA;
	uf_messagebox(2)            		/*	저장확인 메세지 출력	*/
END IF

Return 1
end event

event open;call super::open;String ls_year

idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

// dddw 값 셋팅
Vector lvc_data

lvc_data = Create Vector

lvc_data.setProperty('column1', 'gwa') // 학과
lvc_data.setProperty('key1', 'HJK06')

func.of_dddw( dw_con,lvc_data)

ls_year	= f_haksa_iljung_year()

dw_con.Object.year[1]  = ls_year

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjj105a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjj105a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjj105a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjj105a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjj105a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjj105a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjj105a
end type

type uc_insert from w_condition_window`uc_insert within w_hjj105a
end type

type uc_delete from w_condition_window`uc_delete within w_hjj105a
end type

type uc_save from w_condition_window`uc_save within w_hjj105a
end type

type uc_excel from w_condition_window`uc_excel within w_hjj105a
end type

type uc_print from w_condition_window`uc_print within w_hjj105a
end type

type st_line1 from w_condition_window`st_line1 within w_hjj105a
end type

type st_line2 from w_condition_window`st_line2 within w_hjj105a
end type

type st_line3 from w_condition_window`st_line3 within w_hjj105a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjj105a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjj105a
end type

type gb_1 from w_condition_window`gb_1 within w_hjj105a
end type

type gb_2 from w_condition_window`gb_2 within w_hjj105a
end type

type dw_con from uo_dwfree within w_hjj105a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hjj105a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hjj105a
integer x = 55
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hjj105a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;long	ll_currow	,&
		ll_ilcha
		
string ls_ilcha_yn	,&
		 ls_echa_yn
		 
CHOOSE CASE dwo.name
	CASE	"jolup_sihum_sihum_yn"
				
		if data = '0' or data = '2' then
			setnull(ll_ilcha)
			dw_main.setitem(row, "jolup_sihum_sihum_jumsu", ll_ilcha )
			dw_main.setitem(row, "jolup_sihum_hapgyuk_yn", '0')
						
		end if
		
	CASE	"jolup_sihum_sihum_jumsu"
		ls_ilcha_yn = dw_main.getitemstring(row, "jolup_sihum_sihum_yn")
		
		if ls_ilcha_yn = '0' or ls_ilcha_yn = '2' then
			messagebox("입력오류", "일차시험 점수를 입력할 수 없습니다.", stopsign!)
			return 2
		end if
		
		if integer(data) > 100 then
			messagebox("입력오류", "100점을 초과할 수 없습니다.", stopsign!)
			return 2
			
		elseif integer(data) >= 80 then
			dw_main.setitem(row, "jolup_sihum_hapgyuk_yn", 'Y')
									
			ll_currow = dw_main.getrow()
			dw_main.setrow(ll_currow + 1)
			
		elseif integer(data) < 80 or isnull(data) then
			dw_main.setitem(row, "jolup_sihum_hapgyuk_yn", 'N')
		end if
		
	CASE	"jolup_sihum_jakpum_yn"
		ls_ilcha_yn = dw_main.getitemstring(row, "jolup_sihum_sihum_yn")
		ll_ilcha = dw_main.getitemnumber(row, "jolup_sihum_sihum_jumsu")
		
		if ls_ilcha_yn = '1' and ll_ilcha >= 80 then
			messagebox("입력오류", "졸업시험 합격자입니다.", stopsign!)
			return 2
		end if
		
	
	CASE	"jolup_sihum_jakpum_jumsu"
		
		ls_echa_yn = dw_main.getitemstring(row, "jolup_sihum_jakpum_yn")
		
		if ls_echa_yn = '0' then
			messagebox("입력오류", "졸업작품 점수를 입력할 수 없습니다.", stopsign!)
			return 2
		end if
		
		if isnull(ls_echa_yn) or trim(ls_echa_yn) = '' then
			messagebox("입력오류", "졸업작품 응시여부를 먼저 선택하세요.", stopsign!)
			return 2
		end if
		
		if integer(data) > 100 then
			messagebox("입력오류", "100점을 초과할 수 없습니다.", stopsign!)
			return 2
			
		elseif integer(data) >= 80 then
			dw_main.setitem(row, "jolup_sihum_hapgyuk_yn", 'Y')
						
		elseif integer(data) < 80 or isnull(data) then
			dw_main.setitem(row, "jolup_sihum_hapgyuk_yn", 'N')
						
		end if
END CHOOSE

end event

event itemerror;call super::itemerror;return 1
end event

type uo_1 from uo_imgbtn within w_hjj105a
integer x = 402
integer y = 40
integer width = 581
integer taborder = 20
boolean bringtotop = true
string btnname = "시험대상자생성"
end type

event clicked;call super::clicked;string	ls_year, ls_hakbun, ls_sihum_year, ls_ilcha_yn, ls_echa_yn, ls_gwa
int		li_count, li_ilcha_jumsu, li_echa_jumsu
long		ll_ans, ll_count

dw_con.AcceptText()

ls_year	= dw_con.Object.year[1]
ls_gwa	= func.of_nvl(dw_con.Object.gwa[1], '%')

if isnull(ls_year) or trim(ls_year) = '' then
	messagebox("확인", "응시연도를 입력하세요!")
	dw_con.setfocus()
	dw_con.SetColumn("year")
	return
end if

ll_ans = messagebox("확인", ls_year + " 학년도 졸업시험 대상자를 생성하시겠습니까?"	+&
							"~r~n기존에 생성된 자료는 삭제 후 새로 생성됩니다.", question!, yesno!, 2)

if ll_ans = 1 then
	
	SELECT	COUNT(A.HAKBUN)
	INTO		:ll_count
	FROM		HAKSA.JOLUP_SIHUM A
	       ,     HAKSA.JAEHAK_HAKJUK B
	WHERE	A.HAKBUN = B.HAKBUN
	    AND   A.JOLUP_YEAR	= :ls_year
		AND  B.GWA IN ( SELECT CODE FROM CDDB.KCH102D
		                           WHERE CODE_GB = 'HJK06'
									AND CODE      LIKE :ls_gwa || '%'
								    AND USE_YN    = 'Y' )
	   
	USING SQLCA ;
	
	if ll_count > 0 then
		DELETE	FROM HAKSA.JOLUP_SIHUM
		WHERE	JOLUP_YEAR	= :ls_year
		    AND    HAKBUN IN ( SELECT A.HAKBUN
			                               FROM HAKSA.JAEHAK_HAKJUK A
										      ,  CDDB.KCH102D B
									  WHERE A.GWA = B.CODE
									       AND B.CODE_GB = 'HJK06'
										   AND B.CODE      LIKE :ls_gwa || '%'
								            AND B.USE_YN    = 'Y' )
		USING SQLCA ;
	end if
	
	
	INSERT	INTO	HAKSA.JOLUP_SIHUM
			(	HAKBUN		,
				JOLUP_YEAR	,
				YEAR			,
				SIHUM_YN		,
				SIHUM_JUMSU	,
				JAKPUM_YN		,
				JAKPUM_JUMSU	,
				HAPGYUK_YN		)
		(	SELECT	HAKBUN	,
						:ls_year	,
						:ls_year	,
						null		,
						null		,
						null		,
						null		,
						'Y'		
			FROM	  HAKSA.JOLUP_SAJUNG 
		   WHERE YEAR = :ls_year
			   AND GWA  IN ( SELECT CODE FROM CDDB.KCH102D
		                               WHERE CODE_GB = 'HJK06'
									    AND CODE      LIKE :ls_gwa || '%'
								        AND USE_YN    = 'Y' ) )
	USING SQLCA ;
	
	if sqlca.sqlcode = 0 then
		
		SetPointer(HourGlass!)
		//기합격자 시험연도, 점수 SETTING
		DECLARE CUR_MIJOLUP CURSOR FOR
			
			SELECT	JH.HAKBUN
			FROM		HAKSA.JAEHAK_HAKJUK	JH		,
						HAKSA.JOLUP_SIHUM		JS
			WHERE	JH.HAKBUN		= JS.HAKBUN
			AND		JS.JOLUP_YEAR	= :ls_year
			AND       JH.GWA  IN ( SELECT CODE FROM CDDB.KCH102D
		                                      WHERE CODE_GB = 'HJK06'
									           AND CODE      LIKE :ls_gwa || '%'
								               AND USE_YN    = 'Y' )
			USING SQLCA ;
		
		OPEN CUR_MIJOLUP	;
		
		DO
			FETCH	CUR_MIJOLUP INTO	:ls_hakbun;
			
			IF SQLCA.SQLCODE <> 0 THEN
				EXIT
			END IF
			
			SELECT	MAX(YEAR)
			INTO		:ls_sihum_year
			FROM		HAKSA.JOLUP_SIHUM
			WHERE	HAKBUN = :ls_hakbun
			AND		HAPGYUK_YN = 'Y'
			USING SQLCA ;
			
			if not(isnull(ls_sihum_year)) then
			
				UPDATE	HAKSA.JOLUP_SIHUM
				SET	(	YEAR		,
							SIHUM_YN		,
							SIHUM_JUMSU	,
							JAKPUM_YN		,
							JAKPUM_JUMSU	,
							HAPGYUK_YN		)	= (	SELECT	YEAR			,
																		SIHUM_YN		,
																		SIHUM_JUMSU	,
																		JAKPUM_YN		,
																		JAKPUM_JUMSU	,
																		'Y'
															FROM		HAKSA.JOLUP_SIHUM
															WHERE	HAKBUN = :ls_hakbun
															AND		YEAR	= :ls_sihum_year
															AND		HAPGYUK_YN = 'Y'			
														)
				WHERE JOLUP_YEAR	= :ls_year
				AND	HAKBUN = :ls_hakbun
				USING SQLCA ;
			end if
		LOOP WHILE TRUE
		
		CLOSE CUR_MIJOLUP	;
		SetPointer(ARROW!)
		
		ll_ans	= messagebox("확인", "자료생성을 완료하였습니다" +&
									"~r~n자료를 저장하시겠습니까?", question!, yesno!, 2)
		if ll_ans = 1 then
			commit using sqlca;
		else
			rollback using sqlca;
		end if
		
	elseif sqlca.sqlcode = -1 then
		messagebox("오류", "시험대상자 생성을 실패하였습니다!")
		return
	end if
	
	dw_main.retrieve('%',ls_year)
	
end if

end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

