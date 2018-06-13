$PBExportHeader$w_dip403a.srw
$PBExportComments$[대학원입시] 등록금생성
forward
global type w_dip403a from w_condition_window
end type
type dw_con from uo_dwfree within w_dip403a
end type
type uo_1 from uo_imgbtn within w_dip403a
end type
type dw_main from uo_dwfree within w_dip403a
end type
end forward

global type w_dip403a from w_condition_window
dw_con dw_con
uo_1 uo_1
dw_main dw_main
end type
global w_dip403a w_dip403a

on w_dip403a.create
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

on w_dip403a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_suhum
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_suhum	=	func.of_nvl(dw_con.Object.suhum_no[1], '%') + '%'

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_suhum)

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

idw_update[1] = dw_main

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

type ln_templeft from w_condition_window`ln_templeft within w_dip403a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dip403a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dip403a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dip403a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dip403a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dip403a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dip403a
end type

type uc_insert from w_condition_window`uc_insert within w_dip403a
end type

type uc_delete from w_condition_window`uc_delete within w_dip403a
end type

type uc_save from w_condition_window`uc_save within w_dip403a
end type

type uc_excel from w_condition_window`uc_excel within w_dip403a
end type

type uc_print from w_condition_window`uc_print within w_dip403a
end type

type st_line1 from w_condition_window`st_line1 within w_dip403a
end type

type st_line2 from w_condition_window`st_line2 within w_dip403a
end type

type st_line3 from w_condition_window`st_line3 within w_dip403a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dip403a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dip403a
end type

type gb_1 from w_condition_window`gb_1 within w_dip403a
end type

type gb_2 from w_condition_window`gb_2 within w_dip403a
end type

type dw_con from uo_dwfree within w_dip403a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_dip403a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_dip403a
integer x = 544
integer y = 40
integer width = 581
integer taborder = 40
boolean bringtotop = true
string btnname = "등록자료생성"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_suhum, ls_suhum_arg, ls_gwajung, ls_hakgwa, ls_jungong, ls_janghak, ls_gyeyul_id
long		ll_hakjum,	ll_iphak, ll_dungrok, ll_wonwoo, ll_i_janghak, ll_d_janghak, ll_cnt

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_suhum	=	func.of_nvl(dw_con.Object.suhum_no[1], '%') + '%'

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
end if

SELECT COUNT(*)
INTO	:ll_cnt
FROM	DIPSI.DI_DUNGROK
WHERE	YEAR			=	:ls_year
AND	HAKGI			=	:ls_hakgi
AND	SUHUM_NO LIKE	:ls_suhum_arg	
USING SQLCA ;

if ll_cnt > 0 then
	if messagebox("확인",ls_year + "년도 " +  ls_hakgi + "학기 자료가 존재합니다.~r~n" + &
									"삭제후 다시 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	DELETE FROM DIPSI.DI_DUNGROK
			WHERE	YEAR	=	:ls_year
			AND	HAKGI	=	:ls_hakgi
			AND	SUHUM_NO LIKE	:ls_suhum_arg
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

DECLARE CUR_DUNGROK	CURSOR FOR
SELECT	SUHUM_NO,
			GWAJUNG_ID,
			GYEYUL_ID,
			GWA_ID,
			JUNGONG_ID,
			JANGHAK_ID
FROM	DIPSI.DI_WONSEO
WHERE	HAP_ID	IN	('01', '11','12')
AND	YEAR	=	:ls_year
AND	HAKGI	=	:ls_hakgi
AND	SUHUM_NO LIKE	:ls_suhum_arg
USING SQLCA ;

OPEN CUR_DUNGROK	;
DO
	FETCH CUR_DUNGROK INTO :ls_suhum, :ls_gwajung, :ls_gyeyul_id, :ls_hakgwa, :ls_jungong, :ls_janghak	;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	//등록금모델에서 등록금을 가져온다.
	SELECT	IPHAK,
				DUNGROK,
				WONWOO
	INTO	:ll_iphak,
			:ll_dungrok,
			:ll_wonwoo
	FROM	DIPSI.DI_DUNGROK_MODEL				   
	WHERE	YEAR			=	:ls_year
	AND	HAKGI			=	:ls_hakgi
	AND   GYEYUL_ID   =  :ls_gyeyul_id
	AND	GWA_ID		=	:ls_hakgwa
	AND	JUNGONG_ID	=	:ls_jungong
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","등록금모델 적용중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	end if
	
	//연구과정
	if ls_gwajung = '5' then
		ll_dungrok	=	(ll_dungrok / 6) * ll_hakjum
		
	end if
	
	//등록금에 따른 장학금 계산
	if ls_janghak = '01' then
		//본교교직원일 경우 (백만원 이상 등록하면 백만원까지, 이하이면 30%만 장학지원)
		if ll_dungrok > 1000000 then
			ll_d_janghak = 1000000
			setnull(ll_i_janghak)
		else
			ll_d_janghak = ll_dungrok * 0.3
			setnull(ll_i_janghak)
			
		end if
		
	elseif ls_janghak = '02' then
		//혜전교직원일 경우 (팔십만원이상 등록하면 팔십원까지, 이하이면 30%만 장학지원)
		if ll_dungrok > 800000 then
			ll_d_janghak = 800000
						
		else
			ll_d_janghak = ll_dungrok * 0.3
						
		end if
		
	elseif ls_janghak	=	'03' then
		// 직장인일 경우
		ll_d_janghak = ll_dungrok * 0.3
				
	elseif ls_janghak	=	'04' then
		// 외국일 경우
		ll_d_janghak = ll_dungrok
		ll_i_janghak = ll_iphak
		
	end if
	
	//Table Insert
	INSERT INTO	DIPSI.DI_DUNGROK
			(	YEAR,			HAKGI,			SUHUM_NO,	CHASU,
				IPHAK,		DUNGROK,			WONWOO,		I_JANGHAK,	D_JANGHAK,
				WAN_YN,		DUNG_YN,			BUN_YN,		CHU_YN,		HWAN_YN		)
	VALUES(	:ls_year,	:ls_hakgi,		:ls_suhum,	1,
				:ll_iphak,	:ll_dungrok,	:ll_wonwoo,	:ll_i_janghak,	:ll_d_janghak,
				'0',			'0',				'0',			'0',				'0'		) USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","등록내역 생성중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	end if
	
	setnull(ll_i_janghak)
	setnull(ll_d_janghak)
LOOP WHILE TRUE
CLOSE CUR_DUNGROK ;

COMMIT USING SQLCA ;
SetPointer(Arrow!)

MESSAGEBOX("확인","작업이 종료되었습니다.")
dw_main.retrieve(ls_year, ls_hakgi, ls_suhum_arg)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_dip403a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dip403a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

