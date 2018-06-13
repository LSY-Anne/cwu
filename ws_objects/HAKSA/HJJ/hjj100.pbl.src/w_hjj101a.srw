$PBExportHeader$w_hjj101a.srw
$PBExportComments$[청운대]졸업예정자 이관
forward
global type w_hjj101a from w_condition_window
end type
type st_3 from statictext within w_hjj101a
end type
type st_4 from statictext within w_hjj101a
end type
type dw_2 from uo_input_dwc within w_hjj101a
end type
type uo_progress from u_progress_bar within w_hjj101a
end type
type cb_1 from commandbutton within w_hjj101a
end type
type dw_con from uo_dwfree within w_hjj101a
end type
end forward

global type w_hjj101a from w_condition_window
st_3 st_3
st_4 st_4
dw_2 dw_2
uo_progress uo_progress
cb_1 cb_1
dw_con dw_con
end type
global w_hjj101a w_hjj101a

on w_hjj101a.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_4=create st_4
this.dw_2=create dw_2
this.uo_progress=create uo_progress
this.cb_1=create cb_1
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.uo_progress
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_con
end on

on w_hjj101a.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_2)
destroy(this.uo_progress)
destroy(this.cb_1)
destroy(this.dw_con)
end on

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.Insertrow(0)
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjj101a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjj101a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjj101a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjj101a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjj101a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjj101a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjj101a
end type

type uc_insert from w_condition_window`uc_insert within w_hjj101a
end type

type uc_delete from w_condition_window`uc_delete within w_hjj101a
end type

type uc_save from w_condition_window`uc_save within w_hjj101a
end type

type uc_excel from w_condition_window`uc_excel within w_hjj101a
end type

type uc_print from w_condition_window`uc_print within w_hjj101a
end type

type st_line1 from w_condition_window`st_line1 within w_hjj101a
end type

type st_line2 from w_condition_window`st_line2 within w_hjj101a
end type

type st_line3 from w_condition_window`st_line3 within w_hjj101a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjj101a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjj101a
end type

type gb_1 from w_condition_window`gb_1 within w_hjj101a
end type

type gb_2 from w_condition_window`gb_2 within w_hjj101a
end type

type st_3 from statictext within w_hjj101a
integer x = 1376
integer y = 820
integer width = 1303
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 1090519039
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_hjj101a
integer x = 617
integer y = 1060
integer width = 2789
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "재학생테이블에서 졸업예정자를 졸업사정TRANS테이블로 이관합니다."
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from uo_input_dwc within w_hjj101a
boolean visible = false
integer x = 846
integer y = 1248
integer width = 2423
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_hjj101a_1"
end type

type uo_progress from u_progress_bar within w_hjj101a
integer x = 1376
integer y = 736
integer taborder = 20
boolean bringtotop = true
end type

on uo_progress.destroy
call u_progress_bar::destroy
end on

type cb_1 from commandbutton within w_hjj101a
integer x = 1733
integer y = 1536
integer width = 695
integer height = 112
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "졸업예정자 이관"
end type

event clicked;
/********************************* 청운대학교 처리로직...************************************************
JAEHAK_HAKJUK테이블에서 SU_HAKYUN = 4 인 학생 and
학적상태가 '재학','휴학는 제외','수료'인 4학년 학생의 학번을 일단 가져와서 

dw_2에 display	예상취득학점이 140이상인자 이관 

if 마지막 학기 성적사정이 아직 미처리 then (처리구분 '1'로 입력)
	취득학점 + 수강학점이 140학점이 된 사람에 대해 졸업Trans 테이블로 이관시키면 될것 같다.
else 마지막 학기 성적사정이 처리 then
	취득학점 140학점이 된 사람에 대해 졸업Trans 테이블에 update하면 될것 같다.
end if
**************************************************************************************************************/
				
date 		ld_jolup_ilja, ld_today, ld_year_in
int 		p_ans, li_rowcount, tot_value, dialog_status, net, li_start, li_hakjum
long 		ll_starttime, ll_endtime

string	    ls_shakbun, ls_shakgwa, ls_gubun
string 	ls_temp, ls_chidk_hakjum, ls_churi_gubun, ls_jido_gyosu, ls_jolup_hakgi, ls_hakwi_code
string 	ls_hakbun, ls_hname, ls_hakbu_id, ls_gwa, ls_birthday, ls_jumin, ls_jolupjung_no
string 	ls_juyau, ls_hakwi_no, ls_jolup_ilja, ls_jolup_hakyun, ls_pro_id, ls_sungjuk, ls_gwa_temp, ls_hakbun_temp

