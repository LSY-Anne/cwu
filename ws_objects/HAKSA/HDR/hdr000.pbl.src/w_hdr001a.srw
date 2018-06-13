$PBExportHeader$w_hdr001a.srw
$PBExportComments$[청운대]등록모델관리
forward
global type w_hdr001a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hdr001a
end type
type dw_con from uo_dwfree within w_hdr001a
end type
type uo_1 from uo_imgbtn within w_hdr001a
end type
type uo_2 from uo_imgbtn within w_hdr001a
end type
end forward

global type w_hdr001a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
end type
global w_hdr001a w_hdr001a

on w_hdr001a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.uo_2
end on

on w_hdr001a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event open;call super::open;String ls_year, ls_hakgi

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

event ue_insert;long		ll_newrow
string	ls_year, ls_hakgi, ls_hakyun, ls_gwa

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]


if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인',  "등록금생성 년도와 학기를 입력하세요!")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_newrow	= dw_main.InsertRow(0)//	데이타윈도우의 마지막 행에 추가

dw_main.object.year[ll_newrow] = ls_year
dw_main.object.hakgi[ll_newrow] = ls_hakgi

IF ll_newrow <> -1 THEN
   dw_main.ScrollToRow(ll_newrow)		//	추가된 행에 스크롤
	dw_main.setcolumn(1)              	//	추가된 행의 첫번째 컬럼에 커서 위치
	dw_main.setfocus()                	//	dw_main 포커스 이동
END IF

end event

event ue_retrieve;integer	li_row
string	ls_year, ls_hakgi, ls_hakyun, ls_gwa

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]


if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인',  "등록금생성 년도와 학기를 입력하세요!")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ls_gwa    	=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')	
	
li_row = dw_main.retrieve(ls_year, ls_hakgi, ls_hakyun, ls_gwa)

if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr001a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr001a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr001a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr001a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr001a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr001a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr001a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr001a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr001a
end type

type uc_save from w_condition_window`uc_save within w_hdr001a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr001a
end type

type uc_print from w_condition_window`uc_print within w_hdr001a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr001a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr001a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr001a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr001a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr001a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr001a
end type

