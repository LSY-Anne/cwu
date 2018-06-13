$PBExportHeader$w_hdr108a.srw
$PBExportComments$[청운대]계절학기등록자료생성
forward
global type w_hdr108a from w_condition_window
end type
type dw_con from uo_dwfree within w_hdr108a
end type
type st_cnt from statictext within w_hdr108a
end type
type uo_1 from uo_imgbtn within w_hdr108a
end type
type dw_main from uo_dwfree within w_hdr108a
end type
end forward

global type w_hdr108a from w_condition_window
dw_con dw_con
st_cnt st_cnt
uo_1 uo_1
dw_main dw_main
end type
global w_hdr108a w_hdr108a

on w_hdr108a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.st_cnt=create st_cnt
this.uo_1=create uo_1
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.st_cnt
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.dw_main
end on

on w_hdr108a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.st_cnt)
destroy(this.uo_1)
destroy(this.dw_main)
end on

event ue_retrieve;string ls_year, ls_hakgi, ls_hakbun
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun   	=	func.of_nvl(dw_con.Object.hakbun[1], '%')

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi)  then
	messagebox('확인', "년도, 학기, 학번을 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun)

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

type ln_templeft from w_condition_window`ln_templeft within w_hdr108a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr108a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr108a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr108a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr108a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr108a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr108a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr108a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr108a
end type

type uc_save from w_condition_window`uc_save within w_hdr108a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr108a
end type

type uc_print from w_condition_window`uc_print within w_hdr108a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr108a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr108a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr108a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr108a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr108a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr108a
end type

type gb_2 from w_condition_window`gb_2 within w_hdr108a
end type

type dw_con from uo_dwfree within w_hdr108a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hdr108a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_cnt from statictext within w_hdr108a
integer x = 2386
integer y = 192
integer width = 581
integer height = 64
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

type uo_1 from uo_imgbtn within w_hdr108a
integer x = 640
integer y = 40
integer width = 722
integer taborder = 20
boolean bringtotop = true
string btnname = "계절학기등록자료생성"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_hakbun, ls_hakyun, ls_drhakyun, ls_hakgwa, ls_shakbun, ls_suhakyun
string	ls_chk
long		ll_tdungrok, ll_thakjum, ll_tot_hakjum, ll_tot_dr
long		ll_hakjum,	ll_dungrok, ll_cnt, ll_tot, i
long		ll_base, ll_a, ll_b, ll_c, ll_d

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_shakbun  	=	func.of_nvl(dw_con.Object.hakbun[1], '%')

//등록생성년도 학기에 해당자료유무검색
SELECT	COUNT(*)
INTO		:ll_cnt
FROM		HAKSA.DUNGROK_GWANRI
WHERE		YEAR	=	:ls_year
AND		HAKGI	=	:ls_hakgi
AND		HAKBUN like :ls_shakbun
USING SQLCA ;

if ll_cnt > 0 then
	if messagebox("확인",ls_year + "년도 " +  ls_hakgi + "학기 자료가 존재합니다.~r~n" + &
									"삭제후 다시 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
									
	DELETE FROM HAKSA.DUNGROK_GWANRI
	WHERE	YEAR	=	:ls_year
	AND	HAKGI	=	:ls_hakgi
	AND	HAKBUN like :ls_shakbun
	AND	WAN_YN 	= 'N'
	AND	DUNG_YN 	= 'N'
	AND	BUN_YN	= 'N'	
	USING SQLCA ;
			
	if sqlca.sqlcode = 0 then
		commit USING SQLCA ;
	else
		messagebox("오류","이전자료 삭제중 오류 발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
	
end if

SELECT	COUNT(DISTINCT B.HAKBUN)
INTO		:ll_tot
FROM		HAKSA.SUGANG_TRANS A,
			HAKSA.JAEHAK_HAKJUK B
WHERE		A.HAKBUN = B.HAKBUN
AND		B.SANGTAE	=	'01'
AND		A.YEAR 		= :ls_year
AND		A.HAKGI 		= :ls_hakgi
AND		A.HAKBUN 	like :ls_shakbun
USING SQLCA ;

setpointer(hourglass!)

DECLARE LC_SEASONDR	CURSOR FOR
	SELECT	DISTINCT B.HAKBUN,
				B.DR_HAKYUN//,  //등록학년, 계절학기 이므로 그냥 등록학년 처리
//				B.DR_HAKYUN//,  //등록학년
//				A.HAKYUN      //수강테이블학년
	FROM		HAKSA.SUGANG_TRANS A,
				HAKSA.JAEHAK_HAKJUK B
	WHERE		A.HAKBUN 	= B.HAKBUN
	AND		B.SANGTAE	=	'01'
	AND		A.YEAR 		= :ls_year
	AND		A.HAKGI		= :ls_hakgi
	AND		A.HAKBUN 	like :ls_shakbun
	USING SQLCA ;

OPEN LC_SEASONDR	;
DO
	FETCH LC_SEASONDR INTO :ls_hakbun, :ls_suhakyun;//, :ls_drhakyun, :ls_hakyun;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT

	/* 학기제, 학점제 적용 구분 체크 */
	ls_chk    = uf_hakgi_chk(ls_year, ls_hakgi, ls_hakbun)
	
	
	DECLARE LC_DUNGROK CURSOR FOR
		SELECT 	GWA,
					SUM( HAKJUM )
		FROM		HAKSA.SUGANG_TRANS
		WHERE		YEAR = :ls_year
		AND		HAKGI = :ls_hakgi
		AND		HAKBUN = :ls_hakbun
		GROUP BY GWA
		USING SQLCA ;

	OPEN LC_DUNGROK ;
	DO
		FETCH LC_DUNGROK INTO :ls_hakgwa, :ll_hakjum;
		
		IF SQLCA.SQLCODE <> 0 THEN EXIT
	
			IF ls_chk = 'Y' THEN              //학기제 학생

				//2. 등록금 계산
				SELECT	TMT_HAKGI_DUNGROK				
				INTO		:ll_dungrok
				FROM		HAKSA.DUNGROK_MODEL
				WHERE		YEAR		= :ls_year
				AND		HAKGI 	= :ls_hakgi
				AND		GWA		= :ls_hakgwa
				AND		HAKYUN 	= :ls_suhakyun
				USING SQLCA ;
	
    			 if sqlca.sqlcode <> 0 then
				messagebox("오류","등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
				return
				end if	
				
				ll_thakjum 	= ll_thakjum + ll_hakjum 
				ll_tdungrok = ll_tdungrok + ll_dungrok 				

			else			//학점제 학생들			
		
				//2. 등록금 계산(장학금은 바로 적용되지 않고, )
				SELECT	DUNGROK				
				INTO		:ll_dungrok
				FROM		HAKSA.DUNGROK_MODEL
				WHERE		YEAR		= :ls_year
				AND		HAKGI 	= :ls_hakgi
				AND		GWA		= :ls_hakgwa
				AND		HAKYUN 	= :ls_suhakyun
				USING SQLCA ;
	
		
				if sqlca.sqlcode <> 0 then
				   messagebox("오류","등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
				   return
				end if	
				
				ll_thakjum 	= ll_thakjum + ll_hakjum 
				ll_tdungrok = ll_tdungrok + (ll_dungrok * ll_hakjum)
			end if
			
			
	LOOP WHILE TRUE;
	CLOSE LC_DUNGROK ;
	
	ll_tot_hakjum 	= ll_thakjum
	ll_tot_dr 		= ll_tdungrok

	//Table Insert
	INSERT INTO	HAKSA.DUNGROK_GWANRI
			(	HAKBUN,		YEAR,				HAKGI,				SU_HAKYUN,			CHASU,		
				HAKJUM,		IPHAK,			DUNGROK,				HAKSENGWHE,			GYOJAE,		
				ALBUM,		MEMORIAL,		DONGCHANGWHE,		I_JANGHAK,			D_JANGHAK,
				JANGHAK_ID,	WAN_YN,			DUNG_YN,				BUN_YN,				CHU_YN,
				HWAN_YN,		DUNGROK_GUBUN,	WORKER,										IPADDR	)
	VALUES(	:ls_hakbun,			:ls_year,		:ls_hakgi,			:ls_suhakyun,		1,				
				:ll_tot_hakjum,	0,					:ll_tot_dr,			0,						0,	
				0,						0,					0,						0,						0,	
				'',					'N',				'N',					'N',					'N',
				'N',					'1',				:gs_empcode,		:gs_ip )	
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","등록내역 생성중 오류발생~r~n" + sqlca.sqlerrtext)
		messagebox("학번", ls_hakbun)
		return
	end if
	
	ll_tdungrok = 0
	ll_thakjum 	= 0
	
	i = i + 1
	
	st_cnt.text = string(i) + '/' + string(ll_tot)
	
LOOP WHILE TRUE;
CLOSE LC_SEASONDR ;

COMMIT USING SQLCA ;

MESSAGEBOX("확인","작업이 종료되었습니다.")
setpointer(arrow!)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hdr108a
integer x = 55
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hdr101a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