INTEGER 	chidk_hakjum, sinchung_hakjum ,chong_hakjum, injung_hakjum, hyunjang_silsup//현장실습 따로 계산할 필요 없다.
STRING  	ls_year, ls_hakgi, ls_next_year, ls_next_hakgi, ls_today, ls_year_arg, ls_month_arg, ls_day_arg


HYUNJANG_SILSUP = 0
CHIDK_HAKJUM = 0
sinchung_hakjum = 0
chong_hakjum = 0
li_rowcount = 1

dw_con.AcceptText()

ls_shakgwa = func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_shakbun  = func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'
li_hakjum   = dw_con.Object.hakjum[1]
ls_gubun    = dw_con.Object.gubun[1]

// 현재 학기를 가져옴
SELECT 	YEAR,
			HAKGI,
			NEXT_YEAR,
			NEXT_HAKGI
INTO 		:ls_year,
			:ls_hakgi,
			:ls_next_year,
			:ls_next_hakgi
FROM 		HAKSA.HAKSA_ILJUNG
WHERE 	SIJUM_FLAG = 'Y'
USING SQLCA ;

if ls_hakgi = '1'  then
	ls_year_arg = string(INTEGER(ls_year) -1)
	ls_jolup_hakgi = '2'
else 
	ls_year_arg = ls_year
	ls_jolup_hakgi = '1'
end if

// 조기 졸업대상자테이블 초기화.
UPDATE HAKSA.EARLY_JOLUP A
      SET A.TRANS_YN = 'N'
 WHERE A.HAKBUN IN ( SELECT HAKBUN FROM HAKSA.JOLUP_SAJUNG
								 WHERE HAKBUN LIKE :ls_shakbun || '%'
								      AND GWA     LIKE :ls_shakgwa || '%' )
USING SQLCA ;

If sqlca.sqlcode <> 0 Then
  Rollback USING SQLCA ;
  Messagebox('조기졸업초기화', '조기졸업대상 테이블 초기화시 실패하였습니다.')
  Return -1
End If

//전체조회
IF ls_gubun = '1' Then
	
   net = Messagebox("졸업","졸업사정 Table 을 지울까요",Question!,yesno!)
	
   if net = 1 then
		setpointer(hourglass!)
		
		DELETE FROM HAKSA.JOLUP_SAJUNG  
		USING SQLCA ;
		
		 if sqlca.sqlcode <> 0 then
			rollback USING SQLCA ;
			Messagebox("졸업","졸업사정 Table 삭제를 실패하였읍니다.")
			Return -1
		 end if
		 
	end if

	dw_2.settransobject(sqlca)
	dw_2.retrieve(ls_shakgwa, ls_shakbun)
	
	li_rowcount = dw_2.rowcount()	

	FOR li_start = 1 TO li_rowcount
	 
		st_3.text = "("+string(li_start)+ " / " + string(li_rowcount) + ")" + " 처리중입니다"
	 
		if li_start = li_rowcount then
			st_3.text = string(li_rowcount)+"건이 처리되었습니다."
		end if
	 
		uo_progress.uf_init(li_rowcount)
		uo_progress.uf_set_position(li_start)
	
		ls_hakbun 	= dw_2.object.hakbun[li_start]              
		ls_hname 	= dw_2.object.hname[li_start]
		ls_gwa 		= dw_2.object.gwa[li_start]
		ls_juyau 	    = dw_2.object.juya_gubun[li_start]
		
		ls_hakwi_code = uf_hakwi_code(ls_gwa)
	
		// 지도교수
		SELECT	MEMBER_NO4           
		INTO   	:ls_jido_gyosu
		FROM   	HAKSA.JAEHAK_SINSANG
		WHERE  	HAKBUN = :ls_hakbun
		USING SQLCA ;
	
		// 성적사정 이후 현재까지 취득학점 구함 (4학년 마지막 학기 전까지)
