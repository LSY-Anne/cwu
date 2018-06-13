$PBExportHeader$w_hjh103a.srw
$PBExportComments$[청운대]근로장학생A관리
forward
global type w_hjh103a from w_condition_window
end type
type dw_con from uo_dwfree within w_hjh103a
end type
type uo_1 from uo_imgbtn within w_hjh103a
end type
type dw_main from uo_dwfree within w_hjh103a
end type
end forward

global type w_hjh103a from w_condition_window
dw_con dw_con
uo_1 uo_1
dw_main dw_main
end type
global w_hjh103a w_hjh103a

type variables

end variables

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

on w_hjh103a.create
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

on w_hjh103a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.dw_main)
end on

event ue_retrieve;integer	li_row
string	ls_year, ls_hakgi, ls_hakyun, ls_gwa, ls_month

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_month    =	String(dw_con.Object.mm[1])

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) or ls_month = '' then
	messagebox('확인', "장학배정년도와 학기를 입력하세요!")
	return  -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
	
li_row = dw_main.retrieve(ls_year, ls_hakgi, ls_month, ls_hakyun, ls_gwa)

if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

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

event ue_insert;long	ll_newrow
string	ls_year, ls_hakgi, ls_hakyun, ls_gwa, ls_month

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_month		=  String(dw_con.Object.mm[1])

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) or ls_month = '' then
	messagebox('확인', "장학배정년도와 학기를 입력하세요!")
	return 
	dw_con.setfocus()
	dw_con.Setcolumn("year")
end if    

ll_newrow	= dw_main.InsertRow(0)//	데이타윈도우의 마지막 행에 추가

dw_main.object.work_janghak_year[ll_newrow] = ls_year
dw_main.object.work_janghak_hakgi[ll_newrow] = ls_hakgi
dw_main.object.work_janghak_janghak_id[ll_newrow] = 'I12'
dw_main.object.work_janghak_jigup_month[ll_newrow] = ls_month

IF ll_newrow <> -1 THEN
   dw_main.ScrollToRow(ll_newrow)		//	추가된 행에 스크롤
	dw_main.setcolumn(1)              	//	추가된 행의 첫번째 컬럼에 커서 위치
	dw_main.setfocus()                	//	dw_main 포커스 이동
END IF

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

type ln_templeft from w_condition_window`ln_templeft within w_hjh103a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh103a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh103a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh103a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh103a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh103a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh103a
end type

type uc_insert from w_condition_window`uc_insert within w_hjh103a
end type

type uc_delete from w_condition_window`uc_delete within w_hjh103a
end type

type uc_save from w_condition_window`uc_save within w_hjh103a
end type

type uc_excel from w_condition_window`uc_excel within w_hjh103a
end type

type uc_print from w_condition_window`uc_print within w_hjh103a
end type

type st_line1 from w_condition_window`st_line1 within w_hjh103a
end type

type st_line2 from w_condition_window`st_line2 within w_hjh103a
end type

type st_line3 from w_condition_window`st_line3 within w_hjh103a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh103a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh103a
end type

type gb_1 from w_condition_window`gb_1 within w_hjh103a
end type

