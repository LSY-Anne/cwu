$PBExportHeader$w_hjh003a.srw
$PBExportComments$[청운대] 장학모델코드관리
forward
global type w_hjh003a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjh003a
end type
type dw_con from uo_dwfree within w_hjh003a
end type
type uo_1 from uo_imgbtn within w_hjh003a
end type
end forward

global type w_hjh003a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hjh003a w_hjh003a

on w_hjh003a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
end on

on w_hjh003a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event open;call super::open;idw_update[1] = dw_main

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

event ue_insert;long		ll_newrow
string	ls_year, ls_hakgi, ls_code

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi)then
	messagebox('확인', "등록금생성 년도와 학기를 입력하세요!")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if    

ll_newrow	= dw_main.InsertRow(0)//	데이타윈도우의 마지막 행에 추가

dw_main.object.year[ll_newrow] 	= ls_year
dw_main.object.hakgi[ll_newrow] = ls_hakgi

IF ll_newrow <> -1 THEN
   dw_main.ScrollToRow(ll_newrow)		//	추가된 행에 스크롤
	dw_main.setcolumn(1)              	//	추가된 행의 첫번째 컬럼에 커서 위치
	dw_main.setfocus()                	//	dw_main 포커스 이동
END IF
end event

event ue_retrieve;integer	li_row
string	ls_year, ls_hakgi

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "장학금모델 년도와 학기및 내외구분코드를 선택하세요!")
	return  -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if
	
li_row = dw_main.retrieve(ls_year, ls_hakgi)

if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

Return 1
end event

event ue_delete;int	li_ans1	,&
		li_ans2

li_ans1 = uf_messagebox(4)		//	삭제확인 메세지 출력

IF li_ans1 = 1 THEN
	dw_main.deleterow(0)          //	현재 행을 삭제
	li_ans2 = dw_main.update()    //	삭제된 내용을 저장
	
	IF li_ans2 = -1 THEN
		ROLLBACK USING SQLCA;     
		uf_messagebox(6)        //	삭제오류 메세지 출력
	
	ELSE
      COMMIT USING SQLCA;		  
		uf_messagebox(5)       //	삭제완료 메시지 출력
	END IF
END IF

end event

event ue_save;int	li_ans

dw_main.AcceptText()

li_ans = dw_main.update()		//	자료의 저장

IF li_ans = -1  THEN
	ROLLBACK USING SQLCA;
	uf_messagebox(3)       	//	저장오류 메세지 출력

ELSE
	COMMIT USING SQLCA;
	uf_messagebox(2)       //	저장확인 메세지 출력
END IF

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjh003a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh003a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh003a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh003a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh003a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh003a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh003a
end type

type uc_insert from w_condition_window`uc_insert within w_hjh003a
end type

type uc_delete from w_condition_window`uc_delete within w_hjh003a
end type

type uc_save from w_condition_window`uc_save within w_hjh003a
end type

type uc_excel from w_condition_window`uc_excel within w_hjh003a
end type

type uc_print from w_condition_window`uc_print within w_hjh003a
end type

type st_line1 from w_condition_window`st_line1 within w_hjh003a
end type

type st_line2 from w_condition_window`st_line2 within w_hjh003a
end type

type st_line3 from w_condition_window`st_line3 within w_hjh003a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh003a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh003a
end type

type gb_1 from w_condition_window`gb_1 within w_hjh003a
end type

type gb_2 from w_condition_window`gb_2 within w_hjh003a
end type

type dw_main from uo_input_dwc within w_hjh003a
integer x = 55
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjh003a_1"
end type

event itemchanged;string	ls_id, ls_jname, ls_sayu, ls_ingubun, ls_jigup

choose case  dwo.name
		
	case 'janghak_id'
		
		ls_id = data
		
		SELECT  	JANGHAK_NAME ,
					JANGHAK_SAYU ,
					INOUT_GUBUN ,
					JIGUP_GUBUN 
		INTO		:ls_jname,
					:ls_sayu,
					:ls_ingubun,
					:ls_jigup
		FROM 		HAKSA.JANGHAK_CODE      
		WHERE 	JANGHAK_ID = :ls_id
		USING SQLCA ;
		
		dw_main.object.janghak_name[row] = ls_jname
		dw_main.object.janghak_sayu[row] = ls_sayu
		dw_main.object.inout_gubun[row] = ls_ingubun
		dw_main.object.jigup_gubun[row] = ls_jigup
end choose
end event

event clicked;call super::clicked;string 	ls_year, ls_hakgi, ls_last_year, ls_last_hakgi
string 	ls_jhid, ls_iphak, ls_dungrok, ls_gigwan
int 		li_count, li_ans
long 		ll_insert, ll_gita

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

SELECT	COUNT(*)
INTO 		:li_count
FROM 		HAKSA.JANGHAK_MODEL
WHERE 	YEAR = 	:ls_year 
AND		HAKGI = 	:ls_hakgi 
USING SQLCA ;
		
/* 최종년도 학기를 가져온다*/		
SELECT 	YEAR, 
			HAKGI
INTO  	:ls_last_year ,
			:ls_last_hakgi
FROM 		HAKSA.JANGHAK_MODEL
WHERE 	YEAR || HAKGI = (	SELECT 	max(YEAR || HAKGI)
									FROM 		HAKSA.JANGHAK_MODEL		)