//		SELECT	SUM(CHIDK_HAKJUM)
//		INTO		:chidk_hakjum
//		FROM		HAKSA.SUNGJUKGYE
//		WHERE		HAKBUN = :ls_hakbun
//		;
		SELECT	SUM(HAKJUM)
		INTO		:chidk_hakjum
		FROM		HAKSA.SUGANG
		WHERE	SUNGJUK_INJUNG ='Y'
		AND		HWANSAN_JUMSU	<> 'F'
		AND		HAKBUN			= :ls_hakbun
		USING SQLCA ;
		
		//인정학점 구함
		SELECT 	INJUNG_HAKJUM
		INTO   	:injung_hakjum
		FROM   	HAKSA.JAEHAK_HAKJUK
		WHERE  	JAEHAK_HAKJUK.HAKBUN = :ls_hakbun 
		USING SQLCA ;

		IF ISNULL(CHIDK_HAKJUM) THEN
			CHIDK_HAKJUM = 0 
		END IF
		IF ISNULL(injung_hakjum) THEN
			injung_hakjum = 0 
		END IF

		// 취득학점(현장실습)+인정학점					
		chong_hakjum = chidk_hakjum + injung_hakjum 
		
	
		IF chong_hakjum >= li_hakjum THEN
			
		   // '졸업사정트랜스'(jolup_sajung_trans)에 데이타 입력부분
			INSERT INTO HAKSA.JOLUP_SAJUNG  
						(	YEAR,
							JUNHUGI,
							HAKBUN,
							GWA,
							PYENGJUM_AVG,
							CHIDK_TOTAL,
							JUNGONG,
							GYOYANG,
							GYOJIK_YN,
							GYOPIL_YN,
							JUNPIL_YN,
							EXAM_YN,
						   GONGPIL_YN,
						   GONGSUN_YN,
							JOLUP_SUKCHA,
							JOLUP_DATE,
							JOLUP_COUNT,
							HAKWI_NO,
							HAKWI_NAME,
							JOLUP_JUNG_NO,
							HAPGYUK_GUBUN
						)
			VALUES	(	:ls_year_arg	,
							:ls_jolup_hakgi,
							:ls_hakbun		,
							:ls_gwa			,
							0					,
							0					,
							0					,
							0					,
							'N'				,
							'N'				,
							'N'				,
							'N'				,
							'N'            ,
							'N'            ,
							0					,
							''					,
							''					,
							''					,
							''					,
							''					,
							'0'
						)
			USING SQLCA ;
			
		END IF
	
	NEXT
	
ELSEIF ls_gubun = '2' Then //학과조회
			
   dw_2.settransobject(sqlca)
   dw_2.retrieve(ls_shakgwa, ls_shakbun)
	
	DELETE FROM HAKSA.JOLUP_SAJUNG
	WHERE GWA = :ls_shakgwa
	USING SQLCA ;
		  
	if sqlca.sqlcode <> 0 then
		rollback USING SQLCA ;
		Messagebox("졸업","실패하였읍니다.")
		Return -1
	end if
	
	li_rowcount = dw_2.rowcount()

	FOR li_start = 1 TO li_rowcount
		 
		st_3.text = "("+string(li_start)+ " / " + string(li_rowcount) + ")" + " 처리중입니다"
		 
		if li_start = li_rowcount then
			st_3.text = string(li_rowcount)+"건이 처리되었습니다."
		end if
		 
		uo_progress.uf_init(li_rowcount)
		uo_progress.uf_set_position(li_start)
		
		ls_hakbun 	= dw_2.object.hakbun[li_start]              
		ls_hname 	= dw_2.object.hname[li_start]
		ls_gwa 		= dw_2.object.gwa[li_start]
		ls_juyau 	= dw_2.object.juya_gubun[li_start]
		
		ls_hakwi_code = uf_hakwi_code(ls_gwa)
	  
		// 지도교수
		SELECT	MEMBER_NO4           
		INTO   	:ls_jido_gyosu
		FROM   	HAKSA.JAEHAK_SINSANG
		WHERE  	HAKBUN = :ls_hakbun
		USING SQLCA ;
	
		// 성적사정 이후 현재까지 취득학점 구함 (4학년 마지막 학기 전까지)
		SELECT	SUM(CHIDK_HAKJUM)
		INTO		:chidk_hakjum
		FROM		HAKSA.SUNGJUKGYE
		WHERE	HAKBUN = :ls_hakbun				
		USING SQLCA ;
		
		//인정학점 구함
		SELECT 	INJUNG_HAKJUM
		INTO   	:injung_hakjum
		FROM   	HAKSA.JAEHAK_HAKJUK
		WHERE  	JAEHAK_HAKJUK.HAKBUN = :ls_hakbun 
		USING SQLCA ;

		IF ISNULL(CHIDK_HAKJUM) THEN
			CHIDK_HAKJUM = 0 
		END IF
		IF ISNULL(injung_hakjum) THEN
			injung_hakjum = 0 
		END IF
				
		// 취득학점(현장실습)+인정학점					
		chong_hakjum = CHIDK_HAKJUM + injung_hakjum 
	  
		IF chong_hakjum >= li_hakjum THEN
		 
		   // '졸업사정트랜스'(jolup_sajung)에 데이타 입력부분
			INSERT INTO HAKSA.JOLUP_SAJUNG  
						(	YEAR,
							JUNHUGI,
							HAKBUN,
							GWA,
							PYENGJUM_AVG,
							CHIDK_TOTAL,
							JUNGONG,
							GYOYANG,
							GYOJIK_YN,
							GYOPIL_YN,
							JUNPIL_YN,
							EXAM_YN,
						   GONGPIL_YN,
						   GONGSUN_YN,
							JOLUP_SUKCHA,
							JOLUP_DATE,
							JOLUP_COUNT,
							HAKWI_NO,
							HAKWI_NAME,
							JOLUP_JUNG_NO,
							HAPGYUK_GUBUN
						)
			VALUES	(	:ls_year_arg	,
							:ls_jolup_hakgi,
							:ls_hakbun		,
							:ls_gwa			,
							0					,
							0					,
							0					,
							0					,
							'N'				,
							'N'				,
							'N'				,
							'N'				,
							'N'            ,
							'N'            ,
							0					,
							''					,
							''					,
							''					,
							''					,
							''					,
							'0'
						)
			USING SQLCA ;
			
			UPDATE HAKSA.EARLY_JOLUP A
				  SET A.TRANS_YN = 'Y'
			 WHERE A.HAKBUN = :ls_hakbun
			USING SQLCA ;
			
			If sqlca.sqlcode <> 0 Then
				Rollback USING SQLCA ;
				Messagebox('조기졸업2', '조기졸업대상 테이블 업데이트를 실패하였습니다.')
				Return -1
			End If
			
		END IF
	NEXT
	
	