type gb_2 from w_condition_window`gb_2 within w_hjh103a
end type

type dw_con from uo_dwfree within w_hjh103a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_hjh103a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjh103a
integer x = 471
integer y = 40
integer width = 690
integer taborder = 30
boolean bringtotop = true
string btnname = "전월근로장학생복사"
end type

event clicked;call super::clicked;string 	ls_year, ls_hakgi, ls_month, ls_hakyun, ls_gwa, ls_hakbun
string 	ls_last_year, ls_last_hakgi, ls_last_month, ls_buseo, ls_start, ls_end
string	ls_year1, ls_hakgi1, ls_hakyun1, ls_janghak, ls_month1, ls_gwa1, ls_gigan
int 		li_count, li_ans, li_jhcnt
dec  		ld_ibhak, ld_suup, ld_gisung
long 		ll_insert, ll_money

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_month  	= string(dw_con.Object.mm[1])
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')

IF ls_year = ''or ls_hakgi ='' or ls_month = '' then
	messagebox('확인', "년도,학기,지급월을 입력하세요!")
	return
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

SELECT	COUNT(*)
INTO 		:li_count
FROM 		HAKSA.WORK_JANGHAK
WHERE 	YEAR 	= :ls_year 
AND		HAKGI = :ls_hakgi
AND		JIGUP_MONTH = :ls_month	
AND		HAKYUN like	:ls_hakyun
AND		GWA	 like :ls_gwa
USING SQLCA ;
		
/* 최종년도 학기 지급월을 가져온다*/		
SELECT 	YEAR, 
			HAKGI,
			JIGUP_MONTH
INTO  	:ls_last_year ,
			:ls_last_hakgi,
			:ls_last_month
FROM 		HAKSA.WORK_JANGHAK
WHERE 	YEAR || HAKGI|| JIGUP_MONTH = (	SELECT	max(YEAR || HAKGI|| JIGUP_MONTH)
														FROM 		HAKSA.WORK_JANGHAK
													)
GROUP BY YEAR, HAKGI, JIGUP_MONTH
USING SQLCA ;

if li_count > 0 then
	messagebox("확인",ls_year + "년도" + ls_hakgi + "학기" + ls_month + "달의 근로장학금 이미 존재합니다.")
	return
else
	DECLARE LS_WORKJH CURSOR FOR
		SELECT 	HAKBUN,   
					YEAR,   
					HAKGI,   
					GWA,   
					HAKYUN,
					JANGHAK_ID,
					JIGUP_MONTH,
					BUSEO,
					WORK_START,
					WORK_END,
					WORK_GIGAN,
					JIGUP_MONEY
		FROM 		HAKSA.WORK_JANGHAK  
		WHERE 	( YEAR = :ls_last_year ) 
		AND  		( HAKGI = :ls_last_hakgi )
		AND		( JIGUP_MONTH = :ls_last_month)
		USING SQLCA ;
			
	OPEN LS_WORKJH ;
	DO
	FETCH LS_WORKJH INTO :ls_hakbun, :ls_year1, :ls_hakgi1, :ls_gwa1, :ls_hakyun1, :ls_janghak, 
								:ls_month1,	:ls_buseo, :ls_start, :ls_end, :ls_gigan, :ll_money;
	
		if sqlca.sqlcode <> 0  then exit
		
		SELECT 	COUNT(*)
		INTO		:li_jhcnt
		FROM		HAKSA.JANGHAK_GWANRI
		WHERE		YEAR 		= :ls_year
		AND		HAKGI		= :ls_hakgi
		AND		HAKBUN	= :ls_hakbun
		AND		JANGHAK_ID = 'I12'
		USING SQLCA ;
		
		IF li_jhcnt >0 then
			
			UPDATE 	HAKSA.JANGHAK_GWANRI  
			SET 		JANGHAK_ID 	= 'I12',
						SUNBAL_DATE	= TO_CHAR(SYSDATE,'YYYYMMDD')
			WHERE		YEAR	= :ls_year
			AND		HAKGI	= :ls_hakgi
			AND		HAKBUN	= :ls_hakbun
			USING SQLCA ;

		ELSE
			INSERT INTO HAKSA.JANGHAK_GWANRI  
				(		HAKBUN,   
						YEAR,   
						HAKGI,   
						GWA,   
						HAKYUN,   
						JANGHAK_ID,   
						SUNBAL_DATE 
				)  
			VALUES ( :ls_hakbun,   
						:ls_year,   
						:ls_hakgi,   
						:ls_gwa1,   
						:ls_hakyun1,   
						'I12',   
						TO_CHAR(SYSDATE,'YYYYMMDD')
					 ) USING SQLCA ;
		END IF
		
		INSERT INTO HAKSA.WORK_JANGHAK
			(	HAKBUN, YEAR, HAKGI, GWA, HAKYUN, JANGHAK_ID, JIGUP_MONTH, BUSEO, 
				WORK_START, WORK_END, WORK_GIGAN, JIGUP_MONEY)
		VALUES
			(	:ls_hakbun, :ls_year1, :ls_hakgi1, :ls_gwa1, :ls_hakyun1, :ls_janghak, 
				:ls_month,	:ls_buseo, :ls_start, :ls_end, :ls_gigan, :ll_money
			) USING SQLCA ;
				
	LOOP WHILE TRUE;
	
	CLOSE LS_WORKJH;
	
	COMMIT USING SQLCA;
	
	MESSAGEBOX('확인', ls_month + "월 근로장학생 생성을 완료하였습니다.!")

	setpointer(Arrow!)
end if
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hjh103a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hjh103a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string	ls_hakbun, ls_hakbun1, ls_hakyun, ls_gwa, ls_name
integer	li_cnt

CHOOSE CASE DWO.NAME
	CASE 'work_janghak_hakbun'
		
		ls_hakbun 	= data + '%'	
		
		SELECT 	count(HAKBUN)
		INTO		:li_cnt
		FROM		HAKSA.JAEHAK_HAKJUK
		WHERE		HAKBUN 	like :ls_hakbun
		or			HNAME	 	like :ls_hakbun
		USING SQLCA ;
		
		if li_cnt = 1 then
		
			SELECT	JAEHAK_HAKJUK.HAKBUN,
						JAEHAK_HAKJUK.HNAME,
						JAEHAK_HAKJUK.DR_HAKYUN,
						JAEHAK_HAKJUK.GWA
			INTO		:ls_hakbun1,
						:ls_name,
						:ls_hakyun,
						:ls_gwa
			FROM		HAKSA.JAEHAK_HAKJUK  
			WHERE		( JAEHAK_HAKJUK.HNAME		like :ls_hakbun)
			or			( JAEHAK_HAKJUK.HAKBUN		like :ls_hakbun)
			USING SQLCA ;
		elseif li_cnt > 1 then
				
			OpenWithParm(w_hjk101pp, ls_hakbun)
	
			ls_hakbun1	= Message.StringParm
			
			SELECT	JAEHAK_HAKJUK.HNAME,
						JAEHAK_HAKJUK.DR_HAKYUN,
						JAEHAK_HAKJUK.GWA
			INTO		:ls_name,
						:ls_hakyun,
						:ls_gwa
			FROM		HAKSA.JAEHAK_HAKJUK  
			WHERE		( JAEHAK_HAKJUK.HNAME		like :ls_hakbun1)
			or			( JAEHAK_HAKJUK.HAKBUN		like :ls_hakbun1)
			USING SQLCA ;
		end if
		
		dw_main.object.work_janghak_hakbun[row] = ls_hakbun1
		dw_main.object.jaehak_hakjuk_hname[row] = ls_name
		dw_main.object.work_janghak_hakyun[row] = ls_hakyun
		dw_main.object.work_janghak_janghak_id[row] = 'I12'
		dw_main.object.work_janghak_gwa[row] = ls_gwa
		
END CHOOSE		
		
end event

event itemerror;call super::itemerror;RETURN 2
end event