GROUP BY YEAR, HAKGI
USING SQLCA ;
			
		
if li_count > 0 then
	messagebox("확인",ls_year + "년도" + ls_hakgi + "학기 장학금 모델이 이미 존재합니다.")
	return
else
	
	setpointer(hourglass!)
	
	DECLARE LC_JHMODEL CURSOR FOR
		SELECT 	JANGHAK_MODEL.JANGHAK_ID,   
					JANGHAK_MODEL.IPHAKGUM_RAT,   
					JANGHAK_MODEL.DUNGROK_RAT,   
					JANGHAK_MODEL.GITAGUM,   
					JANGHAK_MODEL.JIGUP_GIGWAN
		FROM 		HAKSA.JANGHAK_MODEL  
		WHERE 	( JANGHAK_MODEL.YEAR 	= :ls_last_year ) 
		AND  		( JANGHAK_MODEL.HAKGI 	= :ls_last_hakgi )   
		USING SQLCA ;

	OPEN LC_JHMODEL ;
	DO
	FETCH LC_JHMODEL
	INTO  :ls_jhid, :ls_iphak, :ls_dungrok, :ll_gita, :ls_gigwan;
	
		if sqlca.sqlcode <> 0 then EXIT
		
		INSERT INTO HAKSA.JANGHAK_MODEL
			(	YEAR, HAKGI, JANGHAK_ID, IPHAKGUM_RAT, DUNGROK_RAT, GITAGUM, JIGUP_GIGWAN )
		VALUES
			(  :ls_year, :ls_hakgi, :ls_jhid, :ls_iphak, :ls_dungrok, :ll_gita, :ls_gigwan) USING SQLCA ;		

	LOOP WHILE TRUE;
	CLOSE LC_JHMODEL;
	
	COMMIT USING SQLCA;
	setpointer(ARROW!)

	messagebox("확인",ls_year + "학기 " + ls_hakgi + "장학금 모델 생성을 완료 했습니다.")
end if
end event

type dw_con from uo_dwfree within w_hjh003a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 170
boolean bringtotop = true
string dataobject = "d_hjh001a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjh003a
integer x = 672
integer y = 40
integer width = 585
integer taborder = 20
boolean bringtotop = true
string btnname = "이전장학모델복사"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string 	ls_year, ls_hakgi, ls_last_year, ls_last_hakgi
string 	ls_jhid, ls_iphak, ls_dungrok, ls_gigwan
int 		li_count, li_ans
long 		ll_insert, ll_gita

dw_con.Accepttext()

ls_year	= dw_con.Object.year[1]
ls_hakgi  = dw_con.Object.hakgi[1]

SELECT	COUNT(*)
INTO 		:li_count
FROM 	HAKSA.JANGHAK_MODEL
WHERE 	YEAR = 	:ls_year 
AND		HAKGI = 	:ls_hakgi 
USING SQLCA ;
		
/* 최종년도 학기를 가져온다*/		
SELECT 	YEAR, 
			HAKGI
INTO  	:ls_last_year ,
			:ls_last_hakgi
FROM 		HAKSA.JANGHAK_MODEL
WHERE 	YEAR || HAKGI = (	SELECT 	max(YEAR || HAKGI)
									FROM 		HAKSA.JANGHAK_MODEL		)
GROUP BY YEAR, HAKGI
USING SQLCA ;
			
		
if li_count > 0 then
	messagebox("확인",ls_year + "년도" + ls_hakgi + "학기 장학금 모델이 이미 존재합니다.")
	return
else
	
	setpointer(hourglass!)
	
	DECLARE LC_JHMODEL CURSOR FOR
		SELECT 	JANGHAK_MODEL.JANGHAK_ID,   
					JANGHAK_MODEL.IPHAKGUM_RAT,   
					JANGHAK_MODEL.DUNGROK_RAT,   
					JANGHAK_MODEL.GITAGUM,   
					JANGHAK_MODEL.JIGUP_GIGWAN
		FROM 		HAKSA.JANGHAK_MODEL  
		WHERE 	( JANGHAK_MODEL.YEAR 	= :ls_last_year ) 
		AND  		( JANGHAK_MODEL.HAKGI 	= :ls_last_hakgi )   
		USING SQLCA ;

	OPEN LC_JHMODEL ;
	DO
	FETCH LC_JHMODEL
	INTO  :ls_jhid, :ls_iphak, :ls_dungrok, :ll_gita, :ls_gigwan;
	
		if sqlca.sqlcode <> 0 then EXIT
		
		INSERT INTO HAKSA.JANGHAK_MODEL
			(	YEAR, HAKGI, JANGHAK_ID, IPHAKGUM_RAT, DUNGROK_RAT, GITAGUM, JIGUP_GIGWAN )
		VALUES
			(  :ls_year, :ls_hakgi, :ls_jhid, :ls_iphak, :ls_dungrok, :ll_gita, :ls_gigwan)
		USING SQLCA ;

	LOOP WHILE TRUE;
	CLOSE LC_JHMODEL;
	
	COMMIT USING SQLCA;
	setpointer(ARROW!)

	messagebox("확인",ls_year + "학기 " + ls_hakgi + "장학금 모델 생성을 완료 했습니다.")
end if
end event