//학번조회	
ELSE
	dw_2.settransobject(sqlca)
	dw_2.retrieve(ls_shakgwa, ls_shakbun)
	
	DELETE FROM HAKSA.JOLUP_SAJUNG
	WHERE HAKBUN = :ls_shakbun
	 USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		rollback USING SQLCA ;
		Messagebox("졸업","실패하였읍니다.")
		Return -1
	end if	
	
	li_rowcount = dw_2.rowcount()	

	FOR li_start = 1 TO li_rowcount
	 
		st_3.text = "("+string(li_start)+ " / " + string(li_rowcount) + ")" + " 처리중입니다"
		if li_start = li_rowcount then
			st_3.text = string(li_rowcount)+"건이 처리되었습니다."
		end if
		 
		uo_progress.uf_init(li_rowcount)
		uo_progress.uf_set_position(li_start)
		
		ls_hakbun 	= dw_2.object.hakbun[li_start]              
		ls_hname 	= dw_2.object.hname[li_start]
		ls_gwa 		= dw_2.object.gwa[li_start]
		ls_juyau  	= dw_2.object.juya_gubun[li_start]
		
		ls_hakwi_code = uf_hakwi_code(ls_gwa)
		
		// 지도교수
		SELECT 	MEMBER_NO4           
		INTO   	:ls_jido_gyosu
		FROM   	JAEHAK_SINSANG
		WHERE  	HAKBUN = :ls_hakbun
		 USING SQLCA ;
	
		// 성적사정 이후 현재까지 취득학점 구함 (4학년 마지막 학기 전까지)
		SELECT	SUM(CHIDK_HAKJUM)
		INTO		:chidk_hakjum
		FROM		HAKSA.SUNGJUKGYE
		WHERE	HAKBUN = :ls_hakbun
		 USING SQLCA ;
		
		// 인정학점 구함
		SELECT 	INJUNG_HAKJUM
		INTO   	:injung_hakjum
		FROM   	HAKSA.JAEHAK_HAKJUK
		WHERE  	JAEHAK_HAKJUK.HAKBUN = :ls_hakbun 
		 USING SQLCA ;
	
		IF ISNULL(CHIDK_HAKJUM) THEN
			CHIDK_HAKJUM = 0 
		END IF
		IF ISNULL(injung_hakjum) THEN
			injung_hakjum = 0 
		END IF
		
		// 취득학점(현장실습)+인정학점					
		chong_hakjum = chidk_hakjum + injung_hakjum 
	  
		IF chong_hakjum >= li_hakjum THEN
			
			// '졸업사정트랜스'(jolup_sajung)에 데이타 입력부분
			INSERT INTO HAKSA.JOLUP_SAJUNG  
						(	YEAR,
							JUNHUGI,
							HAKBUN,
							GWA,
							PYENGJUM_AVG,
							CHIDK_TOTAL,
							JUNGONG,
							GYOYANG,
							GYOJIK_YN,
							GYOPIL_YN,
							JUNPIL_YN,
							EXAM_YN,
							GONGPIL_YN,
							GONGSUN_YN,
							JOLUP_SUKCHA,
							JOLUP_DATE,
							JOLUP_COUNT,
							HAKWI_NO,
							HAKWI_NAME,
							JOLUP_JUNG_NO,
							HAPGYUK_GUBUN
						)
			VALUES	(	:ls_year_arg	,
							:ls_jolup_hakgi,
							:ls_hakbun		,
							:ls_gwa			,
							0					,
							0					,
							0					,
							0					,
							'N'				,
							'N'				,
							'N'				,
							'N'				,
							'N'            ,
							'N'            ,
							0					,
							''					,
							''					,
							''					,
							''					,
							''					,
							'0'
						)
			 USING SQLCA ;
			 
			 UPDATE HAKSA.EARLY_JOLUP A
				  SET A.TRANS_YN = 'Y'
			 WHERE A.HAKBUN = :ls_hakbun
			USING SQLCA ;
			
			If sqlca.sqlcode <> 0 Then
				Rollback USING SQLCA ;
				Messagebox('조기졸업3', '조기졸업대상 테이블 업데이트를 실패하였습니다.')
				Return -1
			End If
			
		END IF
	NEXT
