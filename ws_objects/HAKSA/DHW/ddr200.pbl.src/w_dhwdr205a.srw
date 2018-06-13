$PBExportHeader$w_dhwdr205a.srw
$PBExportComments$[대학원등록] 납부관리
forward
global type w_dhwdr205a from w_condition_window
end type
type dw_con from uo_dwfree within w_dhwdr205a
end type
type uo_1 from uo_imgbtn within w_dhwdr205a
end type
type uo_2 from uo_imgbtn within w_dhwdr205a
end type
type dw_main from uo_dwfree within w_dhwdr205a
end type
end forward

global type w_dhwdr205a from w_condition_window
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
dw_main dw_main
end type
global w_dhwdr205a w_dhwdr205a

forward prototypes
public subroutine wf_chuga (string as_year, string as_hakgi, string as_hakbun)
end prototypes

public subroutine wf_chuga (string as_year, string as_hakgi, string as_hakbun);string	ls_gwajung, ls_hakgwa, ls_jungong, ls_janghak, ls_chk
long		ll_hakjum,	ll_iphak, ll_dungrok, ll_wonwoo, ll_janghak, ll_cnt
int		li_rtn

SELECT	A.GWAJUNG_ID,
			A.GWA_ID,
			A.JUNGONG_ID,
			(	SELECT	'1'	CHK
				FROM 		HAKSA.D_HAKJUK		C
				WHERE		SUBSTR(C.HAKBUN, 3, 4) >= '2006'
				AND		A.HAKBUN	=	C.HAKBUN
				
				UNION
				
				SELECT	'0'	CHK
				FROM 		HAKSA.D_HAKJUK		C
				WHERE		SUBSTR(C.HAKBUN, 3, 4) < '2006'
				AND		A.HAKBUN	=	C.HAKBUN)		
INTO	:ls_gwajung,
		:ls_hakgwa,
		:ls_jungong,
		:ls_chk
FROM	HAKSA.D_HAKJUK A
WHERE A.HAKBUN	=	:as_hakbun	;

if sqlca.sqlcode <> 0 then
	messagebox("오류","잘못된 학번입니다.")
	return		
end if

//----------------------------- 납입예정 금액을 가져온다.

SELECT	COUNT(HAKBUN)
INTO	:ll_cnt
FROM	HAKSA.D_DUNGROK
WHERE	HAKBUN	=	:as_hakbun
AND	YEAR		=	:as_year	
AND	HAKGI		=	:as_hakgi	;

//이전등록내역이 없는 사람은 최초생성임.
IF ll_cnt = 0 THEN
	li_rtn = uf_dungrok_ilban(as_year, as_hakgi, as_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_chk)
	
ELSE
			
	//장학내역 가져오기
	SELECT	JANGHAK_ID
	INTO	:ls_janghak
	FROM	HAKSA.D_JANGHAK
	WHERE	HAKBUN	=	:as_hakbun
	AND	YEAR		=	:as_year	
	AND	HAKGI		=	:as_hakgi	;
	
	//본교직원일 경우
	if ls_janghak = '01'  then
		
		li_rtn = uf_dungrok_cwu(as_year, as_hakgi, as_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_chk)
		
		
	//혜전직원일 경우	
	elseif ls_janghak = '02' then
		
		li_rtn = uf_dungrok_hj(as_year, as_hakgi, as_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_chk)
		
	
	//직장인인 경우
	elseif ls_janghak = '03' then
		uf_dungrok_jikjang(as_year, as_hakgi, as_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_chk)
		
	//외국인인 경우
	elseif ls_janghak = '04' then	
		 
		
	else
		
	end if
	

END IF

if li_rtn = 0 then
	commit ;
	
elseif li_rtn = 1 then
	messagebox("확인","수강신청 내역이 존재하지 않습니다.")
	
elseif li_rtn = 2 then
	rollback ;
	
end if
	
end subroutine

on w_dhwdr205a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.dw_main
end on