type gb_2 from w_condition_window`gb_2 within w_hdr001a
end type

type dw_main from uo_input_dwc within w_hdr001a
integer x = 50
integer y = 300
integer width = 4384
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hdr001a_1"
end type

event itemchanged;long	ll_hakseng, ll_gyojae, ll_album, ll_hakwhe, ll_memory, ll_dong

CHOOSE CASE DWO.NAME
	
	CASE 'haksengwhe', 'gyojae','album','hakwhe','memorial','dongchangwhe'
		
		dw_main.accepttext()		
		ll_hakseng 	= dw_main.object.haksengwhe[row]
		if isnull(ll_hakseng)  then
			ll_hakseng = 0
		end if
		
		ll_gyojae 	= dw_main.object.gyojae[row]
		if isnull(ll_gyojae)  then
			ll_hakseng = 0
		end if		
		
		ll_album 	= dw_main.object.album[row]
		if isnull(ll_album)  then
			ll_hakseng = 0
		end if		
		
		ll_hakwhe 	= dw_main.object.hakwhe[row]
		if isnull(ll_hakwhe)  then
			ll_hakseng = 0
		end if		
		
		ll_memory 	= dw_main.object.memorial[row]
		if isnull(ll_memory)  then
			ll_hakseng = 0
		end if		
		
		ll_dong 		= dw_main.object.dongchangwhe[row]
		if isnull(ll_dong)  then
			ll_hakseng = 0
		end if		
		
		dw_main.object.tot_japbu[row] = (ll_hakseng + ll_gyojae + ll_album + ll_hakwhe + ll_memory + ll_dong)
		
END CHOOSE
		
end event

type dw_con from uo_dwfree within w_hdr001a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_hdr001a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hdr001a
integer x = 498
integer y = 40
integer width = 457
integer taborder = 20
boolean bringtotop = true
string btnname = "기준학점적용"
end type

event clicked;call super::clicked;String ls_year,   ls_hakgi,  ls_gwa,  ls_hakyun,  ls_ban,  ls_gwamok_id,  ls_bunban
Long   ll_hakjum
Int    l_cnt

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

DECLARE cur_1  CURSOR FOR

SELECT 	a.gwa, a.hakyun, sum(a.hakjum)
FROM 		(	SELECT 	distinct 	gwa,
							hakyun, 
							gwamok_id, 
							gwamok_seq, 
							hakjum
				FROM 		haksa.gaesul_gwamok a 
				WHERE 	year     = :ls_year
				AND 		hakgi    = :ls_hakgi) a
GROUP BY a.gwa, a.hakyun
USING SQLCA ;

 OPEN   cur_1;
 DO WHILE(TRUE)
 FETCH cur_1 INTO  :ls_gwa, :ls_hakyun, :ll_hakjum ;
 IF SQLCA.SQLCODE  <> 0 THEN  EXIT
 
    l_cnt  = 0
    SELECT nvl(count(*), 0)
	   INTO :l_cnt
		FROM HAKSA.DUNGROK_MODEL
	  WHERE year     = :ls_year
	    AND hakgi    = :ls_hakgi
		 AND hakyun   = :ls_hakyun
		 AND gwa      = :ls_gwa 
	  USING SQLCA ;
	  
	 IF l_cnt        > 0 THEN
		 UPDATE HAKSA.DUNGROK_MODEL
			 SET gijun_hakjum  = :ll_hakjum
		  WHERE year     = :ls_year
			 AND hakgi    = :ls_hakgi
			 AND hakyun   = :ls_hakyun
			 AND gwa      = :ls_gwa 
		  USING SQLCA ;
		 IF sqlca.sqlcode  <> 0 THEN
			 messagebox("알림", '기준학점 적용 수정중 오류' + sqlca.sqlerrtext)
			 rollback USING SQLCA ;
			 return
		 END IF
	 END IF
   
Loop
Close  Cur_1;

commit USING SQLCA ;

messagebox("알림", '정상적으로 적용 되었습니다.')

Parent.TriggerEvent('ue_retrieve')
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hdr001a
integer x = 1029
integer y = 40
integer width = 631
integer taborder = 30
boolean bringtotop = true
string btnname = "이전등록금모델복사"
end type

event clicked;call super::clicked;string 	ls_year, ls_hakgi, ls_hakyun, ls_last_year, ls_last_hakgi
string 	ls_gwa, ls_gubun
int 		li_count, li_ans
long 		ll_insert, ll_iphak, ll_dungrok, ll_haksengwhe, ll_gyojae, ll_album
long		ll_hakwhe, ll_memori, ll_dongchang, ll_japbu	, ll_gijun_hakjum
Double   ll_hakgi_hakjum,  ll_hakgi_dungrok

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

/* 최종년도 학기를 가져온다*/		
SELECT 	DISTINCT YEAR, 
			HAKGI
INTO  	:ls_last_year ,
			:ls_last_hakgi
FROM 		HAKSA.DUNGROK_MODEL
WHERE 	YEAR || HAKGI = (	SELECT 	max(YEAR || HAKGI)
									FROM 		HAKSA.DUNGROK_MODEL		
									WHERE		HAKGI  NOT IN  ('3', '4'))
USING SQLCA ;

SELECT	COUNT(*)
INTO 		:li_count
FROM 		HAKSA.DUNGROK_MODEL
WHERE 	YEAR = :ls_year 
AND		HAKGI = :ls_hakgi 
USING SQLCA ;
		
if li_count > 0 then
	messagebox("확인",ls_year + "년도" + ls_hakgi + "학기 등록금 모델이 이미 존재합니다.")
	return
else
	
	DECLARE LC_DRMODEL CURSOR FOR
		SELECT 	DUNGROK_MODEL.HAKYUN,
					DUNGROK_MODEL.GWA,   
					NVL(DUNGROK_MODEL.IPHAK,0),   
					NVL(DUNGROK_MODEL.DUNGROK,0),   
					NVL(DUNGROK_MODEL.HAKSENGWHE,0),   
					NVL(DUNGROK_MODEL.GYOJAE,0),
					NVL(DUNGROK_MODEL.ALBUM,0),
					NVL(DUNGROK_MODEL.HAKWHE,0),
					NVL(DUNGROK_MODEL.MEMORIAL,0),
					NVL(DUNGROK_MODEL.DONGCHANGWHE,0),
					NVL(DUNGROK_MODEL.TOT_JAPBU,0),
					NVL(DUNGROK_MODEL.GIJUN_HAKJUM,0),
					NVL(DUNGROK_MODEL.TMT_HAKGI_DUNGROK,0),
					NVL(DUNGROK_MODEL.TMT_GIJUN_HAKJUM,0)
		FROM 		HAKSA.DUNGROK_MODEL  
		WHERE 	( DUNGROK_MODEL.year = :ls_last_year ) 
		AND  		( DUNGROK_MODEL.hakgi = :ls_last_hakgi )   
		USING SQLCA ;

	OPEN LC_DRMODEL ;
	DO
	FETCH LC_DRMODEL
	INTO  :ls_hakyun, :ls_gwa,		:ll_iphak,		:ll_dungrok,	:ll_haksengwhe,	:ll_gyojae,	:ll_album,
	 		:ll_hakwhe, :ll_memori,	:ll_dongchang,	:ll_japbu,		:ll_gijun_hakjum, :ll_hakgi_dungrok, :ll_hakgi_hakjum;
	
		if sqlca.sqlcode <> 0 then EXIT
		
		INSERT INTO HAKSA.DUNGROK_MODEL
			(	YEAR,		HAKGI,	HAKYUN,	GWA,			IPHAK,			DUNGROK,		HAKSENGWHE, 
				GYOJAE,	ALBUM,	HAKWHE,	MEMORIAL,	DONGCHANGWHE,	TOT_JAPBU, 	GIJUN_HAKJUM,
				TMT_HAKGI_DUNGROK,         TMT_GIJUN_HAKJUM)
		VALUES
			(  :ls_year,	:ls_hakgi,	:ls_hakyun,	:ls_gwa,		:ll_iphak,		:ll_dungrok,	:ll_haksengwhe,
				:ll_gyojae, :ll_album,	:ll_hakwhe,	:ll_memori,	:ll_dongchang,	:ll_japbu,		:ll_gijun_hakjum,
				:ll_hakgi_dungrok,         :ll_hakgi_hakjum)
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("확인", "오류가 발생했습니다.~r~n" + sqlca.sqlerrtext )
			rollback USING SQLCA ;
			return 
		end if

	LOOP WHILE TRUE;
	CLOSE LC_DRMODEL;
	
	COMMIT USING SQLCA ;

	messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 등록금 모델 생성을 완료 했습니다.")
end if
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