END IF

// 조기졸업대상자 이관
INSERT INTO HAKSA.JOLUP_SAJUNG  
					(	YEAR,
						JUNHUGI,
						HAKBUN,
						GWA,
						PYENGJUM_AVG,
						CHIDK_TOTAL,
						JUNGONG,
						GYOYANG,
						GYOJIK_YN,
						GYOPIL_YN,
						JUNPIL_YN,
						EXAM_YN,
						GONGPIL_YN,
						GONGSUN_YN,
						JOLUP_SUKCHA,
						JOLUP_DATE,
						JOLUP_COUNT,
						HAKWI_NO,
						HAKWI_NAME,
						JOLUP_JUNG_NO,
						HAPGYUK_GUBUN			)
( SELECT :ls_year_arg	,			:ls_jolup_hakgi ,			A.HAKBUN		,			B.GWA			,
			0					,			0					,			0					,			0					,
			'N'				    ,			'N'				    ,			'N'				    ,			'N'				     ,
			'N'                  ,			'N'                   ,			0					,			''					,
			''					,			''					,			''					,			''					,
			'0'
	FROM HAKSA.EARLY_JOLUP A
			 , HAKSA.JAEHAK_HAKJUK B
 WHERE A.HAKBUN = B.HAKBUN
	  AND A.HAKBUN LIKE :ls_hakbun_temp || '%'
	  AND B.GWA      LIKE :ls_gwa_temp || '%'
	  AND A.FIX_YN      = 'Y'
	  AND A.TRANS_YN = 'N'  )
 USING SQLCA; 
	  
UPDATE HAKSA.EARLY_JOLUP A
	  SET A.TRANS_YN = 'Y'
 WHERE A.HAKBUN IN ( SELECT A.HAKBUN
								FROM HAKSA.EARLY_JOLUP A
										 , HAKSA.JAEHAK_HAKJUK B
							 WHERE A.HAKBUN = B.HAKBUN
								  AND A.HAKBUN LIKE :ls_hakbun_temp || '%'
								  AND B.GWA      LIKE :ls_gwa_temp || '%'
								  AND A.FIX_YN      = 'Y'
								  AND A.TRANS_YN = 'N'  )
USING SQLCA ;
	
If sqlca.sqlcode <> 0 Then
	Rollback USING SQLCA ;
	Messagebox('조기졸업', '조기졸업대상 테이블 업데이트를 실패하였습니다.')
	Return -1
End If
	

COMMIT USING SQLCA ;

If sqlca.sqlcode <> 0 Then
	Rollback USING SQLCA ;
	Messagebox("오류", "졸업예정자 이관시 오류가 발생하였습니다.")
	Return -1
End If
  
Return 1
end event

type dw_con from uo_dwfree within w_hjj101a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 190
boolean bringtotop = true
string dataobject = "d_hjj101a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

