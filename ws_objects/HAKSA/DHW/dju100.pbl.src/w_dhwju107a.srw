$PBExportHeader$w_dhwju107a.srw
$PBExportComments$[대학원졸업] 학위번호 부여
forward
global type w_dhwju107a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwju107a
end type
type dw_con from uo_dwfree within w_dhwju107a
end type
type uo_1 from uo_imgbtn within w_dhwju107a
end type
end forward

global type w_dhwju107a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_dhwju107a w_dhwju107a

on w_dhwju107a.create
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

on w_dhwju107a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event open;call super::open;string	ls_hakgi, ls_year

idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate( 'YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate( 'YYYYMMDD')

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi 
end event

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_gwajung, ls_hakgwa
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","학기를 선택하세요")
	return -1
end if


ll_ans = dw_main.retrieve(ls_year, ls_hakgi)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwju107a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwju107a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwju107a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwju107a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwju107a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwju107a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwju107a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwju107a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwju107a
end type

type uc_save from w_condition_window`uc_save within w_dhwju107a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwju107a
end type

type uc_print from w_condition_window`uc_print within w_dhwju107a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwju107a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwju107a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwju107a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwju107a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwju107a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwju107a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwju107a
end type

type dw_main from uo_input_dwc within w_dhwju107a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dhwju107a"
end type

event itemchanged;call super::itemchanged;string ls_gwajung, ls_hakgwa, ls_hname

CHOOSE CASE	DWO.NAME
	//학번이 입력되면 기본사항을 가져온다.
	CASE	'd_nonmun_simsa_hakbun'
		
		SELECT	GWAJUNG_ID,
					GWA_ID,
					HNAME
		INTO	:ls_gwajung,
				:ls_hakgwa,
				:ls_hname
		FROM	HAKSA.D_HAKJUK
		WHERE	HAKBUN	=	:data	;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","잘못된 학번입니다.")
			this.object.d_nonmun_simsa_hakbun[row]	=	''
			return 1
			
		else
			this.object.d_hakjuk_hname[row]			=	ls_hname
			this.object.d_hakjuk_gwajung_id[row]	=	ls_gwajung
			this.object.d_hakjuk_gwa_id[row]			=	ls_hakgwa
			
		end if

END CHOOSE
		
end event

event itemerror;call super::itemerror;return 2
end event

type dw_con from uo_dwfree within w_dhwju107a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_dhwju107a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;String ls_from_dt, ls_to_dt

Choose Case dwo.name
	Case 'p_from_dt'
		ls_from_dt 	= String(This.Object.from_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'from_dt' , ls_from_dt)
		
		ls_from_dt 	= left(ls_from_dt, 4) + mid(ls_from_dt, 6, 2) + right(ls_from_dt, 2)
		This.SetItem(row, 'from_dt',  ls_from_dt)
		
	Case 'p_to_dt'
		ls_to_dt 	= String(This.Object.to_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'to_dt' , ls_to_dt)
		
		ls_to_dt 	= left(ls_to_dt, 4) + mid(ls_to_dt, 6, 2) + right(ls_to_dt, 2)
		This.SetItem(row, 'to_dt',  ls_to_dt)
End Choose
end event

type uo_1 from uo_imgbtn within w_dhwju107a
integer x = 745
integer y = 40
integer width = 343
integer taborder = 70
boolean bringtotop = true
string btnname = "번호부여"
end type

event clicked;call super::clicked;//학위등록번호, 학위증서번호, 수료번호 부여

string	ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_panjung, ls_dung_no
string	ls_j_ilja, ls_s_ilja, ls_hakwi_year, ls_chk3
string	ls_hakwi
long		ll_dung_s = 0, ll_jung_s, ll_su_s, ll_su_y

dw_con.AcceptText()

ls_year	 =	dw_con.Object.year[1]
ls_hakgi	 =	dw_con.Object.hakgi[1]
ls_j_ilja	 =	dw_con.Object.from_dt[1]
ls_s_ilja	 =	dw_con.Object.to_dt[1]

if ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","학기를 선택하세요")
	return 
end if

if messagebox("확인","학위번호를 부여하시겠습니까?~r~n졸업일자와 수료일자가 함께 입력됩니다.", Question!, YesNo!, 2) = 2 then return

SetPointer(HourGlass!)

//이전까지의 최종 학위등록번호
SELECT	NVL(MAX(SUBSTR(HAKWI_NO, LENGTH(HAKWI_NO) - 1, 2)), 0)
INTO	:ll_dung_s
FROM	HAKSA.D_HAKJUK
WHERE	substr(JOLUP_DATE, 1, 4) = :ls_hakwi_year
AND	GWAJUNG_ID = '1'
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("오류(1)","최종 학위등록번호를 찾을 수가 없습니다.")
	return
end if

//이전까지의 최종 학위증서번호
SELECT	MAX(JUNG_NO)
INTO :ll_jung_s
FROM	HAKSA.D_HAKJUK
WHERE	GWAJUNG_ID = '1' 
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("오류(2)","최종 졸업증서번호를 찾을 수가 없습니다.")
	return
end if

//이전까지의 최종 학위수료번호(수료번호를 가진 학생중 max가 졸업자인지 아닌지를 모름.)
SELECT NVL(MAX(SURYO_NO), 0)
INTO	:ll_su_s
FROM	(	SELECT	SURYO_NO
			FROM	HAKSA.D_HAKJUK
			WHERE	GWAJUNG_ID = '1'
			UNION
			SELECT	SURYO_NO
			FROM	HAKSA.D_HAKJUK
			WHERE	GWAJUNG_ID = '1') 
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("오류(3)","최종 학위수료번호를 찾을 수가 없습니다.")
	return
end if

//연구과정생의 최종수료번호
SELECT NVL(MAX(SURYO_NO), 0)
INTO	:ll_su_y
FROM	HAKSA.D_HAKJUK
WHERE	GWAJUNG_ID = '5'	
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("오류(4)","연구과정의 최종 학위수료번호를 찾을 수가 없습니다.")
	return
end if

// 전공 사용 체크
SELECT ETC_CD3
   INTO :ls_chk3
  FROM CDDB.KCH102D
 WHERE CODE_GB = 'DHW01'
 USING SQLCA ;

//학위번호 부여
DECLARE CUR_HAKWI CURSOR FOR
SELECT	A.HAKBUN,
			A.GWAJUNG_ID,
			A.GWA_ID,
			A.JUNGONG_ID,
			B.PANJUNG,
			DECODE( :ls_chk3, 'N', C.HAKWI_ID, D.HAKWI_ID )
FROM	HAKSA.D_HAKJUK			A,
		HAKSA.D_JOLUP_SAJUNG	B,
		HAKSA.D_JUNGONG_CODE	C,
		HAKSA.D_GWA_CODE    D
WHERE	A.HAKBUN	=	B.HAKBUN
AND	A.JUNGONG_ID	=	C.JUNGONG_ID
AND   A.GWA_ID        = D.GWA_ID
AND	B.YEAR			= :ls_year
AND	B.HAKGI			= :ls_hakgi
AND	B.PANJUNG 	in ('1', '2')
ORDER BY A.GWAJUNG_ID,
			A.GWA_ID,
			A.JUNGONG_ID,
			A.HAKBUN
USING SQLCA ;
		
OPEN	CUR_HAKWI ;
DO
	FETCH CUR_HAKWI INTO  :ls_hakbun, :ls_gwajung, :ls_hakgwa, :ls_jungong, :ls_panjung, :ls_hakwi	;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	if ls_gwajung = '1' then					//석사과정
		
		if ls_panjung = '1' then
			//학위 등록번호
			ll_dung_s	=  ll_dung_s + 1
			ls_dung_no	= '청운대' + ls_year + '(석)' + string(ll_dung_s, '00')
		
			//졸업증서번호
			ll_jung_s	= ll_jung_s + 1
		
		elseif ls_panjung = '2' then
			//수료번호
			ll_su_s = ll_su_s + 1
			
		end if

		//Update(DECODE가 안되면 IF문 사용해서 두번 할 것)
		UPDATE HAKSA.D_JOLUP_SAJUNG
		SET HAKWI_NO	=	:ls_dung_no	,
			 JUNG_NO		=	DECODE(PANJUNG, '1', :ll_jung_s, NULL)	,
			 SURYO_NO	=	DECODE(PANJUNG, '2', :ll_su_s,	NULL)	,
			 HAKWI_ID	=	DECODE(PANJUNG, '1', :ls_hakwi,	NULL)	,
			 JOLUP_DATE	=	DECODE(PANJUNG, '1', :ls_j_ilja,	NULL)	,
			 SURYO_DATE	=	DECODE(PANJUNG, '2', :ls_s_ilja,	NULL)	
		WHERE HAKBUN	=	:ls_hakbun
		AND	YEAR		=	:ls_year
		AND	HAKGI		=	:ls_hakgi	
		USING SQLCA ;
		
	elseif ls_gwajung = '5'	then				//연구생
		//수료생만 번호부여
		if ls_panjung = '2' then
			
			ll_su_y	= ll_su_y + 1
			
			UPDATE HAKSA.D_JOLUP_SAJUNG
			SET	SURYO_NO		=	:ll_su_y	,
					SURYO_DATE	=	:ls_s_ilja
			WHERE	HAKBUN	=	:ls_hakbun
			AND	YEAR		=	:ls_year
			AND	HAKGI		=	:ls_hakgi	
			USING SQLCA ;
		end if
			
	end if
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","학위번호부여중 오류가 발생되었습니다.")
		rollback USING SQLCA ;
		return
	end if			
					
LOOP WHILE TRUE
CLOSE CUR_HAKWI ;

COMMIT USING SQLCA ;

messagebox("확인","학위번호부여가 완료되었습니다.")
dw_main.retrieve(ls_year, ls_hakgi, '%', '%')
	
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