on w_dhwdr205a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string 	ls_year,		ls_hakgi, 		ls_hakbun, ls_hakbun2, ls_chk
string	ls_sangtae, ls_hjmod_date, ls_hname,  ls_hakbun_chk
long		ll_ans, 		ll_dr_hakjum,	ll_su_hakjum

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun	=  dw_con.Object.hakbun[1] + '%'
ls_hakbun2	=  dw_con.Object.hakbun[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

SELECT	A.SANGTAE_ID, A.HJMOD_DATE, A.HNAME
INTO  	:ls_sangtae,
			:ls_hjmod_date,
			:ls_hname
FROM		HAKSA.D_HAKJUK A
WHERE		A.HAKBUN	= SUBSTR(:ls_hakbun,1,8)
USING SQLCA ;

if ls_sangtae = '03' then
	IF messagebox('확인', ls_hname + "(" + MID(ls_hakbun,1,8) + ") 이 학생은 " + MID(ls_hjmod_date,1,4) + "년" + MID(ls_hjmod_date,5,2) + "월" + MID(ls_hjmod_date,7,2) + "일" + "에 제적한 학생입니다.", Question!, YesNo!, 2) = 2 then
  return 1
	end if
end if

//학번을 입력하면 추가내역이 존재하는지 확인하여 있으면 추가생성
if ls_hakbun2 <> '' then
	
	SELECT HAKBUN
	INTO	:ls_chk
	FROM	HAKSA.D_HAKJUK
	WHERE	HAKBUN	=	:ls_hakbun2	
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","잘못된 학번입니다.")
		dw_con.SetFocus()
		dw_con.SetColumn("hakbun")
		return -1
		
	end if
	
	SELECT	SUM(HAKJUM)
	INTO	:ll_dr_hakjum
	FROM	HAKSA.D_DUNGROK
	WHERE	YEAR		=	:ls_year
	AND	HAKGI		=	:ls_hakgi
	AND	HAKBUN	=	:ls_hakbun2	
	USING SQLCA ;
	
	if sqlca.sqlcode = 100 then
		if messagebox("확인","등록내역이 존재하지 않습니다.~r~n등록내역을 생성하시겠습니까?", Question!, YesNo!, 1) = 1 then 
			uo_1.TriggerEvent('clicked')
			//wf_chuga(ls_year, ls_hakgi, ls_hakbun2)
		end if
		
	elseif sqlca.sqlcode = 0 then
		SELECT	SUM(HAKJUM)
		INTO	:ll_su_hakjum
		FROM	HAKSA.D_SUGANG_TRANS
		WHERE	YEAR		=	:ls_year
		AND	HAKGI		=	:ls_hakgi
		AND	HAKBUN	=	:ls_hakbun2	
		USING SQLCA ;
		
		SELECT	(	SELECT	'1'	CHK
						FROM 		HAKSA.D_HAKJUK		C
						WHERE		SUBSTR(C.HAKBUN, 3, 4) >= '2006'
						AND		A.HAKBUN	=	C.HAKBUN
						
						UNION
						
						SELECT	'0'	CHK
						FROM 		HAKSA.D_HAKJUK		C
						WHERE		SUBSTR(C.HAKBUN, 3, 4) < '2006'
						AND		A.HAKBUN	=	C.HAKBUN)	
		INTO	:ls_hakbun_chk		
		FROM	HAKSA.D_HAKJUK	A		
		WHERE	A.SANGTAE_ID	=	'01'
		AND	A.HAKBUN	LIKE	:ls_hakbun2	
		USING SQLCA ;
		
		 IF ls_hakbun_chk = '1' THEN

//			 UPDATE haksa.D_DUNGROK
//				 SET hakjum    = :ll_su_hakjum
//	//			     job_uid   = :gstru_uid_uname.uid,
//	//				  job_add   = :gstru_uid_uname.address,
//	//				  job_date  = sysdate
//			  WHERE hakbun    = :ls_hakbun
//				 AND year      = :ls_year
//				 AND hakgi     = :ls_hakgi
//				 AND chasu     = 1;
//				 
//				 MESSAGEBOX('ll_su_hakjum',ll_su_hakjum)
//				 				 MESSAGEBOX('ls_hakbun_chk',ls_hakbun_chk)
//				 
//			COMMIT ;	 
 		elseif ls_hakbun_chk = '0' and  ll_dr_hakjum <> ll_su_hakjum then
			if messagebox("확인","추가 또는 삭제 내역이 존재합니다.~r~n등록내역을 생성하시겠습니까?", Question!, YesNo!, 1) = 1 then 
				uo_1.TriggerEvent('clicked')
				//wf_chuga(ls_year, ls_hakgi, ls_hakbun2)
			end if					
		end if
		
	end if
	
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if


end event

event open;call super::open;string	ls_hakgi, ls_year

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

end event

event ue_delete;call super::ue_delete;int li_ans

//삭제확인
if uf_messagebox(4) = 2 then return

dw_main.deleterow(0)
li_ans = dw_main.update()				

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback USING SQLCA ;
else	
	commit USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

event ue_insert;call super::ue_insert;string ls_year, ls_hakgi, ls_dhw, ls_hakgwa, ls_gwajung
long ll_line, ll_row = 0

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_row = dw_main.getrow()

ll_line = dw_main.insertrow(ll_row + 1)
dw_main.scrolltorow(ll_line)

dw_main.object.d_dungrok_year[ll_line]		=	ls_year
dw_main.object.d_dungrok_hakgi[ll_line]	=	ls_hakgi

dw_main.SetColumn('d_dungrok_hakbun')
dw_main.setfocus()
end event

event ue_save;int li_ans
			
li_ans = dw_main.update()
					
if li_ans = -1 then
	rollback using sqlca ;
	//저장 오류 메세지 출력
	uf_messagebox(3)
	
else	
	commit using sqlca ;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwdr205a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwdr205a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwdr205a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwdr205a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwdr205a
integer beginx = -5
integer beginy = 116
integer endx = 4466
integer endy = 116
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwdr205a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwdr205a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwdr205a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwdr205a
end type

type uc_save from w_condition_window`uc_save within w_dhwdr205a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwdr205a
end type

type uc_print from w_condition_window`uc_print within w_dhwdr205a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwdr205a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwdr205a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwdr205a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwdr205a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwdr205a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwdr205a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwdr205a
end type

type dw_con from uo_dwfree within w_dhwdr205a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_dhwdr205a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_dhwdr205a
event destroy ( )
integer x = 402
integer y = 40
integer width = 421
integer taborder = 30
boolean bringtotop = true
string btnname = "추가생성"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_hakbun_arg, ls_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_janghak
string	ls_chk
long		ll_cnt
int		li_rtn

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun_arg	=  func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'

IF MESSAGEBOX("확인","추가생성 하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

SetPointer(HourGlass!)

DECLARE CUR_DUNGROK	CURSOR FOR
SELECT	A.HAKBUN,
			A.GWAJUNG_ID,
			A.GWA_ID,
			A.JUNGONG_ID,
			'0'	CHK
//			20090806	2009학년도 2학기부터 전부 학점제 적용
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
FROM	HAKSA.D_HAKJUK	A
WHERE	A.SANGTAE_ID	=	'01'
AND	A.HAKBUN	LIKE	:ls_hakbun_arg	
USING SQLCA ;

OPEN CUR_DUNGROK	;
DO
	FETCH CUR_DUNGROK INTO :ls_hakbun, :ls_gwajung, :ls_hakgwa, :ls_jungong, :ls_chk	;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT

	//등록금이 납부되지 않은 자료는 무조건 삭제한다.
	//등록금을 납부하지 않은 사람은 이전등록내역이 없는 학생과 같으므로...
	DELETE	FROM	HAKSA.D_DUNGROK
	WHERE	HAKBUN	=	:ls_hakbun
	AND	YEAR		=	:ls_year
	AND	HAKGI		=	:ls_hakgi
	AND	WAN_YN	=	'0'
	AND	DUNG_YN	=	'0'
	AND	BUN_YN	=	'0'
	USING SQLCA ;
	
	if sqlca.sqlcode = -1 then
		messagebox("오류","미납부자료 삭제중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if	

	SELECT	COUNT(HAKBUN)
	INTO	:ll_cnt
	FROM	HAKSA.D_DUNGROK
	WHERE	HAKBUN	=	:ls_hakbun
	AND	YEAR		=	:ls_year	
	AND	HAKGI		=	:ls_hakgi	
	USING SQLCA ;

	//이전등록내역이 없는 사람은 최초생성임.
	if ll_cnt = 0 then 
		
		li_rtn = uf_dungrok_ilban(ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_chk)
		
		if li_rtn = 2 then
			rollback USING SQLCA ;
			return
		else
			continue
		end if
	end if

	//장학내역 가져오기
	ls_janghak = '00'
	
	SELECT	JANGHAK_ID
	INTO	:ls_janghak
	FROM	HAKSA.D_JANGHAK
	WHERE	HAKBUN	=	:ls_hakbun
	AND	YEAR		=	:ls_year	
	AND	HAKGI		=	:ls_hakgi	
	USING SQLCA ;
	
	//본교직원일 경우
	if ls_janghak = '01'  then
		
		li_rtn = uf_dungrok_cwu(ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_chk)
		
	//혜전직원일 경우	
	elseif ls_janghak = '02' then
		
		li_rtn = uf_dungrok_hj(ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_chk)
	
	//직장인인 경우
	elseif ls_janghak = '03' then
		li_rtn = uf_dungrok_jikjang(ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_chk)
		
	//외국인인 경우
	elseif ls_janghak = '04' then	
		li_rtn = uf_dungrok_foreigner(ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_chk)
		
	else
	//장학생이 아닌경우	
		li_rtn =	uf_dungrok_chuga(ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_chk)
		
	end if
	
	//Return 값이 2이면 에러임.
	if li_rtn = 2 then
		rollback USING SQLCA ;
		return
	end if
		
LOOP WHILE TRUE
COMMIT USING SQLCA ;
SetPointer(HourGlass!)
messagebox("확인","작업이 완료되었습니다.")
dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun_arg)

end event

type uo_2 from uo_imgbtn within w_dhwdr205a
event destroy ( )
integer x = 905
integer y = 40
integer width = 718
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string btnname = "학기제수강신청학점적용"
end type

on uo_2.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string	ls_year,     ls_hakgi,   ls_hakbun,   ls_gwa,   ls_chk
Long     ll_cnt,      ll_totcnt,  ll_ans
Double   ldb_hakjum,  ll_hakjum

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun	=  func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'

//등록생성년도 학기에 해당자료유무검색
SELECT nvl(count(*), 0)
  INTO :ll_cnt
  FROM haksa.D_DUNGROK
 WHERE year    = :ls_year
   AND hakgi   = :ls_hakgi
USING SQLCA ;

IF ll_cnt      = 0 THEN
	messagebox("확인", ls_year + "년도 " +  ls_hakgi + "학기 자료가 없으니 확인바랍니다.")
	return
END IF

setpointer(hourglass!)

ll_totcnt     = 0

DECLARE cur_1  CURSOR FOR

  SELECT a.hakbun,
			(	SELECT	'1'	CHK
				FROM 		HAKSA.D_HAKJUK		C
				WHERE		SUBSTR(C.HAKBUN, 3, 4) >= '2006' //학기제 적용학번 2006이상
				AND		A.HAKBUN	=	C.HAKBUN
				
				UNION
				
				SELECT	'0'	CHK
				FROM 		HAKSA.D_HAKJUK		C
				WHERE		SUBSTR(C.HAKBUN, 3, 4) < '2006' //학점제 적용학번 2005이하
				AND		A.HAKBUN	=	C.HAKBUN)  
    FROM haksa.D_DUNGROK a,
	 		haksa.D_HAKJUK b
	WHERE a.year     = :ls_year
	  AND a.hakgi    = :ls_hakgi
	  AND a.hakbun   = b.hakbun
	  AND a.hakbun   like :ls_hakbun
	USING SQLCA ;

 OPEN   cur_1;
 DO WHILE(TRUE)
 FETCH cur_1 INTO  :ls_hakbun, :ls_chk;
 IF SQLCA.SQLCODE  <> 0 THEN  EXIT
 
	 IF ls_chk = '1' THEN

		 SELECT nvl(SUM(HAKJUM), 0)
		   INTO :ll_hakjum
		   FROM HAKSA.D_SUGANG_TRANS
		  WHERE HAKBUN	   = :ls_hakbun
		    AND YEAR      = :ls_year	
		    AND HAKGI     = :ls_hakgi
		 USING SQLCA ;
			 
		 UPDATE haksa.D_DUNGROK
		    SET hakjum    = :ll_hakjum
		  WHERE hakbun    = :ls_hakbun
		    AND year      = :ls_year
			 AND hakgi     = :ls_hakgi
			 AND chasu     = 1
		 USING SQLCA ;
			 
		 ll_totcnt        = ll_totcnt + 1

	 END IF

Loop

Close  Cur_1;


COMMIT USING SQLCA ;

MESSAGEBOX("확인","총 " + string(ll_totcnt) + "건의 작업이 종료되었습니다.")

//ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun)

setpointer(arrow!)
end event

type dw_main from uo_dwfree within w_dhwdr205a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dhwdr205a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemerror;call super::itemerror;return 2
end event

event itemchanged;call super::itemchanged;int	li_chasu, li_chk
long	ll_jang, ll_wonwoo
string	ls_year, ls_hakgi, ls_hakbun, ls_name, ls_gwajung, ls_hakgwa, ls_jungong

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

CHOOSE CASE	DWO.NAME
	//완납을 체크하면 금액이 setting
	CASE	'd_dungrok_wan_yn'
		if data = '1' then
			
			dw_main.object.d_dungrok_bank_id[row]		=	'1'
			dw_main.object.d_dungrok_napbu_date[row]	=	string(date(f_sysdate()), 'yyyymmdd')
			dw_main.object.d_dungrok_iphak_n[row]		=	dw_main.object.d_dungrok_iphak[row]
			
			ll_jang = dw_main.object.d_dungrok_d_janghak[row]
			if isnull(ll_jang) then
				ll_jang = 0 
			end if
			
			dw_main.object.d_dungrok_dungrok_n[row]	=	dw_main.object.d_dungrok_dungrok[row] - ll_jang
			
			dw_main.object.d_dungrok_wonwoo_n[row]		=	dw_main.object.d_dungrok_wonwoo[row]
			
			li_chasu = dw_main.object.d_dungrok_chasu[row]
			li_chk = dw_main.object.wonwoo_chk[row]
			
			//차수가 1이면 등록을 자동 체크한다.(단, 원우회비 입력을 위한 부분이 체크되어 있으면 등록이 안됨)
			if li_chasu = 1 and li_chk = 0  then
				dw_main.object.d_dungrok_dung_yn[row]	=	'1'
			
			end if
			
			//원우회비만 입력하는 컬럼이 check 되어 있으면 원우회비를 자동세팅한다.
			if li_chk = 1 then
				ls_hakbun = this.object.d_dungrok_hakbun[row]
				
				SELECT	B.WONWOO
				INTO		:ll_wonwoo
				FROM	HAKSA.D_HAKJUK				A,
						HAKSA.D_DUNGROK_MODEL	B
				WHERE	A.GWA_ID			=	B.GWA_ID
				AND	A.JUNGONG_ID	=	B.JUNGONG_ID
				AND	B.YEAR			=	:ls_year
				AND	B.HAKGI			=	:ls_hakgi
				AND	A.HAKBUN			=	:ls_hakbun
				USING SQLCA ;
				
				dw_main.object.d_dungrok_wonwoo_n[row] = ll_wonwoo
				
			end if
			
		else
						
			dw_main.object.d_dungrok_bank_id[row]		=	''
			dw_main.object.d_dungrok_napbu_date[row]	=	''
			dw_main.object.d_dungrok_dung_yn[row]		=	''
			
			setnull(ll_jang)
			
			dw_main.object.d_dungrok_iphak_n[row]		=	ll_jang
			dw_main.object.d_dungrok_dungrok_n[row]	=	ll_jang
			dw_main.object.d_dungrok_wonwoo_n[row]		=	ll_jang
		end if
		
		
	CASE	'd_dungrok_hakbun'
		
		SELECT	A.HNAME,
					A.GWAJUNG_ID,
					A.GWA_ID,
					A.JUNGONG_ID
		INTO	:ls_name,
				:ls_gwajung,
				:ls_hakgwa,
				:ls_jungong
		FROM	HAKSA.D_HAKJUK	A
		WHERE	A.HAKBUN		=	:data
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","잘못된 수험번호입니다.~r~n" + sqlca.sqlerrtext)
			this.object.d_dungrok_hakbun[row] = ''
			return 1
			
		end if
		
		//원우회비 납부자인지 체크
		SELECT	NVL(SUM(WONWOO_N), 0)
		INTO	:ll_wonwoo
		FROM	HAKSA.D_DUNGROK
		WHERE	YEAR		=	:ls_year
		AND	HAKGI		=	:ls_hakgi
		AND	HAKBUN	=	:data
		USING SQLCA ;
		
		if ll_wonwoo > 0 then
			messagebox("확인","이미 원우회비를 납부하셨습니다.~r~n" + sqlca.sqlerrtext)
			this.object.d_dungrok_hakbun[row] = ''
			return 1
		end if
		
		//차수생성
		SELECT	MAX(CHASU) + 1
		INTO	:li_chasu
		FROM	HAKSA.D_DUNGROK
		WHERE	YEAR		=	:ls_year
		AND	HAKGI		=	:ls_hakgi
		AND	HAKBUN	=	:data
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","차수생성중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
			this.object.d_dungrok_hakbun[row] = ''
			return 1
			
		end if
		
		dw_main.object.d_dungrok_year[row]		= ls_year
		dw_main.object.d_dungrok_hakgi[row]		= ls_hakgi
		dw_main.object.d_dungrok_chasu[row]		= li_chasu

		dw_main.object.d_hakjuk_hname[row]			= ls_name
		dw_main.object.d_hakjuk_gwajung_id[row]	= ls_gwajung
		dw_main.object.d_hakjuk_gwa_id[row]			= ls_hakgwa
		dw_main.object.d_hakjuk_jungong_id[row]	= ls_jungong

		
		
		dw_main.object.d_dungrok_chu_yn[row]	= '1'
		//원우회비만을 입력할 수 있게 Potect되어 있는 field값을 1로 setting
		dw_main.object.wonwoo_chk[row] = 1
		
END CHOOSE

end event

